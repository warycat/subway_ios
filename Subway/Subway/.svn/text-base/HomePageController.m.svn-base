//
//  ViewController.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "HomePageController.h"
#import "MenuViewController.h"
#import "StoreLocatorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomePageController ()

@end

@implementation HomePageController


-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
    // ----------------- GENERATE TOP BAR
    
    
    UIButton *storeLocatorBtn =  [[UIButton alloc] init];
    
     if ([settingMethod weiboIsConnected]) {
         
         [displayMethod createTopBar:self.view viewName:@"home" leftBtn:nil rightBtn:storeLocatorBtn otherBtn:nil];
         
     }else {
         
         UIButton *weiboBtn =  [[UIButton alloc] init];
         
         [displayMethod createTopBar:self.view viewName:@"home" leftBtn:weiboBtn rightBtn:storeLocatorBtn otherBtn:nil];
         
         [weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
         [weiboBtn release];
         
     }
    
    [storeLocatorBtn addTarget:self action:@selector(pushStoreLocatorView) forControlEvents:UIControlEventTouchDown];
    [storeLocatorBtn release];
    
    
    
    // ----------------- GENERATE BOTTOM BAR
    
    UIButton *menuBtn =  [[UIButton alloc] init];
    UIButton *couponBtn =  [[UIButton alloc] init];;
    
    [displayMethod createBottomBar:self.view viewName:@"home" myBtn1:menuBtn myBtn2:couponBtn myBtn3:nil];
    
    [menuBtn addTarget:self action:@selector(pushMenuView) forControlEvents:UIControlEventTouchDown];
    [menuBtn release];
    [couponBtn addTarget:self action:@selector(pushCouponView) forControlEvents:UIControlEventTouchDown];
    [couponBtn release];

    
    
    
    
}

#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)weiboAction { }

-(void)pushStoreLocatorView {
    
    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushMenuView {
    
    MenuViewController *menuViewCtrl = [[MenuViewController alloc] init];
    [self.navigationController pushViewController:menuViewCtrl animated:YES];
    [menuViewCtrl release];
    
}

-(void)pushCouponView { }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
