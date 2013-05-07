//
//  MenuViewController.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StoreLocatorViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuScroll;
@synthesize subOfTheDayView, productsView, menuArray, currentProductsArray, productsScroll, pageControl;
@synthesize weiboShareBtn, healthShareBtn, tastyShareBtn, energyShareBtn, buildShareBtn;
@synthesize healthLbl, tastyLbl, energyLbl, buildLbl;

-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    firstTimeProductsViewAppear = YES;
    
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
    
    // ----------------- GENERATE TOP BAR
    
    UIButton *homeBtn =  [[UIButton alloc] init];
    UIButton *storeLocatorBtn =  [[UIButton alloc] init];;
    
    [displayMethod createTopBar:self.view viewName:@"menu" leftBtn:homeBtn rightBtn:storeLocatorBtn otherBtn:nil];
    
    [homeBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn release];
    [storeLocatorBtn addTarget:self action:@selector(pushStoreLocatorView) forControlEvents:UIControlEventTouchDown];
    [storeLocatorBtn release];
    
    
    // ----------------- GENERATE SUB OF THE DAY VIEW
    subOfTheDayView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - 253 - 55, screenWidth, 253)];
    subOfTheDayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subOfTheDayView];
    
    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"categories_bg@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, 0, subOfTheDayView.frame.size.width, subOfTheDayView.frame.size.height);
    [subOfTheDayView addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    
    // ----------------- GENERATE PRODUCTS VIEW
    productsView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 230)];
    productsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:productsView];
    
    UIImageView *BackgroundImgProduct = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_bg@2x"]];
    BackgroundImgProduct.frame = CGRectMake(0, 0, productsView.frame.size.width, productsView.frame.size.height);
    [productsView addSubview:BackgroundImgProduct];
    [BackgroundImgProduct release];
    
    
    productsScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(12, 0, screenWidth - 23, 170)];
    productsScroll.clipsToBounds = YES;
    productsScroll.delegate = self;
    productsScroll.tag = 1000;
    productsScroll.hidden = NO;
    productsScroll.backgroundColor = [UIColor clearColor];
    productsScroll.pagingEnabled = YES;
    productsScroll.bounces = YES;
    productsScroll.showsHorizontalScrollIndicator = NO;
    [productsView addSubview:productsScroll];
    
    
    // ----------------- PAGE CONTROL
    pageControl = [[DDPageControl alloc] init];
    pageControl.center = CGPointMake(productsView.center.x, productsView.frame.size.height + 18 );
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    
    // Customisation
    pageControl.defersCurrentPageDisplay = YES;
    pageControl.type = DDPageControlTypeOnFullOffFull; //DDPageControlTypeOnFullOffEmpty;   // ou
    pageControl.onColor = [UIColorCov colorWithHexString:YELLOW_TEXT];
    pageControl.offColor = [UIColor blackColor];
    pageControl.indicatorDiameter = 9.0f;
    pageControl.indicatorSpace = 10.0f;
    
    [productsView addSubview:pageControl];
    
    
    
    //---SHARE ON WEIBO
    UIImage *shareImgON = [UIImage imageNamed:@"icon_weibo@2x"];

    weiboShareBtn =  [[UIButton alloc] init];
    [weiboShareBtn  setFrame:CGRectMake(25, productsView.frame.size.height - 56, 43, 43)];
    weiboShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    weiboShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [weiboShareBtn setBackgroundImage:[shareImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [weiboShareBtn addTarget:self action:@selector(shareToWeibo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:weiboShareBtn];
    [weiboShareBtn release];
    
    CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    weiboLbl.text = @"share on";
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    weiboLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    weiboLbl.textAlignment = UITextAlignmentCenter;
    weiboLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:weiboLbl];
    [weiboLbl release];
    
    UIImageView *separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator@2x"]];
    separator.frame = CGRectMake(weiboShareBtn.frame.size.width + weiboShareBtn.frame.origin.x + 10, productsScroll.frame.size.height + 2, 1, 47);
    separator.backgroundColor = [UIColor clearColor];
    [productsView addSubview:separator];
    [separator release];
    
    
    //---HEALTH
    UIImage *healthImgON = [UIImage imageNamed:@"icon_lowfat@2x"];
    
    healthShareBtn =  [[UIButton alloc] init];
    [healthShareBtn  setFrame:CGRectMake(separator.frame.origin.x + separator.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    healthShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    healthShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [healthShareBtn setBackgroundImage:[healthImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [healthShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:healthShareBtn];
    [healthShareBtn release];
    
    healthLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(healthShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [healthLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    healthLbl.text = @"low fat";
    [healthLbl setDrawOutline:YES];
    [healthLbl setOutlineSize:strokeSize];
    [healthLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    healthLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    healthLbl.textAlignment = UITextAlignmentCenter;
    healthLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:healthLbl];
    [healthLbl release];
    
    
    //---TASTY
    UIImage *tastyImgON = [UIImage imageNamed:@"icon_tasty@2x"];
    
    tastyShareBtn =  [[UIButton alloc] init];
    [tastyShareBtn  setFrame:CGRectMake(healthShareBtn.frame.origin.x + healthShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    tastyShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tastyShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [tastyShareBtn setBackgroundImage:[tastyImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [tastyShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:tastyShareBtn];
    [tastyShareBtn release];
    
    tastyLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(tastyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [tastyLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    tastyLbl.text = @"tasty flavor";
    [tastyLbl setDrawOutline:YES];
    [tastyLbl setOutlineSize:strokeSize];
    [tastyLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    tastyLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    tastyLbl.textAlignment = UITextAlignmentCenter;
    tastyLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:tastyLbl];
    [tastyLbl release];
    
    
    //---ENERGY
    UIImage *energyImgON = [UIImage imageNamed:@"icon_energy@2x"];
    
    energyShareBtn =  [[UIButton alloc] init];
    [energyShareBtn  setFrame:CGRectMake(tastyShareBtn.frame.origin.x + tastyShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    energyShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    energyShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [energyShareBtn setBackgroundImage:[energyImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [energyShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:energyShareBtn];
    [energyShareBtn release];
    
    energyLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(energyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [energyLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    energyLbl.text = @"energy boost";
    [energyLbl setDrawOutline:YES];
    [energyLbl setOutlineSize:strokeSize];
    [energyLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    energyLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    energyLbl.textAlignment = UITextAlignmentCenter;
    energyLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:energyLbl];
    [energyLbl release];
    
    
    //---BUILD
    UIImage *buildImgON = [UIImage imageNamed:@"icon_build@2x"];
    
    buildShareBtn =  [[UIButton alloc] init];
    [buildShareBtn  setFrame:CGRectMake(energyShareBtn.frame.origin.x + energyShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    buildShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buildShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buildShareBtn setBackgroundImage:[buildImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [buildShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:buildShareBtn];
    [buildShareBtn release];
    
    buildLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(buildShareBtn.frame.origin.x - 6, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 52, 10)];
    [buildLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    buildLbl.text = @"sandwichbuild";
    [buildLbl setDrawOutline:YES];
    [buildLbl setOutlineSize:strokeSize];
    [buildLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    buildLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    buildLbl.textAlignment = UITextAlignmentCenter;
    buildLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:buildLbl];
    [buildLbl release];
    
    
    // ----------------- GENERATE BOTTOM BAR
    
    UIButton *cateringBtn =  [[UIButton alloc] init];
    UIButton *optionsBtn =  [[UIButton alloc] init];
    UIButton *howToBtn =  [[UIButton alloc] init];
    
    [displayMethod createBottomBar:self.view viewName:@"menu" myBtn1:cateringBtn myBtn2:optionsBtn myBtn3:howToBtn];
    
    [cateringBtn addTarget:self action:@selector(pushCateringView) forControlEvents:UIControlEventTouchDown];
    [cateringBtn release];
    [optionsBtn addTarget:self action:@selector(pushOptionsView) forControlEvents:UIControlEventTouchDown];
    [optionsBtn release];
    [howToBtn addTarget:self action:@selector(pushHowToView) forControlEvents:UIControlEventTouchDown];
    [howToBtn release];
    
    
    // ----------------- CREATE MENU

    // -----------------
    NSString *jsonMenuFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"product_all_%@", [settingMethod getUserLanguage]] ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:jsonMenuFilePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSError *error = nil;
    NSMutableDictionary *myResult = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //menuArray = [[NSMutableArray alloc] init];
    menuArray = [myResult objectForKey:@"data"];
    [menuArray retain];
    
    menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 65, screenWidth - 18, 90)];
    menuScroll.clipsToBounds = NO;
    menuScroll.delegate = self;
    menuScroll.hidden = NO;
    menuScroll.backgroundColor = [UIColor clearColor];
    menuScroll.pagingEnabled = NO;
    menuScroll.bounces = YES;
    menuScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:menuScroll];
    
    
    UIImage *BtnImgON = nil;
    UIImage *BtnImgOFF = nil;
    
    int XposInside = 0;
    for (int i = 0; i < [menuArray count]; i++) {
        
        
        CustomLabel *btn1Lbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 90 - 31, 90, 25)];
        [btn1Lbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12]];
        [btn1Lbl setDrawOutline:NO];
        btn1Lbl.textColor = [UIColorCov colorWithHexString:GREEN_TEXT];
        btn1Lbl.textAlignment = UITextAlignmentCenter;
        btn1Lbl.backgroundColor = [UIColor clearColor];
        btn1Lbl.text = [[menuArray objectAtIndex:i] objectForKey:@"title"];
        
        if (i == 0) {
            BtnImgON = [UIImage imageNamed:@"menu_value_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_value_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuValue", nil);
        }
        else if (i == 1) {
            BtnImgON = [UIImage imageNamed:@"menu_classic_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_classic_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuClassic", nil);
        }
        else if (i == 2) {
            BtnImgON = [UIImage imageNamed:@"menu_premium_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_premium_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuPremium", nil);
        }
        else if (i == 3) {
            BtnImgON = [UIImage imageNamed:@"menu_drink_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_drink_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuDrink", nil);
        }
        else if (i == 4) {
            BtnImgON = [UIImage imageNamed:@"menu_salad_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_salad_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuSalad", nil);
        }
        else if (i == 5) {
            BtnImgON = [UIImage imageNamed:@"menu_wrap_on@2x"];
            BtnImgOFF = [UIImage imageNamed:@"menu_wrap_off@2x"];
            //btn1Lbl.text = NSLocalizedString(@"kMenuWrap", nil);
        }

        
        UIButton *menuBtn =  [[UIButton alloc] initWithFrame:CGRectMake(XposInside, 0, 90, 90)];
        menuBtn.tag = [[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue];
        menuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        menuBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [menuBtn setBackgroundImage:[BtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [menuBtn setBackgroundImage:[BtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        [menuBtn setBackgroundImage:[BtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
        [menuBtn setBackgroundImage:[BtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateReserved];
        [menuBtn addTarget:self action:@selector(LaunchMenuAction:) forControlEvents:UIControlEventTouchDown];
        [menuScroll  addSubview:menuBtn];
        [menuBtn release];
        
        
        [menuBtn addSubview:btn1Lbl];
        [btn1Lbl release];
        
        
        XposInside = XposInside + 90;
        
    }
    
    menuScroll.contentSize = CGSizeMake(XposInside, 90);
    
    float width = menuScroll.frame.size.width;
    float height = menuScroll.frame.size.height;
    float newPosition = menuScroll.contentOffset.x + 165;
    CGRect toVisible = CGRectMake(newPosition, 0, width, height);
    [menuScroll scrollRectToVisible:toVisible animated:NO];
    
    
    //---------
    //ANIMATE THE MENU
    //---------
    #define GROW_FACTOR 1.2f
    #define SHRINK_FACTOR 1.0f
    #define MOVE_ANIMATION_DURATION_SECONDS 0.5    
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:MOVE_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop)];
	CGAffineTransform transform = CGAffineTransformMakeScale(GROW_FACTOR, GROW_FACTOR);
	menuScroll.transform = transform;
	[UIView commitAnimations];
    
    
}


- (void)growAnimationDidStop {
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:MOVE_ANIMATION_DURATION_SECONDS];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishMenu)];
	menuScroll.transform = CGAffineTransformMakeScale(SHRINK_FACTOR, SHRINK_FACTOR);
	[UIView commitAnimations];
}


-(void)showPopupInfo:(id)sender {
    
    
}

#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushStoreLocatorView {
    
    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}

-(void)backAction { [self.navigationController popViewControllerAnimated:YES]; }


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushCateringView { }

-(void)pushOptionsView { }

-(void)pushHowToView { }



#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- 
#pragma mark ---------------
#pragma mark ---------------


-(void)LaunchMenuAction:(id)sender {
    
    int idCategory = [sender tag];
    
    if (firstTimeProductsViewAppear) {
        firstTimeProductsViewAppear = NO;
        
        [self changeProductsInfo:idCategory];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [subOfTheDayView setFrame:CGRectMake(0, screenHeight, screenWidth, 253)];
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  
                                                  [productsView setFrame:CGRectMake(0, screenHeight - 245 - 65 , screenWidth, 230)];
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  
                                              }];
                             
                         }];
        
    }else {
        
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             productsScroll.alpha = 0.0;
                             
                         }
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  
                                                  [self changeProductsInfo:idCategory];
                                                  productsScroll.alpha = 1.0;
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  
                                              }];
                             
                         }];
        
        
    }
    
}

-(void)changeProductsInfo:(int)idCat {
    
    for (UIView *sub in productsScroll.subviews) {
        [sub removeFromSuperview];
    }
    
    float width = productsScroll.frame.size.width;
    float height = productsScroll.frame.size.height;
    CGRect toVisible = CGRectMake(0.0, 0, width, height);
    [productsScroll scrollRectToVisible:toVisible animated:NO];
    
    
    
    for (int i = 0; i < [menuArray count]; i++) {
        
        if ([[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue] == idCat) {
            
            if (currentProductsArray == nil) {
                currentProductsArray = [[NSMutableArray alloc] init];
            }else {
                [currentProductsArray removeAllObjects];
                [currentProductsArray release];
                currentProductsArray = nil;
                currentProductsArray = [[NSMutableArray alloc] init];
            }
                
            for (int y = 0; y < [[[menuArray objectAtIndex:i] objectForKey:@"products"] count]; y++) {
                [currentProductsArray addObject:[[[menuArray objectAtIndex:i] objectForKey:@"products"] objectAtIndex:y]];
            }
            break;
            
        }
        
    }
    
    pageControl.numberOfPages = [currentProductsArray count];
    pageControl.currentPage = 0;
    
    float productScrollContentSize = productsScroll.frame.size.width * [currentProductsArray count];
    productsScroll.contentSize = CGSizeMake(productScrollContentSize, productsScroll.frame.size.height);

    int XPosImage = 0;
    
    for (int i = 0; i < [currentProductsArray count]; i++) {
     
        NSLog(@"my image = %@", [[[[currentProductsArray objectAtIndex:i] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]);
        
        UIImageView *ImageProduct = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[[[currentProductsArray objectAtIndex:i] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
        ImageProduct.frame = CGRectMake(XPosImage, productsScroll.frame.size.height - 110, 300, 105);
        [productsScroll addSubview:ImageProduct];
        [ImageProduct release];
    
        CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(XPosImage, 5, 300, 40)];
        [titleProductLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:22.0]];
        titleProductLbl.text = [[currentProductsArray objectAtIndex:i] objectForKey:@"title"];
        [titleProductLbl setDrawOutline:YES];
        [titleProductLbl setOutlineSize:strokeSize];
        [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleProductLbl.textAlignment = UITextAlignmentCenter;
        titleProductLbl.backgroundColor = [UIColor clearColor];
        [productsScroll addSubview:titleProductLbl];
        [titleProductLbl release];
        
        
        XPosImage = XPosImage + productsScroll.frame.size.width;
    }
    
    [self redrawButtonsInfo:0];

}

-(void)redrawButtonsInfo:(int)position {
    
    BOOL hasHealth = NO;
    BOOL hasTasty = NO;
    BOOL hasEnergy = NO;
    BOOL hasBuild = NO;
    
    NSMutableArray *productFactsArray = [[currentProductsArray objectAtIndex:position] objectForKey:@"product_facts"];
    
    for (int i = 0; i < [productFactsArray count]; i++) {
        
        if ([[[productFactsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"T"]) {
            hasTasty = YES;
            tastyShareBtn.tag = [[[productFactsArray objectAtIndex:i] objectForKey:@"pfid"] intValue];
        }
        if ([[[productFactsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"H"]) {
            hasHealth = YES;
            healthShareBtn.tag = [[[productFactsArray objectAtIndex:i] objectForKey:@"pfid"] intValue];
        }
        if ([[[productFactsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"E"]) {
            hasEnergy = YES;
            energyShareBtn.tag = [[[productFactsArray objectAtIndex:i] objectForKey:@"pfid"] intValue];
        }
        if ([[[productFactsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"B"]) {
            hasBuild = YES;
            buildShareBtn.tag = [[[productFactsArray objectAtIndex:i] objectForKey:@"pfid"] intValue];
        }
        
    }
    
    [UIView animateWithDuration:0.35
                     animations:^{
                         
                         healthShareBtn.alpha = 0.0;
                         tastyShareBtn.alpha = 0.0;
                         energyShareBtn.alpha = 0.0;
                         buildShareBtn.alpha = 0.0;
                         healthLbl.alpha = 0.0;
                         tastyLbl.alpha = 0.0;
                         energyLbl.alpha = 0.0;
                         buildLbl.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              
                                              int xPosElements = 78;
                                              
                                              if (hasHealth == YES) {
                                                
                                                  [healthShareBtn  setFrame:CGRectMake(xPosElements + 12, productsView.frame.size.height - 56, 43, 43)];
                                                  [healthLbl  setFrame:CGRectMake(healthShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
                                                  
                                                  xPosElements = healthShareBtn.frame.origin.x + healthShareBtn.frame.size.width;
                                              }
                                              
                                              if (hasTasty == YES) {
                                                  
                                                  [tastyShareBtn  setFrame:CGRectMake(xPosElements + 12, productsView.frame.size.height - 56, 43, 43)];
                                                  [tastyLbl  setFrame:CGRectMake(tastyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
                                                  
                                                  xPosElements = tastyShareBtn.frame.origin.x + tastyShareBtn.frame.size.width;
                                              }
                                              
                                              if (hasEnergy == YES) {
                                                  
                                                  [energyShareBtn  setFrame:CGRectMake(xPosElements + 12, productsView.frame.size.height - 56, 43, 43)];
                                                  [energyLbl  setFrame:CGRectMake(energyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
                                                  
                                                  xPosElements = energyShareBtn.frame.origin.x + energyShareBtn.frame.size.width;
                                              }
                                              
                                              if (hasBuild == YES) {
                                                  
                                                  [buildShareBtn  setFrame:CGRectMake(xPosElements + 12, productsView.frame.size.height - 56, 43, 43)];
                                                  [buildLbl  setFrame:CGRectMake(buildShareBtn.frame.origin.x - 6, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 52, 10)];
                                                  
                                              }
                                              
                                              
                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                              [UIView animateWithDuration:0.35
                                                               animations:^{
                                                                   
                                                                   if (hasHealth == YES) {
                                                                       healthShareBtn.hidden = NO;
                                                                       healthLbl.hidden = NO;
                                                                       healthShareBtn.alpha = 1.0;
                                                                       healthLbl.alpha = 1.0;
                                                                   }else {
                                                                       healthShareBtn.hidden = YES;
                                                                       healthLbl.hidden = YES;
                                                                   }
                                                                   
                                                                   if (hasTasty == YES) {
                                                                       tastyShareBtn.hidden = NO;
                                                                       tastyLbl.hidden = NO;
                                                                       tastyShareBtn.alpha = 1.0;
                                                                       tastyLbl.alpha = 1.0;
                                                                   }else {
                                                                       tastyShareBtn.hidden = YES;
                                                                       tastyLbl.hidden = YES;
                                                                   }
                                                                   
                                                                   if (hasEnergy == YES) {
                                                                       energyShareBtn.hidden = NO;
                                                                       energyLbl.hidden = NO;
                                                                       energyShareBtn.alpha = 1.0;
                                                                       energyLbl.alpha = 1.0;
                                                                   }else {
                                                                       energyShareBtn.hidden = YES;
                                                                       energyLbl.hidden = YES;
                                                                   }
                                                                   
                                                                   if (hasBuild == YES) {
                                                                       buildShareBtn.hidden = NO;
                                                                       buildLbl.hidden = NO;
                                                                       buildShareBtn.alpha = 1.0;
                                                                       buildLbl.alpha = 1.0;
                                                                   }else {
                                                                       buildShareBtn.hidden = YES;
                                                                       buildLbl.hidden = YES;
                                                                   }
                                                                   
                                                                   
                                                               }
                                                               completion:^(BOOL finished){
                                                                   
                                                               }];
                                              
                                          }];
                         
                     }];
    
    
}


// --------------------
// SCROLLVIEW METHOD
// --------------------

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (aScrollView.tag == 1000) {
        
        CGFloat pageWidth = productsScroll.bounds.size.width;
        float fractionalPage = productsScroll.contentOffset.x / pageWidth ;
        NSInteger nearestNumber = lround(fractionalPage) ;
        
        weiboShareBtn.tag = nearestNumber;
        
        if (pageControl.currentPage != nearestNumber)
        {
            pageControl.currentPage = nearestNumber ;
            
            // if we are dragging, we want to update the page control directly during the drag
            if (productsScroll.dragging)
                [pageControl updateCurrentPageDisplay];
                [self redrawButtonsInfo:nearestNumber];
        }
        
    }

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView {
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
    

    
}




// --------------------
// BUTTON PRODUCTS ACTION
// --------------------


-(void)shareToWeibo:(id)sender {
    
    
}


-(void)finishMenu
{
    
    UIImageView *test = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_sub@2x"]];
    test.frame = CGRectMake((screenWidth-236)/2, subOfTheDayView.frame.size.height - 140, 236, 105);
    test.contentMode = UIViewContentModeScaleToFill;
    [subOfTheDayView addSubview:test];
    [test release];
    
    
	CATransition *transition = [CATransition animation];
	transition.duration = 0.75;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
	transition.type = @"rippleEffect"; //@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip"
	transition.subtype = subtypes[2];
	transition.delegate = self;
	[subOfTheDayView.layer addAnimation:transition forKey:nil];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
