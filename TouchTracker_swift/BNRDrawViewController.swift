//
//  BNRDrawViewController.swift
//  TouchTracker_swift
//
//  Created by 毛泉 on 2016/10/20.
//  Copyright © 2016年 MaoQuan. All rights reserved.
//

import UIKit


class BNRDrawViewController: ViewController {
    override func loadView() {
        self.view = BNRDrawView(frame: CGRect.zero);
    }
    
}
