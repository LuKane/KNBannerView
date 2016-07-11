//
//  KNCollectionViewTextView.m
//  KNBannerView
//
//  Created by LuKane on 16/7/11.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNCollectionViewTextView.h"

#define ShowMultiple 0.200
#define StayMultiple 0.600

@implementation KNCollectionViewTextView{
    UILabel *_IntroduceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel{
    UILabel *introductLabel = [[UILabel alloc] init];
    _IntroduceLabel = introductLabel;
    [self addSubview:introductLabel];
}

- (void)setIntroduceString:(NSString *)IntroduceString{
    self.hidden = [KNJudgementTool isEmptyString:IntroduceString];
    [_IntroduceLabel setText:IntroduceString];
    switch (_textShowStyle) {
        case KNTextShowStyleFadeOut:{
            [self textShowStyleFadeOut];
        }
            break;
        case KNTextShowStyleStay:{
            _IntroduceLabel.alpha = 1.f;
        }
            break;
        default:
            _IntroduceLabel.alpha = 1.f;
            break;
    }
}

- (void)setIntroduceBackGroundColor:(UIColor *)IntroduceBackGroundColor{
    [self setBackgroundColor:IntroduceBackGroundColor];
}

- (void)setIntroduceTextColor:(UIColor *)IntroduceTextColor{
    [_IntroduceLabel setTextColor:IntroduceTextColor];
}

- (void)setIntroduceBackGroundAlpha:(CGFloat)IntroduceBackGroundAlpha{
    [self setAlpha:IntroduceBackGroundAlpha];
}

- (void)setIntroduceTextFont:(UIFont *)IntroduceTextFont{
    [_IntroduceLabel setFont:IntroduceTextFont];
}

// textLabel stay on the bannerView,but show style is change base on your choosen
- (void)textShowStyleFadeOut{
    [UIView animateWithDuration:_showTime * ShowMultiple animations:^{
        _IntroduceLabel.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ShowMultiple * _showTime delay:_showTime * StayMultiple options:UIViewAnimationOptionLayoutSubviews animations:^{
            _IntroduceLabel.alpha = 0.f;
        } completion:nil];
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _IntroduceLabel.frame = CGRectMake(0, 0, width, height);
    
    switch (_IntroduceStyle) {
        case KNIntroduceStyleLeft:
            _IntroduceLabel.textAlignment = NSTextAlignmentLeft;
            _IntroduceLabel.frame = CGRectMake(10, 0, width, height);
            break;
            
        case KNIntroduceStyleMiddle:
            _IntroduceLabel.textAlignment = NSTextAlignmentCenter;
            _IntroduceLabel.frame = CGRectMake(0, 0,width, height);
            break;
            
        case KNIntroduceStyleRight:
            _IntroduceLabel.textAlignment = NSTextAlignmentRight;
            _IntroduceLabel.frame = CGRectMake(-10, 0, width, height);
            break;
            
        default:
            break;
    }
}

@end
