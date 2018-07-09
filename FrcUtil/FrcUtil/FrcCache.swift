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
    private let cache: NSCache<NSString, UIImage>!
    private init() {
        cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 5
    }
    
    func cache(image: UIImage, name: String) {
        cache.setObject(image, forKey: NSString(string: name))
    }
    func image(name: String) -> UIImage? {
        return cache.object(forKey: NSString(string: name))
    }
}
