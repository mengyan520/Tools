//
//  DCTimer.m
//  定时器循环引用问题
//
//  Created by ma on 2021/5/26.
//

#import "DCTimer.h"

@implementation DCTimer
// 注意多线程操作字典
static NSMutableDictionary *timers;
dispatch_semaphore_t semaphore;
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers = [NSMutableDictionary dictionary];
        semaphore = dispatch_semaphore_create(1);
    });
}
+ (NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC), interval*NSEC_PER_SEC, 0);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    // 定时器唯一标识
    NSString *name = [NSString stringWithFormat:@"%lu",(unsigned long)timers.count];
    timers[name] = timer;
    dispatch_semaphore_signal(semaphore);
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    dispatch_resume(timer);
    return name;
}
+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!target || !selector) {
        return nil;
    }
    return [self execTask:^{
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
            
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}
+ (void)cancelTask:(NSString *)task {
    NSLog(@"%zd",timers.count);
    if (task.length <= 0) {
        return;
    }
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (timers[task]) {
        dispatch_source_cancel(timers[task]);
        [timers removeObjectForKey:task];
    }
    dispatch_semaphore_signal(semaphore);
}
@end
