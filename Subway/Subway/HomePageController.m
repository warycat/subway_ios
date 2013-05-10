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
@synthesize subOfTheDayContainer, subOfTheDayView, subOfTheDayViewInfo;

-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	viewIsFlipped = YES;
    
    
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
    
    UIImageView *BackgroundImgInfoSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_sub_background@2x"]];
    BackgroundImgInfoSub.frame = CGRectMake(0, subOfTheDayViewInfo.frame.size.height - 80, subOfTheDayViewInfo.frame.size.width, 80);
    [subOfTheDayViewInfo addSubview:BackgroundImgInfoSub];
    [BackgroundImgInfoSub release];
    
    
    // --------------- + back
    
    UIImage *myLocationImageOn = [[UIImage imageNamed:@"btn_red_on.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    UIImage *myLocationImageOff = [[UIImage imageNamed:@"btn_red_off.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    
    UIButton *backInfobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backInfobtn.frame = CGRectMake(screenWidth-125, subOfTheDayViewInfo.frame.size.height - 45, 110, 40);
    backInfobtn.userInteractionEnabled = YES;
    [backInfobtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [backInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [backInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [backInfobtn addTarget:self action:@selector(showMoreInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    CustomLabel *backLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 3, backInfobtn.frame.size.width, backInfobtn.frame.size.height)];
    [backLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
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
    infoScrollSubOfTheDay.pagingEnabled = NO;
    infoScrollSubOfTheDay.bounces = YES;
    infoScrollSubOfTheDay.showsHorizontalScrollIndicator = NO;
    [subOfTheDayViewInfo addSubview:infoScrollSubOfTheDay];
    [infoScrollSubOfTheDay release];
    
    
    // the Sub Of the Day MAIN VIEW
    subOfTheDayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 253)];
    subOfTheDayView.backgroundColor = [UIColor clearColor];
    [subOfTheDayContainer addSubview:subOfTheDayView];
    
    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_sub_background@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, subOfTheDayView.frame.size.height-80, subOfTheDayView.frame.size.width, 80);
    [subOfTheDayView addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    
    // --------------- + informations
    
    UIButton *showMOreInfobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showMOreInfobtn.frame = CGRectMake(screenWidth-125, subOfTheDayView.frame.size.height - 45, 110, 40);
    showMOreInfobtn.userInteractionEnabled = YES;
    [showMOreInfobtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [showMOreInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [showMOreInfobtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [showMOreInfobtn addTarget:self action:@selector(showMoreInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    CustomLabel *learnLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 3, showMOreInfobtn.frame.size.width, showMOreInfobtn.frame.size.height)];
    [learnLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    learnLbl.text = NSLocalizedString(@"allWeek_btn_txt", nil);
    [learnLbl setDrawOutline:YES];
    [learnLbl setOutlineSize:strokeSize];
    [learnLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    learnLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    learnLbl.textAlignment = UITextAlignmentCenter;
    learnLbl.backgroundColor = [UIColor clearColor];
    [showMOreInfobtn addSubview:learnLbl];
    [learnLbl release];
    
    [subOfTheDayView addSubview:showMOreInfobtn];
    
    
    
    //---------
    //DISPLAY SUB OF THE DAY
    //---------
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    unsigned int compFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *weekdayComponents = [gregorianCalendar components:compFlags fromDate:[NSDate date]];
    
    int today = weekdayComponents.weekday-1;
    NSLog(@"today : %i", today);
    
    BOOL hasBeenDisplay = NO;
    
    for (int i = 0; i < [menuMethod.menuArray count]; i++) {
        
        NSMutableArray *productsArray = [[menuMethod.menuArray objectAtIndex:i] objectForKey:@"products"];
        
        for (int y = 0; y < [productsArray count]; y++) {
            
            int requestSOD = [[[productsArray objectAtIndex:y] objectForKey:@"sub_of_the_day"] intValue];
            
            if (requestSOD == today) {
                
                hasBeenDisplay = YES;
                
                CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, subOfTheDayView.frame.size.height - 44, subOfTheDayView.frame.size.width - 145, 40)];
                [titleProductLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:19.0]];
                titleProductLbl.text = [[productsArray objectAtIndex:y] objectForKey:@"title"];
                [titleProductLbl setDrawOutline:YES];
                [titleProductLbl setOutlineSize:strokeSize];
                [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
                titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                //[titleProductLbl sizeToFit];
                titleProductLbl.textAlignment = UITextAlignmentCenter;
                titleProductLbl.backgroundColor = [UIColor clearColor];
                [subOfTheDayView addSubview:titleProductLbl];
                [titleProductLbl release];
                
                UIImageView *mainImgSubOfTheDay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[[[productsArray objectAtIndex:y] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
                mainImgSubOfTheDay.frame = CGRectMake(0, subOfTheDayView.frame.size.height - 170, 320, 125);
                mainImgSubOfTheDay.contentMode = UIViewContentModeScaleToFill;
                [subOfTheDayView addSubview:mainImgSubOfTheDay];
                [mainImgSubOfTheDay release];
                
                
                UIImageView *logoDay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_suboftheday@2x"]];
                logoDay.frame = CGRectMake(20, 60, 103, 74);
                logoDay.contentMode = UIViewContentModeScaleToFill;
                [subOfTheDayView addSubview:logoDay];
                [logoDay release];
                

            }
            
            if (hasBeenDisplay == YES) {
                break;
            }
            
        }
        
    }
    
    [gregorianCalendar release];
    
    
    [self showMoreInfoBtn];
    
}



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
