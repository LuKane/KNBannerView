//
//  ViewController.m
//  KNBannerView
//
//  Created by LUKHA_Lu on 15/11/6.
//  Copyright (c) 2015年 KNKane. All rights reserved.
//

#import "ViewController.h"
#import "KNBannerView.h"

#import "NSData+KNCache.h"

@interface ViewController ()<KNBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *imgArr = [NSMutableArray array];
    
//    NSString *img1 = @"1";
//    NSString *img2 = @"2";
//    NSString *img3 = @"3";
//    NSString *img4 = @"4";
//    NSString *img5 = @"5";
    
    NSString *img1 = @"http://i3.download.fd.pchome.net/t_960x600/g1/M00/07/09/oYYBAFMv8q2IQHunACi90oB0OHIAABbUQAAXO4AKL3q706.jpg";
    NSString *img2 = @"http://images.weiphone.net/attachments/photo/Day_120308/118871_91f6133116504086ed1b82e0eb951.jpg";
    NSString *img3 = @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/110425215921926a173e0f728e.jpg";
    NSString *img4 = @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/1104241737046031b3a754f783.jpg";
    NSString *img5 = @"http://2b.zol-img.com.cn/product/68/951/cerUrKWCmHCnU.jpg";

    [imgArr addObject:img1];
    [imgArr addObject:img2];
    [imgArr addObject:img3];
    [imgArr addObject:img4];
    [imgArr addObject:img5];
    
    NSString *string1 = @"网络图片加载时";
    NSString *string2 = @"图片较大";
    NSString *string3 = @"所以比较缓慢";
    NSString *string4 = @"如有框架建议";
    NSString *string5 = @"GitHub上指教我(通过Email)";
    NSMutableArray *IntroduceArr = [NSMutableArray array];
    
    [IntroduceArr addObject:string1];
    [IntroduceArr addObject:string2];
    [IntroduceArr addObject:string3];
    [IntroduceArr addObject:string4];
    [IntroduceArr addObject:string5];
    
    // 1.本地图片加载
//    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr:imgArr frame:CGRectMake(0, 20, self.view.frame.size.width, 180)];
    
    
    // 2.网络图片加载
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:imgArr frame:CGRectMake(0, 64, self.view.width, 180)];
    bannerView.delegate = self;
    
    
    bannerView.IntroduceStringArr = IntroduceArr;
    bannerView.placeHolder = @"3";
    
//    bannerView.timeInterval = 2;
    
//    bannerView.IntroduceTextFont = [UIFont systemFontOfSize:20];
//    bannerView.IntroduceBackGroundAlpha = 1.0;
//    bannerView.IntroduceBackGroundColor = [UIColor greenColor];
//    bannerView.IntroduceHeight = 60;
//    bannerView.IntroduceTextColor = [UIColor redColor];
    
//    bannerView.PageIndicatorTintColor = [UIColor whiteColor];
//    bannerView.CurrentPageIndicatorTintColor = [UIColor blackColor];
//    bannerView.pageControlStyle = KNPageControlStyleRight;
//    bannerView.IntroduceStyle = KNIntroduceStyleRight;
    
    [self.view addSubview:bannerView];
}

- (void)KNBannerView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    
}

@end
