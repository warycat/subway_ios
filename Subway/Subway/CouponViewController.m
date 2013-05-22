//
//  CouponViewController.m
//  Subway
//
//  Created by Larry Fantasy on 5/17/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "CouponViewController.h"
#import "DDPageControl.h"
#import "MenuViewController.h"
#import "StoreLocatorViewController.h"

@interface CouponViewController ()
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CouponViewController
@synthesize pageControl;

-(void)backAction {  [self.navigationController popViewControllerAnimated:YES]; }


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
            
    // ----------------- GENERATE TOP BAR
    
    UIButton *homeBtn =  [[UIButton alloc] init];
    
    if ([settingMethod weiboIsConnected]) {
        
        [displayMethod createTopBar:self.view viewName:@"coupon" leftBtn:nil rightBtn:homeBtn otherBtn:nil];
        
    }else {
        
        self.weiboBtn =  [[UIButton alloc] init];
        
        [displayMethod createTopBar:self.view viewName:@"coupon" leftBtn:self.weiboBtn rightBtn:homeBtn otherBtn:nil];
        
        [self.weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
        
    }
    
    [homeBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn release];
    
    
    // ----------------- GENERATE BOTTOM BAR
    
    UIButton *menuBtn =  [[UIButton alloc] init];
    UIButton *locatorBtn =  [[UIButton alloc] init];;
    
    [displayMethod createBottomBar:self.view viewName:@"coupon" myBtn1:menuBtn myBtn2:locatorBtn myBtn3:nil];
    
    [menuBtn addTarget:self action:@selector(pushMenuView) forControlEvents:UIControlEventTouchDown];
    [menuBtn release];
    [locatorBtn addTarget:self action:@selector(pushStoreLocatorView) forControlEvents:UIControlEventTouchDown];
    [locatorBtn release];
    
    
    
    // ---------------- Share Coupon on Weibo
    // ----
    UIImage *shareImgON = [UIImage imageNamed:@"icon_weibo@2x"];

    UIButton *weiboShareBtn =  [[UIButton alloc] init];
    [weiboShareBtn  setFrame:CGRectMake(25, 75, 43, 43)];
    weiboShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    weiboShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [weiboShareBtn setBackgroundImage:[shareImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
//    [weiboShareBtn addTarget:self action:@selector(shareToWeibo:) forControlEvents:UIControlEventTouchDown];
    [self.view  addSubview:weiboShareBtn];
    [weiboShareBtn release];
    
    CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 120, 48, 10)];
    weiboLbl.center = CGPointMake(weiboLbl.center.x, weiboLbl.center.y);
    [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    weiboLbl.text = NSLocalizedString(@"kShareOnWeibo", nil);
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    weiboLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    weiboLbl.textAlignment = UITextAlignmentCenter;
    weiboLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:weiboLbl];
    [weiboLbl release];
    
    
    // ---------------- Checkin Coupon
    // ----
    UIImage *checkIn = [UIImage imageNamed:@"icon_checkin@2x"];
    
    UIButton *checkInBtn =  [[UIButton alloc] init];
    [checkInBtn  setFrame:CGRectMake(252, 75, 43, 43)];
    checkInBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    checkInBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [checkInBtn setBackgroundImage:[checkIn stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [checkInBtn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchDown];
    [self.view  addSubview:checkInBtn];
    [checkInBtn release];
    
    CustomLabel *checkInLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(250, 120, 48, 10)];
    checkInLbl.center = CGPointMake(checkInBtn.center.x, checkInLbl.center.y);
    [checkInLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    checkInLbl.text = NSLocalizedString(@"kCheckIn", nil);
    [checkInLbl setDrawOutline:YES];
    [checkInLbl setOutlineSize:strokeSize];
    [checkInLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    checkInLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    checkInLbl.textAlignment = UITextAlignmentCenter;
    checkInLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:checkInLbl];
    [checkInLbl release];

    
    CustomLabel *specialOffers = [[CustomLabel alloc]initWithFrame:CGRectMake(100, 70, 100, 70)];
    specialOffers.text = @"SPECIAL\nOFFERS";
    specialOffers.numberOfLines = 2;
    specialOffers.center = CGPointMake(160, specialOffers.center.y);
    specialOffers.font = [UIFont fontWithName:APEX_BOLD_ITALIC size:20];
    specialOffers.drawOutline = YES;
    specialOffers.outlineSize = 5;
    specialOffers.outlineColor = [UIColorCov colorWithHexString:GREEN_STROKE];
    specialOffers.textColor = [UIColorCov colorWithHexString:YELLOW_TEXT];
    specialOffers.textAlignment = UITextAlignmentCenter;
    specialOffers.backgroundColor = [UIColor clearColor];
    [self.view addSubview:specialOffers];
    
    
    // ----------------- PAGE CONTROL
    
    pageControl = [[DDPageControl alloc] init];
    pageControl.center = CGPointMake(self.view.center.x, 420 );
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
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, 320, 250)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    [self loadCoupon];
}


- (void)loadCoupon
{
    NSString *locale = [settingMethod getUserLanguage];
    NSString *coupon_url = [NSString stringWithFormat:@"%@coupon/all?locale=%@&screen_size=%@",ADRESS,locale, @"640"];
    NSLog(@"%@",coupon_url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:coupon_url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *coupons = [dict objectForKey:@"data"];
        NSLog(@"%@",coupons);
        self.coupons = coupons;
        self.scrollView.contentSize = CGSizeMake(coupons.count *320, 250);
        int i = 0;
        self.pageControl.numberOfPages = coupons.count;
        
        for (NSDictionary *coupon in self.coupons) {
            
            NSDictionary *media = [[coupon objectForKey:@"media"] lastObject];
            NSString *url = [media objectForKey:@"path"];
            
            NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            
            [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                UIImage *image = [UIImage imageWithData:data];
                UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
                imageView.frame = CGRectMake(i * 320, 0, 320, 250);
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipRight:)]];
                imageView.tag = 2 * (i+1);
                [self.scrollView addSubview:imageView];

                UIImage *back = [UIImage imageNamed:@"coupon_reversed-640"];
                UIImageView *backView = [[UIImageView alloc]initWithImage:back];
                backView.contentMode = UIViewContentModeScaleAspectFit;
                backView.frame = CGRectMake(i * 320, 0, 320, 250);
                backView.userInteractionEnabled = YES;
                backView.tag = 2 * (i+1) + 1;
                backView.hidden = YES;
                [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipLeft:)]];
                [self.scrollView addSubview:backView];

                UIImageView *subway = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"logo_subway"]];
                subway.frame = CGRectMake(0, 0, 100, 20);
                subway.center = CGPointMake(160, 39);
                [backView addSubview:subway];
                
                CustomLabel *title = [[CustomLabel alloc]init];
                title.drawOutline = YES;
                title.outlineColor = [UIColorCov colorWithHexString:GREEN_STROKE];
                title.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                title.outlineSize = 3;
                title.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:18.0];
                title.textAlignment = UITextAlignmentCenter;
                title.text = coupon[@"title"];
                title.frame = CGRectMake(0, 0, 120, 20);
                title.center = CGPointMake(160, 70);
                [backView addSubview:title];
                
                CustomLabel *description = [[CustomLabel alloc]init];
                description.drawOutline = YES;
                description.outlineColor = [UIColorCov colorWithHexString:GREEN_STROKE];
                description.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                description.outlineSize = 3;
                description.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
                description.numberOfLines = 6;
                description.textAlignment = UITextAlignmentCenter;
                description.text = coupon[@"description"];
                description.frame = CGRectMake(0, 0, 120, 100);
                description.center = CGPointMake(160, 130);
                [backView addSubview:description];
                
                CustomLabel *dates = [[CustomLabel alloc]init];
                dates.drawOutline = YES;
                dates.outlineColor = [UIColorCov colorWithHexString:GREEN_STROKE];
                dates.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
                dates.outlineSize = 3;
                dates.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
                dates.numberOfLines = 1;
                dates.textAlignment = UITextAlignmentCenter;
                dates.text = [NSString stringWithFormat:@"2013/05/10 - 2013/05/20"];
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
//                NSDate *sdate = [dateFormatter dateFromString:coupon[@"sdate"]];
//                
                dates.frame = CGRectMake(0, 0, 120, 20);
                dates.center = CGPointMake(160, 170);
                [backView addSubview:dates];
            }];
            i++;
        }
    }];

}

- (void)flipRight:(UIGestureRecognizer *)gr
{
    [UIView transitionWithView:self.scrollView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        gr.view.hidden = !gr.view.hidden;
        UIView *backView = [self.scrollView viewWithTag:(gr.view.tag + 1)];
        backView.hidden = !backView.hidden;
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)flipLeft:(UIGestureRecognizer *)gr
{
    [UIView transitionWithView:self.scrollView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        gr.view.hidden = !gr.view.hidden;
        UIView *frontView = [self.scrollView viewWithTag:(gr.view.tag - 1)];
        frontView.hidden = !frontView.hidden;
    } completion:^(BOOL finished) {
        ;
    }];
}

-(void)weiboAction {
    
    [BlockSinaWeibo loginWithHandler:^{
        
        self.weiboBtn.alpha = 0.0;
        self.weiboBtn.hidden = YES;
        self.weiboBtn.enabled = NO;
        
        [settingMethod HUDMessage:@"kConnectedToWeibo" typeOfIcon:@"icon_weibo@2x" delay:2.0 offset:CGPointMake(0, 0)];

    }];
}

- (void)checkIn
{
    if (![settingMethod weiboIsConnected]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"xxxx";
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = nil;
    }
}


// ========================== SCROLL VIEW METHODS ============================


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
	CGFloat pageWidth = self.scrollView.bounds.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (aScrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------


-(void)pushMenuView {
    
    MenuViewController *menuViewCtrl = [[MenuViewController alloc] init];
    menuViewCtrl.fromSubOfTheDay = NO;
    [self.navigationController pushViewController:menuViewCtrl animated:YES];
    [menuViewCtrl release];
    
}

-(void)pushStoreLocatorView {
    

    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    storeViewCtrl.fromOtherView = YES;
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
