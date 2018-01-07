//
//  DBManager.h
//  WCDBDemo
//
//  Created by karos li on 2018/1/4.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "DBManager.h"
#import "DBEngine.h"

@implementation DBManager

#pragma mark - public methods
+ (void)setupDatabase {
    [DBEngine setupDatabase];
}

+ (dispatch_queue_t)serialQueque {
    static dispatch_queue_t s_queue = dispatch_queue_create("LKDBManager-serialQueque", DISPATCH_QUEUE_SERIAL);
    return s_queue;
}

+ (dispatch_queue_t)concurrentQueque {
    static dispatch_queue_t s_queue = dispatch_queue_create("LKDBManager-concurrentQueque", DISPATCH_QUEUE_CONCURRENT);
    return s_queue;
}

@end
