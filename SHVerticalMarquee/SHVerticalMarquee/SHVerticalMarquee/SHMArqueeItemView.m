//
//  SHMArqueeItemView.m
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import "SHMArqueeItemView.h"

@implementation SHMArqueeItemView


+ (instancetype)itemViewWithTitle:(NSString *)title message:(NSString *)message {
    return [[self alloc] initWithTitle:title message:message];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        [self commonInit];
        self.title = title;
        self.message = message;
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor blackColor];
    self.userInteractionEnabled = NO;
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor redColor];
        label;
    });
    [self addSubview:self.titleLabel];
    
    self.messageButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [button setBackgroundColor:[self randomColor]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button;
    });
    [self addSubview:self.messageButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marqueeViewWidth = CGRectGetWidth(self.bounds);
    CGFloat marqueeViewHeight = CGRectGetHeight(self.bounds);
    self.titleLabel.frame = CGRectMake(15, 5, 40, marqueeViewHeight-10);
    self.titleLabel.layer.cornerRadius = 3;
    self.titleLabel.layer.masksToBounds = YES;
    self.messageButton.frame = CGRectMake(85, 0, marqueeViewWidth - 85, marqueeViewHeight);
}

- (void)buttonClick:(UIButton *)sender {
    !self.clickBlock ? : self.clickBlock(self.currentIndex, self.messageButton.titleLabel.text);
}

- (UIColor *)randomColor {
    UIColor *randomColor = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
    return randomColor;
}

#pragma mark - Setter & getter
- (void)setMessage:(NSString *)message {
    _message = message;
    [self.messageButton setTitle:message forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
