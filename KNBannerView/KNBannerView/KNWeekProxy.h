//
//  KNWeekProxy.h
//  KKRent
//
//  Created by LuKane on 2015/7/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

/**
 * 使用 KNBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNWeekProxy : NSProxy

@property (nonatomic,weak,readonly,nullable) id target;

/**
 类方法 创建 弱引用对象

 @param target 当前对象
 @return 当前对象弱引用之后
 */
+ (instancetype)proxyWithTarget:(id)target;

/**
 实例方法 创建 弱引用对象

 @param target 当前对象
 @return 当前对象弱引用之后
 */
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
