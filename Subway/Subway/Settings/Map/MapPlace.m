//
//  StoreEssilor.m
//  Essilor
//
//  Created by Ngoc-Lan NGUYEN on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPlace.h"


@implementation MapPlace

@synthesize longitude;
@synthesize latitude;
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize idPlace;
@synthesize address;

-(void) dealloc
{
    [title release];
    [subtitle release];
    [idPlace release];
    
	[super dealloc];
}

//- (MKMapItem*)mapItem {
//    
//    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : address};
//    
//    MKPlacemark *placemark = [[MKPlacemark alloc]
//                              initWithCoordinate:self.coordinate
//                              addressDictionary:addressDict];
//    
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = self.title;
//    
//    return mapItem;
//}


@end
