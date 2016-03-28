//
//  AppDelegate.m
//  TravelProject
//
//  Created by lanou on 16/3/28.
//  Copyright © 2016年 huangwenkang. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsIndexVC.h"
#import "ImpressIndexVC.h"
#import "TravelIndexVC.h"
#import "UserInfoIndexInfoVC.h"
#import "WishIndexVC.h"
#import "RKSwipeBetweenViewControllers.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //资讯
    NewsIndexVC *NewsVC = [[NewsIndexVC alloc] init];
    UINavigationController *NewsNavi = [[UINavigationController alloc] initWithRootViewController:NewsVC];
    NewsNavi.tabBarItem.title = @"资讯";
//    NewsVC.tabBarItem.image = [UIImage imageNamed:@"vedio.png"];
    //系统自带的样式  一般使用自己定义的样式
//    NewsVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:100];
    
    //游记
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc] initWithRootViewController:pageController];
    navigationController.tabBarItem.title = @"游记";
    TravelIndexVC *travelVC = [[TravelIndexVC alloc]init];
    ImpressIndexVC *impressVC = [[ImpressIndexVC alloc]init];
    [navigationController.viewControllerArray addObjectsFromArray:@[travelVC,impressVC]];
    
    //用户信息
    UserInfoIndexInfoVC *UserVC = [[UserInfoIndexInfoVC alloc] init];
    UINavigationController *UserNavi = [[UINavigationController alloc] initWithRootViewController:UserVC];
    UserNavi.tabBarItem.title = @"用户信息";
//    UserNavi.tabBarItem.image = [UIImage imageNamed:@"vedio.png"];
    //系统自带的样式  一般使用自己定义的样式
//    UserNavi.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:100];
    
    
    //心愿
    WishIndexVC *WishVC = [[WishIndexVC alloc] init];
    UINavigationController *WishNavi = [[UINavigationController alloc] initWithRootViewController:WishVC];
    WishNavi.tabBarItem.title = @"心愿";
    
    
    
    //标签视图控制器  UITabBarController  控制几个平行的,没有层级关系的视图控制器
    NSArray *vcArr = @[NewsNavi,navigationController,UserNavi,WishNavi];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //由标签视图控制器直接控制视图控制器
    tabBarController.viewControllers = vcArr;
    //填充图片的颜色
//    tabBarController.tabBar.tintColor = [UIColor yellowColor];
    //tabBar背景颜色
//    tabBarController.tabBar.barTintColor = [UIColor blueColor];
    tabBarController.delegate = self;
    tabBarController.selectedViewController = NewsNavi;
    self.window.rootViewController = tabBarController;
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
