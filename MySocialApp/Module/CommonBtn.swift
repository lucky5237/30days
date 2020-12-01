//
//  CommonBtn.swift
//  MySocialApp
//
//  Created by lukey on 2020/9/28.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
import UIKit
import Material

class CommonBtn: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultConfig()
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defaultConfig(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 22
        self.setTitle("确定", for: .normal)
        self.addClickCallback{_ in
            print("click button")
        }
    }
    
}
