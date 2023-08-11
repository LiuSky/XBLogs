//
//  XBLogs.m
//  Created on 2023/8/11
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 LMKJ. All rights reserved.
//  @author 刘小彬(liuxiaomike@gmail.com)   
//

#import "XBLogs.h"
#import "fishhook.h"

//函数指针，用来保存原始的函数的地址
static void(*sys_nslog)(NSString *format, ...);

//新的NSLog
void myNSLog(NSString *format, ...) {
    
    va_list vl;
    va_start(vl, format);
    NSString* str = [[NSString alloc] initWithFormat:format arguments:vl];
    va_end(vl);
    
    [[XBLogs sharedInstance] addNSLog:str];
    sys_nslog(@"%@",str);
}

@interface XBLogs()
@property(nonatomic, strong) NSMutableArray<NSString *> *array;
@end


@implementation XBLogs

+(instancetype)sharedInstance {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// 开启日志监听
-(void)startNSLogMonitor {
    
    struct rebinding logRebinding;
    logRebinding.name = "NSLog"; //需要Hook的函数名称
    logRebinding.replacement = myNSLog; //新函数地址
    logRebinding.replaced = (void *) &sys_nslog; // 原始函数地址指针
    struct rebinding arr[1] = {logRebinding};
    rebind_symbols(arr, 1);
}


/// 关闭日志监听
-(void)stopNSLogMonitor {
    
    struct rebinding logRebinding;
    logRebinding.name = "NSLog"; //需要Hook的函数名称
    logRebinding.replacement = NULL; //新函数地址
    logRebinding.replaced = (void*)&sys_nslog; // 原始函数地址指针
    
    struct rebinding arr[1] = {logRebinding};
    rebind_symbols(arr, 1);
}
-(void)setIsOn:(BOOL)isOn {
    _isOn = isOn;
    if (isOn) {
        [self startNSLogMonitor];
    } else {
        [self stopNSLogMonitor];
    }
}
 
// 日志写入缓存
-(void)addNSLog:(NSString *)log {
    [self.array addObject:log];
}

-(NSMutableArray<NSString *> *)logs {
    return self.array;
}

-(NSMutableArray<NSString *> *)array {
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}
@end
