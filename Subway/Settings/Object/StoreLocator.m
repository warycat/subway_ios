//
//  StoreLocator.m
//  Subway
//
//  Created by ludo on 4/26/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "StoreLocator.h"

@implementation StoreLocator

static StoreLocator * store;
//Get the singleton object
+ (StoreLocator*) storeFunction
{
    if (nil == store)
    {
        store = [[StoreLocator alloc] init];
    }
    return store;
}


-(void)dealloc{
    
    [super dealloc];
}



- (id) init
{
    self = [super init];
    return self;
}



//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------




-(id)getAllStores:(NSString *)gpsx longitude:(NSString *)gpsy radius:(NSString *)radius {
    
    NSDictionary *jsonDictonary = @{@"locale": [settingMethod getUserLanguage], @"lat": gpsx, @"lon": gpsy, @"radius": radius};
    
    id myResult = [settingMethod postAndParseJson:jsonDictonary action:@"all" type:MODULE_STORE];
    
    if (myResult == nil || myResult == [NSNull null])
        return nil;
    else
        return [myResult objectForKey:@"data"];
    
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








@end
