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
#import "BlockSinaWeiboRequest.h"

@interface CouponViewController ()
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CouponViewController
@synthesize pageControl;


-(void)backAction {  [self.navigationController popViewControllerAnimated:YES]; }
-(void)viewDidAppear:(BOOL)animated {
    
//    if (firstLoading) {
//        [self changeWeiboLogDesign];
//    }else { firstLoading = NO; };
    
    [super viewDidAppear:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
            
    // ----------------- GENERATE TOP BAR
    
    UIButton *homeBtn =  [[UIButton alloc] init];
    self.weiboBtn =  [[UIButton alloc] init];
    
    [displayMethod createTopBar:self.view viewName:@"coupon" leftBtn:self.weiboBtn rightBtn:homeBtn otherBtn:nil];
    
    [self.weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn release];
    
    if ([settingMethod weiboIsConnected]) {
        firstLoading = YES;
    }else {
        firstLoading = NO;
    }
    
    if ([settingMethod weiboIsConnected]) {
        [self changeWeiboLogDesign];
    }
    
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
    [weiboShareBtn addTarget:self action:@selector(shareCouponToWeibo) forControlEvents:UIControlEventTouchDown];
    [self.view  addSubview:weiboShareBtn];
    [weiboShareBtn release];
    
    CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 120, 48, 10)];
    weiboLbl.center = CGPointMake(weiboLbl.center.x, weiboLbl.center.y);
    [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    weiboLbl.text = NSLocalizedString(@"kShareOnWeibo", nil);
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
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
    [checkInLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
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
    specialOffers.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
    specialOffers.textColor = [UIColorCov colorWithHexString:YELLOW_TEXT];
    specialOffers.textAlignment = UITextAlignmentCenter;
    specialOffers.backgroundColor = [UIColor clearColor];
    [self.view addSubview:specialOffers];
    
    
    // ----------------- PAGE CONTROL
    
    pageControl = [[DDPageControl alloc] init];
    pageControl.center = CGPointMake(self.view.center.x, screenHeight - 60);
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
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, 320, screenHeight- 230)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    if ([settingMethod connectedToNetwork]) {
        
        if ([settingMethod weiboIsConnected]) {
            
            NSString *wid = [BlockSinaWeibo sharedClient].sinaWeibo.userID;
            [self loadCouponWith:wid];
            
        }else{
            
            [self loadCoupon];
            
        }
        
    }else {
        
        [settingMethod HUDMessage:@"kNoConnection" typeOfIcon:HUD_ICON_NO_CONNEXION delay:3.5 offset:CGPointMake(0, 0)];
        
    }
    

    
}

- (void)loadScrollView
{

    self.scrollView.contentSize = CGSizeMake(self.coupons.count *320, screenHeight- 230);
    int i = 0;
    self.pageControl.numberOfPages = self.coupons.count;
    [self clearView:self.scrollView];
    
    for (NSMutableDictionary *coupon in self.coupons) {
        
        NSDictionary *media = [[coupon objectForKey:@"media"] lastObject];
        NSString *url = [media objectForKey:@"path"];
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i * 320, 0, 320, screenHeight- 230);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipRight:)]];
        imageView.tag = 2 * (i+1);
        [self.scrollView addSubview:imageView];
        
        UIImageView *stampedImageView = [[UIImageView alloc]initWithFrame:imageView.bounds];
        stampedImageView.image = [UIImage imageNamed:@"coupon_validated-640"];
        stampedImageView.frame = imageView.frame;
        stampedImageView.center = CGPointMake(imageView.center.x - 1, imageView.center.y -1);
        stampedImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:stampedImageView];
        
        NSDateFormatter *checkindateFormatter = [[NSDateFormatter alloc] init];
        [checkindateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate *checkinDate = (coupon[@"checkintime"] != [NSNull null])?[checkindateFormatter dateFromString:coupon[@"checkintime"]]:[NSDate date];
        NSString *stampString = [NSDateFormatter localizedStringFromDate:checkinDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        
        CustomLabel *stampedLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        [stampedLabel setFont:[UIFont fontWithName:APEX_BOLD size:40]];
        stampedLabel.numberOfLines = 2;
        [stampedLabel setDrawOutline:YES];
        [stampedLabel setOutlineSize:3];
        [stampedLabel setOutlineColor:[UIColorCov colorWithHexString:GRAY_TEXT]];
        stampedLabel.textAlignment = UITextAlignmentCenter;
        stampedLabel.textColor = [UIColor whiteColor];
        stampedLabel.text = [NSString stringWithFormat:@"%@",stampString];
        stampedLabel.backgroundColor = [UIColor clearColor];
        stampedLabel.center = CGPointMake(imageView.center.x, imageView.center.y + 50);
        [self.scrollView addSubview:stampedLabel];
        

        
        coupon[@"stampedLabel"] = stampedLabel;
        coupon[@"stampedImage"] = stampedImageView;
        NSString *checkinable = coupon[@"checkinable"];
        
        if ([checkinable isEqualToString:@"on"]||!checkinable) {
            stampedLabel.hidden = YES;
            stampedImageView.hidden = YES;
        }else{
            stampedLabel.hidden = NO;
            stampedImageView.hidden = NO;
        }
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [indicator startAnimating];
        indicator.center = imageView.center;
        [self.scrollView addSubview:indicator];
        
        
        NSString *backgroundCouponSize = @"640";
        if (IS_4_INCH_SCREEN) { backgroundCouponSize = @"720"; }
        
        UIImage *back = [UIImage imageNamed:[NSString stringWithFormat:@"coupon_reversed-%@", backgroundCouponSize]];
        UIImageView *backView = [[UIImageView alloc] initWithImage:back];
        backView.contentMode = UIViewContentModeScaleAspectFit;
        backView.frame = CGRectMake(i * 320, 0, 320, screenHeight- 230);
        backView.userInteractionEnabled = YES;
        backView.tag = 2 * (i+1) + 1;
        backView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipLeft:)];
        tap.delegate = self;
        [backView addGestureRecognizer:tap];
        [self.scrollView addSubview:backView];
        
        UIImageView *subway = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"logo_subway"]];
        subway.frame = CGRectMake(0, 0, 100, 25);
        subway.center = CGPointMake(160, 35);
        [backView addSubview:subway];
        
        CustomLabel *title = [[CustomLabel alloc]init];
        title.drawOutline = YES;
        title.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
        title.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title.outlineSize = 3;
        title.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:18.0];
        title.textAlignment = UITextAlignmentCenter;
        title.text = coupon[@"title"];
        title.frame = CGRectMake(0, 0, 120, 20);
        title.center = CGPointMake(160, 60);
        [backView addSubview:title];
        
        CustomLabel *description = [[CustomLabel alloc]init];
        description.drawOutline = YES;
        description.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
        description.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        description.outlineSize = 3;
        description.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
        description.numberOfLines = 6;
        description.textAlignment = UITextAlignmentCenter;
        description.text = coupon[@"description"];
        description.frame = CGRectMake(0, 0, 120, 100);
        description.center = CGPointMake(160, 110);
        [backView addSubview:description];
        
        CustomLabel *avaliableLabel = [[CustomLabel alloc]init];
        avaliableLabel.drawOutline = YES;
        avaliableLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
        avaliableLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        avaliableLabel.outlineSize = 3;
        avaliableLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
        avaliableLabel.numberOfLines = 1;
        avaliableLabel.textAlignment = UITextAlignmentCenter;
        avaliableLabel.text = NSLocalizedString(@"kAvailable", nil);
        avaliableLabel.frame = CGRectMake(0, 0, 120, 20);
        avaliableLabel.center = CGPointMake(160, 160);
        [backView addSubview:avaliableLabel];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate *sdate = (coupon[@"sdate"] != [NSNull null])?[dateFormatter dateFromString:coupon[@"sdate"]]:nil;
        NSDate *edate = (coupon[@"edate"] != [NSNull null])?[dateFormatter dateFromString:coupon[@"edate"]]:nil;
        
        if (sdate && edate) {
            
            NSString *sdateString = [NSDateFormatter localizedStringFromDate:sdate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            sdateString = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"kFrom", nil),sdateString];
            CustomLabel *sdateLabel = [[CustomLabel alloc]init];
            sdateLabel.drawOutline = YES;
            sdateLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
            sdateLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            sdateLabel.outlineSize = 3;
            sdateLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
            sdateLabel.numberOfLines = 1;
            sdateLabel.textAlignment = UITextAlignmentCenter;
            sdateLabel.text = sdateString;
            sdateLabel.frame = CGRectMake(0, 0, 120, 20);
            sdateLabel.center = CGPointMake(160, 170);
            [backView addSubview:sdateLabel];
            
            NSString *edateString = [NSDateFormatter localizedStringFromDate:edate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            edateString = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"kUntil", nil),edateString];
            CustomLabel *edateLabel = [[CustomLabel alloc]init];
            edateLabel.drawOutline = YES;
            edateLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
            edateLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            edateLabel.outlineSize = 3;
            edateLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
            edateLabel.numberOfLines = 1;
            edateLabel.textAlignment = UITextAlignmentCenter;
            edateLabel.text = edateString;
            edateLabel.frame = CGRectMake(0, 0, 120, 20);
            edateLabel.center = CGPointMake(160, 190);
            [backView addSubview:edateLabel];
            
        }else if (sdate) {
            
            NSString *sdateString = [NSDateFormatter localizedStringFromDate:sdate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            sdateString = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"kFrom", nil),sdateString];
            CustomLabel *sdateLabel = [[CustomLabel alloc]init];
            sdateLabel.drawOutline = YES;
            sdateLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
            sdateLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            sdateLabel.outlineSize = 3;
            sdateLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
            sdateLabel.numberOfLines = 1;
            sdateLabel.textAlignment = UITextAlignmentCenter;
            sdateLabel.text = sdateString;
            sdateLabel.frame = CGRectMake(0, 0, 120, 20);
            sdateLabel.center = CGPointMake(160, 180);
            [backView addSubview:sdateLabel];
            
        }else if (edate){
            
            NSString *edateString = [NSDateFormatter localizedStringFromDate:edate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
            edateString = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"kUntil", nil),edateString];
            CustomLabel *edateLabel = [[CustomLabel alloc]init];
            edateLabel.drawOutline = YES;
            edateLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
            edateLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            edateLabel.outlineSize = 3;
            edateLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
            edateLabel.numberOfLines = 1;
            edateLabel.textAlignment = UITextAlignmentCenter;
            edateLabel.text = edateString;
            edateLabel.frame = CGRectMake(0, 0, 120, 20);
            edateLabel.center = CGPointMake(160, 180);
            [backView addSubview:edateLabel];
            
        }else{
            
            NSString *nowString = NSLocalizedString(@"kNow", nil);
            CustomLabel *nowLabel = [[CustomLabel alloc]init];
            nowLabel.drawOutline = YES;
            nowLabel.outlineColor = [UIColorCov colorWithHexString:GRAY_STROKE];
            nowLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            nowLabel.outlineSize = 3;
            nowLabel.font =  [UIFont fontWithName:APEX_HEAVY_ITALIC size:10.0];
            nowLabel.numberOfLines = 1;
            nowLabel.textAlignment = UITextAlignmentCenter;
            nowLabel.text = nowString;
            nowLabel.frame = CGRectMake(0, 0, 120, 20);
            nowLabel.center = CGPointMake(160, 180);
            [backView addSubview:nowLabel];
        }
        
        UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        viewButton.frame = CGRectMake(0,0 , 100, 30);
        viewButton.center = CGPointMake(160, 210);
        viewButton.userInteractionEnabled = YES;
        UIImage *buttonImage = [UIImage imageNamed:@"btn_red_on"];
        [viewButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [viewButton addTarget:self action:@selector(view:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:viewButton];
        
        CustomLabel *viewLabel = [[CustomLabel alloc] init];
        viewLabel.textAlignment = UITextAlignmentCenter;
        viewLabel.frame = CGRectMake(0, 0, 100, 15);
        viewLabel.center = CGPointMake(160 , 212);
        [viewLabel setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:13.0]];
        viewLabel.text = NSLocalizedString(@"kView", nil);
        [viewLabel setDrawOutline:YES];
        [viewLabel setOutlineSize:strokeSize];
        [viewLabel setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
        viewLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        viewLabel.backgroundColor = [UIColor clearColor];
        [backView addSubview:viewLabel];
        
        if (!coupon[@"data"]) {
            
            [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                [coupon setObject:data forKey:@"data"];
                UIImage *image = [UIImage imageWithData:data];
                imageView.image = image;
                [indicator stopAnimating];
                
            }];
        }
        i++;
    }
    
    
}


- (void) clearView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        [self clearView:subview];
        [subview removeFromSuperview];
    }
    
}


- (void)loadCouponWith:(NSString *)wid
{
    
    NSString *locale = [settingMethod getUserLanguage];
    NSString *CouponSize = @"640";
    
    if( IS_4_INCH_SCREEN ) { CouponSize = @"720"; };
    
    NSString *coupon_url = [NSString stringWithFormat:@"%@coupon/all?locale=%@&screen_size=%@&weiboid=%@",ADRESS, locale, CouponSize,wid];
    NSLog(@"%@",coupon_url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:coupon_url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *coupons = [dict objectForKey:@"data"];
        NSLog(@"%@",coupons);
        self.coupons = coupons;
        [self loadScrollView];
    
        
    }];
    
}

- (void)loadCoupon
{
    
    NSString *locale = [settingMethod getUserLanguage];
    NSString *CouponSize = @"640";
    
    if( IS_4_INCH_SCREEN ) { CouponSize = @"720"; };
    
    NSString *coupon_url = [NSString stringWithFormat:@"%@coupon/all?locale=%@&screen_size=%@",ADRESS, locale, CouponSize];
    NSLog(@"%@",coupon_url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:coupon_url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *coupons = [dict objectForKey:@"data"];
        NSLog(@"%@",coupons);
        
        self.coupons = coupons;
        [self loadScrollView];
    }];

}



#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- ANIMATION COUPONS
#pragma mark ---------------
#pragma mark ---------------

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        // we touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

- (void)view:(UIButton *)sender
{
    
    [UIView transitionWithView:self.scrollView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
        UIView *view = sender.superview;
        view.hidden = !view.hidden;
        UIView *frontView = [self.scrollView viewWithTag:(view.tag - 1)];
        frontView.hidden = !frontView.hidden;
        
    } completion:^(BOOL finished) {
        
        UIView *view = sender.superview;
        UIImageView *frontView = (UIImageView *) [self.scrollView viewWithTag:(view.tag - 1)];
        UIImage *image = frontView.image;
        UIImageView *bigImageView = [[UIImageView alloc]initWithImage:image];
        CGRect frame = [self.scrollView convertRect:frontView.frame toView:self.view ];
        bigImageView.frame = frame;
        bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        bigImageView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:bigImageView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            bigImageView.frame = self.view.bounds;
            bigImageView.backgroundColor = [UIColor blackColor];
            
        } completion:^(BOOL finished) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fade:)];
            [bigImageView addGestureRecognizer:tap];
            bigImageView.userInteractionEnabled = YES;
            
        }];
        
    }];
    
}

- (void)fade:(UIGestureRecognizer *)gr
{
    UIView *view = gr.view;
    
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    
}

- (void)flipRight:(UIGestureRecognizer *)gr
{
    
    [UIView transitionWithView:self.scrollView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        gr.view.hidden = !gr.view.hidden;
        UIView *backView = [self.scrollView viewWithTag:(gr.view.tag + 1)];
        backView.hidden = !backView.hidden;
        
    } completion:^(BOOL finished) { }];
    
}

- (void)flipLeft:(UIGestureRecognizer *)gr
{
    [UIView transitionWithView:self.scrollView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
        gr.view.hidden = !gr.view.hidden;
        UIView *frontView = [self.scrollView viewWithTag:(gr.view.tag - 1)];
        frontView.hidden = !frontView.hidden;
        
    } completion:^(BOOL finished) { }];
}



#pragma mark ---------------
#pragma mark ---------------
#pragma mark ---------------  WEIBO + CHECKIN Action
#pragma mark ---------------
#pragma mark ---------------


- (void)checkIn
{
    
    if (![settingMethod weiboIsConnected]) {
        
        [settingMethod HUDMessage:@"kNoConnectedToWeibo" typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
        
    }else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"kWait", nil);
        
        NSString *wid = [BlockSinaWeibo sharedClient].sinaWeibo.userID;
        NSInteger currentCoupon = self.pageControl.currentPage;
        NSMutableDictionary *coupon = self.coupons[currentCoupon];
        NSString *cid = coupon[@"cid"];
        NSString *lat = [settingMethod latitude];
        NSString *lon = [settingMethod longitude];
        NSString *checkin_url = [NSString stringWithFormat:@"%@coupon/checkin?cid=%@&lat=%@&lon=%@&map=google&weiboid=%@",ADRESS,cid, lat,lon,wid];
        NSLog(@"%@",checkin_url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:checkin_url]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSDictionary *err = dict[@"err"];
            if (err) {
                
                [settingMethod HUDMessage:err[@"msg"] typeOfIcon:HUD_ICON_CHECKIN delay:4.0 offset:CGPointMake(0, 0)];
                
                
            }else{
                
                [settingMethod HUDMessage:@"kCheckInForCoupon" typeOfIcon:HUD_ICON_CHECKIN delay:3.0 offset:CGPointMake(0, 0)];
                
                
                UIView *stampedLabel = coupon[@"stampedLabel"];
                UIView *stampedImage = coupon[@"stampedImage"];
                stampedLabel.hidden = NO;
                stampedImage.hidden = NO;
                
            }

        }];

    }
}

- (void)shareCouponToWeibo
{
    
    if ([settingMethod weiboIsConnected]) {
        
        
        NSInteger currentCoupon = self.pageControl.currentPage;
        NSMutableDictionary *coupon = self.coupons[currentCoupon];
        NSData *data = coupon[@"data"];
        UIImage *pic = [UIImage imageWithData:data];
        NSString *title = coupon[@"title"];
        NSString *status = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"kShareCoupon", nil),title];
        
        if ([BlockSinaWeibo sharedClient].sinaWeibo.isAuthValid) {
            
            NSLog(@"%@",pic);
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = NSLocalizedString(@"kWait", nil);
            
            [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload.json"
                                   withParams:@{@"status":status,@"pic":pic}
                                  withHandler:^(id result) {
            NSLog(@"%@",result);
                  
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      
            if (result[@"error"]) {
                
                [settingMethod HUDMessage:result[@"error"] typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
                
                
            }else if(result[@"text"]) {
                
                
                [settingMethod HUDMessage:[NSString stringWithFormat:@"%@ %@",@"Share", NSLocalizedString(title, nil)] typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
                
                
            }
                                      
            }];
        }
        
    }else{
        shareCouponAfterLogIn = YES;
        [self weiboAction];
    }
}



#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------


-(void)weiboAction {
    
    if (shareCouponAfterLogIn) {
        shareCouponAfterLogIn = NO;
        
        [BlockSinaWeibo loginWithHandler:^{
                        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *wid = [BlockSinaWeibo sharedClient].sinaWeibo.userID;
                [self loadCouponWith:wid];
                [self changeWeiboLogDesign];
                [self shareCouponToWeibo];
                
            });
            
        }];
        
        
    }else {
        
        [BlockSinaWeibo loginWithHandler:^{
            
            [settingMethod HUDMessage:@"kConnectedToWeibo" typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *wid = [BlockSinaWeibo sharedClient].sinaWeibo.userID;
                [self loadCouponWith:wid];
                [self changeWeiboLogDesign];
                
            });
            
        }];
        
    }
    

    
}




-(void)weiboLogOutAction {
    
    [BlockSinaWeibo logout];
    [self changeWeiboLogDesign];
    [settingMethod HUDMessage:@"kDisconnectedToWeibo" typeOfIcon:HUD_ICON_WEIXIN delay:2.5 offset:CGPointMake(0, 0)];
    [self loadCoupon];
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
                
                CGRect mysubFrame = mysub.frame;
                mysubFrame.origin.x = mysubFrame.origin.x - 6;
                [mysub setFrame:mysubFrame];
                
            }
            
            if ([sub isKindOfClass:[UIImageView class]] && sub.tag == 100) {
                
                UIImageView *mysub = (UIImageView *)sub;
                
                CGRect mysubFrame = mysub.frame;
                mysubFrame.origin.x = mysubFrame.origin.x - 6;
                [mysub setFrame:mysubFrame];
                
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
                
                CGRect mysubFrame = mysub.frame;
                mysubFrame.origin.x = mysubFrame.origin.x + 6;
                [mysub setFrame:mysubFrame];
            }
            
            if ([sub isKindOfClass:[UIImageView class]] && sub.tag == 100) {
                
                UIImageView *mysub = (UIImageView *)sub;
                
                CGRect mysubFrame = mysub.frame;
                mysubFrame.origin.x = mysubFrame.origin.x + 6;
                [mysub setFrame:mysubFrame];
                
            }
            
        }
        
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
