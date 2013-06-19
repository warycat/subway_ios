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
#import "HowToOrderViewController.h"
#import "CateringViewController.h"
#import "CouponViewController.h"
#import "BlockSinaWeiboRequest.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuScroll;
@synthesize subOfTheDayView, subOfTheDayContainer, subOfTheDayViewInfo;
@synthesize productsView, menuArray, currentProductsArray, productsScroll, pageControl;
@synthesize weiboShareBtn, healthShareBtn, tastyShareBtn, energyShareBtn, buildShareBtn, popupInfo, factIconImgForPopup, factTitleLbl, factDescriptionLbl, menuTempHolderImg;
@synthesize healthLbl, tastyLbl, energyLbl, buildLbl, fromSubOfTheDay, productId, myCurrentCatID, fromSubOfTheDayAllWeek;
@synthesize optionsProductBtn, optionsDesc;


-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    firstTimeProductsViewAppear = YES;
    tempProdFact = 0;
    viewIsFlipped = YES;
    
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
    
    // -----------------
    // -----------------
    // ----------------- GENERATE SUB OF THE DAY VIEW
    // -----------------
    // -----------------
    
    subOfTheDayContainer = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - 253 - 55, screenWidth, 253)];
    
    if( IS_4_INCH_SCREEN ) {
        [subOfTheDayContainer setFrame:CGRectMake(0, screenHeight - 273 - 55, screenWidth, 253)];
    }
    
    
    subOfTheDayContainer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subOfTheDayContainer];
    
    
    // Information view for the Sub Of the Day FLIPPED VIEW
    subOfTheDayViewInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 253)];
    subOfTheDayViewInfo.backgroundColor = [UIColor clearColor];
    [subOfTheDayContainer addSubview:subOfTheDayViewInfo];
    
    UIImageView *BackgroundImgInfoSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"categories_bg@2x"]];
    BackgroundImgInfoSub.frame = CGRectMake(0, 0, subOfTheDayViewInfo.frame.size.width, subOfTheDayViewInfo.frame.size.height);
    [subOfTheDayViewInfo addSubview:BackgroundImgInfoSub];
    [BackgroundImgInfoSub release];
    
    
    // --------------- + back
    
    UIImage *myLocationImageOn = [[UIImage imageNamed:@"btn_red_on.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    UIImage *myLocationImageOff = [[UIImage imageNamed:@"btn_red_off.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    
    UIButton *backInfobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backInfobtn.frame = CGRectMake((screenWidth-130)/2, subOfTheDayViewInfo.frame.size.height - 55, 130, 40);
    backInfobtn.userInteractionEnabled = YES;
    [backInfobtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [backInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [backInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [backInfobtn addTarget:self action:@selector(showMoreInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    CustomLabel *backLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 3, backInfobtn.frame.size.width, backInfobtn.frame.size.height)];
    [backLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:15.5]];
    backLbl.text = NSLocalizedString(@"back_btn_txt", nil);
    [backLbl setDrawOutline:YES];
    [backLbl setOutlineSize:strokeSize];
    [backLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    backLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    backLbl.textAlignment = UITextAlignmentCenter;
    backLbl.backgroundColor = [UIColor clearColor];
    [backInfobtn addSubview:backLbl];
    [backLbl release];
    
    [subOfTheDayViewInfo addSubview:backInfobtn];
    
    //Create scroll info for sub of the day
    UIScrollView *infoScrollSubOfTheDay = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, subOfTheDayViewInfo.frame.size.width - 20, subOfTheDayViewInfo.frame.size.height - 80)];
    infoScrollSubOfTheDay.clipsToBounds = YES;
    infoScrollSubOfTheDay.hidden = NO;
    infoScrollSubOfTheDay.backgroundColor = [UIColor clearColor];
    infoScrollSubOfTheDay.pagingEnabled = YES;
    infoScrollSubOfTheDay.bounces = YES;
    infoScrollSubOfTheDay.showsHorizontalScrollIndicator = NO;
    [subOfTheDayViewInfo addSubview:infoScrollSubOfTheDay];
    [infoScrollSubOfTheDay release];
    
    
    // the Sub Of the Day MAIN VIEW
    subOfTheDayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 253)];
    subOfTheDayView.backgroundColor = [UIColor clearColor];
    [subOfTheDayContainer addSubview:subOfTheDayView];
    
    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"categories_bg@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, 0, subOfTheDayView.frame.size.width, subOfTheDayView.frame.size.height);
    [subOfTheDayView addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    
    // --------------- + informations
        
    UIButton *showMOreInfobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showMOreInfobtn.frame = CGRectMake((screenWidth-135)/2, subOfTheDayView.frame.size.height - 55, 140, 40);
    
    if ([[settingMethod getUserLanguage] isEqualToString:@"cn"]) {
        showMOreInfobtn.frame = CGRectMake((screenWidth-115)/2, subOfTheDayView.frame.size.height - 55, 120, 40);
    }
    
    showMOreInfobtn.userInteractionEnabled = YES;
    [showMOreInfobtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [showMOreInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [showMOreInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [showMOreInfobtn addTarget:self action:@selector(showMoreInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoPLus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_aroundme@2x"]];
    logoPLus.frame = CGRectMake(10, (showMOreInfobtn.frame.size.height-25)/2, 25, 25);
    [showMOreInfobtn addSubview:logoPLus];
    [logoPLus release];
    
    
    CustomLabel *learnLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoPLus.frame.size.width + logoPLus.frame.origin.x - 1, 3, 100, showMOreInfobtn.frame.size.height)];
    [learnLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:15.5]];
    learnLbl.text = NSLocalizedString(@"learnMore_btn_txt", nil);
    [learnLbl setDrawOutline:YES];
    [learnLbl setOutlineSize:strokeSize];
    [learnLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    learnLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    learnLbl.textAlignment = UITextAlignmentLeft;
    learnLbl.backgroundColor = [UIColor clearColor];
    [showMOreInfobtn addSubview:learnLbl];
    [learnLbl release];

    [subOfTheDayView addSubview:showMOreInfobtn];
    
    
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
    pageControl.type = DDPageControlTypeOnFullOffFull;
    pageControl.onColor = [UIColorCov colorWithHexString:YELLOW_TEXT];
    pageControl.offColor = [UIColor blackColor];
    pageControl.indicatorDiameter = 9.0f;
    pageControl.indicatorSpace = 10.0f;
    
    [productsView addSubview:pageControl];
    
    
    //---CREATE POPUP INFO
    popupInfo = [[UIView alloc] init];
    [popupInfo setFrame:CGRectMake(12, 168, productsView.frame.size.width - 21, 0)];

    popupInfo.backgroundColor = [UIColor clearColor];
    popupInfo.clipsToBounds = YES;
    popupInfo.userInteractionEnabled = YES;
    [productsView addSubview:popupInfo];
    
    
    //draw gradient on top
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, productsView.frame.size.width - 21, 168)] autorelease];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.0] CGColor], (id)[[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.6] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];

    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, productsView.frame.size.width - 21, 168)] autorelease];
    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    gradient2.frame = view2.bounds;
    gradient2.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.0] CGColor], (id)[[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.6] CGColor], nil];
    [view2.layer insertSublayer:gradient2 atIndex:0];

    view.userInteractionEnabled = YES;
    view2.userInteractionEnabled = YES;
    
    [popupInfo addSubview:view];
    [popupInfo addSubview:view2];
    
    
    // Fasts Title
    factTitleLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(5, 45, popupInfo.frame.size.width, 20)];
    [factTitleLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:18.0]];
    factTitleLbl.text = @"";
    [factTitleLbl setDrawOutline:YES];
    [factTitleLbl setOutlineSize:strokeSize];
    [factTitleLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    factTitleLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    factTitleLbl.textAlignment = UITextAlignmentLeft;
    factTitleLbl.backgroundColor = [UIColor clearColor];
    [popupInfo addSubview:factTitleLbl];
    
    // Facts Image
    factIconImgForPopup = [[UIImageView alloc] init];
    factIconImgForPopup.frame = CGRectMake(popupInfo.frame.size.width - 38, 38, 33, 33);
    factIconImgForPopup.contentMode = UIViewContentModeScaleToFill;
    [popupInfo addSubview:factIconImgForPopup];
    
    // Facts Description
    factDescriptionLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(5, 60, popupInfo.frame.size.width - 10, 100)];
    [factDescriptionLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:13.0]];
    factDescriptionLbl.text = @"";
    [factDescriptionLbl setDrawOutline:YES];
    [factDescriptionLbl setOutlineSize:strokeSize];
    [factDescriptionLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    factDescriptionLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    factDescriptionLbl.textAlignment = UITextAlignmentCenter;
    factDescriptionLbl.numberOfLines = 0;
    factDescriptionLbl.backgroundColor = [UIColor clearColor];
    [popupInfo addSubview:factDescriptionLbl];
    
    // --- ADD GESTURE TO HIDE INFO IS DISPLAYED
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupInfo)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeLeftRecognizer setNumberOfTouchesRequired:1];
    [popupInfo addGestureRecognizer:swipeLeftRecognizer];
    [swipeLeftRecognizer release];
    
    
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupInfo)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeRightRecognizer setNumberOfTouchesRequired:1];
    [popupInfo addGestureRecognizer:swipeRightRecognizer];
    [swipeRightRecognizer release];
    // ---
    
    popupInfo.alpha = 0.0;
    popupInfo.hidden = YES;
    
    
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
    [weiboLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
    weiboLbl.text = NSLocalizedString(@"kShareOnWeibo", nil);
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
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
    
    healthLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(healthShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [healthLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
    healthLbl.text = NSLocalizedString(@"kLowFat", nil);
    [healthLbl setDrawOutline:YES];
    [healthLbl setOutlineSize:strokeSize];
    [healthLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    healthLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    healthLbl.textAlignment = UITextAlignmentCenter;
    healthLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:healthLbl];
    
    //---TASTY
    UIImage *tastyImgON = [UIImage imageNamed:@"icon_tasty@2x"];
    
    tastyShareBtn =  [[UIButton alloc] init];
    [tastyShareBtn  setFrame:CGRectMake(healthShareBtn.frame.origin.x + healthShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    tastyShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tastyShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [tastyShareBtn setBackgroundImage:[tastyImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [tastyShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:tastyShareBtn];
    
    tastyLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(tastyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [tastyLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
    tastyLbl.text = NSLocalizedString(@"kTastyFlavor", nil);
    [tastyLbl setDrawOutline:YES];
    [tastyLbl setOutlineSize:strokeSize];
    [tastyLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    tastyLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    tastyLbl.textAlignment = UITextAlignmentCenter;
    tastyLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:tastyLbl];
    
    
    //---ENERGY
    UIImage *energyImgON = [UIImage imageNamed:@"icon_energy@2x"];
    
    energyShareBtn =  [[UIButton alloc] init];
    [energyShareBtn  setFrame:CGRectMake(tastyShareBtn.frame.origin.x + tastyShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    energyShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    energyShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [energyShareBtn setBackgroundImage:[energyImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [energyShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:energyShareBtn];
    
    energyLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(energyShareBtn.frame.origin.x - 5, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [energyLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
    energyLbl.text = NSLocalizedString(@"kEnergyBoost", nil);
    [energyLbl setDrawOutline:YES];
    [energyLbl setOutlineSize:strokeSize];
    [energyLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    energyLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    energyLbl.textAlignment = UITextAlignmentCenter;
    energyLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:energyLbl];
    
    
    //---BUILD
    UIImage *buildImgON = [UIImage imageNamed:@"icon_build@2x"];
    
    buildShareBtn =  [[UIButton alloc] init];
    [buildShareBtn  setFrame:CGRectMake(energyShareBtn.frame.origin.x + energyShareBtn.frame.size.width + 12, productsView.frame.size.height - 56, 43, 43)];
    buildShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buildShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buildShareBtn setBackgroundImage:[buildImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [buildShareBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:buildShareBtn];
    
    buildLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(buildShareBtn.frame.origin.x - 6, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 52, 10)];
    [buildLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
    buildLbl.text = NSLocalizedString(@"kSandwichBuild", nil);
    [buildLbl setDrawOutline:YES];
    [buildLbl setOutlineSize:strokeSize];
    [buildLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    buildLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    buildLbl.textAlignment = UITextAlignmentCenter;
    buildLbl.backgroundColor = [UIColor clearColor];
    [productsView addSubview:buildLbl];
    
    
    // ----------------- OPTIONS btn
    UIImage *optionImgON = [UIImage imageNamed:@"menu_options_icon@2x"];
    
    hasOptions = NO;
    
    optionsProductBtn =  [[UIButton alloc] init];
    optionsProductBtn.tag = 999;
    [optionsProductBtn  setFrame:CGRectMake(productsView.frame.size.width - 35, 11, 25, 25)];
    optionsProductBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    optionsProductBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [optionsProductBtn setBackgroundImage:[optionImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [optionsProductBtn addTarget:self action:@selector(showPopupInfo:) forControlEvents:UIControlEventTouchDown];
    [productsView  addSubview:optionsProductBtn];
    
    
    // ----------------- GENERATE BOTTOM BAR
    
    UIButton *cateringBtn =  [[UIButton alloc] init];
    UIButton *howToBtn =  [[UIButton alloc] init];
    UIButton *couponBtn =  [[UIButton alloc] init];
    
    [displayMethod createBottomBar:self.view viewName:@"menu" myBtn1:cateringBtn myBtn2:howToBtn myBtn3:couponBtn];
    
    [cateringBtn addTarget:self action:@selector(pushCateringView) forControlEvents:UIControlEventTouchDown];
    [cateringBtn release];
    [howToBtn addTarget:self action:@selector(pushHowToView) forControlEvents:UIControlEventTouchDown];
    [howToBtn release];
    [couponBtn addTarget:self action:@selector(pushCouponsView) forControlEvents:UIControlEventTouchDown];
    [couponBtn release];
    
    
    // ----------------- CREATE MENU & OVERALL VIEW INFO
    // -----------------
        
    NSData *menuFromSetting = [[NSUserDefaults standardUserDefaults] objectForKey:@"products"];
    menuArray = [NSKeyedUnarchiver unarchiveObjectWithData:menuFromSetting];
    [menuArray retain];
    
    menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 65, screenWidth - 18, 90)];
    
    if( IS_4_INCH_SCREEN ) {
        [menuScroll setFrame:CGRectMake(10, 95, screenWidth - 18, 90)];
    }
    
    menuScroll.clipsToBounds = NO;
    menuScroll.delegate = self;
    menuScroll.hidden = NO;
    menuScroll.backgroundColor = [UIColor clearColor];
    menuScroll.pagingEnabled = NO;
    menuScroll.bounces = YES;
    menuScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:menuScroll];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    unsigned int compFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *weekdayComponents = [gregorianCalendar components:compFlags fromDate:[NSDate date]];
    int today = weekdayComponents.weekday-1;
    
    
    int SODId = 0;
    
    if (fromSubOfTheDay == YES) {
        
        for (int i = 0; i < [menuArray count]; i++) {
            
            NSMutableArray *productsArray = [[menuArray objectAtIndex:i] objectForKey:@"products"];
            
            for (int y = 0; y < [productsArray count]; y++) {
                
                int theSOD = [[[productsArray objectAtIndex:y] objectForKey:@"sub_of_the_day"] intValue];
                
                if (theSOD == today) {
                    
                    SODId = [[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue];
                    break;
                }
                
            }
            
            
        }
    }
    

    menuTempHolderImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"taxo_on@2x"]];
    menuTempHolderImg.frame = CGRectMake(0, 0, 90, 90);
    [menuScroll addSubview:menuTempHolderImg];
    menuTempHolderImg.hidden = YES;
    
    UIImage *BtnImgON = nil;
    UIImage *BtnImgOFF = nil;
    
    int XposInside = 0;
    
    
    
    for (int i = 0; i < [menuArray count]; i++) {
        
        
        CustomLabel *btn1Lbl = [[CustomLabel alloc] initWithFrame:CGRectMake(5, 90 - 31, 80, 25)];
        [btn1Lbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:11]];
        [btn1Lbl setDrawOutline:NO];
        btn1Lbl.textColor = [UIColorCov colorWithHexString:GREEN_TEXT];
        btn1Lbl.textAlignment = UITextAlignmentCenter;
        btn1Lbl.backgroundColor = [UIColor clearColor];
        btn1Lbl.text = [[menuArray objectAtIndex:i] objectForKey:@"title"];
        
        if ([[[menuArray objectAtIndex:i] objectForKey:@"media"] count] > 0) {
            
            BtnImgON = [settingMethod getImagePath:[[[[menuArray objectAtIndex:i] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]];
            BtnImgOFF =  [settingMethod getImagePath:[[[[menuArray objectAtIndex:i] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]];
            
        }
        
        UIButton *menuBtn =  [[UIButton alloc] initWithFrame:CGRectMake(XposInside, 0, 90, 90)];
        menuBtn.tag = [[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue];
        menuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        menuBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        menuBtn.userInteractionEnabled = YES;
        [menuBtn setBackgroundImage:[BtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [menuBtn setBackgroundImage:[BtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        [menuBtn setBackgroundImage:[BtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
        [menuBtn setBackgroundImage:[BtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateReserved];
        [menuBtn addTarget:self action:@selector(LaunchMenuAction:) forControlEvents:UIControlEventTouchDown];
        [menuScroll  addSubview:menuBtn];
        [menuBtn release];
        
        
        [menuBtn addSubview:btn1Lbl];
        [btn1Lbl release];
        
        if (fromSubOfTheDay == YES) {
            
            if (SODId == [[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue]) {
                
                menuTempHolderImg.frame = CGRectMake(XposInside, 0, 90, 90);
                [menuScroll addSubview:menuTempHolderImg];
                menuTempHolderImg.hidden = NO;
                
            }
            
        }

        
        XposInside = XposInside + 90;
        
    }
    
    menuScroll.contentSize = CGSizeMake(XposInside, 90);
    
//    float width = menuScroll.frame.size.width;
//    float height = menuScroll.frame.size.height;
//    float newPosition = menuScroll.contentOffset.x + 165;
//    CGRect toVisible = CGRectMake(newPosition, 0, width, height);
//    [menuScroll scrollRectToVisible:toVisible animated:NO];
    
    
    //---------
    //DISPLAY SUB OF THE DAY
    //---------    
    
    BOOL hasBeenDisplay = NO;
    
    for (int i = 0; i < [menuArray count]; i++) {
        
        NSMutableArray *productsArray = [[menuArray objectAtIndex:i] objectForKey:@"products"];
        
        for (int y = 0; y < [productsArray count]; y++) {
            
            int requestSOD = [[[productsArray objectAtIndex:y] objectForKey:@"sub_of_the_day"] intValue];
            
            if (requestSOD == today) {
                
                hasBeenDisplay = YES;
                
                CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 10, subOfTheDayView.frame.size.width, 50)];
                [titleProductLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:29.0]];
                titleProductLbl.text = [[productsArray objectAtIndex:y] objectForKey:@"title"];
                [titleProductLbl setDrawOutline:YES];
                [titleProductLbl setOutlineSize:strokeSize];
                [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                titleProductLbl.textAlignment = UITextAlignmentCenter;
                titleProductLbl.backgroundColor = [UIColor clearColor];
                [subOfTheDayView addSubview:titleProductLbl];
                [titleProductLbl release];
                
                
                
                UIImageView *mainImgSubOfTheDay = [[UIImageView alloc] initWithImage:[settingMethod getImagePath:[[[[productsArray objectAtIndex:y] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
                mainImgSubOfTheDay.frame = CGRectMake(0, subOfTheDayView.frame.size.height - 180, 320, 125);
                mainImgSubOfTheDay.contentMode = UIViewContentModeScaleToFill;
                [subOfTheDayView addSubview:mainImgSubOfTheDay];
                [mainImgSubOfTheDay release];
                
                
                UIImageView *logoDay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_suboftheday@2x"]];
                logoDay.frame = CGRectMake(20, 50, 103, 74);
                logoDay.contentMode = UIViewContentModeScaleToFill;
                [subOfTheDayView addSubview:logoDay];
                [logoDay release];
                
                
                // yuan Label
                CustomLabel *yuanLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoDay.frame.size.width - 53, 28, 12, 20)];
                [yuanLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:16.0]];
                yuanLbl.text = @"¥";
                [yuanLbl setDrawOutline:NO];
                yuanLbl.textColor = [UIColor blackColor];
                yuanLbl.textAlignment = UITextAlignmentCenter;
                yuanLbl.backgroundColor = [UIColor clearColor];
                [logoDay addSubview:yuanLbl];
                [yuanLbl release];
                
                // price label
                CustomLabel *priceLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(yuanLbl.frame.size.width + yuanLbl.frame.origin.x - 5, 16, 30, 35)];
                [priceLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:24.0]];
                priceLbl.text = @"15" ;
                [priceLbl setDrawOutline:NO];
                priceLbl.textColor = [UIColor blackColor];
                priceLbl.textAlignment = UITextAlignmentCenter;
                priceLbl.backgroundColor = [UIColor clearColor];
                [logoDay addSubview:priceLbl];
                [priceLbl release];
                
                
                int xPosFacts = 0;
                
                for (int z = 0; z < [[[productsArray objectAtIndex:y] objectForKey:@"product_facts"] count]; z++) {
                    
                    
                    UIImage *myImageFact = nil;
                    NSString *factType = [[[[productsArray objectAtIndex:y] objectForKey:@"product_facts"] objectAtIndex:z] objectForKey:@"type"];
                    NSString *factName = @"";
                                            
                        if ([factType isEqualToString:@"T"]) {
                            myImageFact = [UIImage imageNamed:@"icon_tasty@2x"];
                            factName = NSLocalizedString(@"kTastyFlavor", nil);
                        }else if ([factType isEqualToString:@"E"]) {
                            myImageFact = [UIImage imageNamed:@"icon_energy@2x"];
                            factName = NSLocalizedString(@"kEnergyBoost", nil);
                        }else if ([factType isEqualToString:@"B"]) {
                            myImageFact = [UIImage imageNamed:@"icon_build@2x"];
                            factName = NSLocalizedString(@"kSandwichBuild", nil);
                        }else if ([factType isEqualToString:@"H"]) {
                            myImageFact = [UIImage imageNamed:@"icon_lowfat@2x"];
                            factName = NSLocalizedString(@"kLowFat", nil);
                        }else if ([factType isEqualToString:@"O"]) {
                            myImageFact = nil;
                            factName = nil;
                        }

                        UIImageView *factIconImg = [[UIImageView alloc] initWithImage:myImageFact];
                        factIconImg.frame = CGRectMake(xPosFacts + ((infoScrollSubOfTheDay.frame.size.width-43)/2), 5, 43, 43);
                        factIconImg.contentMode = UIViewContentModeScaleToFill;
                        [infoScrollSubOfTheDay addSubview:factIconImg];
                        [factIconImg release];
                        
                        CustomLabel *factTitleImg = [[CustomLabel alloc] initWithFrame:CGRectMake(factIconImg.frame.origin.x - 6, factIconImg.frame.size.height + factIconImg.frame.origin.y - 1, 54, 10)];
                        [factTitleImg setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:8.0]];
                        factTitleImg.text = factName;
                        [factTitleImg setDrawOutline:YES];
                        [factTitleImg setOutlineSize:strokeSize];
                        [factTitleImg setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                        factTitleImg.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                        factTitleImg.textAlignment = UITextAlignmentCenter;
                        factTitleImg.backgroundColor = [UIColor clearColor];
                        [infoScrollSubOfTheDay addSubview:factTitleImg];
                        [factTitleImg release];
                        
                        
                        UIFont *fontSD = [UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:15.0];
                        CGSize sizeForDesc = {infoScrollSubOfTheDay.frame.size.width - 40,300.0f};
                        
                        NSString *myText = [[[[productsArray objectAtIndex:y] objectForKey:@"product_facts"] objectAtIndex:z] objectForKey:@"description"];
                        CGSize descSize = [myText sizeWithFont:fontSD
                                             constrainedToSize:sizeForDesc lineBreakMode:UILineBreakModeWordWrap];
                        
                        
                        CustomLabel *factLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20 + xPosFacts, factIconImg.frame.size.height + factIconImg.frame.origin.y + 15, infoScrollSubOfTheDay.frame.size.width - 40, 100)];
                        [factLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:15.0]];
                        factLbl.text = myText;
                        [factLbl setDrawOutline:NO];
                        factLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                        factLbl.textAlignment = UITextAlignmentCenter;
                        factLbl.numberOfLines = 0;
                        factLbl.backgroundColor = [UIColor clearColor];
                        [infoScrollSubOfTheDay addSubview:factLbl];
                        [factLbl release];
                    
                    
                    // DISPLAY ARROW
                    if (z == 0) {
                        
                        UIImageView *indicatorPushImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_push@2x"]];
                        indicatorPushImg.frame = CGRectMake(infoScrollSubOfTheDay.frame.size.width-20 + xPosFacts, ((infoScrollSubOfTheDay.frame.size.height-15)/2) + 20, 12, 15);
                        [infoScrollSubOfTheDay addSubview:indicatorPushImg];
                        [indicatorPushImg release];
                        
                    }else if (z == [[[productsArray objectAtIndex:y] objectForKey:@"product_facts"] count]-1) {
                        
                        UIImageView *indicatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_back@2x"]];
                        indicatorImg.frame = CGRectMake(8 + xPosFacts, ((infoScrollSubOfTheDay.frame.size.height-15)/2) + 20, 12, 15);
                        [infoScrollSubOfTheDay addSubview:indicatorImg];
                        [indicatorImg release];
                        
                    }else {
                        
                        UIImageView *indicatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_back@2x"]];
                        indicatorImg.frame = CGRectMake(8 + xPosFacts, ((infoScrollSubOfTheDay.frame.size.height-15)/2) + 20, 12, 15);
                        [infoScrollSubOfTheDay addSubview:indicatorImg];
                        [indicatorImg release];
                        
                        UIImageView *indicatorPushImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_push@2x"]];
                        indicatorPushImg.frame = CGRectMake(infoScrollSubOfTheDay.frame.size.width-20 + xPosFacts, ((infoScrollSubOfTheDay.frame.size.height-15)/2) + 20, 12, 15);
                        [infoScrollSubOfTheDay addSubview:indicatorPushImg];
                        [indicatorPushImg release];
                    }
                    
                    
                        if ([factType isEqualToString:@"O"]) {
                            
                            CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20 + xPosFacts, 20, infoScrollSubOfTheDay.frame.size.width - 40, 37)];
                            [titleProductLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:29.0]];
                            titleProductLbl.text = NSLocalizedString(@"kOptionsTxt", nil);
                            [titleProductLbl setDrawOutline:YES];
                            [titleProductLbl setOutlineSize:strokeSize];
                            [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                            titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                            titleProductLbl.textAlignment = UITextAlignmentCenter;
                            titleProductLbl.backgroundColor = [UIColor clearColor];
                            [infoScrollSubOfTheDay addSubview:titleProductLbl];
                            [titleProductLbl release];
                            
                            [factIconImg removeFromSuperview];
                            [factTitleImg removeFromSuperview];
                            [factLbl setFrame:CGRectMake(20+ xPosFacts, titleProductLbl.frame.origin.y + titleProductLbl.frame.size.height + 10, infoScrollSubOfTheDay.frame.size.width - 40, descSize.height)];
                        }
                    
                        xPosFacts = xPosFacts + infoScrollSubOfTheDay.frame.size.width; // (60 is the Image + the text size)
                        
                    
                    
                }
                
                infoScrollSubOfTheDay.contentSize = CGSizeMake([[[productsArray objectAtIndex:y] objectForKey:@"product_facts"] count]*infoScrollSubOfTheDay.frame.size.width, infoScrollSubOfTheDay.frame.size.height);
                break;
            }
            
            if (hasBeenDisplay == YES) {
                break;
            }
            
        }
        
    }
    
    
    [self showMoreInfoBtn];
    
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
    
    if (fromSubOfTheDay == YES) {
        
        if (fromSubOfTheDayAllWeek == YES) {
            [self LaunchProduct:myCurrentCatID];
        }else {
            [self LaunchProduct:SODId];
        }
    
        
    }
    
}


- (void)growAnimationDidStop {
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:MOVE_ANIMATION_DURATION_SECONDS];
    [UIView setAnimationDelegate:self];
    menuScroll.transform = CGAffineTransformMakeScale(SHRINK_FACTOR, SHRINK_FACTOR);
	[UIView commitAnimations];
    
}




#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushStoreLocatorView {
    
    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    storeViewCtrl.fromOtherView = YES;
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}

-(void)backAction { [self.navigationController popViewControllerAnimated:YES]; }


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushCateringView {


    CateringViewController *cateringView = [[CateringViewController alloc] init];
    UINavigationController *myNavigationController = [[[UINavigationController alloc] initWithRootViewController:cateringView] autorelease];
    [self presentModalViewController:myNavigationController animated:YES];
    [cateringView release];
    
}

-(void)pushCouponsView {

    CouponViewController *cvc = [[CouponViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
    [cvc release];
    
}

-(void)pushHowToView {

    HowToOrderViewController *howToOrderView = [[HowToOrderViewController alloc] init];
    UINavigationController *myNavigationController = [[[UINavigationController alloc] initWithRootViewController:howToOrderView] autorelease];
    [self presentModalViewController:myNavigationController animated:YES];
    [howToOrderView release];

}



#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- 
#pragma mark ---------------
#pragma mark ---------------


-(void)showMoreInfoBtn {
    
    if (viewIsFlipped == NO) {
        [UIView transitionFromView:subOfTheDayView toView:subOfTheDayViewInfo
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:NULL];
        viewIsFlipped = YES;
    }
    else {
        [UIView transitionFromView:subOfTheDayViewInfo toView:subOfTheDayView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:NULL];
        viewIsFlipped = NO;
    }
    
    
}


-(void)LaunchProduct:(int)idCategory {
    
    if (popupInfo.alpha == 1.0) {
        [self hidePopupInfo];
    }
    
    
    if (firstTimeProductsViewAppear) {
        firstTimeProductsViewAppear = NO;
        
        [self changeProductsInfo:idCategory];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [subOfTheDayContainer setFrame:CGRectMake(0, screenHeight, screenWidth, 253)];
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  
                                                  if( IS_4_INCH_SCREEN ) {
                                                      [productsView setFrame:CGRectMake(0, screenHeight - 265 - 65 , screenWidth, 230)];
                                                  }else {
                                                      [productsView setFrame:CGRectMake(0, screenHeight - 245 - 65 , screenWidth, 230)];
                                                  }
                                                  
                                                  
                                                  
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

-(void)LaunchMenuAction:(id)sender {
    
    int idCategory = [sender tag];
    
    for (UIView *sub in menuScroll.subviews) {
        
        if ([sub isKindOfClass:[UIButton class]]) {
            
            UIButton *myButton = (UIButton *)sub;
            
            if (sub.tag == idCategory) {
                
                menuTempHolderImg.frame = CGRectMake(myButton.frame.origin.x, myButton.frame.origin.y, 90, 90);
                [menuScroll addSubview:menuTempHolderImg];
                menuTempHolderImg.hidden = NO;
                
           
            }
            
        }
        
    }
    

    
    if (popupInfo.alpha == 1.0) {
        [self hidePopupInfo];
    }
    
    
    if (firstTimeProductsViewAppear) {
        firstTimeProductsViewAppear = NO;
        
        [self changeProductsInfo:idCategory];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [subOfTheDayContainer setFrame:CGRectMake(0, screenHeight, screenWidth, 253)];
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  
                                                  if( IS_4_INCH_SCREEN ) {
                                                      [productsView setFrame:CGRectMake(0, screenHeight - 265 - 65 , screenWidth, 230)];
                                                  }else {
                                                      [productsView setFrame:CGRectMake(0, screenHeight - 245 - 65 , screenWidth, 230)];
                                                  }
                                                  
                                                  
                                                  
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
    
    int positionOfTheScroll = 0;
    
    //---
    // ADD TEMP IMG ON CATEGORY
    //---
    if (fromSubOfTheDayAllWeek) {
        fromSubOfTheDayAllWeek = NO;
        
        for (UIView *sub in menuScroll.subviews) {
            
            if ([sub isKindOfClass:[UIButton class]]) {
                
                UIButton *myButton = (UIButton *)sub;
                
                if (sub.tag == myCurrentCatID) {
                    
                    menuTempHolderImg.frame = CGRectMake(myButton.frame.origin.x, myButton.frame.origin.y, 90, 90);
                    [menuScroll addSubview:menuTempHolderImg];
                    menuTempHolderImg.hidden = NO;
                    
                    
                }
                
            }
            
        }
        
    }

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
                
                if (fromSubOfTheDay == YES) {
                    
                    
                    if ([[[[[menuArray objectAtIndex:i] objectForKey:@"products"] objectAtIndex:y] objectForKey:@"pid"] intValue] == productId) {
                        
                        positionOfTheScroll = y;
                            
                        
                    }
 
                    
                }
            }
            break;
            
        }
        
    }
    
    pageControl.numberOfPages = [currentProductsArray count];
    pageControl.currentPage = 0;
    
    float productScrollContentSize = productsScroll.frame.size.width * [currentProductsArray count];
    productsScroll.contentSize = CGSizeMake(productScrollContentSize, productsScroll.frame.size.height);
    
    if (fromSubOfTheDay == YES) {
        
        float width = productsScroll.frame.size.width;
        float height = productsScroll.frame.size.height;
        CGRect toVisible = CGRectMake(positionOfTheScroll*productsScroll.frame.size.width, 0, width, height);
        [productsScroll scrollRectToVisible:toVisible animated:NO];
        
        pageControl.currentPage = positionOfTheScroll;
        
    }
    
    int XPosImage = 0;
    
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorianCalendar setFirstWeekday:2]; // Sunday == 1, Saturday == 7
    NSUInteger adjustedWeekdayOrdinal = [gregorianCalendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
 
    int today = adjustedWeekdayOrdinal;
    
    for (int i = 0; i < [currentProductsArray count]; i++) {
     
        UIImageView *ImageProduct = [[UIImageView alloc] initWithImage:[settingMethod getImagePath:[[[[currentProductsArray objectAtIndex:i] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
        ImageProduct.frame = CGRectMake(XPosImage, productsScroll.frame.size.height - 110, 300, 105);
        [productsScroll addSubview:ImageProduct];
        [ImageProduct release];
    
        CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(XPosImage, 5, 300, 40)];
        [titleProductLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:22.0]];
        titleProductLbl.text = [[currentProductsArray objectAtIndex:i] objectForKey:@"title"];
        [titleProductLbl setDrawOutline:YES];
        [titleProductLbl setOutlineSize:strokeSize];
        [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleProductLbl.textAlignment = UITextAlignmentCenter;
        titleProductLbl.backgroundColor = [UIColor clearColor];
        [productsScroll addSubview:titleProductLbl];
        [titleProductLbl release];
        
        int requestSOD = [[[currentProductsArray objectAtIndex:i] objectForKey:@"sub_of_the_day"] intValue];
        
        if (requestSOD == today) {
            
            UIImageView *logoDay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_suboftheday@2x"]];
            logoDay.frame = CGRectMake(XPosImage + 10, 40, 103, 74);
            logoDay.contentMode = UIViewContentModeScaleToFill;
            [productsScroll addSubview:logoDay];
            [logoDay release];
            
            
            // yuan Label
            CustomLabel *yuanLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoDay.frame.size.width - 53, 28, 12, 20)];
            [yuanLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:16.0]];
            yuanLbl.text = @"¥";
            [yuanLbl setDrawOutline:NO];
            yuanLbl.textColor = [UIColor blackColor];
            yuanLbl.textAlignment = UITextAlignmentCenter;
            yuanLbl.backgroundColor = [UIColor clearColor];
            [logoDay addSubview:yuanLbl];
            [yuanLbl release];
            
            // price label
            CustomLabel *priceLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(yuanLbl.frame.size.width + yuanLbl.frame.origin.x - 5, 16, 30, 35)];
            [priceLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:24.0]];
            priceLbl.text = @"15" ;
            [priceLbl setDrawOutline:NO];
            priceLbl.textColor = [UIColor blackColor];
            priceLbl.textAlignment = UITextAlignmentCenter;
            priceLbl.backgroundColor = [UIColor clearColor];
            [logoDay addSubview:priceLbl];
            [priceLbl release];
            
            
        }
        
        XPosImage = XPosImage + productsScroll.frame.size.width;
    }
    
    if (fromSubOfTheDay == YES) {
        fromSubOfTheDay = NO;
        [self redrawButtonsInfo:positionOfTheScroll];
    }else {
        [self redrawButtonsInfo:0];
    }
    

}

-(void)redrawButtonsInfo:(int)position {
    
    BOOL hasHealth = NO;
    BOOL hasTasty = NO;
    BOOL hasEnergy = NO;
    BOOL hasBuild = NO;
    hasOptions = NO;
    
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
        if ([[[productFactsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"O"]) {
            
            NSLog(@"has Options");
            hasOptions = YES;
            optionsDesc = [[productFactsArray objectAtIndex:i] objectForKey:@"description"];
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
                         optionsProductBtn.alpha = 0.0;
                         
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
                                                                   
                                                                   if (hasOptions == YES) {
                                                                      
                                                                       NSLog(@"optionsProductBtn");
                                                                       
                                                                       optionsProductBtn.hidden = NO;
                                                                       optionsProductBtn.alpha = 1.0;
                                                                       [[optionsProductBtn superview] bringSubviewToFront:optionsProductBtn];
                                                                       
                                                                   }else {
                                                                       optionsProductBtn.hidden = YES;
                                                                       optionsProductBtn.alpha = 0.0;
                                                                   }
                                                                   
                                                                   
                                                               }
                                                               completion:^(BOOL finished){
                                                                   
                                                                   weiboShareBtn.tag = position;
                                                                   
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
    
    NSInteger currentIndex = [sender tag];
    
    if ([settingMethod weiboIsConnected]) {
        
        NSDictionary *currentProduct = currentProductsArray[currentIndex];
        UIImage *pic = [settingMethod getImagePath:currentProduct[@"media"][0][@"filename"]];
        NSString *titleProduct = currentProduct[@"title"];
        NSString *descriptionProduct = currentProduct[@"description"];
        NSString *combineMessage = [NSString stringWithFormat:@"%@ - %@", titleProduct, descriptionProduct];
        NSString *status = combineMessage;
        
        if ([BlockSinaWeibo sharedClient].sinaWeibo.isAuthValid) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = NSLocalizedString(@"kWait", nil);
            
            [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload.json"
                                       withParams:@{@"status":status,@"pic":pic}
                                      withHandler:^(id result) {
                                       
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        
                                          
                                          if (result[@"error"]) {
                                              
                                              MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                              hud.mode = MBProgressHUDModeText;
                                              hud.labelText = hud.labelText = NSLocalizedString(result[@"error"], nil);
                                              
                                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
                                              dispatch_after(popTime, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                                  // Do something...
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                  });
                                              });
                                              
                                          }else if(result[@"text"]) {
                                              
                                              MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                              hud.mode = MBProgressHUDModeText;
                                              hud.labelText = [NSString stringWithFormat:NSLocalizedString(@"kSaringMenu", nil), NSLocalizedString(titleProduct, nil)];
                                              
                                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
                                              dispatch_after(popTime, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                                  // Do something...
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                  });
                                              });
                                              
                                          }
                                          
                                      }];
            
        }
        
    }else{

        [BlockSinaWeibo loginWithHandler:^{
            [self sharingInfoToWeibo:currentIndex];
        }];
        
    }

}

-(void)sharingInfoToWeibo:(int)currentIndex {
    
    
    NSDictionary *currentProduct = currentProductsArray[currentIndex];
    UIImage *pic = [settingMethod getImagePath:currentProduct[@"media"][0][@"filename"]];
    NSString *titleProduct = currentProduct[@"title"];
    NSString *descriptionProduct = currentProduct[@"description"];
    NSString *combineMessage = [NSString stringWithFormat:@"%@ - %@", titleProduct, descriptionProduct];
    NSString *status = combineMessage;
    
    if ([BlockSinaWeibo sharedClient].sinaWeibo.isAuthValid) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"kWait", nil);
        
        [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload.json"
                                   withParams:@{@"status":status,@"pic":pic}
                                  withHandler:^(id result) {
                                      
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      
                                      
                                      if (result[@"error"]) {
                                          
                                          MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                          hud.mode = MBProgressHUDModeText;
                                          hud.labelText = NSLocalizedString(result[@"error"], nil);
                                          
                                          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
                                          dispatch_after(popTime, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                              // Do something...
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              });
                                          });
                                          
                                      }else if(result[@"text"]) {
                                          
                                          MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                          hud.mode = MBProgressHUDModeText;
                                          hud.labelText = [NSString stringWithFormat:NSLocalizedString(@"kSaringMenu", nil), NSLocalizedString(titleProduct, nil)];
                                          
                                          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
                                          dispatch_after(popTime, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                              // Do something...
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              });
                                              
                                          });
                                          
                                      }
                                      
                                  }];

    }
    
}


- (void)sendToSina:(int)position
{
    NSString *titleProduct = [[currentProductsArray objectAtIndex:position] objectForKey:@"title"];
    NSString *descriptionProduct = [[currentProductsArray objectAtIndex:position] objectForKey:@"description"];
    
    NSString *combineMessage = [NSString stringWithFormat:@"%@ - %@", titleProduct, descriptionProduct];

        [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload_url_text.json" withParams:@{@"status":combineMessage,@"url":[[[[currentProductsArray objectAtIndex:position] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]} withHandler:^(id responseDict) {
            
            [[[UIAlertView alloc] initWithTitle:@"Shared Menu" message:@"You just shared your menu on your weibo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            
        }];
        
    
}



-(void)hidePopupInfo {
    
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                        if (popupInfo.alpha == 1.0) {
                            
                            popupInfo.alpha = 0.0;
                            
                            float width = popupInfo.frame.size.width;
                            float height = 0;
                            float newPosition = 168;
                            CGRect toVisible = CGRectMake(12, newPosition, width, height);
                            
                            [popupInfo setFrame:toVisible];
                            
                        }
                         
                     }
                     completion:^(BOOL finished){
    
                          }];
    
    tempProdFact = 0;
    
}

-(void)showPopupInfo:(id)sender {
    
    int myIdTag = [sender tag];
    
    CGFloat pageWidth = productsScroll.bounds.size.width;
    float fractionalPage = productsScroll.contentOffset.x / pageWidth ;
    NSInteger nearestNumber = lround(fractionalPage) ;
    
    NSMutableArray *productFactsArray = [[currentProductsArray objectAtIndex:nearestNumber] objectForKey:@"product_facts"];
    NSString *myDescription = @"";
    UIImage *myImageFact = nil;
    NSString *factName = @"";
    
    
    
    if (myIdTag == 999) {
        
        factName = NSLocalizedString(@"kOptions", nil);
        myDescription = optionsDesc;
        myImageFact = nil;
        
    }else {
        
        for (int i = 0; i < [productFactsArray count]; i++) {
            
            if ([[[productFactsArray objectAtIndex:i] objectForKey:@"pfid"] intValue] == myIdTag) {
                myDescription = [[productFactsArray objectAtIndex:i] objectForKey:@"description"];
                
                NSString *factType = [[productFactsArray objectAtIndex:i] objectForKey:@"type"];
                
                
                if ([factType isEqualToString:@"T"]) {
                    myImageFact = [UIImage imageNamed:@"icon_tasty@2x"];
                    factName = NSLocalizedString(@"kTasty", nil);
                }else if ([factType isEqualToString:@"E"]) {
                    myImageFact = [UIImage imageNamed:@"icon_energy@2x"];
                    factName = NSLocalizedString(@"kEnergy", nil);
                }else if ([factType isEqualToString:@"B"]) {
                    myImageFact = [UIImage imageNamed:@"icon_build@2x"];
                    factName = NSLocalizedString(@"kBuild", nil);
                }else if ([factType isEqualToString:@"H"]) {
                    myImageFact = [UIImage imageNamed:@"icon_lowfat@2x"];
                    factName = NSLocalizedString(@"kHealth", nil);
                }
                
                
                break;
            }
            
        }
        
    }
    
    
 
    
    
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         if (popupInfo.alpha == 0.0) {
                             
                             popupInfo.hidden = NO;
                             popupInfo.alpha = 1.0;
                             
                             factTitleLbl.text = factName;
                             factDescriptionLbl.text = myDescription;
                             factIconImgForPopup.image = myImageFact;
                             
                             float width = popupInfo.frame.size.width;
                             float height = -168;
                             float newPosition = popupInfo.frame.origin.y;
                             CGRect toVisible = CGRectMake(12, newPosition, width, height);
                             
                             [popupInfo setFrame:toVisible];
                             
                         }else {
                             
                             popupInfo.alpha = 0.0;
                             
                             float width = popupInfo.frame.size.width;
                             float height = 0;
                             float newPosition = 168;
                             CGRect toVisible = CGRectMake(12, newPosition, width, height);
                             
                             [popupInfo setFrame:toVisible];
                             
                             
                         }
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         if (tempProdFact != myIdTag && popupInfo.alpha == 0.0) {
                             
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  
                                                  popupInfo.hidden = NO;
                                                  popupInfo.alpha = 1.0;
                                                  
                                                  factTitleLbl.text = factName;
                                                  factIconImgForPopup.image = myImageFact;
                                                  factDescriptionLbl.text = myDescription;
                                                  
                                                  float width = popupInfo.frame.size.width;
                                                  float height = -168;
                                                  float newPosition = popupInfo.frame.origin.y;
                                                  CGRect toVisible = CGRectMake(12, newPosition, width, height);
                                                  
                                                  [popupInfo setFrame:toVisible];
                                                  
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  
                                                  tempProdFact = myIdTag;
                                                  
                                              }];
                             
                         }else {
                             
                             if (popupInfo.alpha == 0.0) {
                                 popupInfo.hidden = YES;
                             }
                             
                             tempProdFact = myIdTag;
                         }
                         
                     }];
    
    
    if (tempProdFact == 0) {
        tempProdFact = myIdTag;
    }
    
}



-(void)finishMenu
{
    
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
