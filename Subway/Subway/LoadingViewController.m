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

#define delta 100

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateWith:(NSString *)timestamp and:(NSString *)locale
{
    NSLog(@"%s",_cmd);

    NSString *upgrade_url = [NSString stringWithFormat:@"http://222.73.219.19:20114/upgrade?ts=%d&locale=%@&screen_size=%@",timestamp.integerValue,locale,@"640"];
    NSLog(@"%@",upgrade_url);
    NSURLRequest *upgradeRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:upgrade_url]];
    [NSURLConnection sendAsynchronousRequest:upgradeRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *upgradeResponse, NSData *upgradeData, NSError *upgradeError) {
        self.progressLabel.hidden = NO;
        self.progressLabel.text = @"0%%";
        if (upgradeData) {
            NSDictionary *upgrade = [NSJSONSerialization JSONObjectWithData:upgradeData options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *body = [upgrade objectForKey:@"data"];
            NSArray *files = [body objectForKey:@"files"];
            NSArray *pages = [body objectForKey:@"pages"];
            NSArray *products = [body objectForKey:@"products"];
            [[NSUserDefaults standardUserDefaults]setValue:files forKey:@"files"];
            [[NSUserDefaults standardUserDefaults]setValue:pages forKey:@"pages"];
            [[NSUserDefaults standardUserDefaults]setValue:products forKey:@"products"];
            __block NSInteger sum = 0;
            for (NSDictionary *file in files) {
                NSString *url = [file objectForKey:@"path"];
                NSString *filename = [file objectForKey:@"filename"];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    sum++;
                    [self saveImage:data with:filename];
                    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",100.0 * sum/files.count];
                    if (sum == files.count) {
                        HomePageController *hvc = [[[HomePageController alloc]initWithNibName:@"HomePageController" bundle:nil]autorelease];
                        UIImage *image = [settingMethod getImagePath:@"spita.png"];
                        NSLog(@"%@",[NSValue valueWithCGSize:image.size]);
                        
                        [self.navigationController pushViewController:hvc animated:NO];
                    }
                }];
            }
        }
    }];
    //    
}

- (BOOL)saveImage:(NSData *)data with:(NSString *)filename
{
	// DOCUMENT PATH
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	// FILEPATH
	NSString* filepath = [NSString stringWithFormat:@"%@/img/%@", documentsDirectory,filename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"%@/img" isDirectory:nil]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:@"%@/img" withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return [data writeToFile:filepath atomically:YES];
}

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
    NSArray *versions = [databaseMethod getVersions];
    NSDictionary *version = [versions lastObject];
    NSString *then = [version objectForKey:@"timestamp"];
    NSInteger lastTimestamp = then.integerValue;
    NSNumber *now = [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]];
    NSInteger currentTimestamp = now.integerValue;
    self.progressLabel.hidden = YES;
    if (currentTimestamp - lastTimestamp > delta) {
        [self updateWith:now.stringValue and:[settingMethod getUserLanguage]];
    }
    // Do any additional setup after loading the view from its nib.
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
