//
//  KNNetworkController.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/15.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNNetworkController.h"
#import "KNBannerView.h"

@interface KNNetworkController ()<KNBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *urlArr;

@property (nonatomic,weak  ) KNBannerView *bannerView1;
@property (nonatomic,weak  ) KNBannerView *bannerView2;
@property (nonatomic,weak  ) KNBannerView *bannerView3;

@property (nonatomic,strong) NSMutableArray *changeArr;

@end

@implementation KNNetworkController

- (NSMutableArray *)changeArr{
    if (!_changeArr) {
        
        _changeArr = [NSMutableArray array];
        
        NSString *url1 = @"http://ww4.sinaimg.cn/mw690/9bbc284bgw1fb29llpshkj20m80dwjt6.jpg";
        NSString *url2 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1fb29lmpn6xj20ia0c5juf.jpg";
        NSString *url3 = @"http://ww4.sinaimg.cn/mw690/9bbc284bgw1fb29lnhmypj20m80gojtg.jpg";
        NSString *url4 = @"http://ww1.sinaimg.cn/mw690/9bbc284bgw1fb29loe46cj20m80go77l.jpg";
        NSString *url5 = @"http://ww4.sinaimg.cn/mw690/9bbc284bgw1fb29lsbrfzj20m80godjg.jpg";
        
        [_changeArr addObject:url1];
        [_changeArr addObject:url2];
        [_changeArr addObject:url3];
        [_changeArr addObject:url4];
        [_changeArr addObject:url5];
    }
    return _changeArr;
}


- (NSMutableArray *)urlArr{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
        NSString *url1 = @"http://ww1.sinaimg.cn/mw690/9bbc284bgw1f9rk86nq06j20fa0a4whs.jpg";
        NSString *url2 = @"http://ww3.sinaimg.cn/mw690/9bbc284bgw1f9qg0bazmnj21hc0u0dop.jpg";
        NSString *url3 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0nw7zbj20rs0jntk7.jpg";
        NSString *url4 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0utssrj20sg0hyx0o.jpg";
        NSString *url5 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg10w0w1j20s40jsah1.jpg";
        
        [_urlArr addObject:url1];
        [_urlArr addObject:url2];
        [_urlArr addObject:url3];
        [_urlArr addObject:url4];
        [_urlArr addObject:url5];
    }
    return _urlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络";
    [self setupNav];
    
    [self setupNetWorkBannerView1];
    [self setupNetWorkBannerView2];
    [self setupNetWorkBannerView3];
    
    
    [self.scrollView setContentSize:(CGSize){0,90 + 30 * 3 + 180 * 3}];
}

- (void)setupNav{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"Change" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setFrame:(CGRect){CGPointZero,{60,30}}];
    [rightBtn addTarget:self action:@selector(rightBtnIBAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBtnIBAction{
    
    _bannerView1.netWorkImgArr = [self.changeArr mutableCopy];
    _bannerView2.netWorkImgArr = [self.changeArr mutableCopy];
    _bannerView3.netWorkImgArr = [self.changeArr mutableCopy];
    
    [_bannerView1 reloadData];
    [_bannerView2 reloadData];
    [_bannerView3 reloadData];
}

// 样式1
- (void)setupNetWorkBannerView1{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                            frame:CGRectMake(0, 90, self.view.frame.size.width, 180)];
    
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
    _bannerView1 = bannerView;
}

- (void)setupNetWorkBannerView2{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                                                      frame:CGRectMake(0, 90 + 30 + 180, self.view.frame.size.width, 180)];
    
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
    _bannerView2 = bannerView;
}

- (void)setupNetWorkBannerView3{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
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
    _bannerView3 = bannerView;
}

/****************************** == Delegate == ********************************/

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    
    NSLog(@"%@",collectionViewCell.imageView);
    
    
    NSLog(@"BannerView :%zd -- index :%zd",bannerView.tag,index);
}

@end
