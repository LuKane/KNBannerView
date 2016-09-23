//
//  KNPageControl.h
//  KNBannerView
//
//  Created by LuKane on 16/9/23.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KNPageControlStyle) {
    KNPageControlStyleLeft,
    KNPageControlStyleMiddle,
    KNPageControlStyleRight
};

@interface KNPageControl : UIView

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, strong) UIColor *CurrentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *PageIndicatorTintColor;

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, assign) KNPageControlStyle pageControlStyle;

@end
