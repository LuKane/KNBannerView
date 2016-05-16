//
//  NSData+KNCache.h
//  KNBannerView
//
//  Created by LuKane on 15/11/15.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSData (KNCache)

/**
 *  get image Data from DB
 *
 *  @param url url: URL unique identification
 *
 *  @return data of images
 */
+ (NSData *)getDataFromLocationApplicationCacheWithURL:(NSString *)url;

/**
 *  save image data to DB through MD5
 *
 *  @param url url: URL unique identification
 *
 *  @param image data to save
 */
+ (void)saveDataIntoLocationApplicationCacheWithURL:(NSString *)url image:(UIImage *)image;


/**
 *  when receiveMemeryWarning or need to clear memery, remove the image'data
 */
//+ (void)removeDataWhenReceiveMemeryWarning;

@end
