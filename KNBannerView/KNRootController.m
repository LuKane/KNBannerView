//
//  KNRootController.m
//  KNBannerView
//
//  Created by LuKane on 2016/11/15.
//  Copyright © 2016年 KNKane. All rights reserved.
//

#import "KNRootController.h"

@interface KNRootController ()

@end

@implementation KNRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIBarButtonItem *backIetm = [[UIBarButtonItem alloc] init];
    backIetm.title =@"返回";
    self.navigationItem.backBarButtonItem = backIetm;
//    self.navigationController.navigationItem.backBarButtonItem = backIetm;
    
    [self setupScrollView];
}

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView  = scrollView;
    [self.view addSubview:scrollView];
}


- (NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [NSMutableArray array];
        
        [_textArr addObject:@"轮播图改版了"];
        [_textArr addObject:@"SDWebImage下载图片"];
        [_textArr addObject:@"通过模型统一设置属性"];
        [_textArr addObject:@"希望大家支持一下"];
        [_textArr addObject:@"谢谢大家!!!"];
    }
    return _textArr;
}

@end
