//
//  AppDelegate.m
//  Jewelry
//
//  Created by lv on 14-4-14.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "AppDelegate.h"
#import "FETabBarViewController.h"
#import "JEFirstTabbarVC.h"
#import "JESecondTabbarVC.h"
#import "JEThirdTabbarVC.h"
#import "JEFourthTabbarVC.h"
#import "JELeftSidePanelVC.h"
#import "JERightSidePanelVC.h"
#import "FESidePanelController.h"
@interface AppDelegate()<UITabBarControllerDelegate>
@property (nonatomic, strong)	FETabBarViewController*	tabBarController;
@end

@implementation AppDelegate

#pragma mark - Private Method
- (void)initTabBarController
{
	NSArray* titlesArr = [NSArray arrayWithObjects:@"商城",@"珠宝圈",@"学苑",@"我", nil];
	UIImage* image1 = [UIImage imageNamed:@"tab_settingsN.png"];
	UIImage* image2 = [UIImage imageNamed:@"tab_settingsN.png"];
	UIImage* image3 = [UIImage imageNamed:@"tab_settingsN.png"];
	UIImage* image4 = [UIImage imageNamed:@"tab_settingsN.png"];
	NSArray* imageNArr = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
	UIImage* imageH1 = [UIImage imageNamed:@"tab_settingsH.png"];
	UIImage* imageH2 = [UIImage imageNamed:@"tab_settingsH.png"];
	UIImage* imageH3 = [UIImage imageNamed:@"tab_settingsH.png"];
	UIImage* imageH4 = [UIImage imageNamed:@"tab_settingsH.png"];
	NSArray* imageHArr = [NSArray arrayWithObjects:imageH1,imageH2,imageH3,imageH4, nil];
    
	
	NSMutableArray* controllerArr = [[NSMutableArray alloc] initWithCapacity:0];
	UIViewController* vc = nil;
    UINavigationController* naviVC = nil;

    JELeftSidePanelVC* leftVC   = [[JELeftSidePanelVC alloc] initWithNibName:@"JELeftSidePanelVC" bundle:nil];
    JERightSidePanelVC* rightVC = [[JERightSidePanelVC alloc] initWithNibName:@"JERightSidePanelVC" bundle:nil];
    JEFirstTabbarVC*centerVC = [[JEFirstTabbarVC alloc] initWithNibName:@"JEFirstTabbarVC" bundle:nil];
    UINavigationController* leftNavi   = [[UINavigationController alloc] initWithRootViewController:leftVC];
    UINavigationController* rightNavi  = [[UINavigationController alloc] initWithRootViewController:rightVC];
    UINavigationController* centerNavi = [[UINavigationController alloc] initWithRootViewController:centerVC];
    FESidePanelController *sidePanel   = [[FESidePanelController alloc] initWithCenterViewController:centerNavi
                                                          leftViewController:leftNavi
                                                         rightViewController:rightNavi];
    
	centerVC.title = FEObjectAtIndex(titlesArr, 0);
	[controllerArr addObject:sidePanel];
    
    vc = [[JESecondTabbarVC alloc] init];
	vc.title = FEObjectAtIndex(titlesArr, 1);
    naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
	[controllerArr addObject:naviVC];

    vc = [[JEThirdTabbarVC alloc] init];
	vc.title = FEObjectAtIndex(titlesArr, 2);
    naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
	[controllerArr addObject:naviVC];
    
    vc = [[JEFourthTabbarVC alloc] init];
	vc.title = FEObjectAtIndex(titlesArr, 3);
    naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
	[controllerArr addObject:naviVC];
    
	
	self.tabBarController = [[FETabBarViewController  alloc] init];
	self.tabBarController.delegate = self;
	self.tabBarController.viewControllers = controllerArr;
	[self.tabBarController setTabBarItemTitle:titlesArr];
	[self.tabBarController setTabBarItemNormalImage:imageNArr highlightImage:imageHArr];
	//tabBarController_.customizableViewControllers = controllerArr;
	//tabBarController_.tabBar.tintColor = kTabCtlColor;
	//tabBarController_.tabBar.tintColor = kToolBarColor;

}

#pragma mark - Life Circle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self initTabBarController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
