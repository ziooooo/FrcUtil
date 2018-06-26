//
//  FrcView+Extension.swift
//  FrcUtil
//
//  Created by ziooooo on 2018/6/25.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

typealias FrcView = UIView

extension FrcView {
    var frc: FrcManager {
        return FrcManager(view: self)
    }
}
