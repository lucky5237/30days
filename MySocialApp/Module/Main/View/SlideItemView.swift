//
//  SlideItemView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/28.
//  Copyright © 2020 lujian. All rights reserved.
//

import UIKit

class SlideItemView: UIView {
    
    var user:UserModel!
    var infoContainer:UIView!
    var nameLabel:UILabel!
    var ageLabel:UILabel!
    var distanceLabel:UILabel!
    
    
    lazy var imageView:UIImageView = {
        let image:UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    lazy var subLayer: CALayer = {
        let border = CALayer()
        border.backgroundColor = kBackgroundColor.cgColor
        border.borderWidth = 1
        border.borderColor = kHexColor(hex: "#E2DCD1")!.cgColor
        border.cornerRadius = 40
        border.masksToBounds = true
        return border
    }()
    
    
//    lazy var infoContainerMaskLayer:CAGradientLayer = {
//        let maskLayer = CAGradientLayer()
//        maskLayer.startPoint = .init(x: 0.5, y: 0)
//        maskLayer.endPoint = .init(x: 0.5, y: 1)
//        maskLayer.colors = [UIColor(red: 0, green: 0  , blue: 0,alpha: 0).cgColor,UIColor(red: 0, green: 0, blue: 0,alpha: 0.65).cgColor]
//        return maskLayer
//    }()

    
    public init(user: UserModel){
        super.init(frame: .zero)
        self.user = user
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subLayer.frame = self.bounds
    }
    
    
    func setup() {
        
        self.layer.shadowColor = kHexColor(hex: "#BDB9A6")!.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10

        self.layer.insertSublayer(subLayer, at: 0)
        
        let container = UIView()
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 20
        container.backgroundColor = kBackgroundColor
        self.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalTo(0)
        }

        container.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.left.right.equalTo(0)
            $0.bottom.equalTo(-kScaleHeight(95))
        }
        
        imageView.loadUrlImageFromNetwork(user.userAvatar)
        
        infoContainer = UIView()
        infoContainer.backgroundColor = kBackgroundColor
        container.addSubview(infoContainer)
        infoContainer.snp.makeConstraints {
            $0.bottom.left.right.equalTo(0)
            $0.height.equalTo(kScaleHeight(95))
        }
        
        
        nameLabel = UILabel()
        nameLabel.textColor = kMainTextColor
        nameLabel.font = kMediumFontSize(20)

        ageLabel = UILabel()
        ageLabel.textColor = kMainTextColor
        ageLabel.font = kMediumFontSize(20)
        
        distanceLabel = UILabel()
        distanceLabel.textColor = kSubTextColor
        distanceLabel.font = kFontSize(15)
        
        infoContainer.addSubviews([nameLabel,ageLabel,distanceLabel])
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(kScaleHeight(20))
            $0.left.equalTo(24)
            $0.height.equalTo(kScaleHeight(24))
            $0.right.lessThanOrEqualTo(ageLabel.snp_leftMargin).offset(-24)
        }
        
        ageLabel.snp.makeConstraints{
            $0.centerY.equalTo(nameLabel)
            $0.right.equalTo(-20)
        }
        
        distanceLabel.snp.makeConstraints{
            $0.bottom.equalTo(-kScaleHeight(24))
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
            $0.height.equalTo(kScaleHeight(18))
        }
        
        nameLabel.text = user.userName
        ageLabel.text = "\(user.age != nil ? user.age! : 0)"
        distanceLabel.text = "10km"
       
    }

}
