//
//  BaseView.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/11.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //初始化子类
    func initSubView() {
        
    }
    
    //初始化布局
    func initLayout(){
        
    }
}

