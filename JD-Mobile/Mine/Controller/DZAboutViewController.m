//
//  DZAboutViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/19.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZAboutViewController.h"

@interface DZAboutViewController ()

@end

@implementation DZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DZColor(240, 243, 245);
    // Uncomment the following line to preserve selection between presentations.
    
    //设置导航栏
    [self setupNavigationItem];
    
    self.tableView.tableHeaderView = [self addHeaderView];
    self.tableView.tableFooterView = [self addFooterView];
    self.tableView.scrollEnabled = NO;
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"关于";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"more_share" highBackgroudImageName:@"more_share_p" target:self action:@selector(shareOnClick)];
}

- (void)shareOnClick{
    XLog(@"shareOnClick");
}

- (UIView *)addHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/2)];
    UIImageView *iamgeView = [UIImageView new];
    iamgeView.layer.borderWidth = 2;
    iamgeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    iamgeView.layer.cornerRadius = 1;
    iamgeView.image = [UIImage imageNamed:@"chars.jpg"];
    [headerView addSubview:iamgeView];
    [DZMasonyUtil centerView:iamgeView size:CGSizeMake(240, 240)];
    
    return headerView;
}

- (UIView *)addFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.view.height/2-40*3)];
    UILabel *labelEn = [[UILabel alloc]initWithFrame:CGRectMake(0, footerView.size.height-90, self.view.width, 30)];
    labelEn.text = @"Copyright © 2016";
    labelEn.textColor = [UIColor grayColor];
    labelEn.font = [UIFont systemFontOfSize:14];
    labelEn.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:labelEn];
    
    UILabel *labelCn = [[UILabel alloc]initWithFrame:CGRectMake(0, footerView.size.height-115, self.view.width, 30)];
    labelCn.text = @"Chars-D 版权所有";
    labelCn.textColor=[UIColor grayColor];
    labelCn.font=[UIFont systemFontOfSize:14];
    labelCn.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:labelCn];
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @[@"特别声明", @"使用帮助",@"给我评分"][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {    
    return 0.1;
}

@end
