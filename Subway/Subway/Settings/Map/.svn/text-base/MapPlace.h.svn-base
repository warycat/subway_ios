//
//  StoreEssilor.h
//  Essilor
//
//  Created by Ngoc-Lan NGUYEN on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>


@interface MapPlace : NSObject <MKAnnotation> {
    
	float latitude;
	float longitude;
	CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *idPlace;
    NSString *address;
    
}

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *idPlace;
@property (nonatomic, copy) NSString *address;

- (MKMapItem*)mapItem;

@end
