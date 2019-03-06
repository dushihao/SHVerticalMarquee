//
//  SHMarqueeItem.m
//  SHVerticalMarquee
//
//  Created by Draven on 2019/3/1.
//  Copyright © 2019 Dush. All rights reserved.
//

#import "SHMarqueeItem.h"

@implementation SHMarqueeItem

+ (instancetype)itemWithContent:(NSString *)content {
    return [[self alloc] initWithContent:content];
}

- (instancetype)initWithContent:(NSString *)content {
    if (self = [super init]) {
        self.title = @"new"; 
        self.content = content;
    }
    return self;
}

@end
