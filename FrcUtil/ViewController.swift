//
//  ViewController.swift
//  FrcUtil
//
//  Created by ziooooo on 2018/6/25.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 120, height: 333))
        view1.backgroundColor = UIColor.gray
        view.addSubview(view1)
        view1.frc.add(roundingCorners: [.topLeft, .bottomLeft], radius: 15, bgColor: UIColor.red)
        
        let view2 = UIView(frame: CGRect(x: 250, y: 100, width: 50, height: 40))
        view2.backgroundColor = UIColor.gray
        view.addSubview(view2)
        view2.frc.add(roundingCorners: [.topLeft, .bottomLeft], radius: 15, bgColor: UIColor.red)
        
        let view3 = UIView(frame: CGRect(x: 50, y: 450, width: 200, height: 40))
        view3.backgroundColor = UIColor.gray
        view.addSubview(view3)
        view3.frc.add(roundingCorners: [.bottomRight, .bottomLeft], radius: 15, bgColor: UIColor.red, fillColor: UIColor.white)
        
        
        let label = UILabel()
        label.text = "测试label"
        label.frame = CGRect(x: 50, y: 0, width: 100, height: 30)
        view3.addSubview(label)
        label.frc.add(roundingCorners: [.topLeft, .bottomRight], radius: 10, bgColor: UIColor.green)
        
        
        let avatarImageView = UIImageView()
        avatarImageView.image = #imageLiteral(resourceName: "avatar")
        avatarImageView.frame = CGRect(x: 250, y: 200, width: 60, height: 60)
        view.addSubview(avatarImageView)
        avatarImageView.frc.add(roundingCorners: .allCorners, radius: 15, bgColor: UIColor.red)
        
        
    }

}

