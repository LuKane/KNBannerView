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
    [self setupScrollView];
}

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView  = scrollView;
    [self.view addSubview:scrollView];
}


@end
