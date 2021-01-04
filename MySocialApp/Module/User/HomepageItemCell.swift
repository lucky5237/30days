//
//  HomepageItemCell.swift
//  MySocialApp
//
//  Created by lukey on 2021/1/4.
//  Copyright © 2021 lujian. All rights reserved.
//

import UIKit

class HomepageItemCell: UITableViewCell {
    
    var bgImageView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)]]
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        
    }
    
}
