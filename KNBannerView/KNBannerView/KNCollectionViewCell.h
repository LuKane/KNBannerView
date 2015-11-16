//
//  KNCollectionViewCell.h
//  KNBannerView
//
//  Created by LuKane on 15/11/14.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "KNJudgementTool.h"

typedef enum {
    KNIntroduceStyleLeft,
    KNIntroduceStyleMiddle,
    KNIntroduceStyleRight
}KNIntroduceStyle;

@interface KNCollectionViewCell : UICollectionViewCell

/* show image on cell */
@property (nonatomic, strong) UIImageView *imageView;

/* IntroduceLabel's string */
@property (nonatomic, copy) NSString *IntroduceString;

/* IntroduceString Height ,Default is 30 */
@property (nonatomic, assign) CGFloat IntroduceHeight;

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

@property (nonatomic, assign) CGFloat cellHeight;

/* IntroduceLabel is set or not */
@property (nonatomic, assign) BOOL isSet;

@end
