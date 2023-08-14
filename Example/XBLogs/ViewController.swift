//
//  ViewController.swift
//  XBLogs
//
//  Created by 327847390@q.com on 08/11/2023.
//  Copyright (c) 2023 327847390@q.com. All rights reserved.
//

import UIKit
import XBLogs

class ViewController: UIViewController {

    private lazy var bubbleView: XBBubble = {
        return $0
    }(XBBubble())
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        XBLogs.sharedInstance().isOn = true
//
//        debugPrint("哈哈验证下可以不可以")
//        debugPrint(XBLogs.sharedInstance().logs)
        
        view.addSubview(bubbleView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

