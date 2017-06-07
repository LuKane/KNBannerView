//
//  KNBannerPageControl.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/14.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "KNBannerPageControl.h"
#import "UIView+KNExtension.h"
#import "KNCustomPageControl.h"
#import "KNBannerViewModel.h"

@implementation KNBannerPageControl{
    UIPageControl *_pageControl;
    KNCustomPageControl *_customPageControl;
    
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupPageControl];
    }
    return self;
}

- (void)setupPageControl{
    // 1.UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    [self addSubview:pageControl];
    
    // 2.KNCustomPageControl
    KNCustomPageControl *customPageControl = [[KNCustomPageControl alloc] init];
    _customPageControl = customPageControl;
    [self addSubview:customPageControl];
}

- (void)setBannerViewModel:(KNBannerViewModel *)bannerViewModel{
    _bannerViewModel = bannerViewModel;
    
    if([self isEmptyArray:bannerViewModel.pageControlImgArr]){ // 系统的 pageControl
        
        [_customPageControl setHidden:YES];
        [_pageControl setHidden:NO];
        
        [_pageControl setCurrentPage:[bannerViewModel currentPage]];
        [_pageControl setNumberOfPages:[bannerViewModel numberOfPages]];
        [_pageControl setPageIndicatorTintColor:[bannerViewModel PageIndicatorTintColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[bannerViewModel CurrentPageIndicatorTintColor]];
        
    }else{ // 自定义 pageControl
        
        [_pageControl setHidden:YES];
        [_customPageControl setHidden:NO];
        
        if([self isEmptyArray:[bannerViewModel pageControlImgArr]] || [bannerViewModel pageControlImgArr].count != 2 || ![[bannerViewModel pageControlImgArr][0] isKindOfClass:[UIImage class]] || ![[bannerViewModel pageControlImgArr][1] isKindOfClass:[UIImage class]]){
            bannerViewModel.pageControlImgArr = nil;
        }
        
        if(![_customPageControl isHidden]){
            [_customPageControl setImageArr:[bannerViewModel pageControlImgArr]];
            [_customPageControl setNumberOfPages:[bannerViewModel numberOfPages]];
            
            
        }
    }
    
    [self layoutSubviews];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    if(![_pageControl isHidden]){
        [_pageControl setCurrentPage:currentPage];
    }else if(![self isEmptyArray:[_bannerViewModel pageControlImgArr]]){
        [_customPageControl setCurrentPage:currentPage];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 4 * 10 + ( 4 - 1) * 5 : pageControl base enum to set frame
    switch ([_bannerViewModel pageControlStyle]) {
        case KNBannerPageControlStyleMiddel:
            _pageControl.frame = CGRectMake(0,0, self.width, 30);
            break;
        case KNBannerPageControlStyleLeft:
            _pageControl.frame = CGRectMake(10 - self.width * 0.5 + [_bannerViewModel numberOfPages] * 0.5 * 10 + ([_bannerViewModel numberOfPages] - 1)  * 0.5 * 5, 0, self.width, 30);
            break;
        case KNBannerPageControlStyleRight:
            _pageControl.frame = CGRectMake(self.width * 0.5 - ([_bannerViewModel numberOfPages] * 10 + ([_bannerViewModel numberOfPages] - 1) * 5) * 0.5 - 10, 0,self.width, 30);
            break;
        default:
            break;
    }
    
    if(![self isEmptyArray:[_bannerViewModel pageControlImgArr]]){
        UIImage *image = [_bannerViewModel pageControlImgArr][0];
        CGFloat width = [_bannerViewModel numberOfPages] * (image.size.width + 5);
        switch ([_bannerViewModel pageControlStyle]) {
            case KNBannerPageControlStyleLeft:{
                _customPageControl.frame = CGRectMake(5, 0, width, 30);
            }
                break;
            case KNBannerPageControlStyleMiddel:{
                _customPageControl.frame = CGRectMake((self.width - width) * 0.5, 0, width, 30);
            }
                break;
            case KNBannerPageControlStyleRight:{
                _customPageControl.frame = CGRectMake(self.width - width - 5, 0, width, 30);
            }
                break;
            default:
                break;
        }
    }
}

- (BOOL)isEmptyArray:(NSArray *)array{
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return YES;
    }
    return NO;
}

@end
