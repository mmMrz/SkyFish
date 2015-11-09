//
//  CSMessageCache.h
//  CQSQ
//
//  Created by 张燕枭 on 15/7/13.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface CSMessageCache : NSObject
{
    sqlite3 *db;
}

@end
