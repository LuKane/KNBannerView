//
//  KNCustomPageControl.m
//  KNBannerView
//
//  Created by LuKane on 16/9/23.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNCustomPageControl.h"

@interface KNCustomPageControl()

@property (nonatomic, strong) NSMutableArray *layerArr;

@end

@implementation KNCustomPageControl{
    UIImage *_selectImg;
    UIImage *_unSelectImg;
}

- (NSMutableArray *)layerArr{
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    return _layerArr;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    for (NSInteger i = 0; i < _layerArr.count; i++) {
        CALayer *layer = _layerArr[i];
        [layer setContents:(__bridge id _Nullable)_unSelectImg.CGImage];
        if(currentPage == i){
            if(_selectImg){
                [layer setContents:(__bridge id _Nullable)_selectImg.CGImage];
            }
        }
    }
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr    = imageArr;
    _selectImg   = imageArr[0];
    _unSelectImg = imageArr[1];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    for (NSInteger i = 0; i < self.layerArr.count; i++) {
        CALayer *layer = self.layerArr[i];
        [layer removeFromSuperlayer];
    }
    [self.layerArr removeAllObjects];
    
    for (NSInteger i = 0; i < numberOfPages; i++) {
        CALayer *layer = [CALayer layer];
        [layer setContents:(__bridge id _Nullable)_unSelectImg.CGImage];
        [self.layer addSublayer:layer];
        [self.layerArr addObject:layer];
    }
    
    CALayer *layer = self.layerArr[0];
    [layer setContents:(__bridge id _Nullable)_selectImg.CGImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat padding = 5;
    CGFloat width  = _selectImg.size.width;
    CGFloat height = _selectImg.size.height;
    for (NSInteger i = 0; i < _layerArr.count; i++) {
        CGFloat x = i * (width + padding) + padding;
        CGFloat y = (30 - height) * 0.5;
        CALayer *layer = _layerArr[i];
        [layer setFrame:(CGRect){{x,y},{width,height}}];
    }
}

@end
