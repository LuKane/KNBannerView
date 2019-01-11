//
//  ViewController.m
//  KNBannerView
//
//  Created by LUKHA_Lu on 15/11/6.
//  Copyright (c) 2015年 KNKane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic,weak  ) UITableView *tableView;

@end

@implementation ViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
        [_dataArr addObject:@"KNNetworkController"];
        [_dataArr addObject:@"KNLocationController"];
        [_dataArr addObject:@"KNBlendController"];
        [_dataArr addObject:@"KNBackGroundController"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"KNBannerView演示";
    
    [self setupTableView];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const ID = @"KNBannerViewID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(self.dataArr[indexPath.section]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

@end
