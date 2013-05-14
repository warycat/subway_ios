//
//  StoreLocatorViewController.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "StoreLocatorViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MKMapView+ZoomLevel.h"
#import "ViewMapAnnotationView.h"
#import "SVPulsingAnnotationView.h"
#import "MapPlace.h"
#import <MapKit/MapKit.h>
#import <Social/Social.h>
#import "BlockSinaWeiboRequest.h"
#import <Accounts/Accounts.h>


@interface StoreLocatorViewController ()
@property (nonatomic, strong)BMKSearch *search;
@end

@implementation StoreLocatorViewController
@synthesize myMapView, tempAnnotation;
@synthesize detailsView, bottomView;
@synthesize allStores;
@synthesize myTableView;
@synthesize adressdetailsLbl, distancedetailsLbl, adressdetailsLblSecondLine;
@synthesize phoneDetailsBtn, phoneDetailsLbl, mailDetailsBtn;

-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.search = [[BMKSearch alloc]init];
    self.search.delegate = self;

    tempAnnotation = nil;
    
    
    // ----------------- GENERATE BACKGROUND
    [displayMethod createBackground:self.view viewName:@""];
    
    
    // -----------------
    // ----------------- GENERATE TOP DETAIL VIEW
    // -----------------
    
    detailsView = [[UIView alloc] init];
    detailsView.frame = CGRectMake(15, 70 ,screenWidth-30, 165);
    detailsView.backgroundColor= [UIColor clearColor];
    [self.view addSubview:detailsView];
    
    
    adressdetailsLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 40, detailsView.frame.size.width, 20)];
    [adressdetailsLbl setFont:[UIFont fontWithName:APEX_MEDIUM size:14.0]];
    adressdetailsLbl.text = @"";
    [adressdetailsLbl setDrawOutline:NO];
    adressdetailsLbl.numberOfLines = 0;
    adressdetailsLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    adressdetailsLbl.textAlignment = UITextAlignmentLeft;
    adressdetailsLbl.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:adressdetailsLbl];
    
    adressdetailsLblSecondLine = [[CustomLabel alloc] initWithFrame:CGRectMake(0, adressdetailsLbl.frame.size.height + adressdetailsLbl.frame.origin.y, detailsView.frame.size.width, 20)];
    [adressdetailsLblSecondLine setFont:[UIFont fontWithName:APEX_MEDIUM size:14.0]];
    adressdetailsLblSecondLine.text = @"";
    [adressdetailsLblSecondLine setDrawOutline:NO];
    adressdetailsLblSecondLine.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    adressdetailsLblSecondLine.textAlignment = UITextAlignmentLeft;
    adressdetailsLblSecondLine.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:adressdetailsLblSecondLine];
    
    distancedetailsLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, adressdetailsLblSecondLine.frame.size.height + adressdetailsLblSecondLine.frame.origin.y + 5, detailsView.frame.size.width, 20)];
    [distancedetailsLbl setFont:[UIFont fontWithName:APEX_MEDIUM size:12.0]];
    distancedetailsLbl.text = @"";
    [distancedetailsLbl setDrawOutline:NO];
    distancedetailsLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    distancedetailsLbl.textAlignment = UITextAlignmentLeft;
    distancedetailsLbl.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:distancedetailsLbl];
    
    
    UIImage *myLocationImageOn = [[UIImage imageNamed:@"btn_red_on.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    UIImage *myLocationImageOff = [[UIImage imageNamed:@"btn_red_off.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    
    // PHONE
    
    phoneDetailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneDetailsBtn.frame = CGRectMake(-5, detailsView.frame.size.height - 40, 150, 40);
    phoneDetailsBtn.userInteractionEnabled = YES;
    [phoneDetailsBtn addTarget:self action:@selector(callSub:) forControlEvents:UIControlEventTouchUpInside];
    [phoneDetailsBtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [phoneDetailsBtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [phoneDetailsBtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [detailsView addSubview:phoneDetailsBtn];
    
    
    UIImageView *logoPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_phone@2x"]];
    logoPhone.frame = CGRectMake(12, (phoneDetailsBtn.frame.size.height-25)/2, 25, 25);
    [phoneDetailsBtn addSubview:logoPhone];
    [logoPhone release];
    
    
    phoneDetailsLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoPhone.frame.size.width + logoPhone.frame.origin.x, 3, 120, phoneDetailsBtn.frame.size.height)];
    [phoneDetailsLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:13.0]];
    phoneDetailsLbl.text = @"";
    [phoneDetailsLbl setDrawOutline:YES];
    [phoneDetailsLbl setOutlineSize:strokeSize];
    [phoneDetailsLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    phoneDetailsLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    phoneDetailsLbl.textAlignment = UITextAlignmentLeft;
    phoneDetailsLbl.backgroundColor = [UIColor clearColor];
    [phoneDetailsBtn addSubview:phoneDetailsLbl];
    
    
    // MAIL
    
    mailDetailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mailDetailsBtn.frame = CGRectMake(detailsView.frame.size.width - 94, detailsView.frame.size.height - 40, 100, 40);
    mailDetailsBtn.userInteractionEnabled = YES;
    [mailDetailsBtn setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [mailDetailsBtn setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [mailDetailsBtn setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    //[mailDetailsBtn addTarget:self action:@selector(moveToUserLocation) forControlEvents:UIControlEventTouchUpInside];
    [detailsView addSubview:mailDetailsBtn];
    
    
    UIImageView *logoMail = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_email@2x"]];
    logoMail.frame = CGRectMake(15, (phoneDetailsBtn.frame.size.height-25)/2, 25, 25);
    [mailDetailsBtn addSubview:logoMail];
    [logoMail release];
    
    
    CustomLabel *mailDetailsLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoMail.frame.size.width + logoMail.frame.origin.x +2, 3, 120, mailDetailsBtn.frame.size.height)];
    [mailDetailsLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:13.0]];
    mailDetailsLbl.text = NSLocalizedString(@"email_btn_txt", nil);
    [mailDetailsLbl setDrawOutline:YES];
    [mailDetailsLbl setOutlineSize:strokeSize];
    [mailDetailsLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    mailDetailsLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    mailDetailsLbl.textAlignment = UITextAlignmentLeft;
    mailDetailsLbl.backgroundColor = [UIColor clearColor];
    [mailDetailsBtn addSubview:mailDetailsLbl];
    
    
    
    // ----------------- GENERATE TOP BAR
    
    
    UIButton *homeBtn =  [[UIButton alloc] init];
    
    if ([settingMethod weiboIsConnected]) {
        
        [displayMethod createTopBar:self.view viewName:@"storeLocator" leftBtn:nil rightBtn:homeBtn otherBtn:nil];
        
    }else {
        
        UIButton *weiboBtn =  [[UIButton alloc] init];
        
        [displayMethod createTopBar:self.view viewName:@"storeLocator" leftBtn:weiboBtn rightBtn:homeBtn otherBtn:nil];
        
        [weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
        [weiboBtn release];
        
    }

    [homeBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn release];
    
    
    
    // ----------------- GENERATE BOTTOM BAR

    UIButton *storeListBtn =  [[UIButton alloc] init];
    
    [displayMethod createBottomBar:self.view viewName:@"storeLocator" myBtn1:storeListBtn myBtn2:nil myBtn3:nil];
    
    [storeListBtn addTarget:self action:@selector(storeListAction) forControlEvents:UIControlEventTouchDown];
    [storeListBtn release];
    
    
    self.myMapView = [[[BMKMapView alloc] initWithFrame:CGRectMake(15, 70, screenWidth-30, screenHeight - 120)] autorelease];
    [self.view addSubview:self.myMapView];
    self.myMapView.showsUserLocation = YES;
    self.myMapView.layer.cornerRadius = 5;
    self.myMapView.layer.masksToBounds = YES;
    self.myMapView.delegate = self;
    
    
    // --------------- show my location
    
    UIButton *actualiserbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    actualiserbutton.frame = CGRectMake(self.myMapView.frame.size.width - 130, 0, 130, 40);
    actualiserbutton.userInteractionEnabled = YES;
    [actualiserbutton setBackgroundImage:myLocationImageOn forState:UIControlStateNormal];
    [actualiserbutton setBackgroundImage:myLocationImageOff forState:UIControlStateSelected];
    [actualiserbutton setBackgroundImage:myLocationImageOff forState:UIControlStateHighlighted];
    [actualiserbutton addTarget:self action:@selector(moveToUserLocation) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *logoLocator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_aroundme@2x"]];
    logoLocator.frame = CGRectMake(15, (actualiserbutton.frame.size.height-25)/2, 25, 25);
    [actualiserbutton addSubview:logoLocator];
    [logoLocator release];
    
    
    CustomLabel *homeLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(logoLocator.frame.size.width + logoLocator.frame.origin.x - 1, 3, 90, actualiserbutton.frame.size.height)];
    [homeLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:13.0]];
    homeLbl.text = NSLocalizedString(@"aroundMe_btn_txt", nil);
    [homeLbl setDrawOutline:YES];
    [homeLbl setOutlineSize:strokeSize];
    [homeLbl setOutlineColor:[UIColorCov colorWithHexString:RED_STROKE]];
    homeLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    homeLbl.textAlignment = UITextAlignmentLeft;
    homeLbl.backgroundColor = [UIColor clearColor];
    [actualiserbutton addSubview:homeLbl];
    [homeLbl release];
    
    
    [self.myMapView addSubview:actualiserbutton];
    
    
    
    
    
    // -----------------
    // ----------------- GENERATE BOTTOM VIEW
    // -----------------
    
    bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, screenHeight - 250,screenWidth, 250);
    bottomView.layer.cornerRadius = 5;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor= [UIColor whiteColor];
    
    
    
    // --------------- TABLEVIEW
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, bottomView.frame.size.height) style:UITableViewStylePlain];
    [myTableView setClipsToBounds:YES];
	[myTableView setDataSource:self];
    [myTableView setDelegate:self];
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.showsHorizontalScrollIndicator = NO;
    myTableView.scrollEnabled = YES;
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    myTableView.opaque = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.backgroundView = nil;
    myTableView.backgroundColor = [UIColor clearColor];
	[bottomView addSubview:myTableView];
    
    
    if ([settingMethod connectedToNetwork]) {
        [self performSelectorInBackground:@selector(loadData) withObject:nil];
    }else {
        
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(31, 121);
        BMKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:BMKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
        [self.myMapView  setRegion:adjustedRegion animated:YES];
        
        
    }

    CustomLabel *cityLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, -20, 300, 100)];
    cityLabel.text = @"SUBWAY,Shanghai";
    cityLabel.drawOutline = YES;
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.outlineColor = [UIColorCov colorWithHexString:GREEN_STROKE];
    cityLabel.font = [UIFont fontWithName:APEX_BOLD size:20.0];
    //CustomLabel *nbLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 2, roundNumberImage.frame.size.width, roundNumberImage.frame.size.height)];
    [cityLabel setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:21.0]];
    //cityLabel.text = [NSString stringWithFormat:@"%i", i+1];
    [cityLabel setDrawOutline:YES];
    [cityLabel setOutlineSize:3];
    [cityLabel setOutlineColor:[UIColorCov colorWithHexString:GREEN_TEXT]];
    cityLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
//    cityLabel.textAlignment = UITextAlignmentCenter;
    cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel = cityLabel;
    [detailsView addSubview:cityLabel];
    //[self.view sendSubviewToBack:cityLabel];
    
    UIButton *weiboShareBtn =  [[UIButton alloc] init];
    [weiboShareBtn  setFrame:CGRectMake(250,25 , 43, 43)];
    weiboShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    weiboShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [weiboShareBtn setImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
    [weiboShareBtn addTarget:self action:@selector(shareStore:) forControlEvents:UIControlEventTouchDown];
    CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(245, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    weiboLbl.text = @"share on";
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GREEN_STROKE]];
    weiboLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    weiboLbl.textAlignment = UITextAlignmentCenter;
    weiboLbl.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:weiboShareBtn];
    [detailsView addSubview:weiboLbl];
}

- (void)shareStore:(id)sender
{
    if ([settingMethod weiboIsConnected]) {
        [self sendToSina];
    }else{
        [BlockSinaWeibo loginWithHandler:^{
            [self sendToSina];
        }];
    }
}

- (void)sendToSina
{
    NSString *local = [settingMethod getUserLanguage];
    NSString *sid = [self.currentStore objectForKey:@"sid"];
    NSString *weiboid = [BlockSinaWeibo sharedClient].sinaWeibo.userID;
    NSLog(@"%@%@%@",local,sid,weiboid);
    [settingMethod getShareStoreMessageWith:@{@"locale":local,@"sid":sid,@"weiboid":weiboid} onSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@",responseDict);
        NSDictionary *data = [responseDict objectForKey:@"data"];
        NSString *baidumap = [data objectForKey:@"baidumap"];
        NSString *sharecontent = [data objectForKey:@"sharecontent"];
        NSString *image = [data objectForKey:@"image"];
        NSString *text = [NSString stringWithFormat:@"%@ %@",baidumap, sharecontent];
        [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload_url_text.json" withParams:@{@"status":text,@"url":image} withHandler:^(id responseDict) {
            [[[UIAlertView alloc]initWithTitle:@"Shared" message:sharecontent delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
        }];
    }];
    
}

-(void)callSub:(id)sender {
    
    int number= [sender tag];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [[allStores objectAtIndex:number] objectForKey:@"phone"]]]];

    
}



-(void)loadData {
    
//    CLLocationCoordinate2D location = myMapView.userLocation.location.coordinate;
//    NSString *latitude = [NSString stringWithFormat:@"%f",location.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",location.longitude];
//    NSMutableArray *storesFromServer = [storeMethod getAllStores:latitude longitude:longitude radius:@"4"];
    NSMutableArray *storesFromServer = [storeMethod getAllStores:settingMethod.latitude longitude:settingMethod.longitude radius:@"4"];
    allStores = [[NSMutableArray alloc] init];
    
    if (storesFromServer != nil) {
        
        for (int i = 0; i < [storesFromServer count]; i++) {
            
            NSMutableDictionary *myDico = [[NSMutableDictionary alloc] initWithDictionary:[storesFromServer objectAtIndex:i]];
            NSString *distance = [settingMethod getDistanceFromMyLocation:[myDico objectForKey:@"latitude"] placeLongitude:[myDico objectForKey:@"longitude"]];
            [myDico setObject:distance forKey:@"distance"];
            [allStores addObject:myDico];
            
        }
        [allStores retain];
        
        NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        [allStores sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (![settingMethod.latitude isEqualToString:@""]) {
                    
                    if (!firstLoad) {
                        [self moveToUserLocation];
                    }
                
                }
                
                for (int i = 0; i < [allStores count]; i++) {
                    
                        MapPlace * newMapAnnotation = [[MapPlace alloc] init];
                        CLLocationCoordinate2D tempCoordinate;
                        tempCoordinate.latitude  = [[[allStores objectAtIndex:i] objectForKey:@"latitude"] floatValue];
                        tempCoordinate.longitude = [[[allStores objectAtIndex:i] objectForKey:@"longitude"] floatValue]; 
                        newMapAnnotation.coordinate = tempCoordinate;
                        newMapAnnotation.title = @"-";
                    newMapAnnotation.address = [[allStores objectAtIndex:i] objectForKey:@"address"];
                        newMapAnnotation.idPlace = [NSString stringWithFormat:@"%i", i+1];
                        [myMapView addAnnotation:newMapAnnotation];
                        [newMapAnnotation release];
                        
                }
                
                [self.myTableView reloadData];
                
            });
        
    }else {
        
         dispatch_async(dispatch_get_main_queue(), ^{
             
             [settingMethod HUDMessage:@"kNoStoresAround" typeOfIcon:nil delay:2.0 offset:CGPointMake(0, 0)];
             
             CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(31.236856, 110.447227);
             BMKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:BMKCoordinateRegionMakeWithDistance(startCoord, 5000000, 150)];
             [self.myMapView  setRegion:adjustedRegion animated:YES];
             
        });
    }
    
}

-(void)moveToUserLocation {
    
    firstLoad = YES;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self.myMapView setFrame:CGRectMake(15, 70, screenWidth-30, screenHeight - 120)];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
    CLLocationCoordinate2D tempCoordinate;
    tempCoordinate.latitude  = [settingMethod.latitude floatValue];
    tempCoordinate.longitude = [settingMethod.longitude floatValue];
    [self zoomTo:tempCoordinate];
    myMapView.showsUserLocation = YES;
    
}

-(void)moveToStoreLocation:(id)myStore {
    
    
    CLLocationCoordinate2D tempCoordinate;
    tempCoordinate.latitude  = [[myStore objectForKey:@"latitude"] floatValue];
    tempCoordinate.longitude = [[myStore objectForKey:@"longitude"] floatValue];
    [self zoomTo:tempCoordinate];
    
    
}


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- TOP PART
#pragma mark ---------------
#pragma mark ---------------

-(void)weiboAction {
    [BlockSinaWeibo loginWithHandler:^{
        [[[UIAlertView alloc]initWithTitle:@"login" message:@"you have login" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
    }];

}

-(void)backAction { [self.navigationController popViewControllerAnimated:YES]; }


#pragma mark ---------------
#pragma mark ---------------
#pragma mark --------------- BOTTOM PART
#pragma mark ---------------
#pragma mark ---------------

-(void)storeListAction {
    
    if ([settingMethod connectedToNetwork] && [allStores count] > 0) {
        [self presentSemiView:bottomView];
    }else if ([allStores count] > 0) {
        [self presentSemiView:bottomView];
    }else {
        [settingMethod HUDMessage:@"kNoStoresAround" typeOfIcon:nil delay:2.0 offset:CGPointMake(0, 0)];
    }
    
}


#pragma mark --------------
#pragma mark --------------
#pragma mark TableView Delegate
#pragma mark --------------
#pragma mark --------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 0; }
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { return 0; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [allStores count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    // ------- CLEAN EVERYTHING BEFORE DISPLAYING THE VIEW
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
	for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
		
	}
	[subviews release];
    
    
    // Logo
    UIImageView *myLogoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_subway@2x"]];
    myLogoImg.frame = CGRectMake(15, 3, 74, 19.5);
    [cell.contentView addSubview:myLogoImg];
    [myLogoImg release];
    
    
    CustomLabel *adressLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(15, myLogoImg.frame.size.height + myLogoImg.frame.origin.y - 5, screenWidth - 35, 30)];
    [adressLbl setFont:[UIFont fontWithName:APEX_BOLD size:12.0]];
    adressLbl.text = [NSString stringWithFormat:@" %@",[[allStores objectAtIndex:indexPath.row] objectForKey:@"address"]];
    [adressLbl setDrawOutline:NO];
    adressLbl.textColor = [UIColorCov colorWithHexString:GREEN_TEXT];
//    adressLbl.textAlignment = UITextAlignmentLeft;
    adressLbl.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:adressLbl];
    [adressLbl release];
    
    float myKmDistance = [[settingMethod getDistanceFromMyLocation:[[allStores objectAtIndex:indexPath.row] objectForKey:@"latitude"] placeLongitude:[[allStores objectAtIndex:indexPath.row] objectForKey:@"longitude"]] floatValue];
    
    
    CustomLabel *distanceLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(15, adressLbl.frame.size.height + adressLbl.frame.origin.y - 10, screenWidth - 30, 20)];
    [distanceLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:12.0]];
    
    if (myKmDistance < 0.999) {
        distanceLbl.text = [NSString stringWithFormat:@"%.0f %@", myKmDistance*1000, NSLocalizedString(@"kMeters", nil)];;
    }else {
        distanceLbl.text = [NSString stringWithFormat:@"%.1f %@", myKmDistance, NSLocalizedString(@"kKms", nil)];
    }
    
    [distanceLbl setDrawOutline:NO];
    distanceLbl.textColor = [UIColor grayColor];
//    distanceLbl.textAlignment = UITextAlignmentLeft;
    distanceLbl.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:distanceLbl];
    [distanceLbl release];

    
    UIImageView *indicatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_push@2x"]];
    indicatorImg.frame = CGRectMake(screenWidth - 20, myLogoImg.frame.size.height + myLogoImg.frame.origin.y, 12, 15);
    [cell.contentView addSubview:indicatorImg];
    [indicatorImg release];
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissSemiModalView];
    
    //Change City
    
    self.currentStore = allStores[indexPath.row];
    
    if ([[allStores objectAtIndex:indexPath.row] objectForKey:@"phone"]) {
        self.cityLabel.text = [NSString stringWithFormat:@"%@,%@",NSLocalizedString(@"kSubway", nil),[[allStores objectAtIndex:indexPath.row]objectForKey:@"city"]];
    }
    
    //Change Phone
    if ([[allStores objectAtIndex:indexPath.row] objectForKey:@"phone"]) {
        
        phoneDetailsLbl.text = [NSString stringWithFormat:@" %@",[[allStores objectAtIndex:indexPath.row] objectForKey:@"phone"]];
        [phoneDetailsBtn setTag:indexPath.row];
        phoneDetailsBtn.alpha = 1.0;
        phoneDetailsBtn.enabled = YES;
    }else {
        
        
        phoneDetailsLbl.text = @"";
        phoneDetailsBtn.enabled = NO;
        phoneDetailsBtn.alpha = 0.0;
        
    }
    
    //Change Mail
    
    if ([[allStores objectAtIndex:indexPath.row] objectForKey:@"email"]) {
        
        mailDetailsBtn.enabled = YES;
        mailDetailsBtn.alpha = 1.0;
        
    }else {
        
        mailDetailsBtn.enabled = NO;
        mailDetailsBtn.alpha = 0.0;
    }
    
    
    
    //Change Adress first Line
    UIFont *fontSD = [UIFont fontWithName:APEX_MEDIUM size:14.0];
    CGSize sizeForDesc = {detailsView.frame.size.width - 100,100.0f};
    
    NSString *myText = [NSString stringWithFormat:@"%@",[[allStores objectAtIndex:indexPath.row] objectForKey:@"address"]];
    CGSize adressSize = [myText sizeWithFont:fontSD
                           constrainedToSize:sizeForDesc lineBreakMode:UILineBreakModeWordWrap];
    
    
    if (adressSize.height > 15) {
        [adressdetailsLbl setFrame:CGRectMake(0, 45, detailsView.frame.size.width - 100, adressSize.height)];
    }else {
        [adressdetailsLbl setFrame:CGRectMake(0, 55, detailsView.frame.size.width - 100, adressSize.height)];
    }
    
    
    adressdetailsLbl.text = [NSString stringWithFormat:@"%@",[[allStores objectAtIndex:indexPath.row] objectForKey:@"address"]];
    adressdetailsLbl.numberOfLines = 3;
    //Change Adress second Line
    [adressdetailsLblSecondLine setFrame:CGRectMake(0, adressdetailsLbl.frame.size.height + adressdetailsLbl.frame.origin.y, detailsView.frame.size.width, 20)];
    adressdetailsLblSecondLine.text = [NSString stringWithFormat:@"%@, %@",[[allStores objectAtIndex:indexPath.row] objectForKey:@"region"], [[allStores objectAtIndex:indexPath.row] objectForKey:@"zipcode"]];
    
    
    //Change Distance
    [distancedetailsLbl setFrame:CGRectMake(0, adressdetailsLblSecondLine.frame.size.height + adressdetailsLblSecondLine.frame.origin.y + 5, detailsView.frame.size.width, 20)];
    
    float myKmDistance = [[settingMethod getDistanceFromMyLocation:[[allStores objectAtIndex:indexPath.row] objectForKey:@"latitude"] placeLongitude:[[allStores objectAtIndex:indexPath.row] objectForKey:@"longitude"]] floatValue];
    
    if (myKmDistance < 0.999) {
        distancedetailsLbl.text = [NSString stringWithFormat:@"%@ %.0f%@", NSLocalizedString(@"kDistance", nil), myKmDistance*1000, NSLocalizedString(@"kMeters", nil)];;
    }else {
        distancedetailsLbl.text = [NSString stringWithFormat:@"%@ %.1f%@", NSLocalizedString(@"kDistance", nil), myKmDistance, NSLocalizedString(@"kKms", nil)];
    }
    
    
    // Remove Pin Description if already exist
    if (tempAnnotation != nil) {
        NSLog(@"tempAnnot is not nil");
        NSLog(@"tempAnnotation : %i", tempAnnotation.tag);
        [self mapView:self.myMapView didDeselectAnnotationView:tempAnnotation];
        
        
    }
    
    // Force Pin Description
    
    for (MapPlace *anAnnotation in [NSArray arrayWithArray:self.myMapView.annotations]) {
        
        if (![anAnnotation isKindOfClass:[BMKUserLocation class]] && [anAnnotation.idPlace intValue] == indexPath.row+1) {
            NSLog(@"anAnnotation.idPlace %@", anAnnotation.idPlace);
            
            ViewMapAnnotationView *annotationView = (ViewMapAnnotationView*)[self.myMapView viewForAnnotation:anAnnotation];
            [self mapView:self.myMapView didSelectAnnotationView:(BMKAnnotationView *)annotationView];
//            BMKPlanNode *start = [[BMKPlanNode alloc]init];
//            start.pt = self.myMapView.userLocation.coordinate;
//            BMKPlanNode *end = [[BMKPlanNode alloc]init];
//            end.pt = anAnnotation.coordinate;
//            NSLog(@"search walkiing");
//            BOOL flag = [self.search walkingSearch:@"上海" startNode:start endCity:@"上海" endNode:end];
//            if (!flag) {
//                NSLog(@"search failed");
//            }
        }
        
    }
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self selector:@selector(redrawFrame:) userInfo:[allStores objectAtIndex:indexPath.row] repeats:NO];

    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

-(void)redrawFrame:(NSTimer *)timer{
    
    id myStore = [timer userInfo];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                
                         [self.myMapView setFrame:CGRectMake(15, 250, 290, screenHeight - 300)];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self moveToStoreLocation:myStore];
                         
                     }];
    
}


#pragma mark --------------
#pragma mark --------------
#pragma mark Map Delegate
#pragma mark --------------
#pragma mark --------------


#define ZOOM_MAPLEVEL 13

- (void)zoomTo:(CLLocationCoordinate2D)coordinate
{
	[myMapView setCenterCoordinate:coordinate
                         zoomLevel:ZOOM_MAPLEVEL
                          animated:YES];
}



- (void)mapView:(BMKMapView*)map regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"regionDidChangeAnimated");
    for (NSObject *annotation in [myMapView annotations])
    {
        if ([annotation isKindOfClass:[BMKUserLocation class]])
        {
            BMKAnnotationView *view = [myMapView viewForAnnotation:(BMKUserLocation *)annotation];
            [view.superview sendSubviewToBack:view];
            //[[view superview] bringSubviewToFront:view];
        }
    }
    
    
}


- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    for (BMKAnnotationView *pin in views) {
        
        if ([[pin annotation] isKindOfClass:[BMKUserLocation class]])
        {
            //[[pin superview] bringSubviewToFront:pin];
        }
        else
        {
            
            pin.canShowCallout = NO;
            CGRect endFrame = pin.frame;
            pin.frame = CGRectOffset(pin.frame, 0, -230);
            
            [UIView animateWithDuration:0.45f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                pin.frame = endFrame;
            } completion:^(BOOL finished) {
                ;
            }];
            
            //[[pin superview] sendSubviewToBack:pin];
            
        }
        
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"view %d temp %d",view.tag,tempAnnotation.tag);

    if (view.tag != 0) {
        
        NSLog(@"tempAnnotation : %i - view: %i", tempAnnotation.tag, view.tag);
        
//        if (tempAnnotation.tag != 0) {
//            NSLog(@"annot already selected, remove it");
//            [self mapView:self.myMapView didDeselectAnnotationView:tempAnnotation];
//        }
        
        if (tempAnnotation != view) {
            tempAnnotation = view;
            [tempAnnotation retain];
            
            NSLog(@"open annot");
//            [[view superview] bringSubviewToFront:view];
            
            UIFont *fontSD = [UIFont fontWithName:APEX_MEDIUM size:10.0];
            CGSize sizeForDesc = {108,50.0f};
            NSString *myText = [NSString stringWithFormat:@"%@",[[allStores objectAtIndex:view.tag-1] objectForKey:@"address"]];
            CGSize adressSize = [myText sizeWithFont:fontSD
                                   constrainedToSize:sizeForDesc lineBreakMode:UILineBreakModeWordWrap];
            
            
            CustomLabel *tempAdressLbl = [[CustomLabel alloc] init];
            [tempAdressLbl setFont:[UIFont fontWithName:APEX_MEDIUM size:10.0]];
            
            if (adressSize.height > 22) {
                [tempAdressLbl setFrame:CGRectMake(14, 25, 108, adressSize.height)];
            }else {
                [tempAdressLbl setFrame:CGRectMake(14, 30, 108, adressSize.height)];
            }
            
            tempAdressLbl.text = myText;
            [tempAdressLbl setDrawOutline:NO];
            tempAdressLbl.tag = 1000 + view.tag;
            tempAdressLbl.numberOfLines = 0;
            tempAdressLbl.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
            tempAdressLbl.textAlignment = UITextAlignmentCenter;
            tempAdressLbl.backgroundColor = [UIColor clearColor];
            tempAdressLbl.alpha = 0.0;
            [view addSubview:tempAdressLbl];
            [tempAdressLbl release];
            CGRect startFrame = view.frame;
            CGRect endFrame = CGRectMake(view.frame.origin.x-40, view.frame.origin.y - 44, 138, 73);
            view.image = [UIImage imageNamed:@"map_pin_open"];
            [view setNeedsDisplay];
            view.frame = startFrame;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.45f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            view.frame = endFrame;
            tempAdressLbl.alpha = 1.0;
            [UIView commitAnimations];
            view.centerOffset = CGPointMake(0, -146/2/2);
        }
    }
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"didDeselectAnnotationView %@",view);
    if (view.tag != 0) {
        
        if (tempAnnotation != nil) {
            
            NSLog(@"close annot");
            
            for (UIView *sub in [view subviews]) {
                
                if ([sub isKindOfClass:[CustomLabel class]] && sub.tag == view.tag+1000) {
                    [sub removeFromSuperview];
                    
                }
                
            }
            CGRect startFrame = view.frame;
            CGRect endFrame = CGRectMake(view.frame.origin.x + 40, view.frame.origin.y + 44, 58, 29);
            view.image =[UIImage imageNamed:@"map_pin"];
            view.frame = startFrame;
            [view setNeedsDisplay];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.45f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            view.frame = endFrame;
            NSLog(@"%@",[NSValue valueWithCGRect:view.frame]);
            
            [UIView commitAnimations];
            view.centerOffset = CGPointMake(0, -58/2/2);

            
            if (tempAnnotation != view) {
                
                NSLog(@"inside temp");
                
                for (UIView *sub in [tempAnnotation subviews]) {
                    
                    if ([sub isKindOfClass:[CustomLabel class]] && sub.tag == tempAnnotation.tag+1000) {
                        [sub removeFromSuperview];
                        
                    }
                    
                }
                
                CGRect endFrame = CGRectMake(tempAnnotation.frame.origin.x + 40, tempAnnotation.frame.origin.y + 44, 58, 29);
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.45f];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                
                tempAnnotation.frame = endFrame;
                tempAnnotation.image =[UIImage imageNamed:@"map_pin"];
                [tempAnnotation setNeedsDisplay];
                NSLog(@"%@",[NSValue valueWithCGRect:view.frame]);

                [UIView commitAnimations];
                view.centerOffset = CGPointMake(0, -58/2/2);

            }
            
            //tempAnnotation = nil;
            
        }

        
    }

    
}


- (BMKAnnotationView*)mapView:(BMKMapView *)map viewForAnnotation:(id<BMKAnnotation>)annotation
{    

    // MY OWN PIN
    if (annotation == myMapView.userLocation) {
        static NSString *identifier = @"currentLocation";
        SVPulsingAnnotationView *pulsingView = (SVPulsingAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(pulsingView == nil) {
            pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:identifier];
            //pulsingView.annotationColor = [UIColor colorWithRed:0.678431 green:0 blue:0 alpha:1];
            pulsingView.canShowCallout = NO;
        }
        pulsingView.canShowCallout = NO;
        return (SVPulsingAnnotationView *)pulsingView;
    
        
        // STORE PIN
    }else {
    
        static NSString *AnnotationViewID = @"SUBWAYID";
        ViewMapAnnotationView *annotationView = (ViewMapAnnotationView*)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        
        if (nil == annotationView)
        {
            annotationView = [[[ViewMapAnnotationView alloc] initWithAnnotation:(id<BMKAnnotation>)annotation
                                                                reuseIdentifier:AnnotationViewID] autorelease];
            
        }
        
        MapPlace * myMapAnnot = (MapPlace*)annotation;
        int myTag = [myMapAnnot.idPlace intValue];
        
        [annotationView setTag:myTag];
        annotationView.image =[UIImage imageNamed:@"map_pin"];
        annotationView.centerOffset = CGPointMake(0, -58/2/2);
        [annotationView setEnabled:YES];
        [annotationView setCanShowCallout:NO];
        annotationView.canShowCallout = NO;
        return (BMKAnnotationView *)annotationView;
    }
    
}



- (void)onGetWalkingRouteResult:(BMKPlanResult *)result errorCode:(int)error
{
	NSLog(@"onGetWalkingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
//		RouteAnnotation* item = [[RouteAnnotation alloc]init];
//		item.coordinate = result.startNode.pt;
//		item.title = @"起点";
//		item.type = 0;
//		[_mapView addAnnotation:item];
//		[item release];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
//				item = [[RouteAnnotation alloc]init];
//				item.coordinate = step.pt;
//				item.title = step.content;
//				item.degree = step.degree * 30;
//				item.type = 4;
//				[_mapView addAnnotation:item];
//				[item release];
			}
			
		}
		
//		item = [[RouteAnnotation alloc]init];
//		item.coordinate = result.endNode.pt;
//		item.type = 1;
//		item.title = @"终点";
//		[_mapView addAnnotation:item];
//		[item release];
//		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
//		[_mapView addOverlay:polyLine];
//		delete []points;
	}

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
