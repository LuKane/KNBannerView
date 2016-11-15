//
//  KNBannerCollectionViewCell.h
//  KNBannerView
//
//  Created by LuKane on 2016/11/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNBannerViewModel;

@interface KNBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

/* 网络图片 url */
@property (nonatomic, copy  ) NSString *url;
/* 本地图片名 */
@property (nonatomic, copy  ) NSString *imageName;
/* 当前文字 */
@property (nonatomic, copy  ) NSString *text;

@property (nonatomic, strong) UIImage *placeHolder;

@property (nonatomic, assign) NSInteger isSet;

@end
