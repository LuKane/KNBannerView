//
//  KNBackGroundController.m
//  KNBannerView
//
//  Created by LuKane on 2018/7/6.
//  Copyright © 2018年 KNKane. All rights reserved.
//

#import "KNBackGroundController.h"
#import "KNBannerView.h"

#define KNColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface KNBackGroundController ()<KNBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic,strong) NSMutableArray *changeArr;

@property (nonatomic,strong) NSMutableArray *colorArr;
@property (nonatomic,strong) NSMutableArray *changeColorArr;

@property (nonatomic,weak  ) UIImageView *topImageView;
@property (nonatomic,weak  ) UIImageView *bottomImageView;

@property (nonatomic,weak  ) KNBannerView *bannerView1;

@end

@implementation KNBackGroundController

- (NSMutableArray *)colorArr{
    if (!_colorArr) {
        _colorArr = [NSMutableArray array];
        [_colorArr addObject:KNColorFromRGB(0x5676F7)];
        [_colorArr addObject:KNColorFromRGB(0xE95B44)];
        [_colorArr addObject:KNColorFromRGB(0x25A053)];
    }
    return _colorArr;
}

- (NSMutableArray *)changeColorArr{
    if (!_changeColorArr) {
        _changeColorArr = [NSMutableArray array];
        [_changeColorArr addObject:KNColorFromRGB(0xE95B44)];
        [_changeColorArr addObject:KNColorFromRGB(0x25A053)];
    }
    return _changeColorArr;
}

- (NSMutableArray *)changeArr{
    if (!_changeArr) {
        
        _changeArr = [NSMutableArray array];
        
        NSString *url1 = @"https://wx4.sinaimg.cn/mw690/005TQtyLly1ft05o87llij312c0gwn0p.jpg";// 红色
        NSString *url2 = @"https://wx1.sinaimg.cn/mw690/005TQtyLly1ft05o8gwjij30j608g0u1.jpg";// 绿色
        
        [_changeArr addObject:url1];
        [_changeArr addObject:url2];
    }
    return _changeArr;
}

- (NSMutableArray *)urlArr{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
        NSString *url1 = @"https://wx4.sinaimg.cn/mw690/005TQtyLly1ft05o8ru11j30j608gwfu.jpg";// 蓝色
        NSString *url2 = @"https://wx4.sinaimg.cn/mw690/005TQtyLly1ft05o87llij312c0gwn0p.jpg";// 红色
        NSString *url3 = @"https://wx1.sinaimg.cn/mw690/005TQtyLly1ft05o8gwjij30j608g0u1.jpg";// 绿色
        
        [_urlArr addObject:url1];
        [_urlArr addObject:url2];
        [_urlArr addObject:url3];
    }
    return _urlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"背景色切换";
    [self setupNav];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 180)];
    _topImageView = topImageView;
    [self.view insertSubview:topImageView belowSubview:self.scrollView];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 180)];
    _bottomImageView = bottomImageView;
    [self.view insertSubview:bottomImageView belowSubview:self.scrollView];
    
    [self setupNetWorkBannerView1];
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
    // 1.若要设置 背景色 ,必须写在 图片数组的前面
    
    _bannerView1.changeColorArr = self.changeColorArr.mutableCopy;

    // 1.1 ( 将 背景色 取消掉, 只需设置颜色 为 clearColor)
//    NSMutableArray *tempArr = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.changeArr.count; i++) {
//        [tempArr addObject:[UIColor clearColor]];
//    }
//    _bannerView1.changeColorArr = tempArr.mutableCopy;
    
    _bannerView1.netWorkImgArr = [self.changeArr mutableCopy];
    
    [_bannerView1 reloadData];
}

// 样式1
- (void)setupNetWorkBannerView1{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                                                      frame:CGRectMake(0, 150, self.view.frame.size.width, 180)];
    
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    [viewM setTextArr:[self.textArr copy]]; // 设置文字, 注意:如果文字和图片的数量不相符,则没有文字.如果不要文字,则不传
    [viewM setTextShowStyle:KNBannerViewTextShowStyleStay]; // 设置文字展示的样式
    
    [viewM setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [viewM setPageIndicatorTintColor:[UIColor whiteColor]];
    [viewM setPageControlStyle:KNBannerPageControlStyleMiddel];
    [viewM setIsNeedTimerRun:true];
    [viewM setIsNeedCycle:true];
    [viewM setIsNeedPageControl:YES]; // 记得设置 YES
    [viewM setIsNeedCycle:YES];
    [viewM setBgChangeColorArr:self.colorArr.copy];
    [viewM setLeftMargin:15];
    [viewM setBannerCornerRadius:10];
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    
    [bannerView setTag:0]; // 标识是哪个bannerView
    
    [self.scrollView addSubview:bannerView];
    _bannerView1 = bannerView;
}

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    
    NSLog(@"BannerView :%zd -- index :%zd",bannerView.tag,index);
}

- (void)bannerView:(KNBannerView *)bannerView topColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor alpha:(CGFloat)alpha isRight:(BOOL)isRight{

    
    /* 这里是做判断 , 如果当前数据源 就一张图片时, 就不改变 背景色 */
    /* bannerView.netWorkImgArr 对应创建时 KNBannerView bannerViewWithNetWorkImagesArr  */
    
    if(bannerView.netWorkImgArr.count == 1){
        return;
    }
    
    if(topColor){
        _topImageView.backgroundColor = topColor;
        if(bottomColor){
            if(isRight){
                _topImageView.alpha = alpha;
            }else{
                _topImageView.alpha = 1 - alpha;
            }
        }else{
            _topImageView.alpha = 1.0;
        }
    }else{
        _topImageView.backgroundColor = nil;
    }
    
    if(bottomColor){
        _bottomImageView.backgroundColor = bottomColor;
        if(isRight){
            _bottomImageView.alpha = 1 - alpha;
        }else{
            _bottomImageView.alpha = alpha;
        }
    }else{
        _bottomImageView.backgroundColor = nil;
        _bottomImageView.alpha = 0.0;
    }
}



@end
