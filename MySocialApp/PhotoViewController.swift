//
//  PhotoViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/14.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import Then
import SwiftyUserDefaults

class PhotoViewController: BaseViewController {
    
    var imageView :UIImageView!
    var button:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        let button = UIButton(type: .system).then{
            $0.setTitle("select image", for: .normal)
            $0.addClickCallback{ [weak self] button in
//                self?.launchPhotoPicker{ item, _ in
//                    if let photo = item.singlePhoto {
//                        OSSTools.uploadImage(image: photo.image, completion: {
//                            self?.imageView.image = photo.image
//                        })
//                    }
//                }
            self?.present(LoginViewController(), animated:true, completion: nil)
            }
        }
        
        imageView = UIImageView().then{
            $0.contentMode = .scaleToFill
        }
        
        self.view.addSubviews([button,imageView])
        
        button.snp.makeConstraints {
            $0.top.left.equalTo(120)
            $0.size.equalTo(50)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
    
    override func initData() {
        
    }
    
    
    func addPhoto() {
        
        self.launchPhotoPicker { (images, assets, isOriginal) in
            self.imageView.image = images.first
        }
        
    }
        
       

}
