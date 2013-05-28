//
//  BlockSinaWeibo.h
//  BlockSinaWeibo
//
//  Created by Larry on 12/29/12.
//  Copyright (c) 2012 warycat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"

@interface BlockSinaWeibo : NSObject <SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property (nonatomic, strong) SinaWeibo *sinaWeibo;
@property (nonatomic, strong) NSMutableArray *requests;

+ (BlockSinaWeibo *)sharedClient;

+ (void)loginWithHandler:(void(^)())handler;

@end
