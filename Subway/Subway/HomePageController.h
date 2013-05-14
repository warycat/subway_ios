//
//  HomePageController.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface HomePageController : UIViewController {
    
    //Weibo Btn
    UIButton *weiboBtn;
    
    UIView *subOfTheDayContainer;
    UIView *subOfTheDayView;
    UIView *subOfTheDayViewInfo;
    BOOL viewIsFlipped;
    
    
}
//Weibo Btn
@property (nonatomic, strong) UIButton *weiboBtn;

@property (nonatomic, strong) UIView *subOfTheDayContainer;
@property (nonatomic, strong) UIView *subOfTheDayView;
@property (nonatomic, strong) UIView *subOfTheDayViewInfo;


@end
