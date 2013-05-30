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
#import <Social/Social.h>
#import "BlockSinaWeiboRequest.h"
#import <Accounts/Accounts.h>


@interface StoreLocatorViewController ()
@property (strong, nonatomic)NSArray *allAnnotations;
@end

@implementation StoreLocatorViewController

@synthesize myMapView, tempAnnotation;
@synthesize detailsView, bottomView;
@synthesize allStores;
@synthesize myTableView;
@synthesize adressdetailsLbl, distancedetailsLbl, adressdetailsLblSecondLine;
@synthesize weiboBtn;
@synthesize phoneDetailsBtn, phoneDetailsLbl, mailDetailsBtn, fromOtherView;

-(void)viewWillAppear:(BOOL)animated {
	
	self.navigationController.navigationBar.hidden = YES;
	[super viewWillAppear:YES];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];

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
    adressdetailsLbl.textColor = [UIColorCov colorWithHexString:GRAY_TEXT];
    adressdetailsLbl.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:adressdetailsLbl];
    
    adressdetailsLblSecondLine = [[CustomLabel alloc] initWithFrame:CGRectMake(0, adressdetailsLbl.frame.size.height + adressdetailsLbl.frame.origin.y, detailsView.frame.size.width, 20)];
    [adressdetailsLblSecondLine setFont:[UIFont fontWithName:APEX_MEDIUM size:14.0]];
    adressdetailsLblSecondLine.text = @"";
    [adressdetailsLblSecondLine setDrawOutline:NO];
    adressdetailsLblSecondLine.textColor = [UIColorCov colorWithHexString:GRAY_TEXT];
    adressdetailsLblSecondLine.backgroundColor = [UIColor clearColor];
    [detailsView addSubview:adressdetailsLblSecondLine];
    
    distancedetailsLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, adressdetailsLblSecondLine.frame.size.height + adressdetailsLblSecondLine.frame.origin.y + 5, detailsView.frame.size.width, 20)];
    [distancedetailsLbl setFont:[UIFont fontWithName:APEX_MEDIUM size:12.0]];
    distancedetailsLbl.text = @"";
    [distancedetailsLbl setDrawOutline:NO];
    distancedetailsLbl.textColor = [UIColorCov colorWithHexString:GRAY_TEXT];
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
    mailDetailsLbl.backgroundColor = [UIColor clearColor];
    [mailDetailsBtn addSubview:mailDetailsLbl];
    
    
    
    // ----------------- GENERATE TOP BAR
    
    
    UIButton *homeBtn =  [[UIButton alloc] init];
    
    if ([settingMethod weiboIsConnected]) {
        
        [displayMethod createTopBar:self.view viewName:@"storeLocator" leftBtn:nil rightBtn:homeBtn otherBtn:nil];
        
    }else {
        
        weiboBtn =  [[UIButton alloc] init];
        
        [displayMethod createTopBar:self.view viewName:@"storeLocator" leftBtn:weiboBtn rightBtn:homeBtn otherBtn:nil];
        
        [weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchDown];
        
    }

    [homeBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [homeBtn release];
    
    
    
    // ----------------- GENERATE BOTTOM BAR

    UIButton *storeListBtn =  [[UIButton alloc] init];
    
    [displayMethod createBottomBar:self.view viewName:@"storeLocator" myBtn1:storeListBtn myBtn2:nil myBtn3:nil];
    
    [storeListBtn addTarget:self action:@selector(storeListAction) forControlEvents:UIControlEventTouchDown];
    [storeListBtn release];
    
    
    self.myMapView = [[[MKMapView alloc] initWithFrame:CGRectMake(15, 70, screenWidth-30, screenHeight - 120)] autorelease];
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
        [self loadData];
    }else {
        
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(31, 121);
        MKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
        [self.myMapView  setRegion:adjustedRegion animated:YES];
        
        
    }

    CustomLabel *cityLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, -20, 300, 100)];
    cityLabel.text = @" SUBWAY,Shanghai";
    [cityLabel setFont:[UIFont fontWithName:APEX_HEAVY_ITALIC size:21.0]];
    [cityLabel setDrawOutline:YES];
    [cityLabel setOutlineSize:3];
    [cityLabel setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
    cityLabel.textColor = [UIColorCov colorWithHexString:WHITE_TEXT];
    cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel = cityLabel;
    [detailsView addSubview:cityLabel];

    
    UIButton *weiboShareBtn =  [[UIButton alloc] init];
    [weiboShareBtn  setFrame:CGRectMake(250, 25 , 43, 43)];
    weiboShareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    weiboShareBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [weiboShareBtn setImage:[UIImage imageNamed:@"icon_weibo@2x"] forState:UIControlStateNormal];
    [weiboShareBtn addTarget:self action:@selector(shareStore:) forControlEvents:UIControlEventTouchDown];
    
    CustomLabel *weiboLbl = [[CustomLabel alloc] initWithFrame:CGRectMake(245, weiboShareBtn.frame.size.height + weiboShareBtn.frame.origin.y - 1, 48, 10)];
    [weiboLbl setFont:[UIFont fontWithName:APEX_BOLD_ITALIC size:8.0]];
    weiboLbl.text = NSLocalizedString(@"kShareOnWeibo", nil);
    [weiboLbl setDrawOutline:YES];
    [weiboLbl setOutlineSize:strokeSize];
    [weiboLbl setOutlineColor:[UIColorCov colorWithHexString:GRAY_STROKE]];
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

    [storeMethod getShareStoreMessageWith:@{@"locale":[settingMethod getUserLanguage],@"sid":[self.currentStore objectForKey:@"sid"],@"weiboid":[BlockSinaWeibo sharedClient].sinaWeibo.userID} onSuccess:^(NSDictionary *responseDict) {
        
        NSLog(@"%@",responseDict);
        
        NSDictionary *data = [responseDict objectForKey:@"data"];
        NSString *baidumap = [data objectForKey:@"baidumap"];
        NSString *sharecontent = [data objectForKey:@"sharecontent"];
        NSString *image = [data objectForKey:@"image"];
        NSString *text = [NSString stringWithFormat:@"%@ %@",baidumap, sharecontent];
        
        [BlockSinaWeiboRequest POSTrequestAPI:@"statuses/upload_url_text.json" withParams:@{@"status":text,@"url":image} withHandler:^(id responseDict) {
            NSLog(@"%@",responseDict);
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = sharecontent;
            if (responseDict[@"error"]) {
                hud.labelText = responseDict[@"error"];
            }
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                // Do something...
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            });
            
        }];
        
    }];
    
}

-(void)callSub:(id)sender {
    
    int number= [sender tag];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [[allStores objectAtIndex:number] objectForKey:@"phone"]]]];

    
}

-(void)loadData {
    
    CLLocation *myLocation = [settingMethod myLocation];
    [self zoomTo:myLocation.coordinate];
    
    [storeMethod getStoreLocationsWith:@{@"locale":[settingMethod getUserLanguage],@"map":@"google"} onSuccess:^(NSDictionary *responseDict) {

        NSArray *stores = responseDict[@"data"];
        
        self.allStores = [stores sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSString *latitude1 = obj1[@"latitude"];
            NSString *longitude1 = obj1[@"longitude"];
            CLLocation *location1 = [[CLLocation alloc]initWithLatitude:latitude1.floatValue longitude:longitude1.floatValue];
            
            NSString *latitude2 = obj2[@"latitude"];
            NSString *longitude2 = obj2[@"longitude"];
            CLLocation *location2 = [[CLLocation alloc]initWithLatitude:latitude2.floatValue longitude:longitude2.floatValue];
            
            CLLocationDistance distance1 = [myLocation distanceFromLocation:location1];
            CLLocationDistance distance2 = [myLocation distanceFromLocation:location2];
            
            if (distance1 < distance2)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
            
        }];
        
        NSMutableArray *annotations = [NSMutableArray array];
        
        for (NSDictionary *store in self.allStores) {
            
            MapPlace * newMapAnnotation = [[MapPlace alloc] init];
            CLLocationCoordinate2D tempCoordinate;
            tempCoordinate.latitude  = [store[@"latitude"] floatValue];
            tempCoordinate.longitude = [store[@"longitude"] floatValue];
            newMapAnnotation.coordinate = tempCoordinate;
            newMapAnnotation.title = store[@"address"];
            //NSLog(@"%@ %@ %@ %@",store[@"ref"],store[@"latitude"],store[@"longitude"],store[@"address"]);
            [myMapView addAnnotation:newMapAnnotation];
            [annotations addObject:newMapAnnotation];
            
        }
        self.allAnnotations = annotations;
    }];
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
        
        weiboBtn.alpha = 0.0;
        weiboBtn.hidden = YES;
        weiboBtn.enabled = NO;
        
        [settingMethod HUDMessage:@"kConnectedToWeibo" typeOfIcon:@"icon_weibo@2x" delay:2.0 offset:CGPointMake(0, 0)];
        
    }];

}

-(void)backAction {
    
    if (fromOtherView == YES) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    

}


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
    adressLbl.textColor = [UIColorCov colorWithHexString:GRAY_TEXT];
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
    distanceLbl.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:distanceLbl];
    [distanceLbl release];

    
    UIImageView *indicatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_push@2x"]];
    indicatorImg.frame = CGRectMake(screenWidth - 20, myLogoImg.frame.size.height + myLogoImg.frame.origin.y, 12, 15);
    [cell.contentView addSubview:indicatorImg];
    [indicatorImg release];
    
    
    return cell;
    
}

- (void)displayStore:(NSInteger)index
{
    
    
    self.currentStore = allStores[index];

    if ([[allStores objectAtIndex:index] objectForKey:@"phone"]) {
        self.cityLabel.text = [NSString stringWithFormat:@"%@,%@",NSLocalizedString(@"kSubway", nil),[[allStores objectAtIndex:index]objectForKey:@"city"]];
    }
    
    //Change Phone
    if ([[allStores objectAtIndex:index] objectForKey:@"phone"]) {
        
        phoneDetailsLbl.text = [NSString stringWithFormat:@" %@",[[allStores objectAtIndex:index] objectForKey:@"phone"]];
        [phoneDetailsBtn setTag:index];
        phoneDetailsBtn.alpha = 1.0;
        phoneDetailsBtn.enabled = YES;
    }else {
        
        
        phoneDetailsLbl.text = @"";
        phoneDetailsBtn.enabled = NO;
        phoneDetailsBtn.alpha = 0.0;
        
    }
    
    //Change Mail
    if ([[allStores objectAtIndex:index] objectForKey:@"email"]) {
        
        mailDetailsBtn.enabled = YES;
        mailDetailsBtn.alpha = 1.0;
        
    }else {
        
        mailDetailsBtn.enabled = NO;
        mailDetailsBtn.alpha = 0.0;
        
    }
    
    
    
    //Change Adress first Line
    UIFont *fontSD = [UIFont fontWithName:APEX_MEDIUM size:14.0];
    CGSize sizeForDesc = {detailsView.frame.size.width - 100,100.0f};
    
    NSString *myText = [NSString stringWithFormat:@"%@",[[allStores objectAtIndex:index] objectForKey:@"address"]];
    CGSize adressSize = [myText sizeWithFont:fontSD
                           constrainedToSize:sizeForDesc lineBreakMode:UILineBreakModeWordWrap];
    
    
    if (adressSize.height > 15) {
        [adressdetailsLbl setFrame:CGRectMake(0, 45, detailsView.frame.size.width - 100, adressSize.height)];
    }else {
        [adressdetailsLbl setFrame:CGRectMake(0, 55, detailsView.frame.size.width - 100, adressSize.height)];
    }
    
    
    adressdetailsLbl.text = [NSString stringWithFormat:@"%@",[[allStores objectAtIndex:index] objectForKey:@"address"]];
    adressdetailsLbl.numberOfLines = 3;
    
    //Change Adress second Line
    [adressdetailsLblSecondLine setFrame:CGRectMake(0, adressdetailsLbl.frame.size.height + adressdetailsLbl.frame.origin.y, detailsView.frame.size.width, 20)];
    adressdetailsLblSecondLine.text = [NSString stringWithFormat:@"%@, %@",[[allStores objectAtIndex:index] objectForKey:@"region"], [[allStores objectAtIndex:index] objectForKey:@"zipcode"]];
    
    
    //Change Distance
    [distancedetailsLbl setFrame:CGRectMake(0, adressdetailsLblSecondLine.frame.size.height + adressdetailsLblSecondLine.frame.origin.y + 5, detailsView.frame.size.width, 20)];
    
    float myKmDistance = [[settingMethod getDistanceFromMyLocation:[[allStores objectAtIndex:index] objectForKey:@"latitude"] placeLongitude:[[allStores objectAtIndex:index] objectForKey:@"longitude"]] floatValue];
    
    if (myKmDistance < 0.999) {
        distancedetailsLbl.text = [NSString stringWithFormat:@"%@ %.0f%@", NSLocalizedString(@"kDistance", nil), myKmDistance*1000, NSLocalizedString(@"kMeters", nil)];;
    }else {
        distancedetailsLbl.text = [NSString stringWithFormat:@"%@ %.1f%@", NSLocalizedString(@"kDistance", nil), myKmDistance, NSLocalizedString(@"kKms", nil)];
    }
    
    
    MapPlace *place = self.allAnnotations[index];
    MapPlace *selectedAnnotation = self.myMapView.selectedAnnotations.lastObject;
    
    if (!selectedAnnotation) {
        [self.myMapView selectAnnotation:place animated:YES];
    }else{

        if (place != selectedAnnotation) {
            [self.myMapView deselectAnnotation:place animated:YES];
        }
        
    }
    [self.myMapView selectAnnotation:place animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self selector:@selector(redrawFrame:) userInfo:[allStores objectAtIndex:index] repeats:NO];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissSemiModalView];
    
    //Change City
    [self displayStore:indexPath.row];    
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


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    for (MKAnnotationView *pin in views) {
        
        if ([[pin annotation] isKindOfClass:[MKUserLocation class]])
        {
            [[pin superview] bringSubviewToFront:pin];
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
            
            [[pin superview] sendSubviewToBack:pin];
        
        }
        
    }
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view isKindOfClass:[SVPulsingAnnotationView class]]) {
        NSLog(@"select pin");
        return;
    }
    if ([view isKindOfClass:[ViewMapAnnotationView class]]) {
        NSLog(@"select store");
        UIFont *fontSD = [UIFont fontWithName:APEX_MEDIUM size:10.0];
        CGSize sizeForDesc = {108,50.0f};
        NSString *myText = [NSString stringWithFormat:@"%@",view.annotation.title];
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
        view.frame = startFrame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.45f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        view.frame = endFrame;
        tempAdressLbl.alpha = 1.0;
        [UIView commitAnimations];
        
        view.centerOffset = CGPointMake(0, -146/2/2);
        
        return;
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([view isKindOfClass:[SVPulsingAnnotationView class]]) {
        NSLog(@"deselect pin");
        return;
    }
    
    if ([view isKindOfClass:[ViewMapAnnotationView class]]) {
        for (UIView *sub in [view subviews]) {
            if ([sub isKindOfClass:[CustomLabel class]]) {
                [sub removeFromSuperview];
            }
        }
        
        NSLog(@"deselect store");
        CGRect startFrame = view.frame;
        CGRect endFrame = CGRectMake(view.frame.origin.x + 40, view.frame.origin.y + 44, 58, 29);
        view.image =[UIImage imageNamed:@"map_pin"];
        view.frame = startFrame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.45f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        view.frame = endFrame;
        NSLog(@"%@",[NSValue valueWithCGRect:view.frame]);
        [UIView commitAnimations];
        
        view.centerOffset = CGPointMake(0, -58/2/2);
        
        return;
    }
}


- (MKAnnotationView*)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation
{    

    // MY OWN PIN
    if (annotation == myMapView.userLocation) {
        static NSString *identifier = @"currentLocation";
        SVPulsingAnnotationView *pulsingView = (SVPulsingAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(pulsingView == nil) {
            pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:identifier];
            pulsingView.annotationColor = [UIColor colorWithRed:0.678431 green:0 blue:0 alpha:1];
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
            annotationView = [[[ViewMapAnnotationView alloc] initWithAnnotation:(id<MKAnnotation>)annotation
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
        NSString *version = [UIDevice currentDevice].systemVersion;
        if ([version compare:@"6.0"] == NSOrderedAscending) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [annotationView addGestureRecognizer:tap];
        tap.delegate = self;

        }
        return (MKAnnotationView *)annotationView;
    }
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (void)tap:(UITapGestureRecognizer *)sender
{
    ViewMapAnnotationView *view = (ViewMapAnnotationView *)sender.view;
    NSLog(@"tap %@",view);
    MapPlace *selectedAnnotation = self.myMapView.selectedAnnotations.lastObject;
    if (!selectedAnnotation) {
        NSLog(@"not selectedAnnotation");
        [self.myMapView selectAnnotation:view.annotation animated:YES];
    }else{
        NSLog(@"did selectedAnnotation");
        NSInteger index = [self.allAnnotations indexOfObjectIdenticalTo:view.annotation];
        //[self.myMapView deselectAnnotation:selectedAnnotation animated:NO];
        [self displayStore:index];
        if (view.annotation != selectedAnnotation) {
            //[self.myMapView deselectAnnotation:view.annotation animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
