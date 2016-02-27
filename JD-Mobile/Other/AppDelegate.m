//
//  AppDelegate.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/8.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "AppDelegate.h"
#import "DZTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark 加载悬浮小图标
- (void)loadAvatarInKeyView {
    _avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 333.5, 60, 60)];
    
    [_avatar setTag:100];
    
    [_avatar setBackgroundImage:[UIImage imageNamed:@"loadAvatar"] forState:UIControlStateNormal];
    _avatar.adjustsImageWhenHighlighted = NO;
    [_avatar setLongPressBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow LongPress");
        //More todo here.
        
    }];
    
    [_avatar setTapBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow Tap");
        //More todo here.
        
    }];
    
    [_avatar setDoubleTapBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow DoubleTap");
        //More todo here.
        
    }];
    
    [_avatar setDraggingBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow Dragging");
        //More todo here.
        
    }];
    
    [_avatar setDragDoneBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow DragDone");
        //More todo here.
        
    }];
    
    [_avatar setAutoDockingBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow AutoDocking");
        //More todo here.
        
    }];
    
    [_avatar setAutoDockingDoneBlock:^(RCDraggableButton *avatar) {
        XLog(@"\n\tAvatar in keyWindow AutoDockingDone");
        //More todo here.
        
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[DZTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self loadAvatarInKeyView];

    //对于大于ios8.1的系统需要注册用户协议通知才能实现applicationIconBadgeNumber
#if __IPHONE_8_1
    if (iOS8){
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        [application registerForRemoteNotificationTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound];
    }
    
#else
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    [application registerForRemoteNotificationTypes:myTypes];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
