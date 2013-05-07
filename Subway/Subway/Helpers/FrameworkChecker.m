//
//  FrameworkChecker.m
//  Subway
//
//  Created by XIA YINCHU on 5/7/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import "FrameworkChecker.h"

@implementation FrameworkChecker
+(BOOL)isTwitterAvailable {
    return NSClassFromString(@"TWTweetComposeViewController") != nil;
}

+(BOOL)isSocialAvailable {
    return NSClassFromString(@"SLComposeViewController") != nil;
}
@end
