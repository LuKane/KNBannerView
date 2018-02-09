//
//  KNWeekProxy.m
//  KKRent
//
//  Created by LuKane on 2018/2/9.
//  Copyright © 2018年 LuKane. All rights reserved.
//

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
