//
//  NSDate+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)
+ (NSString *)dc_timeStamp
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}
+ (NSString *)dc_timeStringWithInterval:(NSTimeInterval)time
{
    NSInteger distance = [[NSDate date] timeIntervalSince1970] - time/1000;
    NSString *string;
    if (distance < 1){//avoid 0 seconds
        string = @"刚刚";
    }
    else if (distance < 60) {
        string = [NSString stringWithFormat:@"%@秒前", @(distance)];
    }
    else if (distance < 3600) {//60 * 60
        distance = distance / 60;
        string = [NSString stringWithFormat:@"%@分钟前", @(distance)];
    }
    else if (distance < 86400) {//60 * 60 * 24
        distance = distance / 3600;
        string = [NSString stringWithFormat:@"%@小时前", @(distance)];
    }
    else if (distance < 604800) {//60 * 60 * 24 * 7
        distance = distance / 86400;
        string = [NSString stringWithFormat:@"%@天前", @(distance)];
    }
    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
        distance = distance / 604800;
        string = [NSString stringWithFormat:@"%@周前", @(distance)];
    }
    else {
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
        
    }
    return string;
}

+ (NSString *)dc_formatTimeWithInterval:(NSTimeInterval) time
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
    return string;
}
+ (NSString *)dc_formatAbsTimeWithInterval:(NSTimeInterval) time
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
    return string;
}
+ (NSString *)dc_formatAbssTimeWithInterval:(NSTimeInterval) time
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
    return string;
}

@end
