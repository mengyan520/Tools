//
//  DCTimer.h
//  定时器循环引用问题
//
//  Created by ma on 2021/5/26.
//

#import <Foundation/Foundation.h>

@interface DCTimer : NSObject
+ (NSString *)execTask:(void(^)(void))task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;
+ (NSString *)execTask:(id)target
              selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;
+ (void)cancelTask:(NSString *)task;
@end
