//
//  ViewController.m
//  WCDBDemo
//
//  Created by karos li on 2018/1/3.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "ViewController.h"
#import <WCDB/WCDB.h>
#import "Table1+WCTTableCoding.h"
#import "Table1.h"

#import "EntryBoothTable+WCTTableCoding.h"
#import "EntryBoothTable.h"
#import "DBManager.h"
#import "DBEngine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 安装数据库，并创建表
    [DBManager setupDatabase];
    
    WCTDatabase *database = [DBEngine sharedDatabase];
    NSString *tableName = NSStringFromClass(Table1.class);
    Table1 *t = [[Table1 alloc] init];
    t.isAutoIncrement = YES;
    t.name = @"karos";
    [database insertObject:t into:tableName];
    
    t = [[Table1 alloc] init];
    t.isAutoIncrement = YES;
    t.name = @"karos1";
    [database insertObject:t into:tableName];
    
    Table1 *result = [database getOneObjectOnResults:Table1.AnyProperty.count().as(Table1.dd) fromTable:tableName];
    NSLog(@"count %zd", result.dd);
    
    result = [database getOneObjectOnResults:Table1.AllProperties fromTable:tableName where:Table1.dd == 1];
    NSLog(@"name %@", result.name);
    
    NSArray<Table1 *> *datas = [database getAllObjectsOfClass:Table1.class fromTable:tableName];
    [datas enumerateObjectsUsingBlock:^(Table1 * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %zd name: %@", obj.dd, obj.name);
    }];
    
    //_id, sceneCode, boothCode, remindType(显示一次，显示多次), remindDate, remindStatus(1, 0)
    NSString *entryBoothTableName = NSStringFromClass(EntryBoothTable.class);
    [database createTableAndIndexesOfName:entryBoothTableName withClass:EntryBoothTable.class];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    EntryBoothTable *t1 = [EntryBoothTable new];
    t1.isAutoIncrement = YES;
    t1.sceneCode = @"home";
    t1.boothCode = @"homeEnter";
    t1.remindType = EntryBoothTableRemindTypeOne;
    t1.remindDate = @"2018-01-03";
    t1.remindStatus = EntryBoothTableRemindStatusReminded;
    
    [database insertOrReplaceObject:t1 into:entryBoothTableName];
    
    t1 = [EntryBoothTable new];
    t1.isAutoIncrement = YES;
    t1.sceneCode = @"home";
    t1.boothCode = @"homeEnter";
    t1.remindType = EntryBoothTableRemindTypeMore;
    t1.remindDate = @"2018-01-04";
    t1.remindStatus = EntryBoothTableRemindStatusUnreminded;
    
    [database insertOrReplaceObject:t1 into:entryBoothTableName];
    
    NSArray<EntryBoothTable *> *data1s = [database getAllObjectsOfClass:EntryBoothTable.class fromTable:entryBoothTableName];
    [data1s enumerateObjectsUsingBlock:^(EntryBoothTable * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"_id: %zd sceneCode: %@ boothCode: %@ remindType: %zd remindDate: %@ remindStatus: %zd", obj._id, obj.sceneCode, obj.boothCode, obj.remindType, obj.remindDate, obj.remindStatus);
    }];
    
    EntryBoothTable *obj = [database getOneObjectOnResults:EntryBoothTable.AllProperties fromTable:entryBoothTableName where:EntryBoothTable.sceneCode == @"home" && EntryBoothTable.boothCode == @"homeEnter"];
    NSLog(@"_id: %zd sceneCode: %@ boothCode: %@ remindType: %zd remindDate: %@ remindStatus: %zd", obj._id, obj.sceneCode, obj.boothCode, obj.remindType, obj.remindDate, obj.remindStatus);
    
    // 插入记录封装在 model 里
    [EntryBoothTable insertOrReplaceObject:t1];
    
    
}



@end
