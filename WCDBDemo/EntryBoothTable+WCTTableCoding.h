//
//  EntryBoothTable+WCTTableCoding.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "EntryBoothTable.h"
#import <WCDB/WCDB.h>

@interface EntryBoothTable (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(_id)
WCDB_PROPERTY(sceneCode)
WCDB_PROPERTY(boothCode)
WCDB_PROPERTY(remindType)
WCDB_PROPERTY(remindDate)
WCDB_PROPERTY(remindStatus)

@end
