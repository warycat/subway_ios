//
//  CateringViewController.m
//  Subway
//
//  Created by ludo on 5/13/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "CateringViewController.h"

@interface CateringViewController ()

@end

@implementation CateringViewController



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
    
    [displayMethod createTopBar:self.view viewName:@"catering" leftBtn:backBtn rightBtn:nil otherBtn:nil];
    
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [backBtn release];
    
    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
    BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
    [self.view addSubview:BackgroundImgSub];
    [BackgroundImgSub release];
    
    CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
    [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
    titleLblView.text = @" CATERING";
    [titleLblView setDrawOutline:YES];
    [titleLblView setOutlineSize:3];
    [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
    titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    titleLblView.textAlignment = UITextAlignmentCenter;
    titleLblView.backgroundColor = [UIColor clearColor];
    [BackgroundImgSub addSubview:titleLblView];
    [titleLblView release];
    

    UIWebView *webContainer = [[UIWebView alloc] initWithFrame:CGRectMake(20, 125, screenWidth - 40, screenHeight - 145)];
    webContainer.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
    [webContainer setBackgroundColor:[UIColor clearColor]];
    webContainer.scrollView.bounces = YES;
    [webContainer setBackgroundColor:[UIColor clearColor]];
    [webContainer setOpaque:NO];
    [webContainer setBackgroundColor: [UIColor clearColor]];
    //[webContainer loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SubwayUrlLink]]];
    [webContainer loadHTMLString:@"<html><body style=\"background-color:transparent;color: #ffffff\">Sandwich and Wraps<br>All SUBWAY® Sandwich Platters are prepared on a variety of freshly baked gourmet breads, with your choice of cold cuts - Ham, Turkey, Roasted Chicken, Roast Beef – as well as Tuna, and Veggie Delite™. You can also go for our special SUBWAY® creations like Italian B.M.T™ or Subway Club™.<br><br><br>Top off your selection with fresh lettuce, tomatoes, cucumbers, pickles, green peppers, hot peppers, red onions and black olives. Bacon or extra cheese may also be added for an additional charge.<br><br><br>Giant Subs<br>Make a big impression on your guests with these BIG sandwiches. Enjoy the same delicious taste of your favourite regular subs in giant 3 foot (90 cm) and 6 foot (180 cm) portions! A 3-foot Giant Sub typically satisfies 10-15 guests while a 6-foot Giant Sub usually caters from 20-25 guests.<br><br><br>Giant Subs are prepared on custom-baked & braided bread, and require 24 hours advance notice to create just for you. Sandwich selections may include any one (or combination) of our cold deli meats and/or seafood selections. Topping your Giant Sub there’s sliced cheese, plus your choice of lettuce, tomatoes, pickles, green peppers, hot peppers, red onions and black olives. Bacon is also available upon request.<br><br><br>Cookie Platter<br>Treat yourself to our mouth watering freshly baked cookies, a sweet ending to your meal. Get a Regular cookie platter with 3 dozen or the Large platter with 5 dozen from your favourites such as Chocolate Chip, White Chocolate Macadamia Nut, Peanut Butter, Oatmeal Raisin and Double Chocolate Chip.<br><br>Bagged snacks, freshly-baked cookies by the dozen, and bottled beverages are also on-hand to accompany your catering order. For more details on catering availability, pricing, orders and delivery, call your nearest SUBWAY® restaurant.</body></html>" baseURL:nil];
     [self.view addSubview:webContainer];
    
    
    for (UIView* shadowView in [webContainer.scrollView subviews])
    {
        if ([shadowView isKindOfClass:[UIImageView class]]) {
            [shadowView setHidden:YES];
        }
    }
    
    [webContainer release];
    
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)backAction { [self dismissModalViewControllerAnimated:YES]; }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
