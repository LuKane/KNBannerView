//
//  KNBlendController.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/15.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNBlendController.h"
#import "KNBannerView.h"

@interface KNBlendController ()<KNBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation KNBlendController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
        
        NSString *url1 = @"http://ww1.sinaimg.cn/mw690/9bbc284bgw1f9rk86nq06j20fa0a4whs.jpg";
        NSString *img2 = @"2";
        NSString *url3 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0nw7zbj20rs0jntk7.jpg";
        NSString *img4 = @"4";
        NSString *url5 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg10w0w1j20s40jsah1.jpg";
        
        [_dataArr addObject:url1];
        [_dataArr addObject:img2];
        [_dataArr addObject:url3];
        [_dataArr addObject:img4];
        [_dataArr addObject:url5];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络+本地(混合)";
    
    [self setupNetWorkBannerView1];
    [self setupNetWorkBannerView2];
    [self setupNetWorkBannerView3];
}

- (void)setupNetWorkBannerView1{
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:[self.dataArr copy] frame:CGRectMake(0, 90, self.view.frame.size.width, 180)];
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    [viewM setTextArr:[self.textArr copy]]; // 设置文字, 注意:如果文字和图片的数量不相符,则没有文字.如果不要文字,则不传
    [viewM setTextShowStyle:KNBannerViewTextShowStyleStay]; // 设置文字展示的样式
    
    NSArray *customPageImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"pageControlSelected1"],[UIImage imageNamed:@"pageControlUnSelected1"], nil];
    [viewM setPageControlImgArr:[customPageImgArr copy]]; // 设置自定义PageControl的两张图
    [viewM setIsNeedPageControl:YES]; // 记得设置 YES
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    
    [bannerView setTag:0]; // 标识是哪个bannerView
    
    
    [self.scrollView addSubview:bannerView];
}

- (void)setupNetWorkBannerView2{
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:[self.dataArr copy] frame:CGRectMake(0, 90 + 30 + 180, self.view.frame.size.width, 180)];
    
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    [viewM setTextArr:[self.textArr copy]]; // 设置文字, 注意:如果文字和图片的数量不相符,则没有文字
    [viewM setTextShowStyle:KNBannerViewTextShowStyleStay]; // 设置文字展示的样式
    [viewM setTextStayStyle:KNBannerViewTextStayStyleRight];// 将文字 显示放在右边
    
    NSArray *customPageImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"pageControlSelected1"],[UIImage imageNamed:@"pageControlUnSelected1"], nil];
    [viewM setPageControlImgArr:[customPageImgArr copy]]; // 设置自定义PageControl的两张图
    [viewM setIsNeedPageControl:YES]; // 记得设置 YES
    [viewM setPageControlStyle:KNBannerPageControlStyleLeft]; // 设置pageControl 在左边
    [viewM setIsNeedTimerRun:YES]; // 是否需要定时
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    [bannerView setTag:1];
    
    [self.scrollView addSubview:bannerView];
}

- (void)setupNetWorkBannerView3{
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:[self.dataArr copy]
                                                                       frame:CGRectMake(0, 90 + 30 + 180 + 30 + 180, self.view.frame.size.width, 180)];
    
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    
    [viewM setIsNeedPageControl:YES]; // 默认系统PageControl
    [viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中
    
    [viewM setIsNeedTimerRun:YES]; // 是否需要定时
    [viewM setBannerTimeInterval:1]; // 改变 定时器时间
    
    [viewM setPlaceHolder:[UIImage imageNamed:@"3"]];
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    [bannerView setTag:2];
    
    [self.scrollView addSubview:bannerView];
}

@end
