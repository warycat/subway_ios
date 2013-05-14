//
//  StoreLocatorViewController.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
//#import <MapKit/MKAnnotationView.h>
#import "UIViewController+KNSemiModal.h"
#import "BMapKit.h"


@interface StoreLocatorViewController : UIViewController < CLLocationManagerDelegate, BMKMapViewDelegate, UITableViewDataSource, UITableViewDelegate,BMKSearchDelegate> {
    
    //Weibo Btn
    UIButton *weiboBtn;
    
    //Map
    BMKMapView * myMapView;
    BMKAnnotationView *tempAnnotation;
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
}

//Weibo Btn
@property (retain, nonatomic) UIButton *weiboBtn;

//Map
@property (retain, nonatomic) BMKMapView * myMapView;
@property (retain, nonatomic) BMKAnnotationView *tempAnnotation;
@property (retain, nonatomic) NSMutableArray *allStores;

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
