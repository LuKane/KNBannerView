//
//  KNBannerCollectionViewCell.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "KNBannerCollectionViewCell.h"
#import "UIView+KNExtension.h"
#import "UIImageView+WebCache.h"
#import "KNBannerViewModel.h"
#import "KNBannerViewText.h"

@interface KNBannerCollectionViewCell(){
    UIImageView *_imageView;
    KNBannerViewText *_viewText; // 显示 文字的 view
}

@end

@implementation KNBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setUserInteractionEnabled:YES];
    [self.contentView addSubview:imageView];
    _imageView = imageView;
    
    KNBannerViewText *viewText = [[KNBannerViewText alloc] init];
    _viewText = viewText;
    [self addSubview:viewText];
}

- (void)setUrl:(NSString *)url{
    __weak typeof(self) weakSelf = self;
    
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [[mgr imageCache] queryDiskCacheForKey:url done:^(UIImage *image, SDImageCacheType cacheType) {
        if(image){
            [_imageView setImage:image];
            [weakSelf layoutSubviews];
        }else{
            [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:weakSelf.placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(!error){
                    [weakSelf layoutSubviews];
                }
            }];
        }
    }];
}

- (void)setBannerViewModel:(KNBannerViewModel *)bannerViewModel{
    _bannerViewModel = bannerViewModel;
    
    if(![bannerViewModel isNeedText]){
        [_viewText setHidden:YES];
    }else{
        [_viewText setBannerViewModel:_bannerViewModel];
    }
}

- (void)setText:(NSString *)text{
    _text = text;
    [_viewText setText:text];
}

- (void)setImageName:(NSString *)imageName{
    [_imageView setImage:[UIImage imageNamed:imageName]];
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imageView setFrame:self.bounds];
    [_viewText setFrame:CGRectMake(0, self.height - TextHeight, self.width,TextHeight)];
}


@end
