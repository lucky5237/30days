//
//  HomepageItemCell.swift
//  MySocialApp
//
//  Created by lukey on 2021/1/4.
//  Copyright © 2021 lujian. All rights reserved.
//

import UIKit

class HomepageItemCell: UICollectionViewCell {
    
    var nameLabel:UILabel!
    var desLabel:UILabel!
    public var name:String?{
        didSet{
            self.nameLabel.text = name
        }
    }
    
    public var des:String?{
        didSet{
            self.desLabel.text = des
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        self.backgroundColor = kBackgroundColor
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = kHexColor(hex: "#E2DCD1")!.cgColor
        self.layer.cornerRadius = 16
        
        
        self.nameLabel = UILabel().then{
            $0.textColor = kMainTextColor
            $0.font = kMediumFontSize(16)
        }
        
        self.desLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kMediumFontSize(14)
        }
        
        self.contentView.addSubviews([self.nameLabel,self.desLabel])
        
        self.nameLabel.snp.makeConstraints{
            $0.top.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(24)
        }
        
        self.desLabel.snp.makeConstraints{
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(19)
            $0.bottom.equalTo(-16)
        }
    }
    
}
