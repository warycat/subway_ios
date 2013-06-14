//
//  HowToOrderViewController.m
//  Subway
//
//  Created by ludo on 5/10/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "HowToOrderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StoreLocatorViewController.h"

@interface HowToOrderViewController ()

@end

@implementation HowToOrderViewController
@synthesize orderScrollView, pageControl;


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
    
    UIButton *backBtn =  [[UIButton alloc] init];
    UIButton *storeLocatorBtn =  [[UIButton alloc] init];
    
    [displayMethod createTopBar:self.view viewName:@"order" leftBtn:backBtn rightBtn:storeLocatorBtn otherBtn:nil];
    
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [backBtn release];
    [storeLocatorBtn addTarget:self action:@selector(pushStoreLocatorView) forControlEvents:UIControlEventTouchDown];
    [storeLocatorBtn release];
    

    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
    [self.view addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
    [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
    titleLblView.text = @" HOW TO ORDER";
    [titleLblView setDrawOutline:YES];
    [titleLblView setOutlineSize:3];
    [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    titleLblView.textAlignment = UITextAlignmentCenter;
    titleLblView.backgroundColor = [UIColor clearColor];
    [BackgroundImgSub addSubview:titleLblView];
    [titleLblView release];
    

    // ----------------- SCROLL VIEW
    
    orderScrollView = [[UIScrollView alloc] init ];
    orderScrollView.frame = CGRectMake(0, 125, screenWidth, screenHeight - 145);
    orderScrollView.backgroundColor = [UIColor clearColor];
    orderScrollView.maximumZoomScale = 1.0;
    orderScrollView.minimumZoomScale = 1.0;
    orderScrollView.delegate = self;
    orderScrollView.clipsToBounds = YES;
    orderScrollView.backgroundColor = [UIColor clearColor];
    orderScrollView.showsHorizontalScrollIndicator = NO;
    orderScrollView.pagingEnabled = YES;
    
    // ----------------- Mise en forme des sliders
    
    myNumberOfSlides = 7;
    int XposSlider = 0;
    int YposElements = 0;
    if (IS_4_INCH_SCREEN) { YposElements = 20; }
    
    
    for (int i = 0; i < myNumberOfSlides; i++) {
        
        UIView *myBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(XposSlider + 5, YposElements, orderScrollView.frame.size.width-10, orderScrollView.frame.size.height)];
        myBackGroundView.backgroundColor = [UIColor clearColor];
        [orderScrollView addSubview:myBackGroundView];
        [myBackGroundView release];
        
        // -----
        // Add elements in the slider
        // -----
        
        UIImageView *BackgroundImgInfoSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-bg@2x"]];
        BackgroundImgInfoSub.frame = CGRectMake(0, 0, myBackGroundView.frame.size.width, myBackGroundView.frame.size.height - 12);
        [myBackGroundView addSubview:BackgroundImgInfoSub];
        [BackgroundImgInfoSub release];
        
        UIImageView *roundNumberImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-numbersbg"]];
        roundNumberImage.frame = CGRectMake(20, 15 + YposElements, 37, 37);
        [myBackGroundView addSubview:roundNumberImage];
        [roundNumberImage release];
        
        // NUMBER
        CustomLabel *nbLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 2, roundNumberImage.frame.size.width, roundNumberImage.frame.size.height)];
        [nbLbl setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:21.0]];
        nbLbl.text = [NSString stringWithFormat:@"%i", i+1];
        [nbLbl setDrawOutline:YES];
        [nbLbl setOutlineSize:3];
        [nbLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        nbLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        nbLbl.textAlignment = UITextAlignmentCenter;
        nbLbl.backgroundColor = [UIColor clearColor];
        [roundNumberImage addSubview:nbLbl];
        [nbLbl release];
        
        // TITLE ORDER
        CustomLabel *titleLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(roundNumberImage.frame.size.width + roundNumberImage.frame.origin.x, 10 + YposElements, 220, 50)];
        [titleLbl setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
        [titleLbl setDrawOutline:YES];
        [titleLbl setOutlineSize:3];
        [titleLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        titleLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleLbl.textAlignment = UITextAlignmentCenter;
        titleLbl.backgroundColor = [UIColor clearColor];
        [myBackGroundView addSubview:titleLbl];
        [titleLbl release];
        
        
        UIImageView *BackgroundImgSub = [[UIImageView alloc] init];
        BackgroundImgSub.frame = CGRectMake((screenWidth-235)/2, titleLbl.frame.size.height+ titleLbl.frame.origin.y + 20, 230, 130);
        BackgroundImgSub.image = [UIImage imageNamed:[NSString stringWithFormat:@"howtoorder_p%i@2x", i+1]];
        [myBackGroundView addSubview:BackgroundImgSub];
        [BackgroundImgSub release];

        
        CustomLabel *stepLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(30, 205 + YposElements, myBackGroundView.frame.size.width - 70, 100)];
        [stepLbl setFont:[UIFont fontWithName:APEX_HEAVY size:13.0]];
        [stepLbl setDrawOutline:YES];
        [stepLbl setOutlineSize:3];
        [stepLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        stepLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        stepLbl.textAlignment = UITextAlignmentCenter;
        stepLbl.lineBreakMode = UILineBreakModeWordWrap;
        stepLbl.numberOfLines = 0;
        stepLbl.backgroundColor = [UIColor clearColor];
        [myBackGroundView addSubview:stepLbl];
        [stepLbl release];
        
        
        UIImageView *bt1IconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_footer_icon@2x"]];
        [myBackGroundView addSubview:bt1IconImg];
        [bt1IconImg release];
        
        CustomLabel *btn1Lbl = [[CustomLabel alloc] init];
        [btn1Lbl setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:9.0]];
        [btn1Lbl setDrawOutline:YES];
        [btn1Lbl setOutlineSize:strokeSize];
        [btn1Lbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        btn1Lbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        btn1Lbl.textAlignment = UITextAlignmentRight;
        btn1Lbl.backgroundColor = [UIColor clearColor];
        [myBackGroundView addSubview:btn1Lbl];
        [btn1Lbl release];
        
        bt1IconImg.frame = CGRectMake(screenWidth-40, orderScrollView.frame.size.height - 38, 17, 17);
        btn1Lbl.frame = CGRectMake(screenWidth-243, orderScrollView.frame.size.height - 38,  200, 20);
        
        
        if (i == 0) {
            titleLbl.text = NSLocalizedString(@"kOrder1Title", nil); 
            stepLbl.text = NSLocalizedString(@"kOrder1Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ", NSLocalizedString(@"kOrder2Title", nil)];
        }else if (i == 1) {
            titleLbl.text = NSLocalizedString(@"kOrder2Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder2Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ",  NSLocalizedString(@"kOrder3Title", nil)];
        }else if (i == 2) {
            titleLbl.text = NSLocalizedString(@"kOrder3Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder3Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ",  NSLocalizedString(@"kOrder4Title", nil)];
        }else if (i == 3) {
            titleLbl.text = NSLocalizedString(@"kOrder4Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder4Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ",  NSLocalizedString(@"kOrder5Title", nil)];
        }else if (i == 4) {
            titleLbl.text = NSLocalizedString(@"kOrder5Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder5Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ", NSLocalizedString(@"kOrder6Title", nil)];
        }else if (i == 5) {
            titleLbl.text = NSLocalizedString(@"kOrder6Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder6Desc", nil);
            btn1Lbl.text = [NSString stringWithFormat:@"%@ ", NSLocalizedString(@"kOrder7Title", nil)];
        }else if (i == 6) {
            titleLbl.text = NSLocalizedString(@"kOrder7Title", nil);
            stepLbl.text = NSLocalizedString(@"kOrder7Desc", nil);
            btn1Lbl.text = @"";
            bt1IconImg.hidden = YES;
        }
        
        
        XposSlider = XposSlider +  orderScrollView.frame.size.width;
        
    }
    
    orderScrollView.contentSize = CGSizeMake(myNumberOfSlides*orderScrollView.frame.size.width, orderScrollView.frame.size.height);
    [self.view addSubview:orderScrollView];
    
    
    // ----------------- PAGE CONTROL
    
    pageControl = [[DDPageControl alloc] init];
    pageControl.center = CGPointMake(self.view.center.x, screenHeight-20);
    pageControl.numberOfPages = myNumberOfSlides;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    
    // Customisation
    pageControl.defersCurrentPageDisplay = YES;
    pageControl.type = DDPageControlTypeOnFullOffFull;
    pageControl.onColor = [UIColorCov colorWithHexString:YELLOW_TEXT];
    pageControl.offColor = [UIColor blackColor];
    pageControl.indicatorDiameter = 9.0f;
    pageControl.indicatorSpace = 10.0f;
    
    [self.view addSubview:pageControl];
    
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)backAction { [self dismissModalViewControllerAnimated:YES]; }


-(void)pushStoreLocatorView {
    
    StoreLocatorViewController *storeViewCtrl = [[StoreLocatorViewController alloc] init];
    storeViewCtrl.fromOtherView = YES;
    [self.navigationController pushViewController:storeViewCtrl animated:YES];
    [storeViewCtrl release];
    
}


// ========================== SCROLL VIEW METHODS ============================


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	CGFloat pageWidth = orderScrollView.bounds.size.width;
    float fractionalPage = orderScrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (orderScrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
