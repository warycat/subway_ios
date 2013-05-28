//
//  DatabaseMethod.h
//  MOODJO
//
//  Created by BACQUE Ludovic on 10/22/11.
//  Copyright 2011 digital tango. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseMethod : NSObject {

	NSString *databasePath;

}

@property (nonatomic, retain) NSString *databasePath;

+ (DatabaseMethod*) sharedDatabase;






- (NSArray *)getVersions;






// -------------------------------------------------------------------- METHOD KEY SQL ------------------------------------------------------------------------------
-(NSArray *)executeSql:(NSString *)sql;
-(NSArray *)columnNamesForStatement:(sqlite3_stmt *)statement;
-(NSArray *)columnTypesForStatement:(sqlite3_stmt *)statement;
-(int) typeForStatement:(sqlite3_stmt *)statement column: (int)column;
-(int)columnTypeToInt:(NSString *)columnType;
-(void)copyValuesFromStatement:(sqlite3_stmt *)statement toRow:(NSMutableDictionary *)row queryInfo:(NSDictionary *)queryInfo
				   columnTypes:(NSArray *)columnTypes columnNames:(NSArray *)columnNames;
-(id)valueFromStatement:(sqlite3_stmt *)statement column:(int)column 
			  queryInfo:(NSDictionary *)queryInfo columnTypes:(NSArray *)columnTypes;


@end
