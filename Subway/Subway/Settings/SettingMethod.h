//
//  SettingMethod.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "BlockSinaWeibo.h"


@interface SettingMethod : NSObject < CLLocationManagerDelegate, MBProgressHUDDelegate>{

    
    CLLocationManager *locationManager;
    NSString *latitude;
    NSString *longitude;
    
    
    MBProgressHUD *HUD;
    
}


+ (SettingMethod*) sharedSetting;
+(BOOL)isTwitterAvailable;
+(BOOL)isSocialAvailable;


@property (retain, nonatomic) NSString *latitude;
@property (retain, nonatomic) NSString *longitude;


// ----------------- CHECK NETWORK
- (BOOL) connectedToNetwork;

// ----------------- JSON
-(id)postAndParseJson:(id)jsonDictionary action:(NSString *)action type:(NSString *)myType;

// ----------------- CHECK EMAIL
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

// ----------------- LANGUAGE 
-(void)setLanguage;
-(NSString *)getUserLanguage;

// ----------------- LOCATION 
-(void)doLocation;
-(void)stopLocation;
-(void)startLocation;
-(NSString *)getDistanceFromMyLocation:(NSString *)placeLatitude placeLongitude:(NSString *)placeLongitude;

// ----------------- HUD 
-(void)HUDMessage:(NSString *)theMessage typeOfIcon:(NSString *)myIconName delay:(int)myDelay offset:(CGPoint)myOffset;

// ----------------- CHECK WEIBO
-(BOOL)weiboIsConnected;

// ----------------- GET IMAGE PATH
- (UIImage *)getImagePath:(NSString *)imageName ;


- (void)getShareStoreMessageWith:(NSDictionary *)requestDict onSuccess:(void (^)(NSDictionary *responseDict))successBlock;

@end

