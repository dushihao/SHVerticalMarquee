//
//  SHMArqueeItemView.h
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMarqueeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHMArqueeItemView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *messageButton;

@property (nonatomic, assign) NSInteger currentIndex; /// 当前对应的数据索引

@property (nonatomic, copy) void (^clickBlock)(NSInteger clickIndex, NSString *message);

+ (instancetype)itemViewWithTitle:(NSString *)title message:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
