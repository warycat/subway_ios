//
//  DatabaseMethod.m
//  MOODJO
//
//  Created by BACQUE Ludovic on 10/22/11.
//  Copyright 2011 digital tango. All rights reserved.
//

#import "DatabaseMethod.h"


@implementation DatabaseMethod
@synthesize databasePath;


static DatabaseMethod * DBmethod;
//Get the singleton object
+ (DatabaseMethod*) sharedDatabase
{
	if (nil == DBmethod)
	{
		DBmethod = [[DatabaseMethod alloc] init];
		
	}
	return DBmethod;
}


-(void)dealloc{
	
	[super dealloc];
}

- (id) init
{
	self = [super init];
        //DATABASE, INFO...
		
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		self.databasePath = [documentsDir stringByAppendingPathComponent:DATABASE_FILENAME];
		
		// check if the db is already installed
		NSFileManager *manager = [NSFileManager defaultManager];
		
		if(![manager fileExistsAtPath:self.databasePath]) {
			NSString *appPath = [[NSBundle mainBundle] pathForResource:DATABASE_FILENAME ofType:nil];
			[manager copyItemAtPath:appPath toPath:databasePath error:NULL];
        }
    
    return self;
    
}

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------


#define GET_VERSION_QUERY @"SELECT * FROM versioning WHERE locale='cn' ORDER BY timestamp DESC limit 0,1"
#define QUERY1
#define QUERY2


//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------



-(NSArray *)getVersions
{
    NSArray *results = [self executeSql:GET_VERSION_QUERY];
    return results;
}







// -------------------------------------------------------------------- METHOD KEY SQL ------------------------------------------------------------------------------



-(NSArray *)executeSql:(NSString *)sql
{
	sqlite3 *database;
	
	NSMutableDictionary *queryInfo = [NSMutableDictionary dictionary];
	[queryInfo setObject:sql forKey:@"sql"];
	
	NSMutableArray *rows = [NSMutableArray array];
	
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK){
		
		sqlite3_stmt *statement = NULL;
		
		if(sqlite3_prepare(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			BOOL needsToFetchColumnTypesAndNames = YES;
			NSArray *columnTypes = nil;
			NSArray *columnNames = nil;
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				if (needsToFetchColumnTypesAndNames) 
				{
					columnTypes = [self columnTypesForStatement:statement];
					columnNames = [self columnNamesForStatement:statement];
					needsToFetchColumnTypesAndNames = NO;
				}
				NSMutableDictionary *row = [[NSMutableDictionary alloc]init];
				[self copyValuesFromStatement:statement toRow:row queryInfo:queryInfo 
								  columnTypes:columnTypes columnNames:columnNames];
				
				
				[rows addObject:row];
				[row release];
			}
		}
		sqlite3_finalize(statement);
	}
	sqlite3_close(database);
	
	return rows;
}



-(NSArray *)columnNamesForStatement:(sqlite3_stmt *)statement
{
	int columnCount = sqlite3_column_count(statement);
	NSMutableArray *columnNames = [NSMutableArray array];
	for (int i =0; i < columnCount; i++)
	{
		[columnNames addObject:[NSString stringWithUTF8String:sqlite3_column_name(statement, i)]];
	} 
	return columnNames;
}

-(NSArray *)columnTypesForStatement:(sqlite3_stmt *)statement
{
	int columnCount = sqlite3_column_count(statement);
	NSMutableArray *columnTypes = [NSMutableArray array];
	for (int i =0; i < columnCount; i++)
	{
		[columnTypes addObject:[NSNumber numberWithInt:[self typeForStatement:statement column:i]]];
	} 
	return columnTypes;
}

-(int) typeForStatement:(sqlite3_stmt *)statement column: (int)column
{
	const char * columnType = sqlite3_column_decltype(statement, column);
	
	if(columnType != NULL)
	{
		return [self columnTypeToInt:[[NSString stringWithUTF8String:columnType]uppercaseString]];
	}
	return sqlite3_column_type(statement, column);	
}

-(int)columnTypeToInt:(NSString *)columnType
{
	if([columnType isEqualToString:@"INTEGER"])
	{
		return SQLITE_INTEGER;
	}else if([columnType isEqualToString:@"REAL"])
	{
		return SQLITE_FLOAT;
	}else if ([columnType isEqualToString:@"TEXT"])
	{
		return SQLITE_TEXT;
	}else if ([columnType isEqualToString:@"BLOB"]) 
	{
		return SQLITE_BLOB;
	}else if ([columnType isEqualToString:@"NULL"]) 
	{
		return SQLITE_NULL;
	}
	return SQLITE_TEXT;
	
}

-(void)copyValuesFromStatement:(sqlite3_stmt *)statement toRow:(NSMutableDictionary *)row queryInfo:(NSDictionary *)queryInfo
				   columnTypes:(NSArray *)columnTypes columnNames:(NSArray *)columnNames
{
	int columnCount = sqlite3_column_count(statement);
	
	for (int i=0; i<columnCount; i++) {
		id value = [self valueFromStatement:statement column:i 
								  queryInfo:queryInfo columnTypes: columnTypes];
		if (value != nil) 
		{
			[row setValue:value forKey:[columnNames objectAtIndex:i]];
		}
	}
}

-(id)valueFromStatement:(sqlite3_stmt *)statement column:(int)column 
			  queryInfo:(NSDictionary *)queryInfo columnTypes:(NSArray *)columnTypes
{
	int columnType = [[columnTypes objectAtIndex:column]intValue];
	if (columnType == SQLITE_INTEGER) {
		return [NSNumber numberWithInt:sqlite3_column_int(statement, column)];
	}else if(columnType == SQLITE_FLOAT)
	{
		return [NSNumber numberWithDouble:sqlite3_column_double(statement, column)];
	}else if (columnType == SQLITE_TEXT) {
		const char *text = (const char *)sqlite3_column_text(statement, column);
		if(text != nil)
		{
			return [NSString stringWithUTF8String:text];
		}else {return nil;}
	}else if (columnType == SQLITE_BLOB) {
		return [NSData dataWithBytes:sqlite3_column_blob(statement, column) length:sqlite3_column_bytes(statement, column)];
	}else if (columnType == SQLITE_NULL)
	{
		return nil;
	}
	return nil;	
}







@end
