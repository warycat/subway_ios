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
#import "BlockSinaWeiboRequest.h"
#import "CouponViewController.h"

@interface HomePageController ()

@end

@implementation HomePageController
@synthesize subOfTheDayContainer, subOfTheDayView, subOfTheDayViewInfo;
@synthesize weiboBtn;

-(void)viewWillAppear:(BOOL)animated {
    
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}

-(void)viewDidAppear:(BOOL)animated {
    
//    if (firstLoading) {
        [self changeWeiboLogDesign];
//    }else { firstLoading = NO; };
    
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	viewIsFlipped = YES;
    
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
    
    // ----------------- GENERATE TOP BAR
    
    UIButton *storeLocatorBtn =  [[UIButton alloc] init];
    weiboBtn =  [[UIButton alloc] init];
     
    [displayMethod createTopBar:self.view viewName:@"home" leftBtn:weiboBtn rightBtn:storeLocatorBtn otherBtn:nil];
     
    [weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
    [storeLocatorBtn addTarget:self action:@selector(pushStoreLocatorView) forControlEvents:UIControlEventTouchDown];
    [storeLocatorBtn release];
    
    if ([settingMethod weiboIsConnected]) {
        firstLoading = YES;
    }else {
        firstLoading = NO;
    }

    
    // ----------------- GENERATE BOTTOM BAR
    
    UIButton *menuBtn =  [[UIButton alloc] init];
    UIButton *couponBtn =  [[UIButton alloc] init];;
    
    [displayMethod createBottomBar:self.view viewName:@"home" myBtn1:menuBtn myBtn2:couponBtn myBtn3:nil];
    
    [menuBtn addTarget:self action:@selector(pushMenuView) forControlEvents:UIControlEventTouchDown];
    [menuBtn release];
    [couponBtn addTarget:self action:@selector(pushCouponView) forControlEvents:UIControlEventTouchDown];
    [couponBtn release];
    
    
    
    // EVENT BUTTON
    UIImage *eventImageOn = [[UIImage imageNamed:@"home_event@2x"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    UIButton *eventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eventBtn.frame = CGRectMake(0, 70, 320, 165);
    eventBtn.userInteractionEnabled = YES;
    [eventBtn setBackgroundImage:eventImageOn forState:UIControlStateNormal];
    [eventBtn setBackgroundImage:eventImageOn forState:UIControlStateSelected];
    [eventBtn setBackgroundImage:eventImageOn forState:UIControlStateHighlighted];
    [eventBtn addTarget:self action:@selector(launchEventAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    
    
    subOfTheDayContainer = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - 253 - 55, screenWidth, 253)];
    
    if( IS_4_INCH_SCREEN ) {
        
        [subOfTheDayContainer setFrame:CGRectMake(0, screenHeight - 273 - 55, screenWidth, 253)];
    }
    
    subOfTheDayContainer.backgroundColor = [UIColor clearColor];
    subOfTheDayContainer.userInteractionEnabled = YES;
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
    
    
    //Create scroll info for sub of the day
    UIScrollView *infoScrollSubOfTheDay = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 80, subOfTheDayViewInfo.frame.size.width - 20, subOfTheDayViewInfo.frame.size.height - 80)];
    infoScrollSubOfTheDay.clipsToBounds = YES;
    infoScrollSubOfTheDay.hidden = NO;
    infoScrollSubOfTheDay.backgroundColor = [UIColor clearColor];
    infoScrollSubOfTheDay.pagingEnabled = YES;
    infoScrollSubOfTheDay.bounces = YES;
    infoScrollSubOfTheDay.showsHorizontalScrollIndicator = NO;
    [subOfTheDayViewInfo addSubview:infoScrollSubOfTheDay];
    [infoScrollSubOfTheDay release];
    
    
    
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
    
    
    // the Sub Of the Day MAIN VIEW
    subOfTheDayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 253)];
    subOfTheDayView.backgroundColor = [UIColor clearColor];
    subOfTheDayView.userInteractionEnabled = YES;
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
    [learnLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:15.5]];
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
    
    
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorianCalendar setFirstWeekday:2]; // Sunday == 1, Saturday == 7
    NSUInteger adjustedWeekdayOrdinal = [gregorianCalendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
    
    int today = adjustedWeekdayOrdinal;
    
    NSData *menuFromSetting = [[NSUserDefaults standardUserDefaults] objectForKey:@"products"];
    NSMutableArray *menuArray = [NSKeyedUnarchiver unarchiveObjectWithData:menuFromSetting];
        
    for (int i = 0; i < [menuArray count]; i++) {
        
        NSMutableArray *productsArray = [[menuArray objectAtIndex:i] objectForKey:@"products"];
        
        for (int y = 0; y < [productsArray count]; y++) {
            
            int requestSOD = [[[productsArray objectAtIndex:y] objectForKey:@"sub_of_the_day"] intValue];
            int SODId = [[[productsArray objectAtIndex:y] objectForKey:@"pid"] intValue];
            
            NSString *myWeekDay = @"";
            
            if      (requestSOD == 1)  { myWeekDay = NSLocalizedString(@"kMonday", nil); }
            else if (requestSOD == 2)  { myWeekDay = NSLocalizedString(@"kTuesday", nil); }
            else if (requestSOD == 3)  { myWeekDay = NSLocalizedString(@"kWednesday", nil); }
            else if (requestSOD == 4)  { myWeekDay = NSLocalizedString(@"kThursday", nil); }
            else if (requestSOD == 5)  { myWeekDay = NSLocalizedString(@"kFriday", nil); }
            else if (requestSOD == 6)  { myWeekDay = NSLocalizedString(@"kSaturday", nil); }
            else if (requestSOD == 7)  { myWeekDay = NSLocalizedString(@"kSunday", nil); }
            
            if (requestSOD == today) {
                
                CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, subOfTheDayView.frame.size.height - 44, subOfTheDayView.frame.size.width - 145, 40)];
                [titleProductLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:19.0]];
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
                mainImgSubOfTheDay.frame = CGRectMake(0, subOfTheDayView.frame.size.height - 170, 320, 125);
                mainImgSubOfTheDay.contentMode = UIViewContentModeScaleToFill;
                [subOfTheDayView addSubview:mainImgSubOfTheDay]; 
                [mainImgSubOfTheDay release];
                
                
                UIImageView *logoDay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_suboftheday@2x"]];
                logoDay.frame = CGRectMake(20, 60, 103, 74);
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
                
                
                UIButton *pushToMenuViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                pushToMenuViewBtn.frame = CGRectMake(20, subOfTheDayView.frame.size.height - 170, 320, 125);
                pushToMenuViewBtn.backgroundColor = [UIColor clearColor];
                pushToMenuViewBtn.userInteractionEnabled = YES;
                pushToMenuViewBtn.tag = SODId;
                [pushToMenuViewBtn addTarget:self action:@selector(pushToMenuViewFromSOD:) forControlEvents:UIControlEventTouchUpInside];
                [subOfTheDayView addSubview:pushToMenuViewBtn];
                
                
                //-------- Put the sub on the ALL WEEK subday
                
                CustomLabel *titleProductForAllWeekLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(((requestSOD-1)*infoScrollSubOfTheDay.frame.size.width) + 20, infoScrollSubOfTheDay.frame.size.height - 44, infoScrollSubOfTheDay.frame.size.width - 145, 40)];
                [titleProductForAllWeekLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:17.0]];
                titleProductForAllWeekLbl.text = [[productsArray objectAtIndex:y] objectForKey:@"title"];
                [titleProductForAllWeekLbl setDrawOutline:YES];
                [titleProductForAllWeekLbl setOutlineSize:strokeSize];
                [titleProductForAllWeekLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                titleProductForAllWeekLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                titleProductForAllWeekLbl.textAlignment = UITextAlignmentCenter;
                titleProductForAllWeekLbl.backgroundColor = [UIColor clearColor];
                [infoScrollSubOfTheDay addSubview:titleProductForAllWeekLbl];
                [titleProductForAllWeekLbl release];
                
                UIImageView *imgMainForAllWeek = [[UIImageView alloc] initWithImage:[settingMethod getImagePath:[[[[productsArray objectAtIndex:y] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
                imgMainForAllWeek.frame = CGRectMake((requestSOD-1)*infoScrollSubOfTheDay.frame.size.width, infoScrollSubOfTheDay.frame.size.height - 160, 320, 125);
                imgMainForAllWeek.contentMode = UIViewContentModeScaleToFill;
                [infoScrollSubOfTheDay addSubview:imgMainForAllWeek];
                [imgMainForAllWeek release];
                
                UIImageView *logoDayForWeek = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_suboftheday@2x"]];
                logoDayForWeek.frame = CGRectMake(((requestSOD-1)*infoScrollSubOfTheDay.frame.size.width) + 15, 25, 103, 74);
                logoDayForWeek.contentMode = UIViewContentModeScaleToFill;
                [infoScrollSubOfTheDay addSubview:logoDayForWeek];
                [logoDayForWeek release];
                
                
                // yuan Label
                CustomLabel *yuanLbl1 = [[CustomLabel alloc] initWithFrame:CGRectMake(logoDay.frame.size.width - 53, 28, 12, 20)];
                [yuanLbl1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:16.0]];
                yuanLbl1.text = @"¥";
                [yuanLbl1 setDrawOutline:NO];
                yuanLbl1.textColor = [UIColor blackColor];
                yuanLbl1.textAlignment = UITextAlignmentCenter;
                yuanLbl1.backgroundColor = [UIColor clearColor];
                [logoDayForWeek addSubview:yuanLbl1];
                [yuanLbl1 release];
                
                // price label
                CustomLabel *priceLbl1 = [[CustomLabel alloc] initWithFrame:CGRectMake(yuanLbl.frame.size.width + yuanLbl.frame.origin.x - 5, 16, 30, 35)];
                [priceLbl1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:24.0]];
                priceLbl1.text = @"15" ;
                [priceLbl1 setDrawOutline:NO];
                priceLbl1.textColor = [UIColor blackColor];
                priceLbl1.textAlignment = UITextAlignmentCenter;
                priceLbl1.backgroundColor = [UIColor clearColor];
                [logoDayForWeek addSubview:priceLbl1];
                [priceLbl1 release];
                
                
                
                CustomLabel *weekLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(((requestSOD-1)*infoScrollSubOfTheDay.frame.size.width) + 15, 5, infoScrollSubOfTheDay.frame.size.width, 30)];
                [weekLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:22.0]];
                weekLbl.text = myWeekDay;
                [weekLbl setDrawOutline:YES];
                [weekLbl setOutlineSize:strokeSize];
                [weekLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                weekLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                weekLbl.textAlignment = UITextAlignmentLeft;
                weekLbl.backgroundColor = [UIColor clearColor];
                [infoScrollSubOfTheDay addSubview:weekLbl];
                [weekLbl release];
                
                UIButton *pushToMenuViewBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                pushToMenuViewBtn2.frame = CGRectMake((requestSOD-1)*infoScrollSubOfTheDay.frame.size.width, infoScrollSubOfTheDay.frame.size.height - 160, 320, 125);
                pushToMenuViewBtn2.backgroundColor = [UIColor clearColor];
                pushToMenuViewBtn2.tag = SODId;
                pushToMenuViewBtn2.userInteractionEnabled = YES;
                [pushToMenuViewBtn2 addTarget:self action:@selector(pushToMenuViewFromSOD:) forControlEvents:UIControlEventTouchUpInside];
                [infoScrollSubOfTheDay addSubview:pushToMenuViewBtn2];
                
                
                //--------

            }else {
                
                if (requestSOD != 0 ) {
                    
                    requestSOD = requestSOD - 1;
                    
                    CustomLabel *weekLbl = [[CustomLabel alloc] initWithFrame:CGRectMake((requestSOD*infoScrollSubOfTheDay.frame.size.width) + 15, 5, infoScrollSubOfTheDay.frame.size.width, 30)];
                    [weekLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:22.0]];
                    weekLbl.text = myWeekDay;
                    [weekLbl setDrawOutline:YES];
                    [weekLbl setOutlineSize:strokeSize];
                    [weekLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                    weekLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                    weekLbl.textAlignment = UITextAlignmentLeft;
                    weekLbl.backgroundColor = [UIColor clearColor];
                    [infoScrollSubOfTheDay addSubview:weekLbl];
                    [weekLbl release];
                    
                    
                    CustomLabel *titleProductLbl = [[CustomLabel alloc] initWithFrame:CGRectMake((requestSOD*infoScrollSubOfTheDay.frame.size.width) + 20, infoScrollSubOfTheDay.frame.size.height - 44, infoScrollSubOfTheDay.frame.size.width - 145, 40)];
                    [titleProductLbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:17.0]];
                    titleProductLbl.text = [[productsArray objectAtIndex:y] objectForKey:@"title"];
                    [titleProductLbl setDrawOutline:YES];
                    [titleProductLbl setOutlineSize:strokeSize];
                    [titleProductLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
                    titleProductLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                    titleProductLbl.textAlignment = UITextAlignmentCenter;
                    titleProductLbl.backgroundColor = [UIColor clearColor];
                    [infoScrollSubOfTheDay addSubview:titleProductLbl];
                    [titleProductLbl release];
                    
                    UIImageView *mainImgSubOfTheDay = [[UIImageView alloc] initWithImage:[settingMethod getImagePath:[[[[productsArray objectAtIndex:y] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"filename"]]];
                    mainImgSubOfTheDay.frame = CGRectMake(requestSOD*infoScrollSubOfTheDay.frame.size.width, infoScrollSubOfTheDay.frame.size.height - 160, 320, 125);
                    mainImgSubOfTheDay.contentMode = UIViewContentModeScaleToFill;
                    mainImgSubOfTheDay.userInteractionEnabled = YES;
                    [infoScrollSubOfTheDay addSubview:mainImgSubOfTheDay];
                    [mainImgSubOfTheDay release];
                    
                    
                    UIButton *pushToWeekSubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    pushToWeekSubBtn.frame = CGRectMake(0, 0, 320, 125);
                    pushToWeekSubBtn.backgroundColor = [UIColor clearColor];
                    pushToWeekSubBtn.tag = SODId;
                    pushToWeekSubBtn.userInteractionEnabled = YES;
                    [pushToWeekSubBtn addTarget:self action:@selector(pushToMenuViewFromSODForAllWeek:) forControlEvents:UIControlEventTouchUpInside];
                    [mainImgSubOfTheDay addSubview:pushToWeekSubBtn];
                    
                }

                
            }
            
        }
        
    }
    
    infoScrollSubOfTheDay.contentSize = CGSizeMake(7*infoScrollSubOfTheDay.frame.size.width, infoScrollSubOfTheDay.frame.size.height);    
    
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


-(void)launchEventAction {
    
    [settingMethod HUDMessage:@"kNoEventAvailable" typeOfIcon:nil delay:2.0 offset:CGPointMake(0, 0)];
    
}

-(void)weiboAction {
    
    [BlockSinaWeibo loginWithHandler:^{
        [self changeWeiboLogDesign];
        [settingMethod HUDMessage:@"kConnectedToWeibo" typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
        [BlockSinaWeiboRequest GETrequestAPI:@"users/show.json" withParams:@{@"uid":[BlockSinaWeibo sharedClient].sinaWeibo.userID} withHandler:^(id dict) {
            NSLog(@"login %@",dict);
            NSString *body = [NSString stringWithFormat:@"name=%@&weiboid=%@&region=%@", dict[@"screen_name"],dict[@"id"],dict[@"location"]];
            NSString *register_url = [NSString stringWithFormat:@"%@user/register",ADRESS];
            NSLog(@"%@",body);
            NSURL *URL = [NSURL URLWithString:register_url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                
                
                NSDictionary *err = dict[@"err"];
                if (err) {
                    
                }else{
                    
                }
            }];

        }];
    }];
    
}


-(void)weiboLogOutAction {
    
    [BlockSinaWeibo logout];
    [self changeWeiboLogDesign];
    [settingMethod HUDMessage:@"kDisconnectedToWeibo" typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
}


-(void)changeWeiboLogDesign {
    
    
    if ([settingMethod weiboIsConnected]) {
        
        // Change weibo Action
        [self.weiboBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.weiboBtn addTarget:self action:@selector(weiboLogOutAction) forControlEvents:UIControlEventTouchDown];
        
        // Change weibo title Btn
        for (UIView * sub in [self.weiboBtn subviews]) {
            
            if ([sub isKindOfClass:[CustomLabel class]]) {
                CustomLabel *mysub = (CustomLabel *)sub;
                mysub.text = NSLocalizedString(@"weibo_logout_btn_txt", nil);
                
                if (![[settingMethod getUserLanguage]isEqualToString:@"cn"]) {
                    
                    CGRect mysubFrame = mysub.frame;
                    
                    NSString *myString = [NSString stringWithFormat:@"%.0f", mysubFrame.origin.x];
                    int myValue = [myString intValue];
                    if (myValue != 32-6) {
                        mysubFrame.origin.x = mysubFrame.origin.x - 6;
                        [mysub setFrame:mysubFrame];
                    }
                    
                }

 
            }
            
            if ([sub isKindOfClass:[UIImageView class]] && sub.tag == 100) {
                
                if (![[settingMethod getUserLanguage]isEqualToString:@"cn"]) {
                    
                UIImageView *mysub = (UIImageView *)sub;
                
                    CGRect mysubFrame = mysub.frame;
                    
                    NSString *myString = [NSString stringWithFormat:@"%.0f", mysubFrame.origin.x];
                    int myValue = [myString intValue];
                    if (myValue != 14-6) {
                        CGRect mysubFrame = mysub.frame;
                        mysubFrame.origin.x = mysubFrame.origin.x - 6;
                        [mysub setFrame:mysubFrame];
                    }
                    
                }

                
            }
            
        }
        
    }else {
        
        // Change weibo Action
        [self.weiboBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
        
        // Change weibo title Btn
        for (UIView * sub in [self.weiboBtn subviews]) {
            
            if ([sub isKindOfClass:[CustomLabel class]]) {
                CustomLabel *mysub = (CustomLabel *)sub;
                mysub.text = NSLocalizedString(@"weibo_login_btn_txt", nil);
                
                if (![[settingMethod getUserLanguage]isEqualToString:@"cn"]) {
                    
                    CGRect mysubFrame = mysub.frame;
                    
                    NSString *myString = [NSString stringWithFormat:@"%.0f", mysubFrame.origin.x];
                    int myValue = [myString intValue];
                    if (myValue != 32) {
                        mysubFrame.origin.x = mysubFrame.origin.x + 6;
                        [mysub setFrame:mysubFrame];
                    }
                    
                }


            }
            
            if ([sub isKindOfClass:[UIImageView class]] && sub.tag == 100) {
                
                if (![[settingMethod getUserLanguage]isEqualToString:@"cn"]) {
                    
                    UIImageView *mysub = (UIImageView *)sub;
                    
                    CGRect mysubFrame = mysub.frame;
                    NSString *myString = [NSString stringWithFormat:@"%.0f", mysubFrame.origin.x];
                    int myValue = [myString intValue];
                    if (myValue != 14) {
                        mysubFrame.origin.x = mysubFrame.origin.x + 6;
                        [mysub setFrame:mysubFrame];
                    }
                    
                }

                
            }
            
        }
        
    }
    
}

-(void)pushStoreLocatorView {
    
    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    storeViewCtrl.fromOtherView = NO;
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------

-(void)pushToMenuViewFromSOD:(id)sender {
    
    int myTag = [sender tag];
    
    MenuViewController *menuViewCtrl = [[MenuViewController alloc] init];
    menuViewCtrl.fromSubOfTheDay = YES;
    menuViewCtrl.productId = myTag;
    menuViewCtrl.fromSubOfTheDayAllWeek = NO;
    [self.navigationController pushViewController:menuViewCtrl animated:YES];
    [menuViewCtrl release];
    
}

-(void)pushToMenuViewFromSODForAllWeek:(id)sender {
    
    int myTag = [sender tag];
    
    
    NSData *menuFromSetting = [[NSUserDefaults standardUserDefaults] objectForKey:@"products"];
    NSMutableArray *menuArray = [NSKeyedUnarchiver unarchiveObjectWithData:menuFromSetting];
    
    int myCurrentCatID = 0;
    
    
    
    for (int i = 0; i < [menuArray count]; i++) {

        for (int y = 0; y < [[[menuArray objectAtIndex:i] objectForKey:@"products"] count]; y++) {
            
                
                if ([[[[[menuArray objectAtIndex:i] objectForKey:@"products"] objectAtIndex:y] objectForKey:@"pid"] intValue] == myTag) {
                    myCurrentCatID = [[[menuArray objectAtIndex:i] objectForKey:@"tid"] intValue];
                    break;
                }
            
        }            
        
    }

    
    
    MenuViewController *menuViewCtrl = [[MenuViewController alloc] init];
    menuViewCtrl.fromSubOfTheDay = YES;
    menuViewCtrl.fromSubOfTheDayAllWeek = YES;
    menuViewCtrl.myCurrentCatID = myCurrentCatID;
    menuViewCtrl.productId = myTag;
    [self.navigationController pushViewController:menuViewCtrl animated:YES];
    [menuViewCtrl release];
    
}

-(void)pushMenuView {
    
    MenuViewController *menuViewCtrl = [[MenuViewController alloc] init];
    menuViewCtrl.fromSubOfTheDay = NO;
    [self.navigationController pushViewController:menuViewCtrl animated:YES];
    [menuViewCtrl release];
    
}

-(void)pushCouponView {
    
    CouponViewController *cvc = [[CouponViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
    [cvc release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
