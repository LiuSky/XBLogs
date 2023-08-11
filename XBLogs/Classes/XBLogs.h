//
//  XBLogs.h
//  Created on 2023/8/11
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 LMKJ. All rights reserved.
//  @author 刘小彬(liuxiaomike@gmail.com)   
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// MARK - 日志管理类
@interface XBLogs : NSObject

/// 单利
+(instancetype)sharedInstance;
@property(nonatomic, assign) BOOL isOn; //是否开启
@property(nonatomic, strong, readonly) NSMutableArray<NSString *> *logs;//日志集合数据


/// 添加日志
/// - Parameter log: log
-(void)addNSLog: (NSString *)log;
@end

NS_ASSUME_NONNULL_END
