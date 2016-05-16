//
//  KNBannerView.h
//  KNBannerView
//
//  Created by LuKane on 15/11/14.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCollectionViewCell.h"

typedef enum {
    KNPageControlStyleRight,
    KNPageControlStyleLeft,
    KNPageControlStyleMiddle
}KNPageControlStyle;

@class KNBannerView;

@protocol KNBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index;

@end


@interface KNBannerView : UIView

@property (nonatomic, weak) id<KNBannerViewDelegate> delegate;

/* timer's time .Default is 1.5 seconds */
@property (nonatomic, assign) CGFloat timeInterval;
/* placeHolder for download not completed */
@property (nonatomic, copy) NSString *placeHolder;

/* locationImagesArray */
@property (nonatomic, strong) NSMutableArray *locationImgArr;
/* netWorkImagesUrlArray */
@property (nonatomic, strong) NSMutableArray *netWorkImgArr;


/***************************Divder************************/

/* pageIndicatorTintColor for PageControl ,Default is GrayColor */
@property (nonatomic, strong) UIColor *PageIndicatorTintColor;

/* currentPageIndicatorTintColor for PageControl ,Default is WhiteColor */
@property (nonatomic, strong) UIColor *CurrentPageIndicatorTintColor;

/* pageControlStyle ,Default is AligmentRight */
@property (nonatomic, assign) KNPageControlStyle pageControlStyle;

/***************************Divder************************/

/* Array IntroduceString for display, if don't need one of them ,just put that one empty */
@property (nonatomic, strong) NSMutableArray *IntroduceStringArr;

/* IntroduceString Aligment style,Default is Left */
@property (nonatomic, assign) KNIntroduceStyle IntroduceStyle;

/* IntroduceString BackGroundColor ,Default is BlackColor */
@property (nonatomic, strong) UIColor *IntroduceBackGroundColor;

/* IntroduceString TextColor ,Default is WhiteColor */
@property (nonatomic, strong) UIColor *IntroduceTextColor;

/* IntroduceString BackGroundAlpha ,Default is 0.5 */
@property (nonatomic, assign) CGFloat IntroduceBackGroundAlpha;

/* IntroduceString TextFont ,Default is Heiti SC 15 */
@property (nonatomic, strong) UIFont *IntroduceTextFont;

/* IntroduceString Height ,Default is 30 */
@property (nonatomic, assign) CGFloat IntroduceHeight;

/***************************Divder************************/

/**
*  create scrollView by collectionView for image flow
*
*  @param locationImgArr locationImageArr
*  @param frame scrollView's frame
*
*  @return scrollView image flow
*/
+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame;

/**
 *  create scrollView by collectionView for image flow
 *
 *  @param locationImgArr netWorkImageUrl
 *  @param frame scrollView's frame
 *
 *  @return scrollView image flow
 */
+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame;


@end
