//
//  ViewController.m
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import "ViewController.h"
#import "SHVerticalMarquee.h"
static CGFloat const kItemHeight = 40;
static NSInteger const kVisibleItemCount = 2;

@interface ViewController ()<SHVerticalMarqueeDelegate,SHVerticalMarqueeDataSource>

@property (nonatomic) SHVerticalMarquee *verticalMarquee;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.verticalMarquee];
}

- (NSArray <SHMarqueeItem *>*)prepareDataSource {
    NSArray *marqueeItemArray = @[
                                  [SHMarqueeItem itemWithContent:@"bala bala bala"],
                                  [SHMarqueeItem itemWithContent:@"哦豁！哦豁！哦豁！"],
                                  [SHMarqueeItem itemWithContent:@"动次 动次 动次"],
                                  [SHMarqueeItem itemWithContent:@"打次 打次 打次"],
                                  [SHMarqueeItem itemWithContent:@"-------------"],
                                  ];
    return marqueeItemArray;
}

#pragma mark - Setter & getter
- (SHVerticalMarquee *)verticalMarquee {
    if (!_verticalMarquee) {
        // item height = 40;
        _verticalMarquee = [SHVerticalMarquee marqueeWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), kVisibleItemCount*kItemHeight) visibleItemCount:kVisibleItemCount delegateDataSource:self];
        _verticalMarquee.layer.borderColor = [UIColor blackColor].CGColor;
        _verticalMarquee.layer.borderWidth = 1;
        _verticalMarquee.animationStyle = SHScrollAnimationStyleContinuity;
    }
    return _verticalMarquee;
}

#pragma mark - SHVerticalMarqueeDataSource & delegate
- (NSArray<SHMarqueeItem *> *)itemsInVerticalMarquee {
    return [self prepareDataSource];
}

- (void)verticalMarquee:(SHVerticalMarquee *)verticalMarquee didselectAtIndex:(NSInteger)index {
    NSLog(@"%@", [self prepareDataSource][index].content);
}

@end
