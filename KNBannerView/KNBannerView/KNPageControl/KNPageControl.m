//
//  KNPageControl.m
//  KNBannerView
//
//  Created by LuKane on 16/9/23.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNPageControl.h"
#import "KNCustomPageControl.h"
#import "UIView+Extension.h"
#import "KNJudgementTool.h"

@implementation KNPageControl{
    UIPageControl       *_pageControl;
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

- (void)setPageIndicatorTintColor:(UIColor *)PageIndicatorTintColor{
    [_pageControl setPageIndicatorTintColor:PageIndicatorTintColor];
}

-  (void)setCurrentPageIndicatorTintColor:(UIColor *)CurrentPageIndicatorTintColor{
    [_pageControl setCurrentPageIndicatorTintColor:CurrentPageIndicatorTintColor];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [_pageControl setCurrentPage:currentPage];
    if(![KNJudgementTool isEmptyArray:_imageArr]){
        [_customPageControl setCurrentPage:currentPage];
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    [_pageControl setNumberOfPages:numberOfPages];
    
    [self layoutSubviews];
}

- (void)setPageControlStyle:(KNPageControlStyle)pageControlStyle{
    _pageControlStyle = pageControlStyle;
    [self layoutSubviews];
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    
    if([KNJudgementTool isEmptyArray:imageArr] || imageArr.count != 2 || ![imageArr[0] isKindOfClass:[UIImage class]] || ![imageArr[1] isKindOfClass:[UIImage class]]){
        imageArr = nil;
        _imageArr = nil;
    }
    
    if([KNJudgementTool isEmptyArray:imageArr]){
        [_pageControl setHidden:NO];
        [_customPageControl setHidden:YES];
    }else{
        [_pageControl setHidden:YES];
        [_customPageControl setHidden:NO];
        [_customPageControl setImageArr:imageArr];
        [_customPageControl setNumberOfPages:_numberOfPages];
        [_customPageControl setCurrentPage:_currentPage];
    }
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 4 * 10 + ( 4 - 1) * 5 : pageControl base enum to set frame
    switch (_pageControlStyle) {
        case KNPageControlStyleMiddle:
            _pageControl.frame = CGRectMake(0,0, self.width, 30);
            break;
        case KNPageControlStyleLeft:
            _pageControl.frame = CGRectMake(10 - self.width * 0.5 + _numberOfPages * 0.5 * 10 + (_numberOfPages - 1)  * 0.5 * 5, 0, self.width, 30);
            break;
        case KNPageControlStyleRight:
            _pageControl.frame = CGRectMake(self.width * 0.5 - (_numberOfPages * 10 + (_numberOfPages - 1) * 5) * 0.5 - 10, 0,self.width, 30);
            break;
        default:
            break;
    }
    
    if(![KNJudgementTool isEmptyArray:_imageArr]){
        UIImage *image = _imageArr[0];
        CGFloat width = _numberOfPages * (image.size.width + 5);    
        switch (_pageControlStyle) {
            case KNPageControlStyleLeft:{
                _customPageControl.frame = CGRectMake(5, 0, width, 30);
            }
                break;
            case KNPageControlStyleMiddle:{
                _customPageControl.frame = CGRectMake((self.width - width) * 0.5, 0, width, 30);
            }
                break;
            case KNPageControlStyleRight:{
                _customPageControl.frame = CGRectMake(self.width - width - 5, 0, width, 30);
            }
                break;
            default:
                break;
        }
    }
    
}

@end
