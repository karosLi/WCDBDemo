//
//  EntryBoothTable.m
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "EntryBoothTable.h"
#import "EntryBoothTable+WCTTableCoding.h"
#import <WCDB/WCDB.h>
#import <WCDB/WCDB.h>
#import "DBEngine.h"
#import "DBManager.h"

@interface EntryBoothTable () <DBEngineTableDelegate>

@end

@implementation EntryBoothTable

WCDB_IMPLEMENTATION(EntryBoothTable)
WCDB_SYNTHESIZE(EntryBoothTable, _id)
WCDB_SYNTHESIZE(EntryBoothTable, sceneCode)
WCDB_SYNTHESIZE(EntryBoothTable, boothCode)
WCDB_SYNTHESIZE(EntryBoothTable, remindType)
WCDB_SYNTHESIZE(EntryBoothTable, remindDate)
WCDB_SYNTHESIZE(EntryBoothTable, remindStatus)

WCDB_PRIMARY_AUTO_INCREMENT(EntryBoothTable, _id)
WCDB_MULTI_UNIQUE(EntryBoothTable, "MultiUniqueConstraint", sceneCode)
WCDB_MULTI_UNIQUE(EntryBoothTable, "MultiUniqueConstraint", boothCode)

#pragma mark - DBEngineTableDelegate
+ (void)dbEngine:(DBEngine *)dbEngine didSetupDatabase:(WCTDatabase *)database {
    dispatch_async([DBManager serialQueque], ^{
        [[DBEngine sharedDatabase] createTableAndIndexesOfName:NSStringFromClass(self.class) withClass:self.class];
    });
}

+ (void)load {
    dispatch_async([DBManager concurrentQueque], ^{
        [DBEngine registerTable:self];
    });
}

#pragma mark - SQL
+ (BOOL)insertOrReplaceObject:(EntryBoothTable *)model {
    model.isAutoIncrement = YES;
    return [[DBEngine sharedDatabase] insertOrReplaceObject:model into:NSStringFromClass(self.class)];
}

+ (EntryBoothTable *)getOneObjectOnResults:(NSString *)sceneCode boothCode:(NSString *)boothCode {
    return [[DBEngine sharedDatabase] getOneObjectOnResults:self.class.AllProperties fromTable:NSStringFromClass(self.class) where:self.class.sceneCode == sceneCode && self.class.boothCode == boothCode];
}

@end
