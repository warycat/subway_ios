//
//  CouponViewController.m
//  Subway
//
//  Created by Larry Fantasy on 5/17/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "CouponViewController.h"
#import "DDPageControl.h"

@interface CouponViewController ()
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [displayMethod createBackground:self.view viewName:@""];
    
    
    // ----------------- GENERATE TOP BAR
        
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
    
    UIImage *checkIn = [UIImage imageNamed:@"icon_checkin@2x"];
    
    UIButton *checkInBtn =  [[UIButton alloc] init];
    [checkInBtn  setFrame:CGRectMake(252, 75, 43, 43)];
    checkInBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    checkInBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [checkInBtn setBackgroundImage:[checkIn stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
//    [checkInBtn addTarget:self action:@selector(shareToWeibo:) forControlEvents:UIControlEventTouchDown];
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
    // Do any additional setup after loading the view from its nib.
    
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
    
    DDPageControl *pageControl;
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
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.frame = CGRectMake(i * 320, 0, 320, 250);
                [self.scrollView addSubview:imageView];
            }];
            i++;
        }
    }];

}

-(void)backAction {
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)weiboAction {
    [BlockSinaWeibo loginWithHandler:^{
        self.weiboBtn.alpha = 0.0;
        self.weiboBtn.hidden = YES;
        self.weiboBtn.enabled = NO;
        
        [settingMethod HUDMessage:@"kConnectedToWeibo" typeOfIcon:nil delay:2.0 offset:CGPointMake(0, 0)];
        //[[[UIAlertView alloc]initWithTitle:@"Login" message:@"You have login on your weibo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
