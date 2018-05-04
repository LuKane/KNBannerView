//
//  KNBannerCollectionViewCell.h
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

/* 2018/05/04 -> banner是否需要 左右间距 || 圆角 */
@property (nonatomic,assign) CGFloat  leftMargin;
@property (nonatomic,assign) CGFloat  bannerCornerRadius;

@end
