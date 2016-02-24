//
//  DZClassifyViewController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZClassifyViewController.h"
#import "DZSearchBarView.h"
#import "DZCategoryMenuModel.h"
#import "DZMultilevelMenu.h"
#import "DZCommodityViewController.h"
#import "REFrostedViewController.h"
#import "DZRightMenuViewController.h"
#import "DZNavigationController.h"

@interface DZClassifyViewController ()<DZSearchBarViewDelegate>
{
    NSMutableArray *_list;
}
@end

@implementation DZClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationItem];
    //初始化数据
    [self initData];
    //初始化分类菜单
    [self initCategoryMenu];
}

- (void)setupNavigationItem {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ico_camera_7_gray" highBackgroudImageName:nil target:self action:@selector(cameraClick)];
    
    //将搜索条放在一个UIView上
    DZSearchBarView *searchView = [[DZSearchBarView alloc]initWithFrame:CGRectMake(0, 7, self.view.frame.size.width-60 , 30)];
    searchView.delegate = self;
    self.navigationItem.titleView = searchView;
}

- (void)cameraClick{
    XLog(@"cameraClick");
}

#pragma mark - DZSearchBarViewDelegate Method
- (void)searchBarSearchButtonClicked:(DZSearchBarView *)searchBarView {
    XLog(@"searchBarSearchButtonClicked");
}

- (void)searchBarAudioButtonClicked:(DZSearchBarView *)searchBarView {
    XLog(@"searchBarAudioButtonClicked");
}

- (void)initData{
    
    _list = [NSMutableArray arrayWithCapacity:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
    for (int i = 0; i < [array count]; i++) {
        DZCategoryMenuModel *menu = [[DZCategoryMenuModel alloc] init];
        menu.menuName = [array objectAtIndex:i][@"menuName"];
        menu.nextArray = [array objectAtIndex:i][@"topMenu"];
        NSMutableArray *sub = [NSMutableArray arrayWithCapacity:0];
        
        for ( int j = 0; j <[menu.nextArray count]; j++) {
            DZCategoryMenuModel *menu1 = [[DZCategoryMenuModel alloc] init];
            menu1.menuName = [menu.nextArray objectAtIndex:j][@"topName"];
            menu1.nextArray = [menu.nextArray objectAtIndex:j][@"typeMenu"];
            
            NSMutableArray *zList = [NSMutableArray arrayWithCapacity:0];
            for ( int k = 0; k < [menu1.nextArray count]; k++) {
                DZCategoryMenuModel *menu2 = [[DZCategoryMenuModel alloc] init];
                menu2.menuName = [menu1.nextArray objectAtIndex:k][@"typeName"];
                menu2.urlName = [menu1.nextArray objectAtIndex:k][@"typeImg"];
                [zList addObject:menu2];
            }
            
            menu1.nextArray = zList;
            [sub addObject:menu1];
        }
        
        menu.nextArray = sub;
        [_list addObject:menu];
    }
}

- (void)initCategoryMenu{
    DZMultilevelMenu *view = [[DZMultilevelMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49) WithData:_list withSelectIndex:^(NSInteger left, NSInteger right,DZCategoryMenuModel *info) {
        
        XLog(@"点击的 菜单%@",info.menuName);
        DZNavigationController *navigationController = [[DZNavigationController alloc] initWithRootViewController:[[DZCommodityViewController alloc] init]];
        
        DZNavigationController *menuController = [[DZNavigationController alloc]  initWithRootViewController:[[DZRightMenuViewController alloc] init]];
        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
        frostedViewController.direction = REFrostedViewControllerDirectionRight;
        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
        [frostedViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:frostedViewController animated:YES completion:nil];
    }];
    
    view.needToScorllerIndex = 0; //默认是 选中第一行
    view.leftSelectColor = DZColor(243, 121, 120);//选中文字颜色
    view.leftSelectBgColor = [UIColor whiteColor];//选中背景颜色
    view.isRecordLastScroll = NO;//是否记住当前位置
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
