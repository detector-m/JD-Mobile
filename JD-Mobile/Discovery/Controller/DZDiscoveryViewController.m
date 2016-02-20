//
//  DZDiscoveryViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZDiscoveryViewController.h"
#import <KINWebBrowser/KINWebBrowserViewController.h>

static NSString *const defaultAddress = @"http://sale.jd.com/app/act/1nXlBgymWEOuYQv.html";

@interface DZDiscoveryViewController () <KINWebBrowserDelegate>
{
    KINWebBrowserViewController *webBrowser;
}

@end

@implementation DZDiscoveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DZColor(240, 243, 245);
    
    //设置导航栏
    [self setupNavigationItem];
}

#pragma mark UIViewController对象的视图即将加入窗口时调用；
- (void)viewWillAppear:(BOOL)animated {
    NSAssert(self.navigationController, @"SVWebViewController needs to be contained in a UINavigationController. If you are presenting SVWebViewController modally, use SVModalWebViewController instead.");
    
    [super viewWillAppear:animated];
}

#pragma mark UIViewController对象的视图即将消失、被覆盖或是隐藏时调用
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark UIViewController对象的视图已经消失、被覆盖或是隐藏时调用；
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"发现";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:  return 1;
        case 1:  return 1;
        case 2:  return 3;
        case 3:  return 2;
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark 自定义section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.detailTextLabel.font=[UIFont systemFontOfSize:14.0f];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"故事";
            cell.imageView.image = [UIImage imageNamed:@"find_icon_story"];
            cell.detailTextLabel.text = @"618的京东人";
            break;
        case 1:
            cell.textLabel.text = @"逛逛";
            cell.imageView.image = [UIImage imageNamed:@"find_icon_guang"];
            cell.detailTextLabel.text = @"逛楚精彩";
            break;
        case 2:
            cell.textLabel.text = @[@"扫啊扫", @"摇啊摇",@"拍照购"][indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@[@"find_icon_sao", @"find_icon_yao",@"find_icon_yao"][indexPath.row]];
            break;
        case 3:
            cell.textLabel.text = @[@"小冰", @"白宝箱"][indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@[@"find_icon_bing", @"find_icon_application"][indexPath.row]];
            cell.detailTextLabel.text = @[@"人工智能萌妹子",@""][indexPath.row];
            break;
        default: break;
    }
    cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"find_arrow"]];
    
    return cell;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XLog(@"点击了第%i",(int)indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
    
}

- (void)setupWebBrowser{
    webBrowser = [KINWebBrowserViewController webBrowser];
    
    [webBrowser setDelegate:self];
    
    webBrowser.navigationItem.leftBarButtonItem = [UIBarButtonItem  BarButtonItemWithBackgroudImageName:nil highBackgroudImageName:nil target:nil action:nil];
    webBrowser.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"more_share" highBackgroudImageName:@"more_share_p" target:self action:@selector(shareOnClick)];
    
    webBrowser.barTintColor = DZColor(249, 249, 249);
    
    webBrowser.showsPageTitleInNavigationBar = YES;
    [self.navigationController pushViewController:webBrowser animated:nil];
    
    [webBrowser loadURLString:defaultAddress];
}

- (void)shareOnClick{
    XLog(@"shareOnClick");
}

#pragma mark - KINWebBrowserDelegate Protocol Implementation

- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)URL {
    XLog(@"Started Loading URL : %@", URL);
}

- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL {
    XLog(@"Finished Loading URL : %@", URL);
}

- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL withError:(NSError *)error {
    XLog(@"Failed To Load URL : %@ With Error: %@", URL, error);
}

- (void)webBrowserViewControllerWillDismiss:(KINWebBrowserViewController*)viewController {
    XLog(@"View Controller will dismiss: %@", viewController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
