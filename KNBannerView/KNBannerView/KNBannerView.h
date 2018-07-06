//
//  KNBannerView.h
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
#import "KNBannerViewModel.h"
#import "KNBannerCollectionViewCell.h"
@class KNBannerView;

@protocol KNBannerViewDelegate <NSObject>

@optional

/**
    点击 bannerView 的回调
 
 @param bannerView 当前 bannerView
 @param collectionView 当前collectionView
 @param collectionViewCell 当前collectionViewCell
 @param index 当前下标
 */
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index;

/**
 当滑动 banner时, 执行的代理方法

 @param bannerView banner
 @param topColor 当前cell的对应的背景色
 @param bottomColor 下一个cell对应的背景色
 @param alpha 当前cell背景色需要的透明度
 @param isRight banner 是否是向右滑动
 */
- (void)bannerView:(KNBannerView *)bannerView topColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor alpha:(CGFloat)alpha isRight:(BOOL)isRight;

@end

@interface KNBannerView : UIView

/* 代理 */
@property (nonatomic, weak  ) id<KNBannerViewDelegate> delegate;

/* 以下三个数组, 如果单独设置, 则是为了 切换 轮播图中的图片  */
/* 本地图片数组 */
@property (nonatomic, strong) NSMutableArray *locationImgArr;
/* 网络图片数组 */
@property (nonatomic, strong) NSMutableArray *netWorkImgArr;
/* 混合图片数组 */
@property (nonatomic, strong) NSMutableArray *blendImgArr;

/* 当需要切换背景色时才用到的数组 , 如果 想要进行reloadData 方法, 则 changeColorArr 需要 写在 上面三个数组赋值之前, 详细: 看 BackGroundController 中的写法 */
@property (nonatomic,strong) NSMutableArray<UIColor *> *changeColorArr;

/* 自定义信息的模型 --> 一次性全部赋值 */
@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

/* 重载数据 */
- (void)reloadData;

/* 实现方法 */

/**
    1.创建 bannerView 加载本地图片

 @param locationImgArr 本地图片数组(图片实体 UIImage)
 @param frame 大小
 @return bannerView
 */
+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame;

/**
    2.创建 bannerView 加载网络图片(url字符串)

 @param netWorkImgArr 网络图片url数组
 @param frame 大小
 @return bannerView
 */
+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame;

/**
    3.创建 bannerView 记载 网络图片 && 本地图片 (混合 图片实体 UIImage + url字符串)

 @param blendImgArr 混合图片数组 (url && image)
 @param frame 大小
 @return bannerView
 */
+ (instancetype)bannerViewWithBlendImagesArr:(NSArray *)blendImgArr frame:(CGRect)frame;

@end
