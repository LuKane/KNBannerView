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
@property (nonatomic, strong) UIImage *image;
/* 当前文字 */
@property (nonatomic, copy  ) NSString *text;
/* 占位图 */
@property (nonatomic, strong) UIImage *placeHolder;
/* 是否设置过 KNBannerViewModel */
@property (nonatomic, assign) NSInteger isSet;
/* .m文件中所需要的imageView */
@property (nonatomic, strong) UIImageView *imageView;

@end
