//
//  MenuMethod.m
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "MenuMethod.h"


@implementation MenuMethod
@synthesize menuArray;

static MenuMethod * menu;
//Get the singleton object
+ (MenuMethod*) sharedMenu
{
	if (nil == menu)
	{
		menu = [[MenuMethod alloc] init];

	}
	return menu;
}


-(void)dealloc{
	
	[super dealloc];
    
}


- (id) init
{
	self = [super init];
	return self;
}




// ----------------- CREATE MENU
// -----------------


-(void)checkMeals {
    
//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [documentPaths objectAtIndex:0];
//    NSString *allProductsPath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"product_all_%@.json", [settingMethod getUserLanguage]]];
//    
//    // check if the db is already installed
//    NSFileManager *manager = [NSFileManager defaultManager];
//    
//    if(![manager fileExistsAtPath:allProductsPath]) {
//        
//        NSString *appPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"product_all_%@", [settingMethod getUserLanguage]] ofType:@".json"];
//        [manager copyItemAtPath:appPath toPath:allProductsPath error:NULL];
//        
//        NSLog(@"file do not exist \n%@\n%@", appPath, allProductsPath);
//    
//    }
    
    
    NSString *jsonMenuFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"product_all_%@", [settingMethod getUserLanguage]] ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:jsonMenuFilePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSError *error = nil;
    NSMutableDictionary *myResult = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    self.menuArray = [myResult objectForKey:@"data"];
    
    
}










@end