//
//  SHVerticalMarquee.m
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import "SHVerticalMarquee.h"
#import "SHMArqueeItemView.h"

static CGFloat const kPadPerFrame = 0.2;

@interface SHVerticalMarquee ()

@property (nonatomic, strong) CADisplayLink *scrollTimer;
@property (nonatomic, strong) NSMutableArray <SHMArqueeItemView *>*itemViews;
@end

@implementation SHVerticalMarquee

#pragma mark - initialization

- (void)dealloc
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

+ (instancetype)marqueeWithFrame:(CGRect)frame
                visibleItemCount:(NSInteger)visibleItemCount
                        delegateDataSource:(id)delegate
{
    return [[self alloc] initWithFrame:frame visibleItemCount:visibleItemCount delegateDataSource:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame
             visibleItemCount:(NSInteger)visibleItemCount
            delegateDataSource:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.visibelItemCount = visibleItemCount;
        self.marqueeDelegate = delegate;
        self.marqueeaDataSource = delegate;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
    self.animationStyle = SHScrollAnimationStyleDefault;
    
    NSArray <SHMarqueeItem *> *items = [self.marqueeaDataSource itemsInVerticalMarquee];
    self.titlesArray = [items mutableCopy];
    
    // create marqueeViews
    CGFloat itemHeight = CGRectGetHeight(self.bounds) / self.visibelItemCount;
    NSString *title = @"new";
    NSString *message = @"";
    for (NSInteger i=0; i<self.visibelItemCount + 1; ++i) {
        if (i != items.count) {
            title = items[i].title;
            message = items[i].content;
        }
        SHMArqueeItemView *itemView = [SHMArqueeItemView itemViewWithTitle:title message:message];
        itemView.currentIndex = i;
        [self.itemViews addObject:itemView];
        itemView.frame = CGRectMake(0, i * itemHeight, CGRectGetWidth(self.bounds), itemHeight);
        [self addSubview:itemView];
        itemView.clickBlock = ^(NSInteger clickIndex, NSString *content) {
            SHMarqueeItem *clickItem = self.titlesArray[clickIndex];
//            NSLog(@"%@ \n",clickItem.content);
        };
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        if (self.animationStyle == SHScrollAnimationStyleDefault) {
//            间断性动画
            [self scrollAnimation];
        } else {
//            连续性动画
            CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerFire)];
            [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            _scrollTimer = link;
        }
    }
}

#pragma mark - Setter & getter
- (NSMutableArray<SHMArqueeItemView *> *)itemViews {
    if (!_itemViews) {
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}

- (NSMutableArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _titlesArray;
}

#pragma mark - Animation

- (CGRect)resetTopFrame:(CGRect)frame {
    CGFloat itemHeight = CGRectGetHeight(self.bounds) / self.visibelItemCount;
//    frame.origin.y -= kPadPerFrame;
    if (frame.origin.y <= -itemHeight) {
        SHMArqueeItemView *topItemView = [self getTopItemView];
        if (topItemView) {
            topItemView.currentIndex += (self->_visibelItemCount + 1);
            if (topItemView.currentIndex >= self.titlesArray.count) {
                topItemView.currentIndex = topItemView.currentIndex % self.titlesArray.count;
            }
            SHMarqueeItem *willShowItem = self.titlesArray[topItemView.currentIndex];
            topItemView.message = willShowItem.content;
            topItemView.frame = ({
                CGRect frame = topItemView.frame;
                frame.origin.y += (self.visibelItemCount + 1) * itemHeight;
                frame;
            });
        }
        frame.origin.y = self.visibelItemCount * itemHeight;
    }
    return frame;
}

- (void)timerFire {
    for (SHMArqueeItemView *itemView in self.itemViews) {
        itemView.frame = ({
            CGRect frame = itemView.frame;
            frame.origin.y -= kPadPerFrame;
            frame = [self resetTopFrame:frame];
            frame;
        });
    }
}

- (void)scrollAnimation {
    CGFloat itemHeight = CGRectGetHeight(self.bounds) / self.visibelItemCount;

    SHMArqueeItemView *topItemView = [self getTopItemView];
    [self resetTopFrame:topItemView.frame];
    
    // 间断性动画
    [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        for (SHMArqueeItemView *itemView in self.itemViews) {
            itemView.frame = ({
                CGRect frame = itemView.frame;
                frame.origin.y -= itemHeight;
                frame;
            });
        }
    } completion:^(BOOL finished) {
        [self scrollAnimation];
    }];
}

#pragma mark - Data
- (NSArray *)getItems {
    NSArray <SHMarqueeItem *> *items = [self.marqueeaDataSource itemsInVerticalMarquee];
    [items enumerateObjectsUsingBlock:^(SHMarqueeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.titlesArray addObject:obj.content];
    }];
    return self.titlesArray;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    for (SHMArqueeItemView *itemView in self.itemViews) {
        if ([itemView.layer.presentationLayer hitTest:touchLocation]) {
            if ([self.marqueeDelegate respondsToSelector:@selector(verticalMarquee:didselectAtIndex:)]) {
                [self.marqueeDelegate verticalMarquee:self didselectAtIndex:itemView.currentIndex];
            }
        }
    }
}


#pragma mark - Layout

#pragma mark -
- (void)reloadData {
    // resetData
    [self.titlesArray removeAllObjects];
    [self getItems];
    
    [self setNeedsLayout];
}

#pragma mark - Convenice func
- (SHMArqueeItemView *)getTopItemView {
    SHMArqueeItemView *topItemView = nil;
    for (SHMArqueeItemView *itemView in self.subviews) {
        if (itemView.frame.origin.y < 0) {
            topItemView = itemView;
        }
    }
    return topItemView;
}
@end
