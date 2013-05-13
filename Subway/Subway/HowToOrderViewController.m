//
//  HowToOrderViewController.m
//  Subway
//
//  Created by ludo on 5/10/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "HowToOrderViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    [displayMethod createTopBar:self.view viewName:@"order" leftBtn:backBtn rightBtn:nil otherBtn:nil];
    
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [backBtn release];

    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
    [self.view addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
    [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
    titleLblView.text = @" HOW TO ORDER";
    [titleLblView setDrawOutline:YES];
    [titleLblView setOutlineSize:3];
    [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
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
    
    for (int i = 0; i < myNumberOfSlides; i++) {
        
        UIView *myBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(XposSlider + 5, 0, orderScrollView.frame.size.width-10, orderScrollView.frame.size.height)];
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
        roundNumberImage.frame = CGRectMake(20, 15, 37, 37);
        [myBackGroundView addSubview:roundNumberImage];
        [roundNumberImage release];
        
        // NUMBER
        CustomLabel *nbLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 2, roundNumberImage.frame.size.width, roundNumberImage.frame.size.height)];
        [nbLbl setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:21.0]];
        nbLbl.text = [NSString stringWithFormat:@"%i", i+1];
        [nbLbl setDrawOutline:YES];
        [nbLbl setOutlineSize:3];
        [nbLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
        nbLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        nbLbl.textAlignment = UITextAlignmentCenter;
        nbLbl.backgroundColor = [UIColor clearColor];
        [roundNumberImage addSubview:nbLbl];
        [nbLbl release];
        
        // TITLE ORDER
        CustomLabel *titleLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(roundNumberImage.frame.size.width + roundNumberImage.frame.origin.x, 10, 220, 50)];
        [titleLbl setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
        [titleLbl setDrawOutline:YES];
        [titleLbl setOutlineSize:3];
        [titleLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
        titleLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleLbl.textAlignment = UITextAlignmentCenter;
        titleLbl.backgroundColor = [UIColor clearColor];
        [myBackGroundView addSubview:titleLbl];
        [titleLbl release];
        
        
        UIImageView *BackgroundImgSub = [[UIImageView alloc] init];
        BackgroundImgSub.frame = CGRectMake((screenWidth-230)/2, titleLbl.frame.size.height+ titleLbl.frame.origin.y + 20, 230, 130);
        BackgroundImgSub.image = [UIImage imageNamed:[NSString stringWithFormat:@"howtoorder_p%i@2x", i+1]];
        [myBackGroundView addSubview:BackgroundImgSub];
        [BackgroundImgSub release];
        
        
        if (i == 0) {
           titleLbl.text = @" Sub, salad or wrap?";
    
        }else if (i == 1) {
            titleLbl.text = @" Which type of Bread?";
        }else if (i == 2) {
            titleLbl.text = @" Which size?";
        }else if (i == 3) {
            titleLbl.text = @" Which extras?";
        }else if (i == 4) {
            titleLbl.text = @" Which veggies?";
        }else if (i == 5) {
            titleLbl.text = @" Which sauce?";
        }else if (i == 6) {
            titleLbl.text = @" Make it a meal?";
        }

        
        
        CustomLabel *stepLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 190, myBackGroundView.frame.size.width - 40, 100)];
        [stepLbl setFont:[UIFont fontWithName:APEX_HEAVY size:13.0]];
        stepLbl.text = @"First thing's, first. Are you feeling like a sub, a wrap, or a salad? Once you've figured out what form you want our tasty ingredients to come in, you're ready to move on.";
        [stepLbl setDrawOutline:YES];
        [stepLbl setOutlineSize:3];
        [stepLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
        stepLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        stepLbl.textAlignment = UITextAlignmentLeft;
        stepLbl.lineBreakMode = UILineBreakModeWordWrap;
        stepLbl.numberOfLines = 0;
        stepLbl.backgroundColor = [UIColor clearColor];
        [myBackGroundView addSubview:stepLbl];
        [stepLbl release];
        
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