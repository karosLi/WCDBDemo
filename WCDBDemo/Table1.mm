//
//  Table1.m
//  WCDBDemo
//
//  Created by karos li on 2018/1/3.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "Table1.h"
#import "Table1+WCTTableCoding.h"
#import <WCDB/WCDB.h>
#import "DBEngine.h"
#import "DBManager.h"

@interface Table1 () <DBEngineTableDelegate>

@end

@implementation Table1

WCDB_IMPLEMENTATION(Table1)
WCDB_SYNTHESIZE(Table1, dd)
WCDB_SYNTHESIZE(Table1, name)

WCDB_PRIMARY_AUTO_INCREMENT(Table1, dd)

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


@end
