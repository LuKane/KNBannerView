//
//  KNBannerViewText.h
//  KNBannerView
//
//  Created by LuKane on 2016/11/10.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNBannerViewModel;

@interface KNBannerViewText : UIView

/* 设置 属性  -- > 这个最好只设置一次*/
@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

/* 设置 文字 */
@property (nonatomic, copy  ) NSString *text;

@end
