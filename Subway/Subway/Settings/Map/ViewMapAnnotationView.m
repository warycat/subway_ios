//
//  ViewMapAnnotationView.m
//  McDo
//
//  Created by Ngoc 'Jade' Tran on 2/6/10.
//  Copyright 2010 DigiBee. All rights reserved.
//

#import "ViewMapAnnotationView.h"

@implementation ViewMapAnnotationView


- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) 
	{
        
		self.enabled = YES;
		self.canShowCallout = NO;
//		self.multipleTouchEnabled = NO;     
//        
//		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//		rightButton.tag = 101;
////
//		UIImage *arImage = [UIImage imageNamed:@"mark-member.png"];
//		[rightButton setImage:arImage forState:UIControlStateNormal];
//		CGRect rect = rightButton.frame;
//		rect.size.width = arImage.size.width;
//		rect.size.height = arImage.size.height;
//		rightButton.frame = rect;
//        
////        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        rightButton.tag = 101;
//        
//		self.rightCalloutAccessoryView = nil;
//        
//        
//		self.leftCalloutAccessoryView  = nil;
        self.canShowCallout = NO;
        
	}
	return self;
}


- (void)dealloc {
    [super dealloc];
}




- (void)showDetails:(UIButton *)button
{
    
}


- (void)didAddSubview:(UIView *)subview{
    int image = 0;
    int labelcount = 0;

    if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
        for (UIView *subsubView in subview.subviews) {
            if ([subsubView class] == [UIImageView class]) {
                UIImageView *imageView = ((UIImageView *)subsubView);
                imageView.hidden = YES;
                switch (image) {
                    case 0:
                        [imageView setImage:nil];


                        break;
                    case 1:
                        [imageView setImage:nil];


                        break;
                    case 3:
                        [imageView setImage:nil];

                        break;
                    default:
                        [imageView setImage:nil];


                        break;
                }
                image++;
            }else if ([subsubView class] == [UILabel class]) {
                UILabel *labelView = ((UILabel *)subsubView);
                labelView.hidden = YES;
                switch (labelcount) {
                    case 0:
                        labelView.textColor = [UIColor clearColor];
                        break;
                    case 1:
                        labelView.textColor = [UIColor clearColor];
                        break;

                    default:
                        break;
                }
                labelView.shadowOffset = CGSizeMake(0, 0);
                [labelView sizeToFit];
                labelcount++;
            }
        }
    }
}





@end
