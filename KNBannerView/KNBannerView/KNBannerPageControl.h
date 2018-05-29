//
//  KNBannerPageControl.h
//  KNBannerView
//
//  Created by LuKane on 2016/11/14.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNBannerViewModel;

@interface KNBannerPageControl : UIView

@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

@property (nonatomic, assign) NSInteger currentPage;

@end
