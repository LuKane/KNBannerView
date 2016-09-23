//
//  KNCustomPageControl.m
//  KNBannerView
//
//  Created by LuKane on 16/9/23.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNCustomPageControl.h"

@implementation KNCustomPageControl{
    UIImage *_selectImg;
    UIImage *_unSelectImg;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = (UIImageView *)obj;
        
        [imageView setImage:_unSelectImg];
        
        if(currentPage == idx){
            if(_selectImg){
                [imageView setImage:_selectImg];
            }
        }
    }];
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr    = imageArr;
    _selectImg   = imageArr[0];
    _unSelectImg = imageArr[1];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    for (NSInteger i = 0; i < numberOfPages; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:_unSelectImg];
        [self addSubview:imageView];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 5;
    CGFloat width  = _selectImg.size.width;
    CGFloat height = _selectImg.size.height;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = (UIImageView *)obj;
        CGFloat x = idx * (width + padding) + padding;
        CGFloat y = (30 - height) * 0.5;
        [imageView setFrame:(CGRect){{x,y},{width,height}}];
    }];
}

@end
