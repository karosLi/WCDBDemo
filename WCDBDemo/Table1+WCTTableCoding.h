//
//  Table1+WCTTableCoding.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/3.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "Table1.h"
#import <WCDB/WCDB.h>

@interface Table1 (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(dd)
WCDB_PROPERTY(name)

@end
