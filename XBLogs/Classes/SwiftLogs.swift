//
//  SwiftLogs.swift
//  Created on 2023/8/12
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 LMKJ. All rights reserved.
//  @author 刘小彬(liuxiaomike@gmail.com)   
//

import Foundation

// 重载print方法
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
   #if DEBUG
    // 调用原系统的打印方法 保持控制台的正常输出
    Swift.print(items, separator: separator, terminator: terminator)
    
    guard XBLogs.sharedInstance().isOn else { return }
    let str =  items.map { "\($0)" }.joined(separator: separator)
    // 日志写入缓存
    XBLogs.sharedInstance().addNSLog(str)
  #endif
}

/// 重载debugprint
public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
 // 调用原系统的打印方法 保持控制台的正常输出
 Swift.debugPrint(items, separator: separator, terminator: terminator)
 
 guard XBLogs.sharedInstance().isOn else { return }
 let str =  items.map { "\($0)" }.joined(separator: separator)
 // 日志写入缓存
 XBLogs.sharedInstance().addNSLog(str)
#endif
}
