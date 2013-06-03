//
//  CouponViewController.h
//  Subway
//
//  Created by Larry Fantasy on 5/17/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"

@interface CouponViewController : UIViewController < UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    
    BOOL firstLoading;
    BOOL shareCouponAfterLogIn;
    
}

@end
