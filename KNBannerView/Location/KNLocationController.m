//
//  KNLocationController.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/15.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNLocationController.h"
#import "KNBannerView.h"

@interface KNLocationController ()<KNBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic,weak  ) KNBannerView *bannerView1;
@property (nonatomic,weak  ) KNBannerView *bannerView2;
@property (nonatomic,weak  ) KNBannerView *bannerView3;

@property (nonatomic,strong) NSMutableArray *changeArr;

@end

@implementation KNLocationController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
        
        UIImage *img1 = [UIImage imageNamed:@"1"];
        UIImage *img2 = [UIImage imageNamed:@"2"];
        UIImage *img3 = [UIImage imageNamed:@"3"];
        UIImage *img4 = [UIImage imageNamed:@"4"];
        UIImage *img5 = [UIImage imageNamed:@"5"];
        
        [_dataArr addObject:img1];
        [_dataArr addObject:img2];
        [_dataArr addObject:img3];
        [_dataArr addObject:img4];
        [_dataArr addObject:img5];
    }
    return _dataArr;
}

- (NSMutableArray *)changeArr{
    if(!_changeArr){
        _changeArr = [NSMutableArray array];
        
        UIImage *img1 = [UIImage imageNamed:@"1Change"];
        UIImage *img2 = [UIImage imageNamed:@"2Change"];
        UIImage *img3 = [UIImage imageNamed:@"3Change"];
        UIImage *img4 = [UIImage imageNamed:@"4Change"];
        UIImage *img5 = [UIImage imageNamed:@"5Change"];
        
        [_changeArr addObject:img1];
        [_changeArr addObject:img2];
        [_changeArr addObject:img3];
        [_changeArr addObject:img4];
        [_changeArr addObject:img5];
    }
    return _changeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地";
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
    _bannerView1.locationImgArr = [self.changeArr mutableCopy];
    _bannerView2.locationImgArr = [self.changeArr mutableCopy];
    _bannerView3.locationImgArr = [self.changeArr mutableCopy];
    
    [_bannerView1 reloadData];
    [_bannerView2 reloadData];
    [_bannerView3 reloadData];
}

- (void)setupNetWorkBannerView1{
    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr:[self.dataArr copy] frame:CGRectMake(0, 90, self.view.frame.size.width, 180)];
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
    [viewM setIsNeedCycle:true];
    [viewM setIsNeedTimerRun:true];
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    
    [bannerView setTag:0]; // 标识是哪个bannerView
    
    [self.scrollView addSubview:bannerView];
    
    _bannerView1 = bannerView;
}

- (void)setupNetWorkBannerView2{
    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr: [self.dataArr copy] frame:CGRectMake(0, 90 + 30 + 180, self.view.frame.size.width, 180)];
    
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
    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr:[self.dataArr copy]
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

@end
