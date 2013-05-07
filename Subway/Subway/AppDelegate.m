//
//  AppDelegate.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "AppDelegate.h"

#import "HomePageController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //Set Language For app.
    [settingMethod setLanguage];
    
    //Get User Location
    [settingMethod doLocation];
    
    // Override point for customization after application launch.
    self.viewController = [[[HomePageController alloc] initWithNibName:@"HomePageController" bundle:nil] autorelease];
    UINavigationController *myNavigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    self.window.rootViewController = myNavigationController;
    [self.window makeKeyAndVisible];
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
