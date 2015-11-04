//
//  MyCustomFormatter.h
//  SZNotificationDemo
//
//  Created by 陈圣治 on 15/11/4.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface SZNotificationLogFormatter : NSObject <DDLogFormatter> {
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
