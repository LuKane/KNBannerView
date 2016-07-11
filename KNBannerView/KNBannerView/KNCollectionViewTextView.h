//
//  KNCollectionViewTextView.h
//  KNBannerView
//
//  Created by LuKane on 16/7/11.
//  Copyright © 2016年 KNKane. All rights reserved.
//  展示 文字的view

#import <UIKit/UIKit.h>
#import "KNJudgementTool.h"

typedef enum {
    KNIntroduceStyleLeft,
    KNIntroduceStyleMiddle,
    KNIntroduceStyleRight
}KNIntroduceStyle;

typedef enum {
    KNTextShowStyleNormal,
    KNTextShowStyleFadeOut,
    KNTextShowStyleStay
}KNTextShowStyle;

@interface KNCollectionViewTextView : UIView

/* IntroduceLabel's string */
@property (nonatomic, copy) NSString *IntroduceString;

/* IntroduceString Aligment style,Default is Left */
@property (nonatomic, assign) KNIntroduceStyle IntroduceStyle;

/* textLabel show style ,Default is normal */
@property (nonatomic, assign) KNTextShowStyle textShowStyle;

/* IntroduceString BackGroundColor ,Default is BlackColor */
@property (nonatomic, strong) UIColor *IntroduceBackGroundColor;

/* IntroduceString TextColor ,Default is WhiteColor */
@property (nonatomic, strong) UIColor *IntroduceTextColor;

/* IntroduceString BackGroundAlpha ,Default is 0.5 */
@property (nonatomic, assign) CGFloat IntroduceBackGroundAlpha;

/* IntroduceString TextFont ,Default is Heiti SC 15 */
@property (nonatomic, strong) UIFont *IntroduceTextFont;

/* IntroduceString for show */
@property (nonatomic, assign) CGFloat showTime;

@end
