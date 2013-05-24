//
//  AppDelegate.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageController.h"
#import "LoadingViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeNewsstandContentAvailability|
     UIRemoteNotificationTypeSound
     ];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //Test Flight
    [TestFlight takeOff:@"9c7d0d95-9fb2-49df-9f70-601eeec1eb4b"];
    
    //Set Language For app.
    [settingMethod setLanguage];
    
    //Get User Location
    [settingMethod doLocation];
    
    //Check Meals
    [menuMethod checkMeals];
    

    LoadingViewController *lvc = [[[LoadingViewController alloc] init] autorelease];
    UINavigationController *myNavigationController = [[[UINavigationController alloc] initWithRootViewController:lvc] autorelease];
    myNavigationController.navigationBarHidden = YES;
    self.window.rootViewController = myNavigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* tokenString = [deviceToken description];
    tokenString = [tokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tokenString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",tokenString);
    
    NSString *token_url = [NSString stringWithFormat:@"%@device/add?device=ios&token=%@",ADRESS, tokenString];
    
    NSLog(@"%@",token_url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:token_url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
    }];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
    //abort();
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:kCallbackScheme]) {
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
