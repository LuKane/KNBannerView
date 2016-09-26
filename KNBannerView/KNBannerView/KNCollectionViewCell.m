//
//  KNCollectionViewCell.m
//  KNBannerView
//
//  Created by LuKane on 15/11/14.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "KNCollectionViewCell.h"

@implementation KNCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupImageLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupImageLayer];
    }
    return self;
}

- (void)setupImageLayer{
    CALayer *imageLayer = [CALayer layer];
    [self.layer addSublayer:imageLayer];
    _imageLayer = imageLayer;
    
    KNCollectionViewTextView *IntroduceBgView = [[KNCollectionViewTextView alloc] init];
    _IntroduceBgView = IntroduceBgView;
    [self addSubview:IntroduceBgView];
}

- (void)setIsShowStyleNormal:(BOOL)isShowStyleNormal{
    if (!isShowStyleNormal) {
        [_IntroduceBgView removeFromSuperview];
        _IntroduceBgView = nil;
    }
}

- (void)setIntroduceString:(NSString *)IntroduceString{
    if([KNJudgementTool isEmptyString:IntroduceString]){
        _IntroduceBgView.hidden = YES;
    }else{
        _IntroduceBgView.hidden = NO;
    }
    _IntroduceBgView.IntroduceString = IntroduceString;
}

- (void)setIntroduceBackGroundColor:(UIColor *)IntroduceBackGroundColor{
    _IntroduceBgView.IntroduceBackGroundColor = IntroduceBackGroundColor;
}

- (void)setIntroduceTextColor:(UIColor *)IntroduceTextColor{
    _IntroduceBgView.IntroduceTextColor = IntroduceTextColor;
}

- (void)setIntroduceBackGroundAlpha:(CGFloat)IntroduceBackGroundAlpha{
    _IntroduceBgView.IntroduceBackGroundAlpha = IntroduceBackGroundAlpha;
}

- (void)setIntroduceTextFont:(UIFont *)IntroduceTextFont{
    _IntroduceBgView.IntroduceTextFont = IntroduceTextFont;
}

- (void)setIntroduceStyle:(KNIntroduceStyle)IntroduceStyle{
    _IntroduceBgView.IntroduceStyle = IntroduceStyle;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imageLayer setFrame:self.bounds];
    CGFloat height = _IntroduceHeight?_IntroduceHeight:30;
    _IntroduceBgView.frame = CGRectMake(0, self.height - height, self.width, height);
}

@end
