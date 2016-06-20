//
//  KNBannerView.m
//  KNBannerView
//
//  Created by LuKane on 15/11/14.
//  Copyright © 2015年 KNKane. All rights reserved.
//

#import "KNBannerView.h"
#import "NSData+KNCache.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface KNBannerView()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSInteger _networkConnectTime;
}

@property (nonatomic, weak) UICollectionView *collectionView; // main view for flow
@property (nonatomic, weak) UICollectionViewFlowLayout *layout;// flow

@property (nonatomic, assign) NSInteger imagesCount;// All images's count * 50

@property (nonatomic, strong) NSTimer *timer; // timer clock

@property (nonatomic, strong) NSMutableArray *IMGArray; // temp Array, for locationImg or netWorkImg(download img or get img from DataBase)

@property (nonatomic, weak) UIPageControl *pageControl;

@end

static NSString *ID = @"KNCollectionView";

@implementation KNBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initializeCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initializeCollectionView];
    }
    return self;
}

+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame{
    KNBannerView *bannerView = [[self alloc] initWithFrame:frame];
    if([KNJudgementTool isEmptyArray:locationImgArr]){
        return bannerView;
    }
    bannerView.locationImgArr = [NSMutableArray arrayWithArray:locationImgArr];
    return bannerView;
}

+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame{
    KNBannerView *bannerView = [[self alloc] initWithFrame:frame];
    if([KNJudgementTool isEmptyArray:netWorkImgArr]){
        return bannerView;
    }
    
    bannerView.netWorkImgArr = [NSMutableArray arrayWithArray:netWorkImgArr];
    return bannerView;
}

- (void)initializeCollectionView{
    
    // 1.create layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // create layout
    [layout setItemSize:self.size];// set layout size
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _layout = layout;
    
    // 2.create collectView
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    [collectView setBackgroundColor:[UIColor clearColor]];
    [collectView setPagingEnabled:YES]; // open collectionView's page control
    
    [collectView registerClass:[KNCollectionViewCell class] forCellWithReuseIdentifier:ID];// register cell
    
    [collectView setDataSource:self];
    [collectView setDelegate:self];
    
    [collectView setShowsHorizontalScrollIndicator:NO];
    [collectView setShowsVerticalScrollIndicator:NO];
    
    [self addSubview:collectView];
    _collectionView = collectView;
    
    [self initDefaultData];
}

- (void)initDefaultData{
    
    _pageControlStyle = KNPageControlStyleRight;
    _CurrentPageIndicatorTintColor = [UIColor whiteColor];
    _PageIndicatorTintColor = [UIColor grayColor];
    
    _IntroduceBackGroundColor = [UIColor blackColor];
    _IntroduceTextColor = [UIColor whiteColor];
    _IntroduceBackGroundAlpha = 0.5;
    _IntroduceTextFont = [UIFont fontWithName:@"Heiti SC" size:15];
    _IntroduceStyle = KNIntroduceStyleLeft;
    _IntroduceHeight = 30;
    _timeInterval = 1.5;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imagesCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row % self.IMGArray.count;
    
    _pageControl.currentPage = row;
    KNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    UIImage *image = _IMGArray[row];
    if(image.size.width){
        cell.imageView.image = _IMGArray[row];
    }else{
        if(_placeHolder){
            cell.imageView.image = [UIImage imageNamed:_placeHolder];
        }
    }
    
    if(!cell.isSet){
        cell.IntroduceStyle = _IntroduceStyle;
        cell.IntroduceBackGroundColor = _IntroduceBackGroundColor;
        cell.IntroduceTextColor = _IntroduceTextColor;
        cell.IntroduceBackGroundAlpha = _IntroduceBackGroundAlpha;
        cell.IntroduceTextFont = _IntroduceTextFont;
        cell.IntroduceHeight = _IntroduceHeight;
        cell.isSet = YES;
    }
    
    cell.IntroduceString = _IntroduceStringArr.count?_IntroduceStringArr[row]:nil;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row % _IMGArray.count;
    if([_delegate respondsToSelector:@selector(bannerView:collectionView:didSelectItemAtIndexPath:)]){
        [_delegate bannerView:(KNBannerView *)self collectionView:collectionView didSelectItemAtIndexPath:row];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

/***************************Divder************************/

- (void)setupTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    _timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)timerRun{
    
    if(!_imagesCount){
        return;
    }
    
    int index = (_collectionView.contentOffset.x / _layout.itemSize.width) + 1;
    if (index == _imagesCount) {
        index = _imagesCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setTimeInterval:(CGFloat)timeInterval{
    _timeInterval = timeInterval;
    if(timeInterval <= 0){
        _timeInterval = 1.5;
    }
    [self removeTimer];
    [self setupTimer];
}

/***************************Divder************************/

- (void)setLocationImgArr:(NSMutableArray *)locationImgArr{
    _locationImgArr = locationImgArr;
    NSMutableArray *imageA = [NSMutableArray arrayWithCapacity:locationImgArr.count];
    for (NSInteger i = 0; i < locationImgArr.count; i++) {
        UIImage *image = [UIImage imageNamed:locationImgArr[i]];
        [imageA addObject:image];
    }
    self.IMGArray = imageA;
}

- (void)setNetWorkImgArr:(NSMutableArray *)netWorkImgArr{
    _netWorkImgArr = netWorkImgArr;
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:netWorkImgArr.count];
    for (NSInteger i = 0; i < netWorkImgArr.count ; i++) {
        UIImage *image = [[UIImage alloc] init];
        [imageArr addObject:image];
    }
    
    self.IMGArray = imageArr;
    
    // download image from self.IMGArray'url
    for (NSInteger i = 0; i < netWorkImgArr.count; i++) {
        [self loadNetWorkImageWithIndex:i];
    }
}

- (void)setIMGArray:(NSMutableArray *)IMGArray{
    _IMGArray = IMGArray;
    _imagesCount = IMGArray.count * 50; // extension array cout for enough cell to display
    
    if(IMGArray.count == 1){
        [self removeTimer];
    }else{
        [self setupTimer];
    }
    
    // PageControl
    [self setupPageControl];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if(!newSuperview){ // 当父视图改变的时候, 要判断新的父视图是否存在
        [self removeTimer];
    }
}

/***************************Divder************************/

- (void)loadNetWorkImageWithIndex:(NSInteger)index{
    NSString *URL = _netWorkImgArr[index];
    
    NSData *data = [NSData getDataFromLocationApplicationCacheWithURL:URL];
    if(data){
        UIImage *image = [UIImage imageWithData:data];
        [_IMGArray setObject:image atIndexedSubscript:index];
    }else{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *download = [session downloadTaskWithURL:[NSURL URLWithString:URL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error){
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                [_IMGArray setObject:image atIndexedSubscript:index];
                
                if(!image) return;
                [NSData saveDataIntoLocationApplicationCacheWithURL:URL image:image];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(index == 0){
                        [_collectionView reloadData];
                    }
                });
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // if cannotConnectToNetWork or require time above 5 : return
                    if(_networkConnectTime > 5 || ![self getCanConnectToNetWork]){
                        return ;
                    }else{
                        _networkConnectTime++;
                        [self loadNetWorkImageWithIndex:index];
                    }
                });
            }
        }];
        [download resume];
    }
}

/***************************Divder************************/

#pragma mark PageControl
- (void)setupPageControl{
    
    if(_pageControl) return;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _IMGArray.count;
    [self addSubview:pageControl];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)CurrentPageIndicatorTintColor{
    _CurrentPageIndicatorTintColor = CurrentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = CurrentPageIndicatorTintColor;
}

- (void)setPageIndicatorTintColor:(UIColor *)PageIndicatorTintColor{
    _PageIndicatorTintColor = PageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = PageIndicatorTintColor;
}

- (void)setIntroduceStringArr:(NSMutableArray *)IntroduceStringArr{
    if([KNJudgementTool isEmptyArray:IntroduceStringArr]){
        _IntroduceStringArr = [NSMutableArray array];
    }else{
        if([KNJudgementTool isEmptyArray:_netWorkImgArr]){
            if(_IntroduceStringArr.count != _locationImgArr.count){
                [_IntroduceStringArr removeAllObjects];
            }
        }else{
            if(_IntroduceStringArr.count != _netWorkImgArr.count){
                [_IntroduceStringArr removeAllObjects];
            }
        }
    }
    _IntroduceStringArr = IntroduceStringArr;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_collectionView.contentOffset.x == 0 &&  _imagesCount) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imagesCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    // 4 * 10 + ( 4 - 1) * 5 : pageControl base enum to set frame
    switch (_pageControlStyle) {
        case KNPageControlStyleMiddle:
            _pageControl.frame = CGRectMake(0, self.height - 30 , self.width, 30);
            break;
        case KNPageControlStyleLeft:
            _pageControl.frame = CGRectMake(10 - self.width * 0.5 + _IMGArray.count * 0.5 * 10 + (_IMGArray.count - 1)  * 0.5 * 5, self.height - 30, self.width, 30);
            break;
        case KNPageControlStyleRight:
            _pageControl.frame = CGRectMake(self.width * 0.5 - ((_IMGArray.count) * 10 + (_IMGArray.count - 1) * 5) * 0.5 - 10, self.height - 30 ,self.width, 30);
            break;
        default:
            break;
    }
}

- (BOOL)getCanConnectToNetWork{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress,sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachabiltiy = SCNetworkReachabilityCreateWithAddress(NULL,  (struct sockaddr *) & zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetriveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachabiltiy, &flags);
    if(!didRetriveFlags){
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    
    BOOL needsConnect=flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnect)? YES:NO;
}


@end
