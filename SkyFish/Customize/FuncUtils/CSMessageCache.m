//
//  CSMessageCache.m
//  CQSQ
//
//  Created by 张燕枭 on 15/7/13.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "CSMessageCache.h"

#define DBNAME @"messageCache.sqlite"

@implementation CSMessageCache

- (void)openDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}

- (void)createMessageTable
{
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT)";
    [self execSql:sqlCreateTable];
}

- (void)createFriendTable
{
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS FRIENDTABLE (ID INTEGER PRIMARY KEY, name TEXT, age INTEGER, address TEXT)";
    [self execSql:sqlCreateTable];
}

@end
