//
//  MenuMethod.h
//  Subway
//
//  Created by ludo on 4/18/13.
//  Copyright (c) 2013 C3O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuMethod : NSObject {

    NSMutableArray *menuArray;

    
}

@property (retain, nonatomic) NSMutableArray *menuArray;

+ (MenuMethod*) sharedMenu;

-(void)checkMeals;


@end

