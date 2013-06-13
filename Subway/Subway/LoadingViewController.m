//
//  LoadingViewController.m
//  Subway
//
//  Created by Larry Fantasy on 5/16/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "LoadingViewController.h"
#import "DatabaseMethod.h"
#import "HomePageController.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

#define delta 1296000
//#define delta 100

@interface LoadingViewController ()

@end

@implementation LoadingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 1.3; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.cicle.layer addAnimation:rotation forKey:@"Spin"];
    
    
    // GET VERSION
    NSArray *versions = [databaseMethod getVersions];
    NSDictionary *version = [versions lastObject];
    NSNumber *then = [version objectForKey:@"timestamp"];
    NSInteger lastTimestamp = then.integerValue;
    NSNumber *now = [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]];
    NSInteger currentTimestamp = now.integerValue;
    
    self.progressLabel.hidden = YES;
        
        // Update the files if the timestamp is updated
        if (currentTimestamp - lastTimestamp > delta) {
            
            [self updateWith:then.integerValue and:[settingMethod getUserLanguage]];
            
        }else{
            
            HomePageController *hvc = [[[HomePageController alloc]initWithNibName:@"HomePageController" bundle:nil]autorelease];
            [self.navigationController setViewControllers:@[hvc] animated:YES];
            
        }
        
    
}


#pragma mark ---------------
#pragma mark --------------- Saving Image


- (BOOL)saveImage:(NSData *)data with:(NSString *)filename
{
	// DOCUMENT PATH
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	// FILEPATH
	NSString* filepath = [NSString stringWithFormat:@"%@/img/%@", documentsDirectory,filename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"%@/img" isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:@"%@/img" withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return [data writeToFile:filepath atomically:YES];
}


#pragma mark ---------------
#pragma mark --------------- UPDATE Function

- (void)updateWith:(NSInteger )timestamp and:(NSString *)locale
{
    
    NSString *upgrade_url = [NSString stringWithFormat:@"%@upgrade?ts=%d&locale=%@&screen_size=%@",ADRESS, timestamp, locale, @"640"];
    NSLog(@"%@",upgrade_url);
    
    NSURLRequest *upgradeRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:upgrade_url]];
    [NSURLConnection sendAsynchronousRequest:upgradeRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *upgradeResponse, NSData *upgradeData, NSError *upgradeError) {
        
        self.progressLabel.text = @"0%";
        self.progressLabel.hidden = NO;
    
        if (upgradeData) {
            
            NSDictionary *upgrade = [NSJSONSerialization JSONObjectWithData:upgradeData options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *body = [upgrade objectForKey:@"data"];
            NSArray *files = [body objectForKey:@"files"];
            NSArray *pages = [body objectForKey:@"pages"];
            NSArray *products = [body objectForKey:@"products"];
            
            
            // Saving files into UserDefaults 
            NSData *datafiles = [NSKeyedArchiver archivedDataWithRootObject:files];
            [[NSUserDefaults standardUserDefaults]setValue:datafiles forKey:@"files"];
            
            NSData *datapages = [NSKeyedArchiver archivedDataWithRootObject:pages];
            [[NSUserDefaults standardUserDefaults]setValue:datapages forKey:@"pages"];
            
            NSData *dataproducts = [NSKeyedArchiver archivedDataWithRootObject:products];
            [[NSUserDefaults standardUserDefaults]setValue:dataproducts forKey:@"products"];

            
            __block NSInteger sum = 0;
            
            for (NSDictionary *file in files) {
                
                NSString *url = [file objectForKey:@"path"];
                NSString *filename = [file objectForKey:@"filename"];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    
                    sum++;
                    [self saveImage:data with:filename];
                    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",100.0 * sum/files.count];
                    
                    // End of the cicle - launch the HomePage
                    if (sum == files.count) {
                        
                        HomePageController *hvc = [[[HomePageController alloc]initWithNibName:@"HomePageController" bundle:nil]autorelease];
                        [self.navigationController setViewControllers:@[hvc] animated:YES];
                        NSNumber *now = [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]];
                        NSInteger currentTimestamp = now.integerValue;
                        [databaseMethod addVersion:currentTimestamp :locale];
                        
                    }
                    
                    
                }];
                
            }
            
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_cicle release];
    [_progressLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCicle:nil];
    [self setProgressLabel:nil];
    [super viewDidUnload];
}
@end
