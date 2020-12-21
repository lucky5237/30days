//
//  StepView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/15.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class StepView: UIView {
    
    public var stepNum:Int = 3
    
    public var currentStep:Int = 1
    
    lazy var grayBackView:UIView = {
        return UIView.init().then {
            $0.backgroundColor = .init(white: 0, alpha: 0.1)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 1
        }
    }()
    
    lazy var stepLabel:UILabel = {
        return UILabel.init().then {
            $0.textColor = kThemeColor
            $0.font = kFontSize(14)
        }
    }()
    
    lazy var progressView:UIView = {
        return UIView.init().then {
            $0.backgroundColor = kThemeColor
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 1
        }
    }()
    
    public init(stepNum:Int,currentStep:Int? = 1){
        super.init(frame: .zero)
        self.stepNum = stepNum
        if let currentStep = currentStep {
            self.currentStep = currentStep
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setup() {
        self.addSubview(self.grayBackView)
        self.grayBackView.snp.makeConstraints {
            $0.bottom.equalTo(0)
            $0.height.equalTo(2)
            $0.left.right.equalTo(0)
        }
        
        self.addSubview(self.stepLabel)
        self.stepLabel.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.height.equalTo(16)
            $0.left.equalTo(0)
        }
        
        self.grayBackView.addSubview(self.progressView)
        self.progressView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.height.equalTo(2)
            $0.left.equalTo(0)
            $0.width.equalToSuperview().dividedBy((Float(stepNum) / Float(currentStep)))
        }
        
        
        self.stepLabel.text = "0\(currentStep)" + "/" + "0\(stepNum)"
    }
}
