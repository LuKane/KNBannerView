//
//  NSData+KNCache.m
//  KNBannerView
//
//  Created by LuKane on 15/11/15.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "NSData+KNCache.h"
#import "NSString+hash.h"

@implementation NSData (KNCache)

+ (NSData *)getDataFromLocationApplicationCacheWithURL:(NSString *)url{
    
    NSString *path = [[self getLocationDBPath] stringByAppendingPathComponent:[url md5String]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (void)saveDataIntoLocationApplicationCacheWithURL:(NSString *)url image:(UIImage *)image{
    // 1.get Path
    NSString *path = [[self getLocationDBPath] stringByAppendingPathComponent:[url md5String]];
    
    // 2. write to file
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}

+ (void)removeDataWhenReceiveMemeryWarning{
    NSString *path = [self getLocationDBPath];
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
}

+ (NSString *)getLocationDBPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"KNBannerCache"];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    if(![mgr fileExistsAtPath:path]){
        [mgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

@end
