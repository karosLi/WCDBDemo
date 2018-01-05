//
//  DBManager.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 数据库管理类，基础 WCDB 去构建的，性能由于 FMDB，支持读写并发
 
 使用教程
 https://github.com/Tencent/wcdb/wiki/iOS+macOS使用教程
 https://github.com/Tencent/wcdb/wiki/ORM使用教程#WCTTableCoding文件模版
 
 **/

@interface DBManager : NSObject

// 安装数据库
+ (void)setupDatabase;

// 串行队列
+ (dispatch_queue_t)serialQueque;
// 并行队列
+ (dispatch_queue_t)concurrentQueque;

@end
