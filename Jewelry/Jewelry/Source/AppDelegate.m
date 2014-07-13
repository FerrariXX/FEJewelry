//
//  AppDelegate.m
//  Jewelry
//
//  Created by xxx on 14-4-14.
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
#import "JEFirstTabbarWrapperPageVC.h"
#import <Crashlytics/Crashlytics.h>

//share
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboApi.h"


@interface AppDelegate()<UITabBarControllerDelegate,UINavigationControllerDelegate,FESidePanelControllerDelegate>
@property (nonatomic, strong)	FETabBarViewController*	tabBarController;
@end

@implementation AppDelegate


#pragma mark - Private Method
- (void)initTabBarController
{
	NSArray* titlesArr = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
	UIImage* image1 = [UIImage imageNamed:@"tab_home.png"];
	UIImage* image2 = [UIImage imageNamed:@"tab_bareDiamond.png"];
	UIImage* image3 = [UIImage imageNamed:@"tab_jewelryCircle.png"];
	UIImage* image4 = [UIImage imageNamed:@"tab_mySetting.png"];
	NSArray* imageNArr = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
	UIImage* imageH1 = [UIImage imageNamed:@"tab_homeH.png"];
	UIImage* imageH2 = [UIImage imageNamed:@"tab_bareDiamondH.png"];
	UIImage* imageH3 = [UIImage imageNamed:@"tab_jewelryCircleH.png"];
	UIImage* imageH4 = [UIImage imageNamed:@"tab_mySettingH.png"];
	NSArray* imageHArr = [NSArray arrayWithObjects:imageH1,imageH2,imageH3,imageH4, nil];
    
	
	NSMutableArray* controllerArr = [[NSMutableArray alloc] initWithCapacity:0];
	UIViewController* vc = nil;
    UINavigationController* naviVC = nil;

    //JELeftSidePanelVC* leftVC   = [[JELeftSidePanelVC alloc] initWithNibName:@"JELeftSidePanelVC" bundle:nil];
    //JERightSidePanelVC* rightVC = [[JERightSidePanelVC alloc] initWithNibName:@"JERightSidePanelVC" bundle:nil];
    //JEFirstTabbarVC*centerVC = [[JEFirstTabbarVC alloc] initWithNibName:@"JEFirstTabbarVC" bundle:nil];
    JEFirstTabbarWrapperPageVC *centerVC = [[JEFirstTabbarWrapperPageVC alloc] init];
    //UINavigationController* leftNavi   = [[UINavigationController alloc] initWithRootViewController:leftVC];
    //UINavigationController* rightNavi  = [[UINavigationController alloc] initWithRootViewController:rightVC];
    UINavigationController* centerNavi = [[UINavigationController alloc] initWithRootViewController:centerVC];
    centerNavi.delegate = self;
    FESidePanelController *sidePanel   = [[FESidePanelController alloc]
                                          initWithCenterViewController:centerNavi
                                                    leftViewController:nil
                                                   rightViewController:nil];
    [sidePanel setDelegate:self];
    
	centerVC.title = FEObjectAtIndex(titlesArr, 0);
    sidePanel.title = FEObjectAtIndex(titlesArr, 0);
	[controllerArr addObject:sidePanel];
    

    vc = [[JEThirdTabbarVC alloc] init];
	vc.title = FEObjectAtIndex(titlesArr, 2);
    naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
	[controllerArr addObject:naviVC];
    
    vc = [[JESecondTabbarVC alloc] init];
	vc.title = FEObjectAtIndex(titlesArr, 1);
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

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];//font, NSFontAttributeName,
    UIColor *naviColor = [UIColor colorWithRed:41/255.0f green:112/255.0f blue:222/255.0f alpha:1.0];
    UINavigationBar *naviBar = [UINavigationBar appearance];
    if (JE_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [naviBar setBarTintColor:naviColor];        
    } else {
        [naviBar setTintColor:naviColor];
    }
    [naviBar setTitleTextAttributes:attributes];

    
}

#pragma mark - Life Circle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //share========================
    [ShareSDK registerApp:@"204fca2ad607"];
    [Crashlytics startWithAPIKey:@"10797bd1166be26204f7f84b2e8e72cda4d1af1a"];
    [self initializePlat];
    //share========================

    // Override point for customization after application launch.
    [self initTabBarController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    application.applicationSupportsShakeToEdit=YES;
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

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //进入二级页面后，tabbar隐藏
    [UIView animateWithDuration:0.3 animations:^{
        if ([[navigationController viewControllers] count] ==1) {
                [self.tabBarController setCustomTabBarHide:NO];
        }else {
            [self.tabBarController setCustomTabBarHide:YES];
        }
    }];
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//}
#pragma mark - FESidePanelControllerDelegate
- (void)sidePanelController:(FESidePanelController*)sidePanelController willShowController:(UIViewController*)controller{
    
    [UIView animateWithDuration:0.3 animations:^{
        if (controller == sidePanelController.centerPanel) {
            [self.tabBarController setCustomTabBarHide:NO];
        }else {
            [self.tabBarController setCustomTabBarHide:YES];
        }
    }];
}

#pragma mark - Shared


- (void)initializePlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //连接短信分享
    [ShareSDK connectSMS];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
}

/**
 *	@brief	托管模式下的初始化平台
 */
- (void)initializePlatForTrusteeship
{
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //导入人人网需要的外部库类型,如果不需要人人网SSO可以不调用此方法
    //[ShareSDK importRenRenClass:[RennClient class]];
    
    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
    
    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
    [ShareSDK importWeChatClass:[WXApi class]];
    
    //导入Google+需要的外部库类型，如果不需要Google＋分享可以不调用此方法
    // [ShareSDK importGooglePlusClass:[GPPSignIn class]
    //                     shareClass:[GPPShare class]];
    
    //导入Pinterest需要的外部库类型，如果不需要Pinterest分享可以不调用此方法
    // [ShareSDK importPinterestClass:[Pinterest class]];
    
    //导入易信需要的外部库类型，如果不需要易信分享可以不调用此方法
    //[ShareSDK importYiXinClass:[YXApi class]];
}


@end
