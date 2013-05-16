//
//  AppDelegate.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "AppDelegate.h"
#import "BMapKit.h"
#import "HomePageController.h"
#import "LoadingViewController.h"
BMKMapManager* _mapManager;

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%s",_cmd);
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"这里输入key" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [TestFlight takeOff:@"9c7d0d95-9fb2-49df-9f70-601eeec1eb4b"];
    
    
    //Set Language For app.
    [settingMethod setLanguage];
    
    //Get User Location
    [settingMethod doLocation];
    
    //Check Meals
    [menuMethod checkMeals];
    
    // Override point for customization after application launch.
    LoadingViewController *lvc = [[[LoadingViewController alloc]initWithNibName:@"LoadingViewController" bundle:nil] autorelease];
    //self.viewController = [[[HomePageController alloc] initWithNibName:@"HomePageController" bundle:nil] autorelease];
    UINavigationController *myNavigationController = [[[UINavigationController alloc] initWithRootViewController:lvc] autorelease];
    myNavigationController.navigationBarHidden = YES;
    self.window.rootViewController = myNavigationController;
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:kCallbackScheme]) {
        NSLog(@"app delegate login");
        return [[BlockSinaWeibo sharedClient].sinaWeibo handleOpenURL:url];
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    NSLog(@"------------------------- BACKGROUND -------------------------");
    NSLog(@"--------------------------------------------------------------");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    NSLog(@"------------------------- FOREGROUND -------------------------");
    NSLog(@"--------------------------------------------------------------");
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    NSLog(@"------------------------- TERMINATE -------------------------");
    NSLog(@"--------------------------------------------------------------");
    
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSLog(@"deviceToken:%@",deviceToken);

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != NULL ) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"APNS"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@" 关闭"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}



// -----------------------------
// ---------------------------------------------------------------------------------------
// -----------------------------



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



@end
