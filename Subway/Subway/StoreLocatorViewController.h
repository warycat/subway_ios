//
//  StoreLocatorViewController.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "UIViewController+KNSemiModal.h"


@protocol StoreLocatorDelegate
@optional
-(void)backToHomeView;
@end

@interface StoreLocatorViewController : UIViewController < CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate, UIAlertViewDelegate> {
    
    UINavigationController *MenuViewControllerNavigation;
    
    //Weibo Btn
    UIButton *weiboBtn;
    
    //Map
    MKMapView * myMapView;
    MKAnnotationView *tempAnnotation;
    NSMutableArray *allStores;
    BOOL firstLoad;

    
    //Detail
    UIView *detailsView;
    CustomLabel *adressdetailsLbl;
    CustomLabel *adressdetailsLblSecondLine;
    CustomLabel *distancedetailsLbl;
    UIButton *phoneDetailsBtn;
    CustomLabel *phoneDetailsLbl;
    UIButton *mailDetailsBtn;
    
    //TableView
    UITableView *myTableView;
    
    //SemiModal
    UIView *bottomView;
    
    //From Catering / How To Order / Menu View
    BOOL fromOtherView;
    BOOL firstLoading;

    id<StoreLocatorDelegate> _delegate;
}

@property (retain, nonatomic)UINavigationController *MenuViewControllerNavigation;

@property (nonatomic, assign) id<StoreLocatorDelegate> delegate;


//Weibo Btn
@property (retain, nonatomic) UIButton *weiboBtn;

//Map
@property (retain, nonatomic) MKMapView * myMapView;
@property (retain, nonatomic) MKAnnotationView *tempAnnotation;
@property (retain, nonatomic) NSArray *allStores;

//Detail
@property (retain, nonatomic) UIView *detailsView;
@property (retain, nonatomic) CustomLabel *cityLabel;
@property (retain, nonatomic) CustomLabel *adressdetailsLbl;
@property (retain, nonatomic) CustomLabel *adressdetailsLblSecondLine;
@property (retain, nonatomic) CustomLabel *distancedetailsLbl;
@property (retain, nonatomic) UIButton *phoneDetailsBtn;
@property (retain, nonatomic) CustomLabel *phoneDetailsLbl;
@property (retain, nonatomic) UIButton *mailDetailsBtn;

//TableView
@property (retain, nonatomic) UITableView *myTableView;

//SemiModal
@property (retain, nonatomic) UIView *bottomView;

@property (retain, nonatomic) NSDictionary *currentStore;

//From Catering or How To Order
@property (nonatomic, assign) BOOL fromOtherView;

@end
