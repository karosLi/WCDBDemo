//
//  DBEngine.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

/**
 数据库管理类，基础 WCDB 去构建的，性能由于 FMDB，支持读写并发
 
 使用教程
 https://github.com/Tencent/wcdb/wiki/iOS+macOS使用教程
 https://github.com/Tencent/wcdb/wiki/ORM使用教程#WCTTableCoding文件模版
 
 **/

@class DBEngine;
@protocol DBEngineTableDelegate <NSObject>

@optional
// 数据库安装完成回调，只有注册的表，才会被回调
+ (void)dbEngine:(DBEngine *)dbEngine didSetupDatabase:(WCTDatabase *)database;

@end

@interface DBEngine : NSObject

// 安装数据库
+ (void)setupDatabase;
+ (WCTDatabase *)sharedDatabase;

// 注册表
+ (void)registerTable:(Class<DBEngineTableDelegate>)table;

@end
