//
//  CateringViewController.m
//  Subway
//
//  Created by ludo on 5/13/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "CateringViewController.h"
#import "StoreLocatorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CateringViewController ()

@end

@implementation CateringViewController
@synthesize cateringScrollView;


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

    
    // ----------------- SCROLL VIEW
    
    cateringScrollView = [[UIScrollView alloc] init ];
    cateringScrollView.frame = CGRectMake(0, 119, screenWidth, screenHeight - 131);
    cateringScrollView.backgroundColor = [UIColor clearColor];
    cateringScrollView.maximumZoomScale = 1.0;
    cateringScrollView.minimumZoomScale = 1.0;
    cateringScrollView.clipsToBounds = YES;
    cateringScrollView.delegate = self;
    cateringScrollView.backgroundColor = [UIColor clearColor];
    cateringScrollView.showsHorizontalScrollIndicator = NO;
    cateringScrollView.pagingEnabled = NO;
    [self.view addSubview:cateringScrollView];
    
    if ([[settingMethod getUserLanguage] isEqualToString:@"en"]) {
        
        CustomLabel *title1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 20, screenWidth - 40, 25)];
        [title1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title1.text = @" Sandwich and Wraps";
        [title1 setDrawOutline:YES];
        [title1 setOutlineSize:strokeSize];
        [title1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title1.textAlignment = UITextAlignmentLeft;
        title1.numberOfLines = 0;
        title1.lineBreakMode = UILineBreakModeWordWrap;
        title1.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title1];
        [title1 release];
        
        CustomLabel *text1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title1.frame.origin.y + title1.frame.size.height, screenWidth - 40, 150)];
        [text1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text1.text = @"\n All SUBWAY® Sandwich Platters are prepared on a variety of freshly baked gourmet breads, with your choice of cold cuts - Ham, Turkey, Roasted Chicken, Roast Beef – as well as Tuna, and Veggie Delite™. You can also go for our special SUBWAY® creations like Italian B.M.T™ or Subway Club™.";
        [text1 setDrawOutline:YES];
        [text1 setOutlineSize:1];
        [text1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text1.textAlignment = UITextAlignmentLeft;
        text1.numberOfLines = 0;
        
        text1.lineBreakMode = UILineBreakModeWordWrap;
        text1.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:text1];
        [text1 release];
        
        CustomLabel *text2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text1.frame.origin.y + text1.frame.size.height, screenWidth - 40, 90)];
        [text2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text2.text = @" Top off your selection with fresh lettuce, tomatoes, cucumbers, pickles, green peppers, hot peppers, red onions and black olives. Bacon or extra cheese may also be added for an additional charge.";
        [text2 setDrawOutline:YES];
        [text2 setOutlineSize:1];
        [text2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text2.textAlignment = UITextAlignmentLeft;
        text2.numberOfLines = 0;
        text2.lineBreakMode = UILineBreakModeWordWrap;
        text2.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text2];
        [text2 release];
        
        
        CustomLabel *title2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text2.frame.origin.y + text2.frame.size.height + 20, screenWidth - 40, 25)];
        [title2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title2.text = @" Giant Subs";
        [title2 setDrawOutline:YES];
        [title2 setOutlineSize:strokeSize];
        [title2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title2.textAlignment = UITextAlignmentLeft;
        title2.numberOfLines = 0;
        title2.lineBreakMode = UILineBreakModeWordWrap;
        title2.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title2];
        [title2 release];
        
        
        CustomLabel *text3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title2.frame.origin.y + title2.frame.size.height, screenWidth - 40, 150)];
        [text3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text3.text = @"\n Make a big impression on your guests with these BIG sandwiches. Enjoy the same delicious taste of your favourite regular subs in giant 3 foot (90 cm) and 6 foot (180 cm) portions! A 3-foot Giant Sub typically satisfies 10-15 guests while a 6-foot Giant Sub usually caters from 20-25 guests.";
        [text3 setDrawOutline:YES];
        [text3 setOutlineSize:1];
        [text3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text3.textAlignment = UITextAlignmentLeft;
        text3.numberOfLines = 0;
        text3.lineBreakMode = UILineBreakModeWordWrap;
        text3.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text3];
        [text3 release];
        
        CustomLabel *text4 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text3.frame.origin.y + text3.frame.size.height, screenWidth - 40, 160)];
        [text4 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text4.text = @" Giant Subs are prepared on custom-baked & braided bread, and require 24 hours advance notice to create just for you. Sandwich selections may include any one (or combination) of our cold deli meats and/or seafood selections. Topping your Giant Sub there’s sliced cheese, plus your choice of lettuce, tomatoes, pickles, green peppers, hot peppers, red onions and black olives. Bacon is also available upon request./n";
        [text4 setDrawOutline:YES];
        [text4 setOutlineSize:1];
        [text4 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text4.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text4.textAlignment = UITextAlignmentLeft;
        text4.numberOfLines = 0;
        text4.lineBreakMode = UILineBreakModeWordWrap;
        text4.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:text4];
        [text4 release];
        
        CustomLabel *title3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20,  text4.frame.origin.y + text4.frame.size.height + 20, screenWidth - 40, 25)];
        [title3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title3.text = @" Cookie Platter";
        [title3 setDrawOutline:YES];
        [title3 setOutlineSize:strokeSize];
        [title3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title3.textAlignment = UITextAlignmentLeft;
        title3.numberOfLines = 0;
        title3.lineBreakMode = UILineBreakModeWordWrap;
        title3.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title3];
        [title3 release];
        
        
        CustomLabel *text5 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title3.frame.origin.y + title3.frame.size.height, screenWidth - 40, 270)];
        [text5 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text5.text = @"\n Treat yourself to our mouth watering freshly baked cookies, a sweet ending to your meal. Get a Regular cookie platter with 3 dozen or the Large platter with 5 dozen from your favourites such as Chocolate Chip, White Chocolate Macadamia Nut, Peanut Butter, Oatmeal Raisin and Double Chocolate Chip.\n\nBagged snacks, freshly-baked cookies by the dozen, and bottled beverages are also on-hand to accompany your catering order. For more details on catering availability, pricing, orders and delivery, call your nearest SUBWAY® restaurant.";
        [text5 setDrawOutline:YES];
        [text5 setOutlineSize:1];
        [text5 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text5.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text5.textAlignment = UITextAlignmentLeft;
        text5.numberOfLines = 0;
        text5.lineBreakMode = UILineBreakModeWordWrap;
        text5.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text5];
        [text5 release];
        
        
        cateringScrollView.contentSize = CGSizeMake(cateringScrollView.frame.size.width, text5.frame.origin.y + text5.frame.size.height + 30);
        
        UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
        BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
        [self.view addSubview:BackgroundImgSub];
        [BackgroundImgSub release];
        
        CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
        [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
        titleLblView.text = @" CATERING";
        [titleLblView setDrawOutline:YES];
        [titleLblView setOutlineSize:3];
        [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleLblView.textAlignment = UITextAlignmentCenter;
        titleLblView.backgroundColor = [UIColor clearColor];
        [BackgroundImgSub addSubview:titleLblView];
        [titleLblView release];

    }else{
        CustomLabel *title1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 20, screenWidth - 40, 25)];
        [title1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title1.text = @"三明治拼盘 (Sandwich Platters)和百味卷拼盘 (Wrap Platters)";
        [title1 setDrawOutline:YES];
        [title1 setOutlineSize:strokeSize];
        [title1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title1.textAlignment = UITextAlignmentLeft;
        title1.numberOfLines = 0;
        title1.lineBreakMode = UILineBreakModeWordWrap;
        title1.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title1];
        [title1 release];
        
        CustomLabel *text1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title1.frame.origin.y + title1.frame.size.height, screenWidth - 40, 150)];
        [text1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text1.text = @"\n 常规的三明治拼盘和百味卷拼盘可供 7 - 12 人食用，而大型的三明治拼盘和百味卷拼盘则可供 10 – 15 人食用。所有 SUBWAY®赛百味三明治拼盘都由各式新鲜烘烤的美味面包搭配而成，还有各式冷食供您选择：火腿、火鸡、香烤鸡排、香烤牛肉、金枪鱼和新鲜蔬菜。另外，您也可以选择特制的 SUBWAY® 赛百味美食，例如意大利经典和百味俱乐部。";
        [text1 setDrawOutline:YES];
        [text1 setOutlineSize:1];
        [text1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text1.textAlignment = UITextAlignmentLeft;
        text1.numberOfLines = 0;
        
        text1.lineBreakMode = UILineBreakModeWordWrap;
        text1.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:text1];
        [text1 release];
        
        CustomLabel *text2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text1.frame.origin.y + text1.frame.size.height, screenWidth - 40, 90)];
        [text2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text2.text = @" 为所选三明治佐以新鲜的生菜、西红柿、黄瓜、酸黄瓜、青椒、红辣椒、洋葱和黑橄榄。也可以追加培根或奶酪，但需另外付费。";
        [text2 setDrawOutline:YES];
        [text2 setOutlineSize:1];
        [text2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text2.textAlignment = UITextAlignmentLeft;
        text2.numberOfLines = 0;
        text2.lineBreakMode = UILineBreakModeWordWrap;
        text2.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text2];
        [text2 release];
        
        
        CustomLabel *title2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text2.frame.origin.y + text2.frame.size.height + 20, screenWidth - 40, 25)];
        [title2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title2.text = @" 超大三明治 (Giant Subs)";
        [title2 setDrawOutline:YES];
        [title2 setOutlineSize:strokeSize];
        [title2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title2.textAlignment = UITextAlignmentLeft;
        title2.numberOfLines = 0;
        title2.lineBreakMode = UILineBreakModeWordWrap;
        title2.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title2];
        [title2 release];
        
        
        CustomLabel *text3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title2.frame.origin.y + title2.frame.size.height, screenWidth - 40, 150)];
        [text3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text3.text = @"\n 这些超大三明治将使您的客人回味无穷。尽情享受这超大的 36 英寸（90 厘米）和 72 英寸（180 厘米）三明治吧，它与您喜爱的常规三明治一样美味难挡！36 英寸超大三明治特别适合 10 - 15 位客人食用，72 英寸超大三明治通常适合 20 - 25 位客人食用。";
        [text3 setDrawOutline:YES];
        [text3 setOutlineSize:1];
        [text3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text3.textAlignment = UITextAlignmentLeft;
        text3.numberOfLines = 0;
        text3.lineBreakMode = UILineBreakModeWordWrap;
        text3.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text3];
        [text3 release];
        
        CustomLabel *text4 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text3.frame.origin.y + text3.frame.size.height, screenWidth - 40, 160)];
        [text4 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text4.text = @" 超大三明治所用的面包是定制烘焙的，呈花瓣型。要品尝为自己量身定做的面包，需提前 24 小时预订。您可以任选一种（或多种组合）熟食类冷肉和/或海鲜搭配成三明治。在超大三明治的上面铺上切片奶酪，还可以选择生菜、西红柿、酸黄瓜、青椒、红辣椒、洋葱和黑橄榄。另外，也可以根据个人口味加入适量培根。/n";
        [text4 setDrawOutline:YES];
        [text4 setOutlineSize:1];
        [text4 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text4.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text4.textAlignment = UITextAlignmentLeft;
        text4.numberOfLines = 0;
        text4.lineBreakMode = UILineBreakModeWordWrap;
        text4.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:text4];
        [text4 release];
        
        CustomLabel *title3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20,  text4.frame.origin.y + text4.frame.size.height + 20, screenWidth - 40, 25)];
        [title3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
        title3.text = @" 甜饼拼盘";
        [title3 setDrawOutline:YES];
        [title3 setOutlineSize:strokeSize];
        [title3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        title3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        title3.textAlignment = UITextAlignmentLeft;
        title3.numberOfLines = 0;
        title3.lineBreakMode = UILineBreakModeWordWrap;
        title3.backgroundColor = [UIColor clearColor];
        [cateringScrollView  addSubview:title3];
        [title3 release];
        
        
        CustomLabel *text5 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title3.frame.origin.y + title3.frame.size.height, screenWidth - 40, 270)];
        [text5 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
        text5.text = @"\n 用令人垂涎欲滴、新鲜出炉的烤甜饼来款待自己吧，为您的用餐画上甜蜜的句号。您可以选择自己喜欢的常规甜饼拼盘（带 36 块甜饼）和超大甜饼拼盘（带 60 块甜饼），例如巧克力甜饼 (Chocolate Chip)、白巧克力核桃甜饼 (White Chocolate Macadamia Nut)、花生甜饼 (Peanut Butter)、麦片提子饼 (Oatmeal Raisin) 和双色巧克力甜饼 (Double Chocolate Chip)。袋装小吃、12 块新鲜烤制的甜饼以及瓶装饮料同样很便利，也是聚会甜点的好选择。有关美食供应、价格、订餐和服务等更多信息，请联系最近的 SUBWAY® 赛百味快餐连锁店。";
        [text5 setDrawOutline:YES];
        [text5 setOutlineSize:1];
        [text5 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        text5.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        text5.textAlignment = UITextAlignmentLeft;
        text5.numberOfLines = 0;
        text5.lineBreakMode = UILineBreakModeWordWrap;
        text5.backgroundColor = [UIColor clearColor];
        [cateringScrollView addSubview:text5];
        [text5 release];
        
        
        cateringScrollView.contentSize = CGSizeMake(cateringScrollView.frame.size.width, text5.frame.origin.y + text5.frame.size.height + 30);
        
        UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
        BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
        [self.view addSubview:BackgroundImgSub];
        [BackgroundImgSub release];
        
        CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
        [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
        titleLblView.text = @" 赛百味聚会经典系列";
        [titleLblView setDrawOutline:YES];
        [titleLblView setOutlineSize:3];
        [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
        titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        titleLblView.textAlignment = UITextAlignmentCenter;
        titleLblView.backgroundColor = [UIColor clearColor];
        [BackgroundImgSub addSubview:titleLblView];
        [titleLblView release];

    }
    
//    CustomLabel *title1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, 20, screenWidth - 40, 25)];
//    [title1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
//    title1.text = @" Sandwich and Wraps";
//    [title1 setDrawOutline:YES];
//    [title1 setOutlineSize:strokeSize];
//    [title1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    title1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    title1.textAlignment = UITextAlignmentLeft;
//    title1.numberOfLines = 0;
//    title1.lineBreakMode = UILineBreakModeWordWrap;
//    title1.backgroundColor = [UIColor clearColor];
//    [cateringScrollView  addSubview:title1];
//    [title1 release];
//    
//    CustomLabel *text1 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title1.frame.origin.y + title1.frame.size.height, screenWidth - 40, 150)];
//    [text1 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
//    text1.text = @"\n All SUBWAY® Sandwich Platters are prepared on a variety of freshly baked gourmet breads, with your choice of cold cuts - Ham, Turkey, Roasted Chicken, Roast Beef – as well as Tuna, and Veggie Delite™. You can also go for our special SUBWAY® creations like Italian B.M.T™ or Subway Club™.";
//    [text1 setDrawOutline:YES];
//    [text1 setOutlineSize:1];
//    [text1 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    text1.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    text1.textAlignment = UITextAlignmentLeft;
//    text1.numberOfLines = 0;
//    
//    text1.lineBreakMode = UILineBreakModeWordWrap;
//    text1.backgroundColor = [UIColor clearColor];
//    [cateringScrollView  addSubview:text1];
//    [text1 release];
//    
//    CustomLabel *text2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text1.frame.origin.y + text1.frame.size.height, screenWidth - 40, 90)];
//    [text2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
//    text2.text = @" Top off your selection with fresh lettuce, tomatoes, cucumbers, pickles, green peppers, hot peppers, red onions and black olives. Bacon or extra cheese may also be added for an additional charge.";
//    [text2 setDrawOutline:YES];
//    [text2 setOutlineSize:1];
//    [text2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    text2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    text2.textAlignment = UITextAlignmentLeft;
//    text2.numberOfLines = 0;
//    text2.lineBreakMode = UILineBreakModeWordWrap;
//    text2.backgroundColor = [UIColor clearColor];
//    [cateringScrollView addSubview:text2];
//    [text2 release];
//    
//    
//    CustomLabel *title2 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text2.frame.origin.y + text2.frame.size.height + 20, screenWidth - 40, 25)];
//    [title2 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
//    title2.text = @" Giant Subs";
//    [title2 setDrawOutline:YES];
//    [title2 setOutlineSize:strokeSize];
//    [title2 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    title2.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    title2.textAlignment = UITextAlignmentLeft;
//    title2.numberOfLines = 0;
//    title2.lineBreakMode = UILineBreakModeWordWrap;
//    title2.backgroundColor = [UIColor clearColor];
//    [cateringScrollView  addSubview:title2];
//    [title2 release];
//    
//    
//    CustomLabel *text3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title2.frame.origin.y + title2.frame.size.height, screenWidth - 40, 150)];
//    [text3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
//    text3.text = @"\n Make a big impression on your guests with these BIG sandwiches. Enjoy the same delicious taste of your favourite regular subs in giant 3 foot (90 cm) and 6 foot (180 cm) portions! A 3-foot Giant Sub typically satisfies 10-15 guests while a 6-foot Giant Sub usually caters from 20-25 guests.";
//    [text3 setDrawOutline:YES];
//    [text3 setOutlineSize:1];
//    [text3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    text3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    text3.textAlignment = UITextAlignmentLeft;
//    text3.numberOfLines = 0;
//    text3.lineBreakMode = UILineBreakModeWordWrap;
//    text3.backgroundColor = [UIColor clearColor];
//    [cateringScrollView addSubview:text3];
//    [text3 release];
//    
//    CustomLabel *text4 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, text3.frame.origin.y + text3.frame.size.height, screenWidth - 40, 160)];
//    [text4 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
//    text4.text = @" Giant Subs are prepared on custom-baked & braided bread, and require 24 hours advance notice to create just for you. Sandwich selections may include any one (or combination) of our cold deli meats and/or seafood selections. Topping your Giant Sub there’s sliced cheese, plus your choice of lettuce, tomatoes, pickles, green peppers, hot peppers, red onions and black olives. Bacon is also available upon request./n";
//    [text4 setDrawOutline:YES];
//    [text4 setOutlineSize:1];
//    [text4 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    text4.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    text4.textAlignment = UITextAlignmentLeft;
//    text4.numberOfLines = 0;
//    text4.lineBreakMode = UILineBreakModeWordWrap;
//    text4.backgroundColor = [UIColor clearColor];
//    [cateringScrollView  addSubview:text4];
//    [text4 release];
//    
//    CustomLabel *title3 = [[CustomLabel alloc] initWithFrame:CGRectMake(20,  text4.frame.origin.y + text4.frame.size.height + 20, screenWidth - 40, 25)];
//    [title3 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD_ITALIC]  size:20.0]];
//    title3.text = @" Cookie Platter";
//    [title3 setDrawOutline:YES];
//    [title3 setOutlineSize:strokeSize];
//    [title3 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    title3.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    title3.textAlignment = UITextAlignmentLeft;
//    title3.numberOfLines = 0;
//    title3.lineBreakMode = UILineBreakModeWordWrap;
//    title3.backgroundColor = [UIColor clearColor];
//    [cateringScrollView  addSubview:title3];
//    [title3 release];
//    
//    
//    CustomLabel *text5 = [[CustomLabel alloc] initWithFrame:CGRectMake(20, title3.frame.origin.y + title3.frame.size.height, screenWidth - 40, 270)];
//    [text5 setFont:[UIFont fontWithName:[settingMethod checkFont:APEX_BOLD] size:15.5]];
//    text5.text = @"\n Treat yourself to our mouth watering freshly baked cookies, a sweet ending to your meal. Get a Regular cookie platter with 3 dozen or the Large platter with 5 dozen from your favourites such as Chocolate Chip, White Chocolate Macadamia Nut, Peanut Butter, Oatmeal Raisin and Double Chocolate Chip.\n\nBagged snacks, freshly-baked cookies by the dozen, and bottled beverages are also on-hand to accompany your catering order. For more details on catering availability, pricing, orders and delivery, call your nearest SUBWAY® restaurant.";
//    [text5 setDrawOutline:YES];
//    [text5 setOutlineSize:1];
//    [text5 setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    text5.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    text5.textAlignment = UITextAlignmentLeft;
//    text5.numberOfLines = 0;
//    text5.lineBreakMode = UILineBreakModeWordWrap;
//    text5.backgroundColor = [UIColor clearColor];
//    [cateringScrollView addSubview:text5];
//    [text5 release];
//    
//
//    cateringScrollView.contentSize = CGSizeMake(cateringScrollView.frame.size.width, text5.frame.origin.y + text5.frame.size.height + 30);    
//    
//    UIImageView *BackgroundImgSub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoorder-titlebg@2x"]];
//    BackgroundImgSub.frame = CGRectMake(0, 75, screenWidth, 45);
//    [self.view addSubview:BackgroundImgSub];
//    [BackgroundImgSub release];
//    
//    CustomLabel *titleLblView = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, BackgroundImgSub.frame.size.width, BackgroundImgSub.frame.size.height)];
//    [titleLblView setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:20.0]];
//    titleLblView.text = @" CATERING";
//    [titleLblView setDrawOutline:YES];
//    [titleLblView setOutlineSize:3];
//    [titleLblView setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
//    titleLblView.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    titleLblView.textAlignment = UITextAlignmentCenter;
//    titleLblView.backgroundColor = [UIColor clearColor];
//    [BackgroundImgSub addSubview:titleLblView];
//    [titleLblView release];
    
    
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.locations = [NSArray arrayWithObjects:
                      [NSNumber numberWithFloat:0.0],
                      [NSNumber numberWithFloat:0.05],
                      [NSNumber numberWithFloat:0.9],
                      [NSNumber numberWithFloat:1.0],
                      nil];
    
    mask.colors = [NSArray arrayWithObjects:
                   ( id)[UIColor clearColor].CGColor,
                   ( id)[UIColor whiteColor].CGColor,
                   ( id)[UIColor whiteColor].CGColor,
                   ( id)[UIColor clearColor].CGColor,
                   nil];
    
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    // Set the frame
    mask.frame = cateringScrollView.bounds;
    
    // vertical direction
    mask.startPoint = CGPointMake(0, 0);
    mask.endPoint = CGPointMake(0, 1);
    
    cateringScrollView.layer.mask = mask;
    
    [CATransaction commit];
    
    
    
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
//    for (UIView* shadowView in [webContainer.scrollView subviews])
//    {
//        if ([shadowView isKindOfClass:[UIImageView class]]) {
//            [shadowView setHidden:YES];
//        }
//    }
//    
//    [webContainer release];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self layoutSubviews];
    
}

-(void)layoutSubviews {
    
    [cateringScrollView layoutSubviews];
    [cateringScrollView.layer.mask removeFromSuperlayer];
    
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.locations = [NSArray arrayWithObjects:
                      [NSNumber numberWithFloat:0.0],
                      [NSNumber numberWithFloat:0.05],
                      [NSNumber numberWithFloat:0.9],
                      [NSNumber numberWithFloat:1.0],
                      nil];
    
    mask.colors = [NSArray arrayWithObjects:
                   ( id)[UIColor clearColor].CGColor,
                   ( id)[UIColor whiteColor].CGColor,
                   ( id)[UIColor whiteColor].CGColor,
                   ( id)[UIColor clearColor].CGColor,
                   nil];
    
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    // Set the frame
    mask.frame = cateringScrollView.bounds;
    
    // vertical direction
    mask.startPoint = CGPointMake(0, 0);
    mask.endPoint = CGPointMake(0, 1);
    
    cateringScrollView.layer.mask = mask;
    
    [CATransaction commit];
    
    
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
