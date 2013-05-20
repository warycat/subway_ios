//
//  MKMapView+ZoomLevel.h
//  Syphon
//
//  Created by Ngoc 'Jade' Tran on 7/4/10.
//  Copyright 2010 DigiBee. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
				  zoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated;

@end 