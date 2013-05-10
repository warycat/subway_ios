//
//  HowToOrderViewController.h
//  Subway
//
//  Created by ludo on 5/10/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"

@interface HowToOrderViewController : UIViewController <UIScrollViewDelegate> {
    
    UIScrollView *orderScrollView;
    int myNumberOfSlides;
    DDPageControl *pageControl;
    
}

@property (assign, nonatomic) UIScrollView *orderScrollView;
@property (assign, nonatomic) DDPageControl *pageControl;

@end
