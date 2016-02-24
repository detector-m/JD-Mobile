//
//  DZRightMenuViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZRightMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "DZCommodityViewController.h"

@interface DZRightMenuViewController ()

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UISwitch *autoPeiSongSwitch;
@property (strong, nonatomic) UISwitch *autoYouHuoSwitch;
@property (strong, nonatomic) UISwitch *autoFukuanSwitch;
@end

@implementation DZRightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DZColor(240, 243, 245);
    //设置导航栏
    [self setupNavigationItem];
    
    self.tableView.tableFooterView = self.footerView;
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"筛选";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(okClick)];
}

- (void)cancelClick{
    [self.frostedViewController hideMenuViewController];
}

- (void)okClick{
    [self.frostedViewController hideMenuViewController];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return 0;
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    switch (sectionIndex) {
        case 0:  return 1;
        case 1:  return 3;
        case 2:  return 9;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.textColor = DZColor(240, 97, 98);
            cell.textLabel.text = @"配送至";
            cell.detailTextLabel.text = @"北京市海淀区";
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
        }
    } else if(indexPath.section == 1){
        NSArray *titles = @[@"京东配送", @"仅看有货", @"货到付款"];
        cell.textLabel.text = titles[indexPath.row];
        if (indexPath.row == 0) {
            self.autoPeiSongSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.autoPeiSongSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.autoPeiSongSwitch.frame.size.height) / 2, self.autoPeiSongSwitch.frame.size.width, self.autoPeiSongSwitch.frame.size.height);
            [cell.contentView addSubview:self.autoPeiSongSwitch];
        }else if(indexPath.row == 1){
            self.autoYouHuoSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_autoYouHuoSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _autoYouHuoSwitch.frame.size.height) / 2, _autoYouHuoSwitch.frame.size.width, _autoYouHuoSwitch.frame.size.height);
            _autoYouHuoSwitch.on = YES;
            [cell.contentView addSubview:_autoYouHuoSwitch];
        }else if(indexPath.row == 2){
            self.autoFukuanSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_autoFukuanSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _autoFukuanSwitch.frame.size.height) / 2, _autoFukuanSwitch.frame.size.width, _autoFukuanSwitch.frame.size.height);
            [cell.contentView addSubview:_autoFukuanSwitch];
        }
    }else if (indexPath.section == 2){
        NSArray *titles = @[@"品牌", @"价格", @"网络",@"系统",@"热点",@"屏幕尺寸",@"机身颜色",@"购买方式",@"大家说"];
        cell.textLabel.text = titles[indexPath.row];
        cell.detailTextLabel.text = @"全部";
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
    }
    
    return cell;
}

#pragma mark - getter
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 20,_footerView.size.width-240, 30)];
        cleanButton.layer.cornerRadius = 3;
        cleanButton.layer.borderWidth = 0.5;
        cleanButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cleanButton setBackgroundColor:[UIColor whiteColor]];;
        [cleanButton setTitle:@"清除选项" forState:UIControlStateNormal];
        [cleanButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [cleanButton addTarget:self action:@selector(cleanClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:cleanButton];
        
    }
    return _footerView;
}

- (void)cleanClick{
    XLog(@"cleanClick");
}

- (UISwitch *)autoPeiSongSwitch{
    if (_autoPeiSongSwitch == nil) {
        _autoPeiSongSwitch = [[UISwitch alloc] init];
        //_autoLoginSwitch.thumbTintColor = [UIColor redColor];//按钮颜色
        //_autoLoginSwitch.tintColor = [UIColor redColor];//处于off时switch 的颜色
        _autoPeiSongSwitch.onTintColor = DZColor(240, 97, 98);//处于on时switch 的颜色
        [_autoPeiSongSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _autoPeiSongSwitch;
}

- (UISwitch *)autoYouHuoSwitch {
    if (_autoYouHuoSwitch == nil) {
        _autoYouHuoSwitch = [[UISwitch alloc] init];
        _autoYouHuoSwitch.onTintColor = DZColor(240, 97, 98);//处于on时switch 的颜色
        [_autoYouHuoSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _autoYouHuoSwitch;
}

- (UISwitch *)autoFukuanSwitch{
    if (_autoFukuanSwitch == nil) {
        _autoFukuanSwitch = [[UISwitch alloc] init];
        _autoFukuanSwitch.onTintColor = DZColor(240, 97, 98);//处于on时switch 的颜色
        [_autoFukuanSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _autoFukuanSwitch;
}

#pragma mark - action
- (void)autoLoginChanged:(UISwitch *)autoSwitch {
    XLog(@"autoLoginChanged");
}

@end
