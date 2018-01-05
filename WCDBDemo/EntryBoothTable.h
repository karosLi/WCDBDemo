//
//  EntryBoothTable.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//

#import <Foundation/Foundation.h>

//_id, sceneCode, boothCode, remindType(显示一次，显示多次), remindDate, remindStatus(1, 0)
typedef NS_ENUM(NSInteger, EntryBoothTableRemindType) {
    EntryBoothTableRemindTypeOne = 1,
    EntryBoothTableRemindTypeMore
};

typedef NS_ENUM(NSInteger, EntryBoothTableRemindStatus) {
    EntryBoothTableRemindStatusUnreminded,
    EntryBoothTableRemindStatusReminded
};

@interface EntryBoothTable : NSObject

@property (nonatomic, assign) long long _id;
@property (nonatomic, copy) NSString *sceneCode;
@property (nonatomic, copy) NSString *boothCode;
@property (nonatomic, assign) EntryBoothTableRemindType remindType;
//yyyy-MM-dd
@property (nonatomic, copy) NSString *remindDate;
@property (nonatomic, assign) EntryBoothTableRemindStatus remindStatus;

#pragma mark - SQL
+ (BOOL)insertOrReplaceObject:(EntryBoothTable *)model;
+ (EntryBoothTable *)getOneObjectOnResults:(NSString *)sceneCode boothCode:(NSString *)boothCode;

@end
