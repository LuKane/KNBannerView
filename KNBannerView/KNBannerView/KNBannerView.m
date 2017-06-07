//
//  KNBannerView.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/8.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#import "KNBannerView.h"
#import "KNBannerCollectionViewCell.h"
#import "KNBannerViewText.h"
#import "UIView+KNExtension.h"
#import "KNBannerPageControl.h"

typedef NS_ENUM(NSInteger,KNBannerType){
    KNBannerTypeNetwork,  // 网络
    KNBannerTypeLocation, // 本地
    KNBannerTypeBlend     // 本地和网络结合
};

@interface KNBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    KNBannerType             _bannerImageType;
    UICollectionView        *_collectionView;
    UICollectionViewFlowLayout  *_layout;
    KNBannerCollectionViewCell    *_collectionViewCell;
    NSInteger                _page;// 页数
    KNBannerViewModel       *_defaultModel;// 默认的模型
    NSTimer                 *_bannerTimer; // bannerView 的 timer
    
    KNBannerViewText        *_viewText; // 文字 view
    BOOL                     _isNeedText;
    KNBannerPageControl     *_pageControl;
}

/* 临时图片数组 : 将.h 3种类型的数组的内容放入此数组中 */
@property (nonatomic, strong) NSMutableArray *imageArr;

@end

static NSString *const KNCollectionViewID = @"KNBannerViewCollectionViewID";

@implementation KNBannerView

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame{
    KNBannerView *bannerView = [[self alloc] initWithFrame:frame];
    if([self isEmptyArray:netWorkImgArr]) return bannerView;
    [bannerView setNetWorkImgArr:[netWorkImgArr mutableCopy]];
    return bannerView;
}
+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame{
    KNBannerView *bannerView = [[self alloc] initWithFrame:frame];
    if([self isEmptyArray:locationImgArr]) return bannerView;
    [bannerView setLocationImgArr:[locationImgArr mutableCopy]];
    return bannerView;
}
+ (instancetype)bannerViewWithBlendImagesArr:(NSArray *)blendImgArr frame:(CGRect)frame{
    KNBannerView *bannerView = [[self alloc] initWithFrame:frame];
    if([self isEmptyArray:blendImgArr]) return bannerView;
    [bannerView setBlendImgArr:[blendImgArr mutableCopy]];
    return bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializeCollectionView];// 初始化 collectionView
        [self initializeDefaultData];   // 初始化 默认数据
    }
    return self;
}

- (void)reloadData{
    
    [self initializeDefaultData];
    
    [self jumpToLocation];
    
//    self.bannerViewModel = _defaultModel;
    self.bannerViewModel.numberOfPages = self.imageArr.count;
    
    [_pageControl setBannerViewModel:self.bannerViewModel];
    
    [_collectionView reloadData];
}

/****************************** == 重写 数组的 setter == ********************************/
#pragma mark - setter ->本地图片
- (void)setLocationImgArr:(NSMutableArray *)locationImgArr{
    [self.imageArr removeAllObjects];
    [_collectionView reloadData]; // 重新给 数组赋值,则刷新 collectionView
    _bannerImageType = KNBannerTypeLocation;
    _locationImgArr = locationImgArr;
    for (NSInteger i = 0; i < locationImgArr.count; i++) {
        BOOL isString = [locationImgArr[i] isKindOfClass:[UIImage class]];
        NSAssert(isString, @"\n **加载本地图片,LocationImgArr 内必须添加 图片(UIImage) ** \n");
        [self.imageArr addObject:locationImgArr[i]];
    }
    
    [self initializePageControl];
    [self jumpToLocation];
}

#pragma mark - setter ->网络图片
- (void)setNetWorkImgArr:(NSMutableArray *)netWorkImgArr{
    [self.imageArr removeAllObjects];
    [_collectionView reloadData]; // 重新给 数组赋值,则刷新 collectionView
    _bannerImageType = KNBannerTypeNetwork;
    _netWorkImgArr = netWorkImgArr;
    for (NSInteger i = 0; i < netWorkImgArr.count; i++) {
        BOOL isHttpString = false;
        isHttpString = [netWorkImgArr[i] isKindOfClass:[NSString class]];
        if([netWorkImgArr[i] hasPrefix:@"http"] || [netWorkImgArr[i] hasPrefix:@"https"]){
            isHttpString = true;
        }else{
            isHttpString = false;
        }
        NSAssert(isHttpString, @"\n **加载网络图片,NetWorkImgArr 内必须添加 图片URL的绝对路径** \n");
        [self.imageArr addObject:netWorkImgArr[i]];
    }
    
    [self initializePageControl];
    [self jumpToLocation];
}

#pragma mark - setter ->混合图片
- (void)setBlendImgArr:(NSMutableArray *)blendImgArr{
    [self.imageArr removeAllObjects];
    [_collectionView reloadData]; // 重新给 数组赋值,则刷新 collectionView
    _bannerImageType = KNBannerTypeBlend;
    _blendImgArr = blendImgArr;
    for (NSInteger i = 0; i < blendImgArr.count; i++) {
        BOOL isBlend = false;
        if([blendImgArr[i] isKindOfClass:[UIImage class]]) isBlend = YES;
        
        if([blendImgArr[i] isKindOfClass:[NSString class]]){
            if([blendImgArr[i] hasPrefix:@"http"] || [blendImgArr[i] hasPrefix:@"https"]){
                isBlend = YES;
            }
        }
        NSAssert(isBlend, @"\n **加载混合图片,blendImgArr 内必须添加 图片URL的绝对路径 或者 图片(UIImage) ** \n");
        [self.imageArr addObject:blendImgArr[i]];
    }
    
    [self initializePageControl];
    [self jumpToLocation];
}

- (void)jumpToLocation{
    if(_imageArr.count == 1) return;
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageArr.count * 50 * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - 初始化 默认数据
- (void)initializeDefaultData{
    _defaultModel = [[KNBannerViewModel alloc] init];
    
    [_defaultModel setTextStayStyle:KNBannerViewTextStayStyleLeft];
    [_defaultModel setTextColor:[UIColor whiteColor]];
    [_defaultModel setTextFont:[UIFont fontWithName:@"Heiti SC" size:15]];
    [_defaultModel setTextBackGroundColor:[UIColor blackColor]];
    [_defaultModel setTextBackGroundAlpha:0.7f];
    [_defaultModel setTextShowStyle:KNBannerViewTextShowStyleNormal];
    [_defaultModel setBannerTimeInterval:1.5f];
    [_defaultModel setIsNeedTimerRun:NO];
    [_defaultModel setPlaceHolder:[UIImage imageNamed:@"KNBannerViewSource.bundle/placeHolder.png"]];
    
    [_defaultModel setPageControlImgArr:nil];
    [_defaultModel setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    [_defaultModel setPageIndicatorTintColor:[UIColor whiteColor]];
    [_defaultModel setIsNeedPageControl:NO];
    [_defaultModel setPageControlStyle:KNBannerPageControlStyleRight];
    [_defaultModel setNumberOfPages:self.imageArr.count];
}

#pragma mark - 设置 text 的参数
- (void)setBannerViewModel:(KNBannerViewModel *)bannerViewModel{
    _bannerViewModel = bannerViewModel;
    
    if(![_bannerViewModel    textStayStyle])
        [_bannerViewModel setTextStayStyle:[_defaultModel textStayStyle]];
    
    if(![_bannerViewModel    textColor])
        [_bannerViewModel setTextColor:[_defaultModel textColor]];
    
    if(![_bannerViewModel    textFont])
        [_bannerViewModel setTextFont:[_defaultModel textFont]];
    
    if(![_bannerViewModel    textBackGroundColor])
        [_bannerViewModel setTextBackGroundColor:[_defaultModel textBackGroundColor]];
    
    if(![_bannerViewModel    textBackGroundAlpha])
        [_bannerViewModel setTextBackGroundAlpha:[_defaultModel textBackGroundAlpha]];
    
    if(![_bannerViewModel    textShowStyle]){
        [_bannerViewModel setTextShowStyle:[_defaultModel textShowStyle]];
    }
    
    if(![_bannerViewModel    isNeedTimerRun]){ // 不需要定时器
        [_bannerViewModel setBannerTimeInterval:0];
    }else{ // 需要定时器
        if([_bannerViewModel     bannerTimeInterval] <= 0){
            [_bannerViewModel setBannerTimeInterval:[_defaultModel bannerTimeInterval]];
        }
    }
    
    if(![_bannerViewModel    placeHolder])
        [_bannerViewModel setPlaceHolder:[_defaultModel placeHolder]];
    
    if(![self isEmptyArray:[_bannerViewModel textArr]]){
        if([self.imageArr count] != [[_bannerViewModel textArr] count]){
            _isNeedText = NO;
        }else{
            _isNeedText = YES;
        }
    }else{
        _isNeedText = NO;
    }
    
    switch ([_bannerViewModel textShowStyle]) {
        case KNBannerViewTextShowStyleNormal:{
            [_bannerViewModel setIsNeedText:_isNeedText];
        }
            break;
        case KNBannerViewTextShowStyleStay:{
            [_bannerViewModel setIsNeedText:NO];
            if(_isNeedText){
                if(!_viewText) [self initializeViewText];      // 初始化 text 的控件
            }
        }
            break;
        default:
            break;
    }
    
    [self removeTimer];
    
    if([_bannerViewModel isNeedTimerRun]) [self setupTimer];
    
    /* pageControl */
    if(![_bannerViewModel pageControlStyle])
        [_bannerViewModel setPageControlStyle:[_defaultModel pageControlStyle]];
    
    if(![_bannerViewModel CurrentPageIndicatorTintColor])
        [_bannerViewModel setCurrentPageIndicatorTintColor:[_defaultModel CurrentPageIndicatorTintColor]];
    
    if(![_bannerViewModel PageIndicatorTintColor])
        [_bannerViewModel setPageIndicatorTintColor:[_defaultModel PageIndicatorTintColor]];
    
    if(![_bannerViewModel isNeedPageControl]){
        [_bannerViewModel setIsNeedPageControl:[_defaultModel isNeedPageControl]];
    }else{
        [_pageControl setHidden:NO];
    }
    
    if(![self isEmptyArray:[_bannerViewModel pageControlImgArr]]){ // 自定义 PageControl
        [_bannerViewModel setNumberOfPages:self.imageArr.count];
        [_pageControl setBannerViewModel:_bannerViewModel];
    }else{ //UIPageControl
        KNBannerViewModel *bannerViewModel = [[KNBannerViewModel alloc] init];
        [bannerViewModel setPageControlStyle:[_bannerViewModel pageControlStyle]];
        [bannerViewModel setPageIndicatorTintColor:[_bannerViewModel PageIndicatorTintColor]];
        [bannerViewModel setCurrentPageIndicatorTintColor:[_bannerViewModel CurrentPageIndicatorTintColor]];
        [bannerViewModel setNumberOfPages:self.imageArr.count];
        [_pageControl setBannerViewModel:bannerViewModel];
    }
    _defaultModel = bannerViewModel;
}

#pragma mark - 创建 Text 的 view控件
- (void)initializeViewText{
    KNBannerViewText *viewText = [[KNBannerViewText alloc] initWithFrame:CGRectMake(0, self.height - TextHeight, self.width,TextHeight)];
    [viewText setBannerViewModel: self.bannerViewModel];
    [viewText setText:_bannerViewModel.textArr[0]];
    _viewText = viewText;
    [self insertSubview:viewText belowSubview:_pageControl];
}

#pragma mark - 初始化 PageControl
- (void)initializePageControl{
    if(_pageControl) return;
    
    if(_imageArr.count == 1){
        [_pageControl setHidden:YES];
        return;
    }
    
    KNBannerPageControl *pageControl = [[KNBannerPageControl alloc] init];
    [pageControl setHidden:YES];
    _pageControl = pageControl;
    [self addSubview:pageControl];
}

/****************************** == collectionView == ********************************/
#pragma mark - 初始化 collectionView
- (void)initializeCollectionView{
    // 1.创建 collectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:[self size]];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _layout = layout;
    
    // 2.创建 collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[self bounds] collectionViewLayout:layout];
    
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView setPagingEnabled:YES];
    
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    
    [collectionView setShowsVerticalScrollIndicator:NO];
    [collectionView setShowsHorizontalScrollIndicator:NO];
    
    [collectionView registerClass:[KNBannerCollectionViewCell class]
       forCellWithReuseIdentifier:KNCollectionViewID];
    
    [self addSubview:collectionView];
    _collectionView = collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.imageArr.count == 1) return 1;
    return self.imageArr.count * 50;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KNBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KNCollectionViewID forIndexPath:indexPath];
    
    NSInteger row = indexPath.row % self.imageArr.count;
    
    if([self.imageArr[row] isKindOfClass:[NSString class]]){
        if([self.imageArr[row] hasPrefix:@"http"]){ // 网络图片
            [cell setPlaceHolder:[_bannerViewModel placeHolder]];
            [cell setUrl:self.imageArr[row]];
        }
    }else{
        [cell setImage:self.imageArr[row]];
    }
    
    if(![cell isSet]){
        [cell setIsSet:YES];
        [cell setBannerViewModel:_bannerViewModel];
    }
    
    if([_bannerViewModel textShowStyle] == KNBannerViewTextShowStyleNormal){
        if([_bannerViewModel isNeedText]){
            [cell setText:_bannerViewModel.textArr[row]];
        }
    }
    
    _collectionViewCell = cell;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row % [_imageArr count];
    KNBannerCollectionViewCell *cell = (KNBannerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if([_delegate respondsToSelector:@selector(bannerView:collectionView:collectionViewCell:didSelectItemAtIndexPath:)]){
        [_delegate bannerView:(KNBannerView *)self
               collectionView:collectionView
           collectionViewCell:cell
     didSelectItemAtIndexPath:row];
    }
}

/****************************** == scrollView Delegate == ********************************/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 设置 pageControl
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    
    NSString *contentOffSetX = [NSString stringWithFormat:@"%f",(x + scrollViewW ) / scrollViewW];
    if([[contentOffSetX substringWithRange:NSMakeRange(contentOffSetX.length - 6, 6)] isEqualToString:@"000000"]){
        if([_bannerViewModel textShowStyle] != KNBannerViewTextShowStyleNormal){
            NSInteger index = ([contentOffSetX integerValue] - 1) % [self.imageArr count];
            [_viewText setText:_bannerViewModel.textArr[index]];
        }
        
        NSInteger index = ([contentOffSetX integerValue] - 1) % [self.imageArr count];
        [_pageControl setCurrentPage:index]; // 设置 pageControl
    }
}

/****************************** == Timer == ********************************/
- (void)setupTimer{
    if([_imageArr count] == 1) return;
    
    if(![_bannerViewModel isNeedTimerRun]) return;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_bannerViewModel.bannerTimeInterval target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    _bannerTimer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    [_bannerTimer invalidate];
    _bannerTimer = nil;
}

- (void)timerRun{
    
    if([self isEmptyArray:_imageArr]) return;
    NSInteger index = (_collectionView.contentOffset.x / _layout.itemSize.width) + 1;
    if (index == _imageArr.count * 50 || index == 0) {
        index = _imageArr.count * 50 * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)willRemoveSubview:(UIView *)subview{
    if (!subview) {
        [self removeTimer];
    }
}

/****************************** == 判断 数组是否为空 == ********************************/
+ (BOOL)isEmptyArray:(NSArray *)array{
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyArray:(NSArray *)array{
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return YES;
    }
    return NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_pageControl setFrame:(CGRect){{0,self.height - 30},{self.width,30}}];
}

@end
