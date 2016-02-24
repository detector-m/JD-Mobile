//
//  DZCommodityViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommodityViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "DZSearchBarView.h"
#import "DZNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "DZCommodityModel.h"
#import "DZCommodityViewCell.h"
#import "DZDetailsViewController.h"

@interface DZCommodityViewController ()<DZSearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_commodity;
}
@end

@implementation DZCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView];
}

#pragma mark 加载数据
-(void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Commodity" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _commodity = [[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_commodity addObject:[DZCommodityModel commodityWithDictionary:obj]];
    }];
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"back_bt_7" highBackgroudImageName:nil target:self action:@selector(backClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"changeProductListGrid" highBackgroudImageName:nil target:self action:@selector(changeClick)];
    
    //将搜索条放在一个UIView上
    DZSearchBarView *searchView = [[DZSearchBarView alloc]initWithFrame:CGRectMake(0, 7, 240 , 30)];
    searchView.delegate = self;
    self.navigationItem.titleView = searchView;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
}

- (void)initView{
    PPiFlatSegmentedControl *segmented = [[PPiFlatSegmentedControl alloc]
                                        initWithFrame:CGRectMake(0, 64, self.view.width, 40)
                                        items:
                                        @[@{@"text":@"综合",@"icon":@"icon-sort"},
                                          @{@"text":@"销量"},
                                          @{@"text":@"价格",@"icon":@"icon-sort"},
                                          @{@"text":@"筛选",@"icon":@"icon-glass"}
                                          ]
                                        iconPosition:IconPositionRight
                                        andSelectionBlock:^(NSUInteger segmentIndex) {
                                            switch (segmentIndex) {
                                                case 0:
                                                    
                                                    break;
                                                case 1:
                                                    
                                                    break;
                                                case 2:
                                                    
                                                    break;
                                                case 3:
                                                    [(DZNavigationController *)self.navigationController showRightMenu];
                                                    break;
                                                    
                                                default:
                                                    break;
                                            }
                                        }];
    
    segmented.color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]];
    segmented.borderColor = [UIColor darkGrayColor];
    //segmented.selectedColor = [UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                               NSForegroundColorAttributeName:DZColor(135, 127, 141)};
    segmented.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                       NSForegroundColorAttributeName:DZColor(243, 106, 107)};
    
    [self.view addSubview:segmented];
    
    //创建一个分组样式的UITableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.width, self.view.height-104) style:UITableViewStylePlain];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;
    //设置代理
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor = DZColor(240, 243, 245);
    [self.view addSubview:_tableView];
}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeClick{
    XLog(@"changeClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource数据源方法

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commodity.count;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    DZCommodityViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil][0];
    }
    
    DZCommodityModel *commodity = _commodity[indexPath.row];
    
    cell.commodityImg.image = [UIImage imageNamed:commodity.commodityImageUrl];
    cell.commodityName.text = commodity.commodityName;
    cell.commodityPrice.text = [NSString stringWithFormat:@"￥%@",commodity.commodityPrice];
    cell.commodityZX.image = [UIImage imageNamed:commodity.commodityZX];
    cell.commodityPraise.text = commodity.praise;
    
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark 每行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLog(@"cell selected at index path %i", (int)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DZDetailsViewController * details = [[DZDetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark 滑动事件
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    XLog(@"scroll view did begin dragging");
}

@end
