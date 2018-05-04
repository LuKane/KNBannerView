//
//  KNBannerViewText.h
//  KNBannerView
//
//  Created by LuKane on 2015/7/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

/**
 * 使用 KNBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */

#import <UIKit/UIKit.h>
@class KNBannerViewModel;

@interface KNBannerViewText : UIView

/* 设置 属性  -- > 这个最好只设置一次*/
@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

/* 设置 文字 */
@property (nonatomic, copy  ) NSString *text;

@end
