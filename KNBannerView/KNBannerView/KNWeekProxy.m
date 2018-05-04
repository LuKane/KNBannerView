//
//  KNWeekProxy.m
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

#import "KNWeekProxy.h"

@implementation KNWeekProxy

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if([self.target respondsToSelector:sel]){
        [invocation invokeWithTarget:self.target];
    }
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [_target respondsToSelector:aSelector];
}

@end
