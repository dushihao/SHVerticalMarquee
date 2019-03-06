//
//  SHMarqueeItem.h
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMarqueeItem : NSObject

@property (nonatomic, copy) NSString *title; /// default is 'new'
@property (nonatomic, copy) NSString *content; /// 栏目内容

+ (instancetype)itemWithContent:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
