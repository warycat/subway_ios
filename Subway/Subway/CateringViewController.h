//
//  CateringViewController.h
//  Subway
//
//  Created by ludo on 5/13/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateringViewController : UIViewController <UIScrollViewDelegate> {
    
    UIScrollView *cateringScrollView;
    UINavigationController *MenuViewControllerNavigation;
}

@property (assign, nonatomic) UIScrollView *cateringScrollView;
@property (assign, nonatomic) UINavigationController *MenuViewControllerNavigation;

@end
