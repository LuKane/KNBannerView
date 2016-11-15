//
//  KNBannerViewText.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/10.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "KNBannerViewText.h"
#import "KNBannerViewModel.h"

#define ShowMultiple 0.200
#define StayMultiple 0.600

@implementation KNBannerViewText{
    UILabel                  *_textLabel;
    KNBannerViewTextShowStyle _textShowStyle;
    NSInteger                 _bannerTimeInterval;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel{
    UILabel *textLabel = [[UILabel alloc] init];
    _textLabel = textLabel;
    [self addSubview:textLabel];
}

- (void)setBannerViewModel:(KNBannerViewModel *)bannerViewModel{
    _bannerViewModel = bannerViewModel;
    
    [self setBackgroundColor:[bannerViewModel textBackGroundColor]];
    [self setAlpha:[bannerViewModel textBackGroundAlpha]];
    
    [_textLabel setFont:[bannerViewModel textFont]];
    [_textLabel setTextColor:[bannerViewModel textColor]];
    
    switch ([bannerViewModel textStayStyle]) {
        case KNBannerViewTextStayStyleLeft:
            [_textLabel setTextAlignment:NSTextAlignmentLeft];
            break;
        case KNBannerViewTextStayStyleMiddle:
            [_textLabel setTextAlignment:NSTextAlignmentCenter];
            break;
        case KNBannerViewTextStayStyleRight:
            [_textLabel setTextAlignment:NSTextAlignmentRight];
            break;
        default:
            break;
    }
    
    _textShowStyle      = [bannerViewModel textShowStyle];
    _bannerTimeInterval = [bannerViewModel bannerTimeInterval];
}

- (void)setText:(NSString *)text{
    [_textLabel setText:text];
    
    switch (_textShowStyle) {
        case KNBannerViewTextShowStyleNormal:
            [_textLabel setAlpha:1.f];
            break;
        case KNBannerViewTextShowStyleStay:
            [_textLabel setAlpha:1.f];
            break;            
        default:
            break;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    switch ([_bannerViewModel textStayStyle]) {
        case KNBannerViewTextStayStyleLeft:
            [_textLabel setFrame:(CGRect){{10,0},{self.bounds.size.width - 10,self.bounds.size.height}}];
            break;
        case KNBannerViewTextStayStyleMiddle:
            [_textLabel setFrame:self.bounds];
            break;
        case KNBannerViewTextStayStyleRight:
            [_textLabel setFrame:(CGRect){CGPointZero,{self.bounds.size.width - 10,self.bounds.size.height}}];
            break;
        default:
            break;
    }
}

@end
