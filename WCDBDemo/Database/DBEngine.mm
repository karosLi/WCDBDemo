//
//  DBEngine.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//
#import "DBEngine.h"
#import <WCDB/WCDB.h>

@implementation DBEngine

#pragma mark - public methods
+ (void)setupDatabase {
    [self sharedDatabase];
}

+ (WCTDatabase *)sharedDatabase {
    static WCTDatabase *database;
    if (!database) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"DB.sqlite"];
        database = [[WCTDatabase alloc] initWithPath:filePath];
        [self didSetupDatabase];
    }
    
    return database;
}

+ (void)registerTable:(Class<DBEngineTableDelegate>)table {
    [[self registerdTables] addObject:table];
}

#pragma mark - private method

+ (NSMutableArray *)registerdTables {
    static NSMutableArray *registerdTables;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registerdTables = [NSMutableArray array];
    });
    
    return registerdTables;
}

+ (void)didSetupDatabase {
    __weak typeof(self) weakSelf = self;
    [[self registerdTables] enumerateObjectsUsingBlock:^(Class<DBEngineTableDelegate> table, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([table respondsToSelector:@selector(dbEngine:didSetupDatabase:)]) {
            [table dbEngine:weakSelf didSetupDatabase:[weakSelf sharedDatabase]];
        }
    }];
    
    [[self registerdTables] removeAllObjects];
}

@end
