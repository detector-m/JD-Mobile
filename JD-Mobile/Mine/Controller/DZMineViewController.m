//
//  DZMineViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZMineViewController.h"
#import "DZRippleButtton.h"
#import "DZWalletCardButton.h"
#import "DZNavigationController.h"
#import "DZLoginViewController.h"
#import "DZSettingViewController.h"
#import "DZUserModel.h"
#import "DZUserDao.h"
#import "DZMyOrderViewController.h"
#import "DZMyAccountViewController.h"

#define CellFooterheight 70
#define HeadrCardColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

@interface DZMineViewController ()<UIAlertViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_myArray;//模型
}

@property (nonatomic, strong) DZUserModel *myInfo;
@property (nonatomic, readonly, assign) int64_t myID;

@end

@implementation DZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DZColor(240, 243, 245);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //设置导航栏
    [self setupNavigationItem];
    //初始化数据
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    if ([DZUserDefaultsUtils getOwnID] == 0) {
        self.tableView.tableHeaderView = [self addNoHeaderBar];
    }else{
        [self refreshView];
        self.tableView.tableHeaderView = [self addHeaderBar];
    }
}

- (void)refreshView{
    _myID = [DZUserDefaultsUtils getOwnID];
    if (_myID == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }else{
        XLog(@"my ID %lli",_myID);
        DZUserDao * ud = [[DZUserDao alloc]init];
        _myInfo = [ud selectAdd:[NSString stringWithFormat:@"%lld",_myID]];
    }
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"my_more_btn_n" highBackgroudImageName:@"my_more_btn_h" target:self action:@selector(more)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"my_message_btn_n" highBackgroudImageName:@"my_message_btn_h" target:self action:@selector(message)];
}

- (void)more{
    DZSettingViewController * setting = [[DZSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)message{
    XLog(@"message");
}

#pragma mark 加载数据
-(void)initData{
    _myArray = [[NSMutableArray alloc]init];
}

-(UIImageView*)addNoHeaderBar{
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my_unlogin_bg"];
    
    //未登录按钮光圈
    DZRippleButtton *unLoginBtnBg = [[DZRippleButtton alloc]
                                     initWithImage:[UIImage imageNamed:@"unlogin_head_n"]
                                     andFrame:CGRectMake(self.view.width/2-90/2, 20, 90, 90)
                                     onCompletion:^(BOOL success) {
                                         
                                         [self showLoginView];
                                         
                                     }];
    
    [unLoginBtnBg setRippeEffectEnabled:NO];
    [header addSubview:unLoginBtnBg];
    //头部卡片
    UIImageView *bgView = [UIImageView new];
    bgView.image = [UIImage imageNamed:@"head_extra_bg"];
    [header addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 50));
        make.bottom.mas_equalTo(header.mas_bottom);
    }];
    UIButton *product = [UIButton new];
    product.titleLabel.font = [UIFont boldSystemFontOfSize:14 ];
    [product setTitle:@"关注的商品" forState:UIControlStateNormal];
    [bgView addSubview:product];
    
    UIButton *store = [UIButton new];
    store.titleLabel.font = [UIFont boldSystemFontOfSize:14 ];
    [store setTitle:@"关注的店铺" forState:UIControlStateNormal];
    [bgView addSubview:store];
    
    UIButton *browse = [UIButton new];
    browse.titleLabel.font = [UIFont boldSystemFontOfSize:14 ];
    [browse setTitle:@"浏览记录" forState:UIControlStateNormal];
    [bgView addSubview:browse];
    
    [DZMasonyUtil equalSpacingView:@[product,store,browse]
                       viewWidth:(self.view.frame.size.width/3)-1
                      viewHeight:50
                  superViewWidth:self.view.frame.size.width];
    
    return header;
}

/**
 *  登录状态头部
 *
 *  @return 返回表格头部
 */
-(UIImageView*)addHeaderBar{
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my_login_bg"];
    
    //登录按钮光圈
    DZRippleButtton *unLoginBtnBg = [[DZRippleButtton alloc]
                                     initWithImage:[UIImage imageNamed:@"my_head_default"]
                                     andFrame:CGRectMake(20, 20, 90, 90)
                                     onCompletion:^(BOOL success) {
                                         [self.navigationController pushViewController:[[DZMyAccountViewController alloc]init] animated:YES];
                                     }];
    
    [unLoginBtnBg setRippeEffectEnabled:NO];
    [header addSubview:unLoginBtnBg];
    
    UILabel * userName = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, header.size.width-120, 30)];
    userName.textColor = [UIColor whiteColor];
    userName.text = _myInfo.userName;
    [header addSubview:userName];
    
    UILabel * grade = [[UILabel alloc]initWithFrame:CGRectMake(120, 55, header.size.width-120, 20)];
    grade.textColor = [UIColor whiteColor];
    grade.font = [UIFont systemFontOfSize:12];
    grade.text = @"至尊用户";
    [header addSubview:grade];
    
    UILabel * address = [[UILabel alloc]initWithFrame:CGRectMake(240, header.size.height-80, 120, 20)];
    address.textColor = [UIColor whiteColor];
    address.font = [UIFont systemFontOfSize:12];
    address.text = @"账户管理、收货地址〉";
    [header addSubview:address];
    //头部卡片
    UIImageView *bgView = [UIImageView new];
    bgView.image = [UIImage imageNamed:@"head_extra_bg"];
    [header addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 50));
        make.bottom.mas_equalTo(header.mas_bottom);
    }];
    
    DZWalletCardButton *focusProduct = [DZWalletCardButton new];
    [focusProduct walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.commodity] Title:@"关注的商品" Width:self.view.width/3 height:50];
    [bgView addSubview:focusProduct];
    
    DZWalletCardButton *focusStore = [DZWalletCardButton new];
    [focusStore walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.shop] Title:@"关注的店铺" Width:self.view.width/3 height:50];
    [bgView addSubview:focusStore];
    
    
    DZWalletCardButton *browseHistory = [DZWalletCardButton new];
    [browseHistory walletCardWith1:[NSString stringWithFormat:@"%@",_myInfo.record] Title:@"浏览记录" Width:self.view.width/3 height:50];
    [bgView addSubview:browseHistory];
    
    [DZMasonyUtil equalSpacingView:@[focusProduct,focusStore,browseHistory]
                       viewWidth:self.view.frame.size.width/3
                      viewHeight:50
                  superViewWidth:self.view.frame.size.width];
    
    return header;
}

-(void)showLoginView{
    DZNavigationController *login = [[DZNavigationController alloc] initWithRootViewController:[[DZLoginViewController alloc] init]];
    
    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark 设置分组标题内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

#pragma mark 设置尾部说明内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:  return CellFooterheight;
        case 1:  return CellFooterheight;
        default: return 1;
    }
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([DZUserDefaultsUtils getOwnID] == 0) {
        return 4;
    }
    return 5;
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"我的订单";
            cell.imageView.image = [UIImage imageNamed:@"my_order_icon"];
            cell.detailTextLabel.text = @"查看全部订单";
            break;
        case 1:
            cell.textLabel.text = @"我的钱包";
            cell.imageView.image = [UIImage imageNamed:@"my_wallet_icon"];
            cell.detailTextLabel.text = @"小金库、白条等";
            break;
        case 2:
            cell.textLabel.text = @"我的服务";
            cell.imageView.image = [UIImage imageNamed:@"my_service_icon"];
            cell.detailTextLabel.text = @"预约、营业厅等";
            break;
        case 3:
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"my_feedback_icon"];
            break;
        case 4:
            cell.textLabel.text = @"猜你喜欢";
            cell.imageView.image = [UIImage imageNamed:@"my_guess_icon"];
            break;
        default:
            break;
    }
    
    if(indexPath.section != 4){
        cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_list_arrow"]];
    }
    
    return cell;
}

#pragma mark 返回table头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark 返回table尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    UIImageView *bgView = [UIImageView new];
    bgView.image=[UIImage imageNamed:@"MyAddressManager_line_new"];
    [footer addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 0.5));
        make.bottom.mas_equalTo(footer.mas_top);
    }];
    
    if (section == 0) {
        UIButton *pay = [UIButton createButtonWithImage:@"wait_money_icon" Title:@"待付款" Target:self Selector:@selector(OnClick:)];
        pay.tag = 1;
        [footer addSubview:pay];
        
        UIButton *receipt = [UIButton createButtonWithImage:@"wait_product_icon" Title:@"待收货" Target:self Selector:@selector(OnClick:)];
        receipt.tag = 2;
        [footer addSubview:receipt];
        
        UIButton *evaluate = [UIButton createButtonWithImage:@"wait_comment_icon" Title:@"待评价" Target:self Selector:@selector(OnClick:)];
        evaluate.tag = 3;
        [footer addSubview:evaluate];
        
        UIButton *repair = [UIButton createButtonWithImage:@"wait_after_icon" Title:@"返修/退货" Target:self Selector:@selector(OnClick:)];
        repair.tag = 4;
        [footer addSubview:repair];
        
        [DZMasonyUtil equalSpacingView:@[pay,receipt,evaluate,repair]
                           viewWidth:self.view.width/4
                          viewHeight:CellFooterheight
                      superViewWidth:self.view.width];
        return footer;
    }else if(section == 1){
        DZWalletCardButton *balance = [DZWalletCardButton new];
        [balance walletCardWith:@"0.00" Title:@"账户余额" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:balance];
        
        DZWalletCardButton *privilege =[DZWalletCardButton new];
        [privilege walletCardWith:@"0" Title:@"优惠劵" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:privilege];
        
        
        DZWalletCardButton *bean = [DZWalletCardButton new];
        [bean walletCardWith:@"0" Title:@"京豆" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:bean];
        
        DZWalletCardButton *clip = [DZWalletCardButton new];
        [clip walletCardWith:@"0" Title:@"京东卡/E卡" Width:self.view.width/4 height:CellFooterheight];
        
        [footer addSubview:clip];
        
        [DZMasonyUtil equalSpacingView:@[balance,privilege,bean,clip]
                           viewWidth:self.view.width/4
                          viewHeight:CellFooterheight
                      superViewWidth:self.view.width];
        return footer;
    }
    return nil;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XLog(@"点击了第%i",(int)indexPath.section);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
    if ([DZUserDefaultsUtils getOwnID] == 0) {
        [self showLoginView];
        return;
    }
}

- (void)OnClick:(UIButton*)sender{
    if ([DZUserDefaultsUtils getOwnID] == 0) {
        [self showLoginView];
        return;
    }
    
    DZMyOrderViewController * myOrder=[[DZMyOrderViewController alloc]init];
    switch (sender.tag) {
        case 1:
            [self.navigationController pushViewController:myOrder animated:YES];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
