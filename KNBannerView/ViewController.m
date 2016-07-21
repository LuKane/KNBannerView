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
    self.title = @"KNBannerView演示";
    
// self.automaticallyAdjustsScrollViewInsets 这个属性是IOS7才有的新方法，目的就是为了让scrollView自动适应屏幕
/****************************** == 加上下面这句代码 == ********************************/
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
/****************************** == 加上上面这句代码 == ********************************/
    
    [self setupNetWorkBannerView];
    [self setupLocatioBannerView];
}

/**
 *  设置 网络 banner图
 */
- (void)setupNetWorkBannerView{
    NSMutableArray *imgArr = [NSMutableArray array];
    NSString *img1 = @"http://i3.download.fd.pchome.net/t_960x600/g1/M00/07/09/oYYBAFMv8q2IQHunACi90oB0OHIAABbUQAAXO4AKL3q706.jpg";
    NSString *img2 = @"http://images.weiphone.net/attachments/photo/Day_120308/118871_91f6133116504086ed1b82e0eb951.jpg";
    NSString *img3 = @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/110425215921926a173e0f728e.jpg";
    NSString *img4 = @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/1104241737046031b3a754f783.jpg";
    NSString *img5 = @"http://2b.zol-img.com.cn/product/68/951/cerUrKWCmHCnU.jpg";
    [imgArr addObject:img1];
//    [imgArr addObject:img2];
//    [imgArr addObject:img3];
//    [imgArr addObject:img4];
//    [imgArr addObject:img5];
    
    // 设置 网络 轮播图
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:imgArr frame:CGRectMake(0, 64, self.view.width, 180)];
    bannerView.delegate = self;
    
    /****************************** == 描述文字 == ********************************/
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
    bannerView.IntroduceStringArr = IntroduceArr;
    /****************************** == 占位图 == ********************************/
    bannerView.placeHolder = @"3";
    bannerView.textShowStyle = KNTextShowStyleStay;
    bannerView.tag = 100;
    [self.view addSubview:bannerView];
}

/**
 *  设置 本地 banner图
 */
- (void)setupLocatioBannerView{
    NSString *img1 = @"1";
    NSString *img2 = @"2";
    NSString *img3 = @"3";
    NSString *img4 = @"4";
    NSString *img5 = @"5";
    NSArray *imgArr = [NSArray arrayWithObjects:img1,img2,img3,img4,img5, nil];
    
    // 设置 本地 轮播图
    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr:imgArr frame:CGRectMake(0, 300, self.view.frame.size.width, 180)];
/****************************** == 描述文字 == ********************************/
    NSString *string1 = @"这是本地图片";
    NSString *string2 = @"如果觉得还不错";
    NSString *string3 = @"记得给我点赞哦";
    NSString *string4 = @"我会更加努力的";
    NSString *string5 = @"谢谢大家的支持!";
    NSMutableArray *IntroduceArr = [NSMutableArray array];
    [IntroduceArr addObject:string1];
    [IntroduceArr addObject:string2];
    [IntroduceArr addObject:string3];
    [IntroduceArr addObject:string4];
    [IntroduceArr addObject:string5];
    bannerView.IntroduceStringArr = IntroduceArr;
    bannerView.timeInterval = 1.5; // 图片轮播的时间间隔
    bannerView.IntroduceTextFont = [UIFont systemFontOfSize:17];// 介绍文字字体大小
    bannerView.IntroduceBackGroundAlpha = 1.0;// 介绍文字的透明度
    bannerView.IntroduceBackGroundColor = [UIColor blackColor]; // 介绍文字的背景色
//    bannerView.IntroduceHeight = 60;// 介绍文字的高度   
    bannerView.IntroduceTextColor = [UIColor orangeColor]; // 介绍文字的颜色
    bannerView.PageIndicatorTintColor = [UIColor whiteColor];// pageControl的 其他'点'的颜色
    bannerView.CurrentPageIndicatorTintColor = [UIColor orangeColor];// pageControl的 当前'点'的颜色
    bannerView.pageControlStyle = KNPageControlStyleLeft;// pageControl 对其方式
    bannerView.IntroduceStyle = KNIntroduceStyleRight;// 介绍文字的对其方式
    bannerView.textShowStyle = KNTextShowStyleFadeOut;// 介绍文字的 显示样式 : 滚动 || 显现 || 直接切换
    bannerView.delegate = self;
    bannerView.tag = 200;
    [self.view addSubview:bannerView];
}

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"%zd---%zd",bannerView.tag,index);
}

@end
