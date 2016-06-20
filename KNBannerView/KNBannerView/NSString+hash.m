//
//  NSString+hash.h
//  KNBannerView
//
//  Created by LuKane on 14/12/15.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "NSString+hash.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (hash)

#pragma mark - 散列函数
- (NSString *)md5String {
    const char *str = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

@end
