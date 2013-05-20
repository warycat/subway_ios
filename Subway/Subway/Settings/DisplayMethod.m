//
//  DisplayMethod.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "DisplayMethod.h"


@implementation DisplayMethod

static DisplayMethod * display;
//Get the singleton object
+ (DisplayMethod*) sharedDisplay
{
	if (nil == display)
	{
		display = [[DisplayMethod alloc] init];

	}
	return display;
}


-(void)dealloc{
	
	[super dealloc];
    
}



- (id) init
{
	self = [super init];
	return self;
}



#define marginLeft 5


// ================= GENERATE BACKGROUND =================


- (void)createBackground:(UIView *)myView viewName:(NSString *)myViewName {
    
    
    UIImageView *background;
    
    
    if( IS_4_INCH_SCREEN ) { // Iphone 5
        
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_iphone5@2x"]];

    }else { 
        
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x"]];
        
    }
    
    background.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    background.contentMode = UIViewContentModeScaleToFill;
    [myView addSubview:background];
    [background release];
}



// ================= GENERATE TOP BAR =================


- (void)createTopBar:(UIView *)myView viewName:(NSString *)myViewName leftBtn:(UIButton *)myLeftBtn rightBtn:(UIButton *)myRightBtn otherBtn:(UIButton *)otherBtn {
    
    
    // Top Bar
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0,screenWidth, 50);
    [myView addSubview:topView];
    [topView release];
    
    
    // Logo
    UIImageView *myLogoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_subway@2x"]];
    myLogoImg.frame = CGRectMake((topView.frame.size.width-148)/2, (topView.frame.size.height-39)/2, 148, 39);
    [topView addSubview:myLogoImg];
    [myLogoImg release];
    
    
    UIImage *leftBtnImgON = [UIImage imageNamed:@"btn_yellow_on@2x"];
    UIImage *leftBtnImgOFF = [UIImage imageNamed:@"btn_yellow_off@2x"];
    UIImage *rightBtnImgON = [UIImage imageNamed:@"btn_yellow_on@2x"];
    UIImage *rightBtnImgOFF =  [UIImage imageNamed:@"btn_yellow_off@2x"];
    
        
    if (myLeftBtn != nil) {
        
        [myLeftBtn  setFrame:CGRectMake(marginLeft, (topView.frame.size.height-42)/2, 84, 42)];
        myLeftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        myLeftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [myLeftBtn setBackgroundImage:[leftBtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [myLeftBtn setBackgroundImage:[leftBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        [myLeftBtn setBackgroundImage:[leftBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
        [topView  addSubview:myLeftBtn];
        
        
    }

     if (myRightBtn != nil) {
        
         [myRightBtn  setFrame:CGRectMake(screenWidth - 84 - marginLeft, (topView.frame.size.height-42)/2, 84, 42)];
         myRightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
         myRightBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [myRightBtn setBackgroundImage:[rightBtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
         [myRightBtn setBackgroundImage:[rightBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
         [myRightBtn setBackgroundImage:[rightBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
         [topView  addSubview:myRightBtn];
         
     }
    
    
    if ([myViewName isEqualToString:@"home"]) {
        
        
        if (myLeftBtn != nil) {

            UIImageView *logoweiboImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_weibo@2x"]];
            logoweiboImg.frame = CGRectMake(14.5, (myLeftBtn.frame.size.height-17)/2, 19, 17);
            [myLeftBtn addSubview:logoweiboImg];
            [logoweiboImg release];
            
            CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoweiboImg.frame.size.width + logoweiboImg.frame.origin.x - 2, 1, 48, myLeftBtn.frame.size.height)];
            [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
            weiboLbl.text = NSLocalizedString(@"weibo_login_btn_txt", nil);
            [weiboLbl setDrawOutline:YES];
            [weiboLbl setOutlineSize:strokeSize];
            [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
            weiboLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            weiboLbl.textAlignment = UITextAlignmentLeft;
            weiboLbl.backgroundColor = [UIColor clearColor];
            [myLeftBtn addSubview:weiboLbl];
            [weiboLbl release];
            

        }
        
        UIImageView *logoLocatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_storelocator@2x"]];
        logoLocatorImg.frame = CGRectMake(14, (myRightBtn.frame.size.height-22)/2, 19, 22);
        [myRightBtn addSubview:logoLocatorImg];
        [logoLocatorImg release];
        
        CustomLabel *storeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, 10, 48, 15.0)];
        [storeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        storeLbl.text = NSLocalizedString(@"store_btn_txt", nil);
        [storeLbl setDrawOutline:YES];
        [storeLbl setOutlineSize:strokeSize];
        [storeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        storeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        storeLbl.textAlignment = UITextAlignmentLeft;
        storeLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:storeLbl];
        [storeLbl release];
        
        CustomLabel *locatorLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, storeLbl.frame.size.height + logoLocatorImg.frame.origin.y - 3.5, 48, 11.0)];
        [locatorLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.5]];
        locatorLbl.text = NSLocalizedString(@"locator_btn_txt", nil);
        [locatorLbl setDrawOutline:YES];
        [locatorLbl setOutlineSize:strokeSize];
        [locatorLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        locatorLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        locatorLbl.textAlignment = UITextAlignmentLeft;
        locatorLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:locatorLbl];
        [locatorLbl release];
        
        
        
    }else if ([myViewName isEqualToString:@"storeLocator"]||[myViewName isEqualToString:@"coupon"]) {
        
        if (myLeftBtn != nil) {
            
            UIImageView *logoweiboImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_weibo@2x"]];
            logoweiboImg.frame = CGRectMake(14.5, (myLeftBtn.frame.size.height-17)/2, 19, 17);
            [myLeftBtn addSubview:logoweiboImg];
            [logoweiboImg release];
            
            CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoweiboImg.frame.size.width + logoweiboImg.frame.origin.x - 2, 1, 48, myLeftBtn.frame.size.height)];
            [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
            weiboLbl.text = NSLocalizedString(@"weibo_login_btn_txt", nil);
            [weiboLbl setDrawOutline:YES];
            [weiboLbl setOutlineSize:strokeSize];
            [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
            weiboLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            weiboLbl.textAlignment = UITextAlignmentLeft;
            weiboLbl.backgroundColor = [UIColor clearColor];
            [myLeftBtn addSubview:weiboLbl];
            [weiboLbl release];
            
        }
        
        UIImageView *logoHomeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_home@2x"]];
        logoHomeImg.frame = CGRectMake(14, (myRightBtn.frame.size.height-22)/2 - 1, 19, 22);
        [myRightBtn addSubview:logoHomeImg];
        [logoHomeImg release];
        
        CustomLabel *homeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoHomeImg.frame.size.width + logoHomeImg.frame.origin.x - 1, 1, 48, myRightBtn.frame.size.height)];
        [homeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        homeLbl.text = NSLocalizedString(@"home_btn_txt", nil);
        [homeLbl setDrawOutline:YES];
        [homeLbl setOutlineSize:strokeSize];
        [homeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        homeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        homeLbl.textAlignment = UITextAlignmentLeft;
        homeLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:homeLbl];
        [homeLbl release];
        
        
    }else if ([myViewName isEqualToString:@"menu"]) {
        
        
        UIImageView *logoHomeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_home@2x"]];
        logoHomeImg.frame = CGRectMake(14, (myLeftBtn.frame.size.height-22)/2 - 1, 19, 22);
        [myLeftBtn addSubview:logoHomeImg];
        [logoHomeImg release];
        
        
        CustomLabel *homeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoHomeImg.frame.size.width + logoHomeImg.frame.origin.x - 1, 1, 48, myLeftBtn.frame.size.height)];
        [homeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        homeLbl.text = NSLocalizedString(@"home_btn_txt", nil);
        [homeLbl setDrawOutline:YES];
        [homeLbl setOutlineSize:strokeSize];
        [homeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        homeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        homeLbl.textAlignment = UITextAlignmentLeft;
        homeLbl.backgroundColor = [UIColor clearColor];
        [myLeftBtn addSubview:homeLbl];
        [homeLbl release];
        
        
        UIImageView *logoLocatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_storelocator@2x"]];
        logoLocatorImg.frame = CGRectMake(14, (myRightBtn.frame.size.height-22)/2, 19, 22);
        [myRightBtn addSubview:logoLocatorImg];
        [logoLocatorImg release];
        
        CustomLabel *storeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, 10, 48, 15.0)];
        [storeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        storeLbl.text = NSLocalizedString(@"store_btn_txt", nil);
        [storeLbl setDrawOutline:YES];
        [storeLbl setOutlineSize:strokeSize];
        [storeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        storeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        storeLbl.textAlignment = UITextAlignmentLeft;
        storeLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:storeLbl];
        [storeLbl release];
        
        CustomLabel *locatorLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, storeLbl.frame.size.height + logoLocatorImg.frame.origin.y - 3.5, 48, 11.0)];
        [locatorLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.5]];
        locatorLbl.text = NSLocalizedString(@"locator_btn_txt", nil);
        [locatorLbl setDrawOutline:YES];
        [locatorLbl setOutlineSize:strokeSize];
        [locatorLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        locatorLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        locatorLbl.textAlignment = UITextAlignmentLeft;
        locatorLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:locatorLbl];
        [locatorLbl release];
        
    }else if ([myViewName isEqualToString:@"order"] || [myViewName isEqualToString:@"catering"]) {
                    
        UIImageView *logoHomeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_back@2x"]];
        logoHomeImg.frame = CGRectMake(15, (myLeftBtn.frame.size.height-16)/2, 12, 15);
        [myLeftBtn addSubview:logoHomeImg];
        [logoHomeImg release];
        
        
        CustomLabel *homeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoHomeImg.frame.size.width + logoHomeImg.frame.origin.x + 2, 0, 48, myLeftBtn.frame.size.height)];
        [homeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        homeLbl.text = NSLocalizedString(@"back_btn_txt", nil);
        [homeLbl setDrawOutline:YES];
        [homeLbl setOutlineSize:strokeSize];
        [homeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        homeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        homeLbl.textAlignment = UITextAlignmentLeft;
        homeLbl.backgroundColor = [UIColor clearColor];
        [myLeftBtn addSubview:homeLbl];
        [homeLbl release];
            
        
        UIImageView *logoLocatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_storelocator@2x"]];
        logoLocatorImg.frame = CGRectMake(14, (myRightBtn.frame.size.height-22)/2, 19, 22);
        [myRightBtn addSubview:logoLocatorImg];
        [logoLocatorImg release];
        
        CustomLabel *storeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, 10, 48, 15.0)];
        [storeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        storeLbl.text = NSLocalizedString(@"store_btn_txt", nil);
        [storeLbl setDrawOutline:YES];
        [storeLbl setOutlineSize:strokeSize];
        [storeLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        storeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        storeLbl.textAlignment = UITextAlignmentLeft;
        storeLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:storeLbl];
        [storeLbl release];
        
        CustomLabel *locatorLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocatorImg.frame.size.width + logoLocatorImg.frame.origin.x - 2, storeLbl.frame.size.height + logoLocatorImg.frame.origin.y - 3.5, 48, 11.0)];
        [locatorLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.5]];
        locatorLbl.text = NSLocalizedString(@"locator_btn_txt", nil);
        [locatorLbl setDrawOutline:YES];
        [locatorLbl setOutlineSize:strokeSize];
        [locatorLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        locatorLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        locatorLbl.textAlignment = UITextAlignmentLeft;
        locatorLbl.backgroundColor = [UIColor clearColor];
        [myRightBtn addSubview:locatorLbl];
        [locatorLbl release];
        
    }


    
    
}


// ================= GENERATE BOTTOM BAR =================


- (void)createBottomBar:(UIView *)myView viewName:(NSString *)myViewName myBtn1:(UIButton *)myBtn1 myBtn2:(UIButton *)myBtn2 myBtn3:(UIButton *)myBtn3 {
    
    
    // Bottom Bar
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, screenHeight - 45,screenWidth, 45);
    bottomView.clipsToBounds = NO;
    [myView addSubview:bottomView];
    [bottomView release];
    
    UIImage *leftBtnImgON = [UIImage imageNamed:@"home_footer_btn_menu_on@2x"];
    UIImage *leftBtnImgOFF = [UIImage imageNamed:@"home_footer_btn_menu_off@2x"];
    UIImage *rightBtnImgON = [UIImage imageNamed:@"home_footer_btn_coupons_on@2x"];
    UIImage *rightBtnImgOFF = [UIImage imageNamed:@"home_footer_btn_coupons_off@2x"];
    
    
     if (myBtn1 != nil) {
         
         [myBtn1  setFrame:CGRectMake(0, 0, 220, 45)];
         
         
         UIImageView *bt1IconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_footer_icon@2x"]];
         [myBtn1 addSubview:bt1IconImg];
         [bt1IconImg release];
         
         CustomLabel *btn1Lbl = [[CustomLabel alloc] init];
         [btn1Lbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
         [btn1Lbl setDrawOutline:YES];
         [btn1Lbl setOutlineSize:strokeSize];
         [btn1Lbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
         btn1Lbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
         btn1Lbl.textAlignment = UITextAlignmentLeft;
         btn1Lbl.backgroundColor = [UIColor clearColor];
         [myBtn1 addSubview:btn1Lbl];
         [btn1Lbl release];
         
         
         if ([myViewName isEqualToString:@"storeLocator"]) {
             
             [myBtn1  setFrame:CGRectMake(0, 0, screenWidth, 45)];
             leftBtnImgON = [UIImage imageNamed:@"store_footer_btn_on@2x"];
             leftBtnImgOFF = [UIImage imageNamed:@"store_footer_btn_off@2x"];
             
             bt1IconImg.frame = CGRectMake(110, 18, 17, 17);
             btn1Lbl.frame = CGRectMake(bt1IconImg.frame.size.width + bt1IconImg.frame.origin.x + 1, 5.5,  myBtn1.frame.size.width, myBtn1.frame.size.height);
             btn1Lbl.text = NSLocalizedString(@"storeList_btn_txt", nil);
             
         }else if ([myViewName isEqualToString:@"menu"]) {
             
             [bt1IconImg removeFromSuperview];
             
             [myBtn1  setFrame:CGRectMake(0, 0, 110, 45)];
             leftBtnImgON = [UIImage imageNamed:@"footer_catering_on@2x"];
             leftBtnImgOFF = [UIImage imageNamed:@"footer_catering_off@2x"];
             
             btn1Lbl.textAlignment = UITextAlignmentCenter;
             btn1Lbl.frame = CGRectMake(0, 5.5,  110, myBtn1.frame.size.height);
             btn1Lbl.text = NSLocalizedString(@"catering_btn_txt", nil);
             
         }else if ([myViewName isEqualToString:@"home"] || [myViewName isEqualToString:@"coupon"]) {
             
             bt1IconImg.frame = CGRectMake(13, 18, 17, 17);
             btn1Lbl.frame = CGRectMake(bt1IconImg.frame.size.width + bt1IconImg.frame.origin.x + 1, 5.5,  myBtn1.frame.size.width, myBtn1.frame.size.height);
             btn1Lbl.text = NSLocalizedString(@"discover_menu_btn_txt", nil);
             
         }
         
         
         myBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
         myBtn1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [myBtn1 setBackgroundImage:[leftBtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
         [myBtn1 setBackgroundImage:[leftBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
         [myBtn1 setBackgroundImage:[leftBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
         [bottomView  addSubview:myBtn1];
         
         
     }
    
    
    if (myBtn2 != nil) {
        
        [myBtn2  setFrame:CGRectMake(screenWidth - 100, 0, 100, 45)];
        
        
        UIImageView *bt2IconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_footer_icon@2x"]];
        [myBtn2 addSubview:bt2IconImg];
        [bt2IconImg release];
        
        CustomLabel *btn2Lbl = [[CustomLabel alloc] init];
        [btn2Lbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:15.5]];
        [btn2Lbl setDrawOutline:YES];
        [btn2Lbl setOutlineSize:strokeSize];
        [btn2Lbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        btn2Lbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        btn2Lbl.textAlignment = UITextAlignmentLeft;
        btn2Lbl.backgroundColor = [UIColor clearColor];
        [myBtn2 addSubview:btn2Lbl];
        [btn2Lbl release];
        
        
        if ([myViewName isEqualToString:@"menu"]) {
            
            [bt2IconImg removeFromSuperview];
            
            [myBtn2  setFrame:CGRectMake(myBtn1.frame.size.width, 0, 110, 45)];
            rightBtnImgON = [UIImage imageNamed:@"footer_options_on@2x"];
            rightBtnImgOFF = [UIImage imageNamed:@"footer_options_off@2x"];
            
            btn2Lbl.textAlignment = UITextAlignmentCenter;
            btn2Lbl.frame = CGRectMake(0, 5.5,  110, myBtn2.frame.size.height);
            btn2Lbl.text = NSLocalizedString(@"options_btn_txt", nil);
            
        }else if ([myViewName isEqualToString:@"home"]) {
            
            bt2IconImg.frame = CGRectMake(10, 18, 17, 17);
            btn2Lbl.frame = CGRectMake(bt2IconImg.frame.size.width + bt2IconImg.frame.origin.x + 1, 5.5,  myBtn2.frame.size.width, myBtn2.frame.size.height);
            btn2Lbl.text = NSLocalizedString(@"coupon_btn_txt", nil);
            
            
        }else if ([myViewName isEqualToString:@"coupon"]) {
            
            bt2IconImg.image = [UIImage imageNamed:@"logo_storelocator@2x"];
            bt2IconImg.frame = CGRectMake(19, 17, 19, 22);
            
            [btn2Lbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
            btn2Lbl.frame = CGRectMake(bt2IconImg.frame.size.width + bt2IconImg.frame.origin.x - 2, 16.0,  48, 15.0);
            btn2Lbl.text = NSLocalizedString(@"store_btn_txt", nil);
            
            
            CustomLabel *locatorLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(bt2IconImg.frame.size.width + bt2IconImg.frame.origin.x - 2, btn2Lbl.frame.size.height + bt2IconImg.frame.origin.y - 3.5, 48, 11.0)];
            [locatorLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.5]];
            locatorLbl.text = NSLocalizedString(@"locator_btn_txt", nil);
            [locatorLbl setDrawOutline:YES];
            [locatorLbl setOutlineSize:strokeSize];
            [locatorLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
            locatorLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            locatorLbl.textAlignment = UITextAlignmentLeft;
            locatorLbl.backgroundColor = [UIColor clearColor];
            [myBtn2 addSubview:locatorLbl];
            [locatorLbl release];

            
            
        }
        
        
        myBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        myBtn2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [myBtn2 setBackgroundImage:[rightBtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [myBtn2 setBackgroundImage:[rightBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        [myBtn2 setBackgroundImage:[rightBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
        [bottomView  addSubview:myBtn2];
        
        
    }
    
    if (myBtn3 != nil) {
        
        UIImage *otherBtnImgON = [UIImage imageNamed:@"footer_order_on@2x"];
        UIImage *otherBtnImgOFF = [UIImage imageNamed:@"footer_order_off@2x"];
        
        [myBtn3  setFrame:CGRectMake(screenWidth - 100, 0, 100, 45)];  
        myBtn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        myBtn3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [myBtn3 setBackgroundImage:[otherBtnImgOFF stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [myBtn3 setBackgroundImage:[otherBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        [myBtn3 setBackgroundImage:[otherBtnImgON stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
        [bottomView  addSubview:myBtn3];
        
        
        CustomLabel *btn3LblTop = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 15, myBtn3.frame.size.width, 13.0)];
        [btn3LblTop setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.5]];
        btn3LblTop.text = NSLocalizedString(@"howTo_btn_txt", nil);
        [btn3LblTop setDrawOutline:YES];
        [btn3LblTop setOutlineSize:strokeSize];
        [btn3LblTop setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        btn3LblTop.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        btn3LblTop.textAlignment = UITextAlignmentCenter;
        btn3LblTop.backgroundColor = [UIColor clearColor];
        [myBtn3 addSubview:btn3LblTop];
        [btn3LblTop release];
        
        CustomLabel *btn3LblBottom = [[CustomLabel alloc] initWithFrame:CGRectMake(0, btn3LblTop.frame.size.height + btn3LblTop.frame.origin.y - 3.5, myBtn3.frame.size.width, 15.0)];
        [btn3LblBottom setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
        btn3LblBottom.text = NSLocalizedString(@"order_btn_txt", nil);
        [btn3LblBottom setDrawOutline:YES];
        [btn3LblBottom setOutlineSize:strokeSize];
        [btn3LblBottom setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
        btn3LblBottom.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
        btn3LblBottom.textAlignment = UITextAlignmentCenter;
        btn3LblBottom.backgroundColor = [UIColor clearColor];
        [myBtn3 addSubview:btn3LblBottom];
        [btn3LblBottom release];
        
        

    }
    
    
    if ([myViewName isEqualToString:@"home"]) {
        
        bottomView.frame = CGRectMake(0, screenHeight,screenWidth, 45);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        bottomView.frame = CGRectMake(0, screenHeight - 45,screenWidth, 45);
        [UIView commitAnimations];
        
    }
    
    
}



@end
