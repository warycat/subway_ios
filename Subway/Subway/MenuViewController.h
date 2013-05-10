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
    
    UIView *popupInfo;
    int tempProdFact;
    CustomLabel *factDescriptionLbl;
    
}
    

@property (nonatomic, strong) UIScrollView *menuScroll;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *currentProductsArray;

@property (nonatomic, strong) UIView *subOfTheDayContainer;
@property (nonatomic, strong) UIView *subOfTheDayView;
@property (nonatomic, strong) UIView *subOfTheDayViewInfo;
@property (nonatomic, strong) UIView *productsView;

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

@property (nonatomic, strong) UIView *popupInfo;
@property (nonatomic, strong) CustomLabel *factDescriptionLbl;

@end
