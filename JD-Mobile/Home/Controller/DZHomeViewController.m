//
//  DZHomeViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZHomeViewController.h"
#import "RCDraggableButton.h"
#import "DZImageName.h"
#import "DZCellConfig.h"
#import "DZImage1ViewCell.h"
#import "DZImage2ViewCell.h"
#import "DZImage3ViewCell.h"
#import "DZImage4ViewCell.h"
#import "DZImage5ViewCell.h"
#import "DZImage6ViewCell.h"
#import "DZCycleScrollView.h"
#import "DZSearchBarView.h"
#import "UIBarButtonItem+Extension.h"
#import "DZRefresh.h"

@interface DZHomeViewController ()<UITableViewDataSource, UITableViewDelegate, DZCycleScrollViewDelegate, DZSearchBarViewDelegate>
{
    
    UISearchBar *_searchBar;
    DZCycleScrollView *_cycleScrollView;
    UIView *_loadAvataView;
    UITableView * _tableView;
    UIButton * topBtn;
    CGFloat lastContentOffset;
    
}

/** cellConfig数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 数据模型*/
@property (nonatomic, strong) DZImageName *modelToShow;

@property (nonatomic, weak) DZRefreshFooterView *refreshFooter;
@property (nonatomic, weak) DZRefreshHeaderView *refreshHeader;

/** 动画视图*/
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;

@end

@implementation DZHomeViewController

- (DZImageName *)modelToShow {
    if (!_modelToShow) {
        _modelToShow = [DZImageName new];
        // 假数据
        for (int i = 1; i < 7; i++) {
            NSString *key = [NSString stringWithFormat:@"imageName%d",i];
            NSString *value = [NSString stringWithFormat:@"cell_%02d",i];
            
            [_modelToShow setValue:value forKey:key];
        }
    }
    return _modelToShow;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        // 改变不同类型cell的顺序、增删时，只需在此修改即可，无需在多个tableView代理方法中逐个修改
        _dataArray = [NSMutableArray array];
        
        /**
         *
         * className:类名
         * title:标题，可用做cell直观的区分
         * showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
         * heightOfCell:此类cell的高度
         *
         */
        DZCellConfig *image1 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage1ViewCell class]) title:@"图1" showInfoMethod:@selector(showInfo:) heightOfCell:500];
        DZCellConfig *image2 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage2ViewCell class]) title:@"图2" showInfoMethod:@selector(showInfo:) heightOfCell:470];
        DZCellConfig *image3 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage3ViewCell class]) title:@"图3" showInfoMethod:@selector(showInfo:) heightOfCell:500];
        DZCellConfig *image4 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage4ViewCell class]) title:@"图4" showInfoMethod:@selector(showInfo:) heightOfCell:450];
        DZCellConfig *image5 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage5ViewCell class]) title:@"图5" showInfoMethod:@selector(showInfo:) heightOfCell:400];
        DZCellConfig *image6 = [DZCellConfig cellConfigWithClassName:NSStringFromClass([DZImage6ViewCell class]) title:@"图6" showInfoMethod:@selector(showInfo:) heightOfCell:500];
        
        [_dataArray addObject:@[image1, image2,image3,image4,image5,image6]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = DZColor(240, 243, 245);
    
    //因为iOS7鼓励全屏布局，它的默认值很自然地是UIRectEdgeAll，四周边缘均延伸，就是说，如果即使视图中上有navigationBar，下有tabBar，那么视图仍会延伸覆盖到四周的区域。
    //来解决UINavigationBar透明的问题。设置了UIRectEdgeNone之后，你嵌在UIViewController里面的UITableView和UIScrollView就不会穿过UINavigationBar了，同时UIView的控件也回复到了iOS6时代。
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置导航栏
    [self setupNavigationItem];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -44, self.view.width, self.view.height + 44) style:UITableViewStyleGrouped];
    //不显示垂直滑动条
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self addHeaderView];
    
    topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 100, 40, 40);
    [topBtn setBackgroundImage:[UIImage imageNamed:@"nearby_return_top_btn"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(DoSomething) forControlEvents:UIControlEventTouchUpInside];
    topBtn.clipsToBounds = YES;
    [self.view  addSubview:topBtn];
    //下拉刷新
    [self setupHeader];
    
    //显示拖动按钮
    _loadAvataView = [[UIApplication sharedApplication].keyWindow viewWithTag:100];
    _loadAvataView.hidden = NO;
}

#pragma mark - 设置导航栏
- (void)setupNavigationItem {
    //设置背景
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_bg"] forBarMetrics:UIBarMetricsCompact];    
    
    //设置为半透明
    [self.navigationController.navigationBar setTranslucent:YES];
    
    //设置透明度
    [self.navigationController.navigationBar setAlpha:0.3f];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"ico_camera_7" highImageName:nil title:@"扫一扫" target:self action:@selector(camera)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"HomePage_Message" highImageName:nil title:@"消息" target:self action:@selector(message)];
    
    //将搜索条放在一个UIView上
    DZSearchBarView *searchView = [[DZSearchBarView alloc]initWithFrame:CGRectMake(0, 7, 220, 30)];
    searchView.delegate = self;
    
    self.navigationItem.titleView = searchView;
}

- (UIView*)addHeaderView {
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    NSArray *imagesURLStrings = @[
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t895/234/1192509025/111466/512174ab/557fed56N3e023b70.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t835/313/1196724882/359493/b53c7b70/5581392cNa08ff0a9.jpg",
                                  @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t898/15/1262262696/95281/57d1f12f/558baeb4Nbfd44d3a.jpg"
                                  ];
    
    // 网络加载 --- 创建不带标题的图片轮播器
    _cycleScrollView = [DZCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) imageURLStringsGroup:nil];
    
    _cycleScrollView.infiniteLoop = YES;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage=[UIImage imageNamed:@"homepagebannerplaceholder"];
    _cycleScrollView.pageControlStyle = DZCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 2.0; // 轮播时间间隔，默认1.0秒，可自定义
    
    //模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
    
    [header addSubview:_cycleScrollView];
    
    return header;
}

- (void)setupHeader {
    DZRefreshHeaderView *refreshHeader = [DZRefreshHeaderView refreshViewWithStyle:DZRefreshViewStyleCustom];
    //默认是在navigationController环境下，如果不是在此环境下，请设置
    refreshHeader.isEffectedByNavigationController = YES;
    [refreshHeader addToScrollView:_tableView];

    UIImageView *headerBackground=[[UIImageView alloc] init];
    headerBackground.frame = CGRectMake(30, 0, 50, refreshHeader.bounds.size.height);
    headerBackground.image = [UIImage imageNamed:@"speed"];
    [refreshHeader addSubview:headerBackground];
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    animationView.frame = CGRectMake(80, 20, 50, refreshHeader.bounds.size.height);
    animationView.image = [UIImage imageNamed:@"staticDeliveryStaff"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;

    UIImageView *boxView = [[UIImageView alloc] init];
    boxView.frame = CGRectMake(200, 10, 15, 8);
    boxView.image = [UIImage imageNamed:@"box"];
    [refreshHeader addSubview:boxView];
    _boxView = boxView;

    UILabel *label= [[UILabel alloc] init];
    label.frame = CGRectMake(animationView.frame.size.width+110, 20, 200, 20);
    label.text = @"下拉更新...";
    label.textColor = DZColor(182,182,182);
    label.font = [UIFont systemFontOfSize:14];
    [refreshHeader addSubview:label];
    _label = label;

    __weak DZRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        // 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [weakRefreshHeader endRefreshing];
        });
    };
    // normal状态执行的操作
    refreshHeader.normalStateOperationBlock = ^(DZRefreshView *refreshView, CGFloat progress){
        refreshView.hidden = NO;
        if (progress == 0) {
            _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _boxView.hidden = NO;
            _label.text = @"下拉更新...";
            [_animationView stopAnimating];
        }

        self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
        self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 90, progress * 35);
    };

    // willRefresh状态执行的操作
    refreshHeader.willRefreshStateOperationBlock = ^(DZRefreshView *refreshView, CGFloat progress){
        _boxView.hidden = YES;
        _label.text = @"松手更新...";
        _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
        NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                            [UIImage imageNamed:@"deliveryStaff1"],
                            [UIImage imageNamed:@"deliveryStaff2"],
                            [UIImage imageNamed:@"deliveryStaff3"]
                            ];
        _animationView.animationImages = images;
        [_animationView startAnimating];
    };

    // refreshing状态执行的操作
    refreshHeader.refreshingStateOperationBlock = ^(DZRefreshView *refreshView, CGFloat progress){
        _label.text = @"更新中...";
        //                [UIView animateWithDuration:1.5 animations:^{
        //                    self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
        //                }];
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader beginRefreshing];
}

#pragma mark - DZSearchBarViewDelegate Method
- (void)searchBarSearchButtonClicked:(DZSearchBarView *)searchBarView {
    XLog(@"searchBarSearchButtonClicked");
}

- (void)searchBarAudioButtonClicked:(DZSearchBarView *)searchBarView {
    XLog(@"searchBarAudioButtonClicked");
}

#pragma mark - 按钮点击事件
- (void)DoSomething {
    //到顶部
    [_tableView setContentOffset:CGPointMake(0, -64) animated:YES];
    
}

- (void)camera {
    XLog(@"camera");
}

- (void)message {
    XLog(@"message");
//    ViewController *secondView = [[ViewController alloc] init];
//    [self.navigationController pushViewController:secondView animated:YES];
}

#pragma mark - display
- (void)viewWillAppear:(BOOL)animated {
    _loadAvataView = [[UIApplication sharedApplication].keyWindow viewWithTag:100];
    _loadAvataView.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    _loadAvataView = [[UIApplication sharedApplication].keyWindow viewWithTag:100];
    _loadAvataView.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取cellConfig
    DZCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    // 获取对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.modelToShow];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DZCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    return cellConfig.heightOfCell;
}

#pragma mark - TableView Delegate
#pragma mark 选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中项
//    // 获取cellConfig
//    ViewController *secondView = [[ViewController alloc] init];
//    [self.navigationController pushViewController:secondView animated:YES];
}

#pragma mark - DZCycleScrollViewDelegate
- (void)cycleScrollView:(DZCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    XLog(@"点击了第%ld张图片", index);
}

- (void)indexOnPageControl:(NSInteger)index{
    XLog(@"现在是第%ld张图片", index);
}

#pragma mark - ReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
