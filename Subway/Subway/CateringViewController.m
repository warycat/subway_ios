//
//  CateringViewController.m
//  Subway
//
//  Created by ludo on 5/13/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "CateringViewController.h"
#import "StoreLocatorViewController.h"

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
    UIButton *storeLocatorBtn =  [[UIButton alloc] init];
    
    [displayMethod createTopBar:self.view viewName:@"catering" leftBtn:backBtn rightBtn:storeLocatorBtn otherBtn:nil];
    
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
    titleLblView.text = @" CATERING";
    [titleLblView setDrawOutline:YES];
    [titleLblView setOutlineSize:3];
    [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
    titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    titleLblView.textAlignment = UITextAlignmentCenter;
    titleLblView.backgroundColor = [UIColor clearColor];
    [BackgroundImgSub addSubview:titleLblView];
    [titleLblView release];
    
    
    // ----------------- SCROLL VIEW
    
    UIScrollView *cateringScrollView = [[UIScrollView alloc] init ];
    cateringScrollView.frame = CGRectMake(0, 125, screenWidth, screenHeight - 145);
    cateringScrollView.backgroundColor = [UIColor clearColor];
    cateringScrollView.maximumZoomScale = 1.0;
    cateringScrollView.minimumZoomScale = 1.0;
    cateringScrollView.clipsToBounds = YES;
    cateringScrollView.backgroundColor = [UIColor clearColor];
    cateringScrollView.showsHorizontalScrollIndicator = NO;
    cateringScrollView.pagingEnabled = NO;
    [self.view addSubview:cateringScrollView];
    
    
    CustomLabel *title1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 5, screenWidth - 40, 25)];
    [title1 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:20.0]];
    title1.text = @"Sandwich and Wraps";
    [title1 setDrawOutline:YES];
    [title1 setOutlineSize:strokeSize];
    [title1 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    title1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    title1.textAlignment = UITextAlignmentLeft;
    title1.numberOfLines = 0;
    title1.lineBreakMode = UILineBreakModeWordWrap;
    title1.backgroundColor = [UIColor clearColor];
    [cateringScrollView  addSubview:title1];
    [title1 release];
    
    CustomLabel *text1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title1.frame.origin.y + title1.frame.size.height, screenWidth - 40, 150)];
    [text1 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    text1.text = @"\nAll SUBWAY® Sandwich Platters are prepared on a variety of freshly baked gourmet breads, with your choice of cold cuts - Ham, Turkey, Roasted Chicken, Roast Beef – as well as Tuna, and Veggie Delite™. You can also go for our special SUBWAY® creations like Italian B.M.T™ or Subway Club™.";
    [text1 setDrawOutline:YES];
    [text1 setOutlineSize:strokeSize];
    [text1 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    text1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    text1.textAlignment = UITextAlignmentLeft;
    text1.numberOfLines = 0;
    text1.lineBreakMode = UILineBreakModeWordWrap;
    text1.backgroundColor = [UIColor clearColor];
    [cateringScrollView  addSubview:text1];
    [text1 release];
    
    CustomLabel *text2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text1.frame.origin.y + text1.frame.size.height, screenWidth - 40, 90)];
    [text2 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    text2.text = @"Top off your selection with fresh lettuce, tomatoes, cucumbers, pickles, green peppers, hot peppers, red onions and black olives. Bacon or extra cheese may also be added for an additional charge./n";
    [text2 setDrawOutline:YES];
    [text2 setOutlineSize:strokeSize];
    [text2 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    text2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    text2.textAlignment = UITextAlignmentLeft;
    text2.numberOfLines = 0;
    text2.lineBreakMode = UILineBreakModeWordWrap;
    text2.backgroundColor = [UIColor clearColor];
    [cateringScrollView addSubview:text2];
    [text2 release];
    
    
    CustomLabel *title2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text2.frame.origin.y + text2.frame.size.height + 20, screenWidth - 40, 25)];
    [title2 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:20.0]];
    title2.text = @"Giant Subs";
    [title2 setDrawOutline:YES];
    [title2 setOutlineSize:strokeSize];
    [title2 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    title2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    title2.textAlignment = UITextAlignmentLeft;
    title2.numberOfLines = 0;
    title2.lineBreakMode = UILineBreakModeWordWrap;
    title2.backgroundColor = [UIColor clearColor];
    [cateringScrollView  addSubview:title2];
    [title2 release];
    
    
    CustomLabel *text3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title2.frame.origin.y + title2.frame.size.height, screenWidth - 40, 150)];
    [text3 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    text3.text = @"\nMake a big impression on your guests with these BIG sandwiches. Enjoy the same delicious taste of your favourite regular subs in giant 3 foot (90 cm) and 6 foot (180 cm) portions! A 3-foot Giant Sub typically satisfies 10-15 guests while a 6-foot Giant Sub usually caters from 20-25 guests.";
    [text3 setDrawOutline:YES];
    [text3 setOutlineSize:strokeSize];
    [text3 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    text3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    text3.textAlignment = UITextAlignmentLeft;
    text3.numberOfLines = 0;
    text3.lineBreakMode = UILineBreakModeWordWrap;
    text3.backgroundColor = [UIColor clearColor];
    [cateringScrollView addSubview:text3];
    [text3 release];
    
    CustomLabel *text4 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text3.frame.origin.y + text3.frame.size.height, screenWidth - 40, 160)];
    [text4 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    text4.text = @"Giant Subs are prepared on custom-baked & braided bread, and require 24 hours advance notice to create just for you. Sandwich selections may include any one (or combination) of our cold deli meats and/or seafood selections. Topping your Giant Sub there’s sliced cheese, plus your choice of lettuce, tomatoes, pickles, green peppers, hot peppers, red onions and black olives. Bacon is also available upon request./n";
    [text4 setDrawOutline:YES];
    [text4 setOutlineSize:strokeSize];
    [text4 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    text4.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    text4.textAlignment = UITextAlignmentLeft;
    text4.numberOfLines = 0;
    text4.lineBreakMode = UILineBreakModeWordWrap;
    text4.backgroundColor = [UIColor clearColor];
    [cateringScrollView  addSubview:text4];
    [text4 release];
    
    CustomLabel *title3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20,  text4.frame.origin.y + text4.frame.size.height + 20, screenWidth - 40, 25)];
    [title3 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:20.0]];
    title3.text = @"Cookie Platter";
    [title3 setDrawOutline:YES];
    [title3 setOutlineSize:strokeSize];
    [title3 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    title3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    title3.textAlignment = UITextAlignmentLeft;
    title3.numberOfLines = 0;
    title3.lineBreakMode = UILineBreakModeWordWrap;
    title3.backgroundColor = [UIColor clearColor];
    [cateringScrollView  addSubview:title3];
    [title3 release];
    
    
    CustomLabel *text5 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title3.frame.origin.y + title3.frame.size.height, screenWidth - 40, 270)];
    [text5 setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
    text5.text = @"\nTreat yourself to our mouth watering freshly baked cookies, a sweet ending to your meal. Get a Regular cookie platter with 3 dozen or the Large platter with 5 dozen from your favourites such as Chocolate Chip, White Chocolate Macadamia Nut, Peanut Butter, Oatmeal Raisin and Double Chocolate Chip.\n\nBagged snacks, freshly-baked cookies by the dozen, and bottled beverages are also on-hand to accompany your catering order. For more details on catering availability, pricing, orders and delivery, call your nearest SUBWAY® restaurant.";
    [text5 setDrawOutline:YES];
    [text5 setOutlineSize:strokeSize];
    [text5 setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    text5.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    text5.textAlignment = UITextAlignmentLeft;
    text5.numberOfLines = 0;
    text5.lineBreakMode = UILineBreakModeWordWrap;
    text5.backgroundColor = [UIColor clearColor];
    [cateringScrollView addSubview:text5];
    [text5 release];
    
    
    cateringScrollView.contentSize = CGSizeMake(cateringScrollView.frame.size.width, text5.frame.origin.y + text5.frame.size.height + 30);
    

//    UIWebView *webContainer = [[UIWebView alloc] initWithFrame:CGRectMake(20, 125, screenWidth - 40, screenHeight - 145)];
//    webContainer.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
//    [webContainer setBackgroundColor:[UIColor clearColor]];
//    webContainer.scrollView.bounces = YES;
//    [webContainer setBackgroundColor:[UIColor clearColor]];
//    [webContainer setOpaque:NO];
//    [webContainer setBackgroundColor: [UIColor clearColor]];
//    //[webContainer loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SubwayUrlLink]]];
//    [webContainer loadHTMLString:@"<html><body style=\"background-color:transparent;color: #ffffff\">Sandwich and Wraps<br>All SUBWAY® Sandwich Platters are prepared on a variety of freshly baked gourmet breads, with your choice of cold cuts - Ham, Turkey, Roasted Chicken, Roast Beef – as well as Tuna, and Veggie Delite™. You can also go for our special SUBWAY® creations like Italian B.M.T™ or Subway Club™.<br><br><br>Top off your selection with fresh lettuce, tomatoes, cucumbers, pickles, green peppers, hot peppers, red onions and black olives. Bacon or extra cheese may also be added for an additional charge.<br><br><br>Giant Subs<br>Make a big impression on your guests with these BIG sandwiches. Enjoy the same delicious taste of your favourite regular subs in giant 3 foot (90 cm) and 6 foot (180 cm) portions! A 3-foot Giant Sub typically satisfies 10-15 guests while a 6-foot Giant Sub usually caters from 20-25 guests.<br><br><br>Giant Subs are prepared on custom-baked & braided bread, and require 24 hours advance notice to create just for you. Sandwich selections may include any one (or combination) of our cold deli meats and/or seafood selections. Topping your Giant Sub there’s sliced cheese, plus your choice of lettuce, tomatoes, pickles, green peppers, hot peppers, red onions and black olives. Bacon is also available upon request.<br><br><br>Cookie Platter<br>Treat yourself to our mouth watering freshly baked cookies, a sweet ending to your meal. Get a Regular cookie platter with 3 dozen or the Large platter with 5 dozen from your favourites such as Chocolate Chip, White Chocolate Macadamia Nut, Peanut Butter, Oatmeal Raisin and Double Chocolate Chip.<br><br>Bagged snacks, freshly-baked cookies by the dozen, and bottled beverages are also on-hand to accompany your catering order. For more details on catering availability, pricing, orders and delivery, call your nearest SUBWAY® restaurant.</body></html>" baseURL:nil];
//     [self.view addSubview:webContainer];
//    
//    
//    
//    
//    
//    for (UIView* shadowView in [webContainer.scrollView subviews])
//    {
//        if ([shadowView isKindOfClass:[UIImageView class]]) {
//            [shadowView setHidden:YES];
//        }
//    }
//    
//    [webContainer release];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
