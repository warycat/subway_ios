//
//  MenuViewController.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"

@interface MenuViewController : UIViewController <UIScrollViewDelegate> {
    
    NSMutableArray *menuArray;
    NSMutableArray *currentProductsArray;
    
    UIView *subOfTheDayContainer;
    UIView *subOfTheDayView;
    UIView *subOfTheDayViewInfo;
    BOOL viewIsFlipped;
    UIView *productsView;
    UIImageView *menuTempHolderImg;
    
    //Product SubView
    UIScrollView *productsScroll;
    BOOL firstTimeProductsViewAppear;
    DDPageControl *pageControl;
    
    UIButton *weiboShareBtn;
    
    // PRODUCTS BTN INFO
    UIButton *healthShareBtn;
    UIButton *tastyShareBtn;
    UIButton *energyShareBtn;
    UIButton *buildShareBtn;
    CustomLabel *healthLbl;
    CustomLabel *tastyLbl;
    CustomLabel *energyLbl;
    CustomLabel *buildLbl;
    
    // OPTIONS
    BOOL hasOptions;
    UIButton *optionsProductBtn;
    NSString *optionsDesc;
    
    
    UIView *popupInfo;
    int tempProdFact;
    CustomLabel *factTitleLbl;
    UIImageView *factIconImgForPopup;
    CustomLabel *factDescriptionLbl;
    
    BOOL fromSubOfTheDay;
    BOOL fromSubOfTheDayAllWeek;
    
    int productId;
    int myCurrentCatID;
    
}
    

@property (nonatomic, strong) UIScrollView *menuScroll;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *currentProductsArray;

@property (nonatomic, strong) UIView *subOfTheDayContainer;
@property (nonatomic, strong) UIView *subOfTheDayView;
@property (nonatomic, strong) UIView *subOfTheDayViewInfo;
@property (nonatomic, strong) UIView *productsView;
@property (nonatomic, strong) UIImageView *menuTempHolderImg;

//Product SubView
@property (nonatomic, strong) UIScrollView *productsScroll;
@property (nonatomic, strong) DDPageControl *pageControl;


@property (nonatomic, strong) UIButton *weiboShareBtn;
@property (nonatomic, strong) UIButton *healthShareBtn;
@property (nonatomic, strong) UIButton *tastyShareBtn;
@property (nonatomic, strong) UIButton *energyShareBtn;
@property (nonatomic, strong) UIButton *buildShareBtn;
@property (nonatomic, strong)  CustomLabel *healthLbl;
@property (nonatomic, strong)  CustomLabel *tastyLbl;
@property (nonatomic, strong)  CustomLabel *energyLbl;
@property (nonatomic, strong)  CustomLabel *buildLbl;

// OPTIONS
@property (nonatomic, strong) UIButton *optionsProductBtn;
@property (nonatomic, strong) NSString *optionsDesc;

@property (nonatomic, strong) UIView *popupInfo;
@property (nonatomic, strong) CustomLabel *factTitleLbl;
@property (nonatomic, strong) UIImageView *factIconImgForPopup;
@property (nonatomic, strong) CustomLabel *factDescriptionLbl;

@property (assign, nonatomic) BOOL fromSubOfTheDay;
@property (assign, nonatomic) BOOL fromSubOfTheDayAllWeek;
@property (assign, nonatomic) int productId;
@property (assign, nonatomic) int myCurrentCatID;

-(void)LaunchProduct:(int)idProduct;


@end
