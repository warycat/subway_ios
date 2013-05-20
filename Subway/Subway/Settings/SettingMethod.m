//
//  SettingMethod.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "SettingMethod.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>   
#import <Social/Social.h>
#import <Accounts/Accounts.h>


@implementation SettingMethod
@synthesize latitude, longitude;


static SettingMethod * setting;
//Get the singleton object
+ (SettingMethod*) sharedSetting
{
	if (nil == setting)
	{
		setting = [[SettingMethod alloc] init];

	}
	return setting;
}



-(void)dealloc{
	
	[super dealloc];
    
}


- (id) init
{
	self = [super init];
	return self;
}


// =================        =================
// ================= FRAMEWORK CHECKER =================
// =================        =================

+(BOOL)isTwitterAvailable {
    return NSClassFromString(@"TWTweetComposeViewController") != nil;
}

+(BOOL)isSocialAvailable {
    return NSClassFromString(@"SLComposeViewController") != nil;
}



// ================= JSON =================


-(id)postAndParseJson:(id)jsonDictionary action:(NSString *)action type:(NSString *)myType {
    
    NSURL *myUrl = nil;
    
    if ([action isEqualToString:@""]) 
        myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADRESS, myType]];
    else
        myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",ADRESS, myType,action]];
    
    NSLog(@"Info Send: %@", jsonDictionary);
    NSLog(@"To Url : %@", myUrl);
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:kNilOptions error:&error];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *messageLength = [NSString stringWithFormat:@"%d", json.length];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:myUrl];
    [request addValue:messageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: [json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSHTTPURLResponse *response = nil;
    NSError *myError = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&myError];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (!error || responseData != nil) {
        
        NSString *JSONResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (!JSONResponse)
        {
            return nil;
        }
                
        NSError *error = nil;
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[JSONResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        NSLog(@"response : %@", jsonDict);
    
        if ([[jsonDict objectForKey:@"status"] integerValue] == 0) 
            return nil;
        
        return jsonDict;
        
    }
    return nil;
    
}


// ================= CHECK INTERNET =================


- (BOOL) connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags)
    {
        return NO;
    }

    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    if (isReachable && !needsConnection) {
        return YES;
    }else {
        
        [self HUDMessage:@"kNoConnection" typeOfIcon:HUD_ICON_NO_CONNEXION delay:3.5 offset:CGPointMake(0, 0)];
        return NO;
    }
    //return (isReachable && !needsConnection)?YES:NO;
}



// ================= HUD PROGRESS =================


-(void)HUDMessage:(NSString *)theMessage typeOfIcon:(NSString *)myIconName delay:(int)myDelay offset:(CGPoint)myOffset {
    
    
    theMessage = NSLocalizedString(([NSString stringWithFormat:@"%@", theMessage]), nil);
    
    
    // Calcul de la taille du message
    UIFont *fontSD = [UIFont fontWithName:FONT_HUD_BIG_LABEL size:FONT_SIZE_HUD_BIG_LABEL];
    CGSize sizeForDesc = {250.0f, 500.0f}; // contraintes max de la taille du label
    CGSize size = [theMessage sizeWithFont:fontSD constrainedToSize:sizeForDesc lineBreakMode:UILineBreakModeWordWrap];
    
    
    // Layout de la notification
    UIView *layoutView = [[UIView alloc] init];
    layoutView.backgroundColor = [UIColor clearColor];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:myIconName];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont fontWithName:FONT_HUD_BIG_LABEL size:FONT_SIZE_HUD_BIG_LABEL];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.lineBreakMode = UILineBreakModeWordWrap;
    messageLabel.numberOfLines = 0;
    messageLabel.text = theMessage;
    
    if ( myIconName == nil ) {
        
        layoutView.frame = CGRectMake(0, 0, size.width, size.height);
        icon.frame = CGRectMake(0, 0, 0, 0);
        messageLabel.frame = CGRectMake(0, 0, size.width, size.height);
    }
    else if ( [myIconName isEqualToString:HUD_ICON_NO_CONNEXION] ) {
        
        layoutView.frame = CGRectMake(0, 0, size.width, size.height+44+15);
        icon.frame = CGRectMake((size.width-134)/2, 0, 134, 44);
        messageLabel.frame = CGRectMake(0, 44+15, size.width, size.height);
    }
    
    
    [layoutView addSubview:icon];
    [layoutView addSubview:messageLabel];
    [icon release];
    [messageLabel release];
    
    
    // Initialisation du HUD
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[[UIApplication sharedApplication].delegate window] addSubview:HUD];
    
    // Modification de son emplacement (si nécessaire)
    if ( myOffset.x != 0 || myOffset.y != 0 ) {
        
        CGRect hudFrame = HUD.frame;
        hudFrame.origin.x = hudFrame.origin.x + myOffset.x;
        hudFrame.origin.y = hudFrame.origin.y + myOffset.y;
        HUD.frame = hudFrame;
    }
    
    HUD.customView = layoutView;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    [HUD show:YES];
    
    [self performSelectorOnMainThread:@selector(hideMyHUD:) withObject:[NSString stringWithFormat:@"%.i", myDelay] waitUntilDone:NO];
    
    [layoutView release];
}


-(void)hideMyHUD:(NSString *)delay {
    
    int myDelay = [delay intValue];
    [HUD hide:YES afterDelay:myDelay];
    
}



// ================= CHECK EMAIl =================


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


// ================= LANGUAGE =================


-(void)setLanguage {
    
    NSString *myLanguage = @"";
    NSArray* preferredLangs = [NSLocale preferredLanguages];
    myLanguage = [preferredLangs objectAtIndex:0];
    myLanguage = [myLanguage substringWithRange: NSMakeRange(0, 2)];
    
    NSLog(@"myLanguage : %@", myLanguage);
    
    NSString *lang = @"";
    
    if ([myLanguage isEqualToString:@"en"]) {
        
        lang = @"en";
        
    }else {
        
        lang = @"cn";
        
    }
            
    [[NSUserDefaults standardUserDefaults] setObject:lang forKey:@"userLanguage"];
          
}

-(NSString *)getUserLanguage {
    
    NSString *myLaguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"];
    return myLaguage;
    
}


// ================= LOCATION =================

-(void)doLocation {
    
    
    
    // ----------------- LOCATION
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    /* Notify changes when device has moved x meters.
     * Default value is kCLDistanceFilterNone: all movements are reported.
     */
    locationManager.distanceFilter = 20.0f;
    
    
    /* Pinpoint our location with the following accuracy:
     *
     *     kCLLocationAccuracyBestForNavigation  highest + sensor data
     *     kCLLocationAccuracyBest               highest
     *     kCLLocationAccuracyNearestTenMeters   10 meters
     *     kCLLocationAccuracyHundredMeters      100 meters
     *     kCLLocationAccuracyKilometer          1000 meters
     *     kCLLocationAccuracyThreeKilometers    3000 meters
     */
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    
    float Latitude = newLocation.coordinate.latitude;
    latitude = [NSString stringWithFormat:@"%f", Latitude];
    [latitude retain];
    
    float Longitude = newLocation.coordinate.longitude;
    longitude = [NSString stringWithFormat:@"%f", Longitude];
    [longitude retain];

}

-(void)stopLocation {
    
    [locationManager stopUpdatingLocation];
    
}


-(void)startLocation {
    
    [locationManager startUpdatingLocation];
    
}

-(NSString *)getDistanceFromMyLocation:(NSString *)placeLatitude placeLongitude:(NSString *)placeLongitude {
    
    CLLocation *mLocation  = [[CLLocation alloc]initWithLatitude:[placeLatitude floatValue] longitude:[placeLongitude floatValue]];
    CLLocation *myLocation = [[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    CLLocationDistance meterDistance;
    meterDistance = [myLocation distanceFromLocation:mLocation];
    
    NSString *distance = [NSString stringWithFormat:@"%.3f", meterDistance/1000];
    
    [myLocation release];
    [mLocation release];
    
    return distance;
    
}



// ================= CHECK WEIBO =================

-(BOOL)weiboIsConnected {
    
    return [BlockSinaWeibo sharedClient].sinaWeibo.isAuthValid;
    
}


// =================GET IMAGE PATH =================

- (UIImage *)getImagePath:(NSString *)imageName {
	
	// FILE MANAGER
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	// DOCUMENT PATH
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString* fullFileName = imageName;
	NSString* fileName = [[fullFileName lastPathComponent] stringByDeletingPathExtension];
	NSString* extension = [fullFileName pathExtension];
	
	// FILEPATH
	NSString* filepath     = [NSString stringWithFormat:@"%@/img/%@", documentsDirectory,fullFileName];
    
	// CHOOSE / GET IMAGE FROM CORRECT DIRECTORY (UPDATE in Documents/img/ OR NATIVE in Bundle)
	UIImage *image;
	if ([fileManager fileExistsAtPath:filepath]) {
		image = [UIImage imageWithContentsOfFile:filepath];
	} else {
		image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:extension]];
	}
    
	[fileManager release];
	return image;
	
}

- (void)getShareStoreMessageWith:(NSDictionary *)requestDict onSuccess:(void (^)(NSDictionary *responseDict))successBlock
{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADRESS, @"Store/share"]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestDict options:NSJSONWritingPrettyPrinted error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber *status = [dict objectForKey:@"status"];
        
        if(status.intValue == 1)successBlock(dict);
        else NSLog(@"status error %d",status.intValue);
        
    }];
}

- (void)getStoreLocationsWith:(NSDictionary *)requestDict onSuccess:(void (^)(NSDictionary *responseDict))successBlock
{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADRESS, @"Store/all"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestDict options:NSJSONWritingPrettyPrinted error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber *status = [dict objectForKey:@"status"];
        
        if(status.intValue == 1)successBlock(dict);
        else NSLog(@"status error %d",status.intValue);
        
    }];
}

- (CLLocation *)myLocation
{
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude.floatValue longitude:longitude.floatValue];
    return location;
}
@end
