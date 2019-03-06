//
//  SHVerticalMarquee.h
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMarqueeItem.h"
@class SHVerticalMarquee;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SHScrollAnimationStyle) {
    SHScrollAnimationStyleDefault,          // regular table view
    SHScrollAnimationStyleContinuity         // preferences style table view
};

@protocol SHVerticalMarqueeDataSource <NSObject>
/// 数据源
- (NSArray <SHMarqueeItem*>*)itemsInVerticalMarquee;
@end

@protocol SHVerticalMarqueeDelegate <NSObject>

@optional
/// 所点击item的索引
- (void)verticalMarquee:(SHVerticalMarquee *)verticalMarquee didselectAtIndex:(NSInteger)index;
@end

@interface SHVerticalMarquee : UIView

@property (nonatomic, strong) NSMutableArray *titlesArray; /// 标题数组

@property (nonatomic, assign) NSInteger visibelItemCount; /// 显示个数

@property (nonatomic, assign) SHScrollAnimationStyle animationStyle; /// 跑马灯动画类型 default is 0

@property (nonatomic, weak) id<SHVerticalMarqueeDataSource> marqueeaDataSource;
@property (nonatomic, weak) id<SHVerticalMarqueeDelegate> marqueeDelegate;

+ (instancetype)marqueeWithFrame:(CGRect)frame visibleItemCount:(NSInteger)visibleItemCount delegateDataSource:(id)delegate;
- (void)reloadData; 
@end

NS_ASSUME_NONNULL_END
