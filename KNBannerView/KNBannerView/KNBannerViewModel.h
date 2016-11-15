//
//  KNBannerViewModel.h
//  KNBannerView
//
//  Created by LuKane on 2016/11/10.
//  Copyright © 2016年 LuKane. All rights reserved.
//  这个模型 主要为了 : 一次性设置 多个自定义信息

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define TextHeight 30   // 文字View的默认高度为 30

// 文字的 位置
typedef NS_ENUM(NSInteger,KNBannerViewTextStayStyle){
    KNBannerViewTextStayStyleLeft,  // 文字局左
    KNBannerViewTextStayStyleMiddle,// 文字居中
    KNBannerViewTextStayStyleRight  // 文字居右
};

// 文字的 显示方式
typedef NS_ENUM(NSInteger,KNBannerViewTextShowStyle) {
    KNBannerViewTextShowStyleNormal, // 跟随 cell 一起滚动, 会自动修改文字
    KNBannerViewTextShowStyleStay    // 一直停留, 会自动修改文字
};

typedef NS_ENUM(NSInteger,KNBannerPageControlStyle){
    KNBannerPageControlStyleRight,
    KNBannerPageControlStyleLeft,
    KNBannerPageControlStyleMiddel
};

@interface KNBannerViewModel : NSObject

/* 文字的位置, 默认左边 */
@property (nonatomic, assign) KNBannerViewTextStayStyle textStayStyle;
/* 文字颜色 ,默认 whiteColor */
@property (nonatomic, strong) UIColor *textColor;
/* 文字的font,默认 [UIFont fontWithName:@"Heiti SC" size:15] */
@property (nonatomic, strong) UIFont *textFont;
/* 文字背景View的颜色 , 默认 blackColor */
@property (nonatomic, strong) UIColor *textBackGroundColor;
/* 文字背景View的透明度 ,默认 0.7f*/
@property (nonatomic, assign) CGFloat textBackGroundAlpha;
/* 文字的显示方式, 默认 跟随一起动 */
@property (nonatomic, assign) KNBannerViewTextShowStyle textShowStyle;
/* 文字 是否需要 ,不做 API*/
@property (nonatomic, assign) BOOL isNeedText;
/* 文字的数组  -->如果 文字数组 和 图片数组的个数不相等,则不显示文字*/
@property (nonatomic, strong) NSArray *textArr;

/* 定时器时间 ,默认为 1.5s */
@property (nonatomic, assign) CGFloat bannerTimeInterval;
/* 是否需要 定时器跑,默认 NO */
@property (nonatomic, assign) BOOL isNeedTimerRun;
/* 占位图 , 默认 KNBannerViewSource.bundle/placeHolder.png */
@property (nonatomic, strong) UIImage *placeHolder;

/* PageControl的显示样式 ,默认 居右 */
@property (nonatomic, assign) KNBannerPageControlStyle pageControlStyle;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;
/* 默认绿色 */
@property (nonatomic, strong) UIColor *CurrentPageIndicatorTintColor;
/* 默认白色 */
@property (nonatomic, strong) UIColor *PageIndicatorTintColor;

/* 自定义PageControl 图片的数组 ,如果设置,则是自定义 pageControl*/
@property (nonatomic, strong) NSArray *pageControlImgArr;

/* 是否需要 pageControl ,默认 不需要 : NO, UIPageControl */
@property (nonatomic, assign) BOOL isNeedPageControl;

@end
