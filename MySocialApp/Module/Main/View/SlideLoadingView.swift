//
//  SlideLoadingView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/28.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
import Lottie

class SlideLoadingView: UIView {
    var animeView:LottieView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        animeView = LottieView()
        
        let starAnimation = Animation.named("search")
        animeView.animate(<#T##animations: [MotionAnimation]##[MotionAnimation]#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
