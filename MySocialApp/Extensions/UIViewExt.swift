//
//  UIViewExt.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/9.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import SKPhotoBrowser
import YPImagePicker
import Kingfisher
import SwiftEntryKit

extension UIView {
    func showLoading(){
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setBackgroundColor(kBackgroundColor)
        SVProgressHUD.show()
    }
    
    func showLoading(text:String){
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setBackgroundColor(kBackgroundColor)
        SVProgressHUD.show(withStatus: text)
    }
    
    func hideLoading(){
        SVProgressHUD.dismiss()
    }
    
    func cornerRadius(_ radius:CGFloat){
        self.roundCorners(.allCorners, radius: radius)
    }
}

extension UIImageView{
    func loadUrlImageFromNetwork(_ urlString:String?){
        guard let urlString = urlString else {
            return
        }
        
        self.kf.setImage(with: URL(string: urlString), placeholder: kPlaceHolderImage)
    }
}

extension UIViewController {
    func showLoading(){
        kKeyWindow.showLoading()
    }
    
    func hideLoading(){
        kKeyWindow.hideLoading()
    }
    
}

extension UIViewController{
    
    func launchPhotoBrowser(photos:[String],currentIndex:Int){
        let photos = photos.map{
            SKPhoto.photoWithImageURL($0)
        }
        SKPhotoBrowserOptions.displayAction = false
        let broswer = SKPhotoBrowser(photos:photos, initialPageIndex: currentIndex)
        self.present(broswer, animated: true, completion: nil)
    }
    
    func launchPhotoPicker(_ completion:@escaping ([YPMediaItem],Bool)->Void){
        var config = YPImagePickerConfiguration()
        config.albumName = "Social App"
        config.startOnScreen = .library
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { item, isFinished in
            completion(item,isFinished)
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
}

extension UIButton{
    func addClickCallback(_ callback:@escaping (UIButton) -> Void){
        let _ = self.rx.controlEvent(.touchUpInside).subscribe(onNext: {
            callback(self)
        })
    }
}

func showErrorText(_ text:String){
    SVProgressHUD.showError(withStatus: text)
}

func showInfoText(_ text:String){
    SVProgressHUD.showInfo(withStatus: text)
}

func showSuccessText(_ text:String){
    SVProgressHUD.showSuccess(withStatus: text)
}
