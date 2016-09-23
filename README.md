# KNBannerView
无限循环轮播器:本地图片,网络图片(图片缓存)
![image](https://github.com/LuKane/KNImageResource/blob/master/BannerView.gif?raw=true)

##一.功能描述及要点
* 1.无限图片轮播器,加载本地图片或网络图片
* 2.NSURLSession下载网络图片,沙盒路径存储图片(路径名:MD5加密)
* 3.通过代理方法执行图片的点击事件
* 4.collectView工作原理实现无限滚动
* 5.设置UIPageControl的位置:(左,中,右) 以及颜色设置
* 6.设置自定义PageControl,位置:(左,中,右),自定义图片
* 7.设置描述文字的位置:(左,中,右) 以及字体颜色,大小,背景颜色
* 8.多张图片滚动时 文字的多种显示样式.单张图片时的样式
* 9.在控制器中 设置 self.automaticallyAdjustsScrollViewInsets = NO;让scrollView自动适应屏幕

##二.方法定义及调用
###1.类方法创建BannerView:本地图片和网络图片
```
+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame
+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame
```

###2.设置bannerView的占位图,定时器的时间
```
bannerView.timeInterval = 2; // 定时器时间
bannerView.placeHolder = [UIImage imageNamed:@"3"];
```

###3.设置bannerView的PageControl的属性
```
// 1.自定义PageControl
注意:这里需要传入一个数组
/**
 *  这一行如果 传入一个数字,那么就是自定义 pageControl, 若不传数组,则是系统默认UIPageControl
 * /
NSArray *arr = @[[UIImage imageNamed:@"pageControlSelected"], [UIImage imageNamed:@"pageControlUnSelected"]];
bannerView.customPageControlImgArr = [arr copy];

// 2.系统UIPageControl
bannerView.PageIndicatorTintColor = [UIColor whiteColor];
bannerView.CurrentPageIndicatorTintColor = [UIColor blackColor];
bannerView.pageControlStyle = KNPageControlStyleRight;
bannerView.textShowStyle = KNTextShowStyleStay; // 介绍文字的 显示样式 : 滚动 || 渐显 || 停留
```

###4.设置bannerView 介绍文字的属性
```
bannerView.IntroduceTextFont = [UIFont systemFontOfSize:20];
bannerView.IntroduceBackGroundAlpha = 1.0;
bannerView.IntroduceBackGroundColor = [UIColor greenColor];
bannerView.IntroduceHeight = 60;
bannerView.IntroduceTextColor = [UIColor redColor];
bannerView.IntroduceStyle = KNIntroduceStyleRight;// 介绍文字的对其方式
```
###5.图片的点击
#####1>遵守 KNBannerViewDelegate
#####2>设代理 bannerView.delegate = self;
#####3>执行方法 - (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index;
