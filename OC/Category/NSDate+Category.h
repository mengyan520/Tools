//
//  NSDate+Category.h
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)
/** Time stamp */
+ (NSString *)dc_timeStamp;

/** current time - service time = ? */
+ (NSString *)dc_timeStringWithInterval:(NSTimeInterval) time;

/** time year-month-day */
+ (NSString *)dc_formatTimeWithInterval:(NSTimeInterval) time;

/** time year-month-dat hh mm*/
+ (NSString *)dc_formatAbsTimeWithInterval:(NSTimeInterval) time;
+ (NSString *)dc_formatAbssTimeWithInterval:(NSTimeInterval) time;
@end
