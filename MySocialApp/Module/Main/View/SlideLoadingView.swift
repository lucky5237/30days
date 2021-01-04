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
    var animeView:AnimationView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        
        self.backgroundColor = .white
        
        animeView = AnimationView(animation: Animation.named("search"))
        
        self.addSubview(animeView)
        animeView.snp.makeConstraints {
//            $0.width.height.equalTo(200)
//            $0.top.equalTo(30)
//            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
    }
    
    public func startAnime(){
        if animeView.isAnimationPlaying {
            animeView.stop()
        }
        animeView.play()
    }
    
    public func stopAnime(){
        animeView.stop()
    }
    
}
