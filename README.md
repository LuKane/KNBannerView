# KNBannerView
无限循环轮播器:本地图片,网络图片,混合图片(本地&&网络)

⭐️⭐️⭐️⭐️⭐️⭐️⭐️ 有任何需要增加的功能,请直接邮箱联系我.欢迎点赞,谢谢 ⭐️⭐️⭐️⭐️⭐️⭐️⭐️

// 1.网络图片
![image](https://github.com/LuKane/KNImageResource/blob/master/BannerViewNetWork.gif?raw=true)

// 2.本地图片
![image](https://github.com/LuKane/KNImageResource/blob/master/BannerViewLocation.gif?raw=true)

// 3.混合图片 (本地 && 网络)
![image](https://github.com/LuKane/KNImageResource/blob/master/BannerViewBlend.gif?raw=true)

## 一.功能描述及要点
* 1.无限图片轮播器,加载 '本地图片' && '网络图片' && '本地和网络的混合图片'
* 2.修改成SDWebImage下载图片
* 3.通过代理方法执行图片的点击事件
* 4.collectView工作原理实现无限滚动
* 5.设置UIPageControl的位置:(左,中,右) 以及颜色设置
* 6.设置自定义PageControl,位置:(左,中,右),自定义图片
* 7.设置描述文字的位置:(左,中,右) 以及字体颜色,大小,背景颜色
* 8.多张图片滚动时 文字的多种显示样式.单张图片时的样式
* 9.在控制器中 设置 self.automaticallyAdjustsScrollViewInsets = NO;让scrollView自动适应屏幕
* 10.新增 当BannerView生成之后, 修改内部展示的图片.

## 二.方法定义及调用
### 1.类方法创建BannerView:本地图片和网络图片
```
// 本地图片
+ (instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame
// 网络图片
+ (instancetype)bannerViewWithNetWorkImagesArr:(NSArray *)netWorkImgArr frame:(CGRect)frame
// 混合图片 (网络 || 本地图片)
+ (instancetype)bannerViewWithBlendImagesArr:(NSArray *)blendImgArr frame:(CGRect)frame
```

### 2.设置bannerView的占位图,定时器的时间
```
KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
[viewM setIsNeedTimerRun:YES]; // 是否需要定时
[viewM setBannerTimeInterval:1]; // 改变 定时器时间
[viewM setPlaceHolder:[UIImage imageNamed:@"3"]]; // 设置占位图
```

### 3.设置bannerView的PageControl的属性
```
// 1.自定义 PageControl
KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
NSArray *customPageImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"pageControlSelected1"],[UIImage imageNamed:@"pageControlUnSelected1"], nil];
[viewM setPageControlImgArr:[customPageImgArr copy]]; // 设置自定义PageControl的两张图
[viewM setIsNeedPageControl:YES]; // 记得设置 YES
[viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中

// 2.系统自带PageControl
KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
[viewM setIsNeedPageControl:YES]; // 默认系统PageControl
[viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中
```
### 4.动态修改 bannerView 中的图片
```
_bannerView1.netWorkImgArr = [self.changeArr mutableCopy];
_bannerView2.netWorkImgArr = [self.changeArr mutableCopy];
_bannerView3.netWorkImgArr = [self.changeArr mutableCopy];
    
[_bannerView1 reloadData];
[_bannerView2 reloadData];
[_bannerView3 reloadData];

```

### 5.让 BannerView 无限循环 (2018-1-11 日更新)
```
[viewM setIsNeedCycle:YES]; // 让bannerView 无限循环, 默认 不循环
```

### 6.设置bannerView 介绍文字的属性
```
KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
[viewM setTextArr:[self.textArr copy]]; // 设置文字, 注意:如果文字和图片的数量不相符,则没有文字.如果不要文字,则不传
[viewM setTextShowStyle:KNBannerViewTextShowStyleStay]; // 设置文字展示的样式
```
### 6.图片的点击

##### 1>遵守 KNBannerViewDelegate

##### 2>设代理 bannerView.delegate = self;

##### 3>执行方法 - (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index;
