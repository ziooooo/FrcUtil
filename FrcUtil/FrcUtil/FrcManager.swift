//
//  FrcManager.swift
//  FrcUtil
//
//  Created by ziooooo on 2018/6/25.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class FrcManager {
    
    let view: FrcView
    init(view: FrcView) {
        self.view = view
    }
    
    func add(roundingCorners: UIRectCorner, radius: CGFloat, bgColor: UIColor, fillColor: UIColor? = nil, bgRect: CGRect? = nil){
        
        let name = fileName(roundingCorners: roundingCorners, radius: radius, bgColor: bgColor, fillColor: fillColor)
        
        var roundImg: UIImage
        
        if let image = cachedImage(with: name) {
            roundImg = image
        }
        else {
            //生成图片
            let roundedRect = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            let rectPath = UIBezierPath(rect: roundedRect)
            let roundPath = UIBezierPath(roundedRect: roundedRect.insetBy(dx: -0.3, dy: -0.3), byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
            rectPath.append(roundPath)
            rectPath.usesEvenOddFillRule = true
            
            UIGraphicsBeginImageContextWithOptions(roundedRect.size, false, UIScreen.main.scale)
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            var finalFillColor: UIColor = UIColor.clear
            if fillColor != nil {
                finalFillColor = fillColor!
            }
            context.setFillColor(finalFillColor.cgColor)
            context.fill(roundedRect)
            context.setFillColor(bgColor.cgColor)
            context.addPath(rectPath.cgPath)
            context.fillPath(using: .evenOdd)
            
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
            UIGraphicsEndImageContext();
            roundImg = image
            saveImage(image, name: name)
        }
        
        //设置圆角图片
        if let old = self.roundLayer() {
            old.removeFromSuperlayer()
        }
        let roundLayer = CALayer()
        roundLayer.name = "roundLayer"
        roundLayer.frame = bgRect ?? view.bounds
        roundLayer.contents = roundImg.cgImage
        roundLayer.contentsScale = UIScreen.main.scale
        roundLayer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0, height: 0)
        view.layer.insertSublayer(roundLayer, at: 0)
    }
    
    // MARK: - 清除圆角
    func clearRound() {
        if let old = self.roundLayer() {
            old.removeFromSuperlayer()
        }
    }
}

// MARK: - 工具方法
extension FrcManager {
    /// 颜色转字符串
    private func colorString(_ color: UIColor) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rStr = String.init(format: "%.5lf", r)
        let gStr = String.init(format: "%.5lf", g)
        let bStr = String.init(format: "%.5lf", b)
        let aStr = String.init(format: "%.5lf", a)
        return "color\(rStr)\(gStr)\(bStr)\(aStr)"
    }
    /// 获得圆角图层
    private func roundLayer() -> CALayer? {
        guard let sublayers = view.layer.sublayers else { return nil }
        guard let layer = sublayers.first else { return nil }
        guard let name = layer.name else { return nil }
        return name == "roundLayer" ? layer : nil
    }
    /// 生成文件名
    private func fileName(roundingCorners: UIRectCorner, radius: CGFloat, bgColor: UIColor, fillColor: UIColor?) -> String {
        let cornerStr = "cor\(roundingCorners.rawValue)"
        let radiusStr = "rad\(radius)"
        let bgColorStr = colorString(bgColor)
        let fillColorStr = colorString(fillColor ?? UIColor.clear)
        
        let fileName = cornerStr + radiusStr + bgColorStr + fillColorStr
        return fileName.replacingOccurrences(of: ".", with: "_")
    }
}
// MARK: - 文件相关操作
extension FrcManager {
    private var basePath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                   .userDomainMask, true).first! + "/FrcStorage/"
    }
    
    private func filePath(name: String) -> String? {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: basePath) {
            try! fileManager.createDirectory(atPath: basePath, withIntermediateDirectories: true, attributes: nil)
        }
        
        let filePath = "\(basePath)/\(name)"
        
        if fileManager.fileExists(atPath: filePath) {
            return filePath
        }
        return nil
    }
    
    private func cachedImage(with name: String) -> UIImage? {
        if let image = FrcCache.shared.image(name: name) {
            return image
        }
        else {
            if let path = filePath(name: name) {
                let image = UIImage(contentsOfFile: path)!
                FrcCache.shared.cache(image: image, name: name)
                return image
            }
            else {
                return nil
            }
        }
    }
    
    private func saveImage(_ image:UIImage, name: String) {
        let url = URL(fileURLWithPath: "\(basePath)\(name)")
        print("\(basePath)\(name)")
        do {
            try UIImagePNGRepresentation(image)?.write(to: url)
        } catch {}
        
        FrcCache.shared.cache(image: image, name: name)
        
    }
}
