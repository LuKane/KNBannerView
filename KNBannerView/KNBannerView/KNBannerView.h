//
//  KNBannerView.h
//  KNBannerView
//
//  Created by LuKane on 2016/11/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNBannerViewModel.h"
@class KNBannerView;

@protocol KNBannerViewDelegate <NSObject>

@optional

/**
    点击 bannerView 的回调
 
 @param bannerView 当前 bannerView
 @param collectionView 当前collectionView
 @param index 当前下标
 */
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index;

/**
    长按 bannerView 的回调

 @param bannerView 当前 bannerView
 @param collectionView 当前 collectionView
 @param index 当前下标
 */
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView longPressAtIndexPath:(NSInteger)index;

@end

@interface KNBannerView : UIView

/* 代理 */
@property (nonatomic, weak  ) id<KNBannerViewDelegate> delegate;
/* 本地图片数组 */
@property (nonatomic, strong,readonly) NSMutableArray *locationImgArr;
/* 网络图片数组 */
@property (nonatomic, strong,readonly) NSMutableArray *netWorkImgArr;
/* 混合图片数组 */
@property (nonatomic, strong,readonly) NSMutableArray *blendImgArr;

/* 自定义信息的模型 --> 一次性全部赋值 */
@property (nonatomic, strong) KNBannerViewModel *bannerViewModel;

/* 实现方法 */

/**
    1.创建 bannerView 加载本地图片

 @param locationImgArr 本地图片数组(图片名字符串)
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
    3.创建 bannerView 记载 网络图片 && 本地图片 (混合 图片名字符串 + url字符串)

 @param blendImgArr 混合图片数组 (url && image)
 @param frame 大小
 @return bannerView
 */
+ (instancetype)bannerViewWithBlendImagesArr:(NSArray *)blendImgArr frame:(CGRect)frame;

@end
