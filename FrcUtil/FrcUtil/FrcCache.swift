//
//  FrcCache.swift
//  FrcUtil
//
//  Created by ziooooo on 2018/6/26.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class FrcCache {
    static let shared = FrcCache()
    private init() {}
    
    // MARK: - 缓存相关
    private var imgCache = [String: UIImage]()
    
    func cache(image: UIImage, name: String) {
        imgCache[name] = image
    }
    func image(name: String) -> UIImage? {
        return imgCache[name]
    }
}
