//
//  KNCollectionViewCell.m
//  KNBannerView
//
//  Created by LuKane on 15/11/14.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "KNCollectionViewCell.h"

@interface KNCollectionViewCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *IntroduceLabel;

@end

@implementation KNCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupImageView];
        [self setupLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupImageView];
        [self setupLabel];
    }
    return self;
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _imageView = imageView;
}

- (void)setupLabel{
    // 1.IntroduceBGView
    UIView *bgView = [[UIView alloc] init];
    _bgView = bgView;
    [self addSubview:bgView];
    
    // 2.IntroduceLabel
    UILabel *introduceLabel = [[UILabel alloc] init];
    _IntroduceLabel = introduceLabel;
    [_bgView addSubview:introduceLabel];
}

- (void)setIntroduceString:(NSString *)IntroduceString{
    _IntroduceString = IntroduceString;
    if([KNJudgementTool isEmptyString:IntroduceString]){
        _bgView.hidden = YES;
    }else{
        _bgView.hidden = NO;
    }
    [_IntroduceLabel setText:IntroduceString];
}

- (void)setIntroduceBackGroundColor:(UIColor *)IntroduceBackGroundColor{
    _IntroduceBackGroundColor = IntroduceBackGroundColor;
    [_bgView setBackgroundColor:IntroduceBackGroundColor];
}

- (void)setIntroduceTextColor:(UIColor *)IntroduceTextColor{
    _IntroduceTextColor = IntroduceTextColor;
    [_IntroduceLabel setTextColor:IntroduceTextColor];
}

- (void)setIntroduceBackGroundAlpha:(CGFloat)IntroduceBackGroundAlpha{
    _IntroduceBackGroundAlpha = IntroduceBackGroundAlpha;
    [_bgView setAlpha:IntroduceBackGroundAlpha];
}

- (void)setIntroduceTextFont:(UIFont *)IntroduceTextFont{
    _IntroduceTextFont = IntroduceTextFont;
    [_IntroduceLabel setFont:IntroduceTextFont];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    CGFloat Height = _IntroduceHeight?_IntroduceHeight:30;
    _bgView.frame = CGRectMake(0, self.height - Height, self.width, Height);
    _IntroduceLabel.frame = CGRectMake(0, 0, _bgView.width, _bgView.height);
    
    switch (_IntroduceStyle) {
        case KNIntroduceStyleLeft:
            _IntroduceLabel.textAlignment = NSTextAlignmentLeft;
            _IntroduceLabel.frame = CGRectMake(10, 0, _bgView.width, _bgView.height);
            break;
            
        case KNIntroduceStyleMiddle:
            _IntroduceLabel.textAlignment = NSTextAlignmentCenter;
            _IntroduceLabel.frame = CGRectMake(0, 0, _bgView.width, _bgView.height);
            break;
            
        case KNIntroduceStyleRight:
            _IntroduceLabel.textAlignment = NSTextAlignmentRight;
            _IntroduceLabel.frame = CGRectMake(-10, 0, _bgView.width, _bgView.height);
            break;
            
        default:
            break;
    }
    
}

@end
