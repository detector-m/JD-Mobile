//
//  DZTabBarController.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZTabBarController.h"
#import "DZNavigationController.h"
#import "DZHomeViewController.h"
#import "DZClassifyViewController.h"
#import "DZDiscoveryViewController.h"
#import "DZMineViewController.h"
#import "DZCartViewController.h"

@interface DZTabBarController ()

/**  首页*/
@property (nonatomic, assign) DZHomeViewController *homeViewController;
/**  分类*/
@property (nonatomic, assign) DZClassifyViewController *classifyViewController;
/**  发现*/
@property (nonatomic, assign) DZDiscoveryViewController *discoveryViewController;
/**  我的*/
@property (nonatomic, assign) DZMineViewController *mineViewController;
/**  购物车*/
@property (nonatomic, assign) DZCartViewController *cartViewController;

@end

@implementation DZTabBarController

+ (void)initialize {
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DZCommonColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加所有的自控制器
    [self addAllChildViewControllers];
    
}


- (void)addAllChildViewControllers {
    DZHomeViewController *homeViewController = [[DZHomeViewController alloc] init];
    [self addOneChildViewController:homeViewController title:@"首页" imageName:@"tabBar_home_normal" selectedImageName:@"tabBar_home_press"];
    _homeViewController = homeViewController;
    
    DZClassifyViewController *classifyViewController = [[DZClassifyViewController alloc] init];
    [self addOneChildViewController:classifyViewController title:@"分类" imageName:@"tabBar_category_normal" selectedImageName:@"tabBar_category_press"];
    _classifyViewController = classifyViewController;
    
    DZDiscoveryViewController *discoveryViewController = [[DZDiscoveryViewController alloc] init];
    [self addOneChildViewController:discoveryViewController title:@"发现" imageName:@"tabBar_find_normal" selectedImageName:@"tabBar_find_press"];
    _discoveryViewController = discoveryViewController;
    
    DZCartViewController *cartViewController = [[DZCartViewController alloc] init];
    [self addOneChildViewController:cartViewController title:@"购物车" imageName:@"tabBar_cart_normal" selectedImageName:@"tabBar_cart_press"];
    _cartViewController = cartViewController;
    
    DZMineViewController *mineViewController = [[DZMineViewController alloc] init];
    [self addOneChildViewController:mineViewController title:@"我的" imageName:@"tabBar_myJD_normal" selectedImageName:@"tabBar_myJD_press"];
    _mineViewController = mineViewController;
}

- (void)addOneChildViewController:(UIViewController *)childViewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //设置标题
    childViewController.title = title;
    //设置图标
    childViewController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childViewController.tabBarItem.selectedImage = selectedImage;
    //设置背景
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    //添加导航控制器
    DZNavigationController *nav = [[DZNavigationController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
