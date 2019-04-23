//
//  KNBlendNetworkController.m
//  KNBannerView
//
//  Created by LuKane on 2019/4/23.
//  Copyright © 2019 KNKane. All rights reserved.
//

#import "KNBlendNetworkController.h"
#import "KNBannerView.h"
@interface KNBlendNetworkController ()<KNBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic,weak  ) KNBannerView *bannerView1;
@property (nonatomic,weak  ) KNBannerView *bannerView2;
@property (nonatomic,weak  ) KNBannerView *bannerView3;

@property (nonatomic,strong) NSMutableArray *changeArr;

@end

@implementation KNBlendNetworkController

- (NSMutableArray *)changeArr{
    if(!_changeArr){
        _changeArr = [NSMutableArray array];
        
        NSString *url1 = @"http://ww4.sinaimg.cn/mw690/9bbc284bgw1fb29llpshkj20m80dwjt6.jpg";
        UIImage *img2 = [UIImage imageNamed:@"2Change"];
        
        [_changeArr addObject:url1];
        [_changeArr addObject:img2];
    }
    return _changeArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"混合:模仿网络请求";
    [self setupNav];
    
    // 可以在网络请求之后,再创建 banner, 也可以 提前创建 banner : 记得刷新就行
    // 如果有缓存,则先创建 banner, 在家在缓存... 在网络请求.. 再刷新
    // 这里的Demo : 没有缓存 , 先创建一个 空的banner, 网络请求, 再刷新
    
    // BannerView3 的占位图 是一张 风景图
    
    [self setupNetWorkBannerView1];
    [self setupNetWorkBannerView2];
    [self setupNetWorkBannerView3];
    
    [self.scrollView setContentSize:(CGSize){0,10 + 30 * 3 + 180 * 3}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    NSString *url1 = @"http://ww1.sinaimg.cn/mw690/9bbc284bgw1f9rk86nq06j20fa0a4whs.jpg";
    UIImage *img2 = [UIImage imageNamed:@"2"];
    NSString *url3 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0nw7zbj20rs0jntk7.jpg";
    UIImage *img4 = [UIImage imageNamed:@"4"];
    NSString *url5 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg10w0w1j20s40jsah1.jpg";
    
    [self.dataArr addObject:url1];
    [self.dataArr addObject:img2];
    [self.dataArr addObject:url3];
    [self.dataArr addObject:img4];
    [self.dataArr addObject:url5];
    
    
    _bannerView1.blendImgArr = [self.dataArr mutableCopy];
    _bannerView2.blendImgArr = [self.dataArr mutableCopy];
    _bannerView3.blendImgArr = [self.dataArr mutableCopy];
    
    [_bannerView1 reloadData];
    [_bannerView2 reloadData];
    [_bannerView3 reloadData];
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
    _bannerView1.blendImgArr = [self.changeArr mutableCopy];
    _bannerView2.blendImgArr = [self.changeArr mutableCopy];
    _bannerView3.blendImgArr = [self.changeArr mutableCopy];
    
    [_bannerView1 reloadData];
    [_bannerView2 reloadData];
    [_bannerView3 reloadData];
}

- (void)setupNetWorkBannerView1{
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:@[@"http://www."] frame:CGRectMake(0, 10, self.view.frame.size.width, 180)];
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
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:@[@"http://www."] frame:CGRectMake(0, 10 + 30 + 180, self.view.frame.size.width, 180)];
    
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
    KNBannerView *bannerView = [KNBannerView bannerViewWithBlendImagesArr:@[@"http://www."]
                                                                    frame:CGRectMake(0, 10 + 30 + 180 + 30 + 180, self.view.frame.size.width, 180)];
    
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    
    [viewM setIsNeedPageControl:YES]; // 默认系统PageControl
    [viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中
    
    [viewM setIsNeedTimerRun:YES]; // 是否需要定时
    [viewM setBannerTimeInterval:1]; // 改变 定时器时间
    [viewM setBannerCornerRadius:8]; // 切个圆角
    [viewM setLeftMargin:10]; // 设置个边距
    [viewM setPlaceHolder:[UIImage imageNamed:@"3"]];
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    [bannerView setTag:2];
    
    [self.scrollView addSubview:bannerView];
    _bannerView3 = bannerView;
}

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"BannerView :%zd -- index :%zd",bannerView.tag,index);
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _bannerView1.frame = CGRectMake(0, 10, self.view.frame.size.width, 180);
    _bannerView2.frame = CGRectMake(0, 10 + 30 + 180, self.view.frame.size.width, 180);
    _bannerView3.frame = CGRectMake(0, 10 + 30 + 180 + 30 + 180, self.view.frame.size.width, 180);
}

@end
