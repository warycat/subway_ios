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







@end