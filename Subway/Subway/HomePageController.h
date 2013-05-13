//
//  HomePageController.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageController : UIViewController {
    
    UIView *subOfTheDayContainer;
    UIView *subOfTheDayView;
    UIView *subOfTheDayViewInfo;
    BOOL viewIsFlipped;
    
    
}

@property (nonatomic, strong) UIView *subOfTheDayContainer;
@property (nonatomic, strong) UIView *subOfTheDayView;
@property (nonatomic, strong) UIView *subOfTheDayViewInfo;


@end
