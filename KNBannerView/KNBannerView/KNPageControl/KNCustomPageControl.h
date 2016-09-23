//
//  KNCustomPageControl.h
//  KNBannerView
//
//  Created by LuKane on 16/9/23.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNCustomPageControl : UIView

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, strong) NSArray *imageArr;

@end
