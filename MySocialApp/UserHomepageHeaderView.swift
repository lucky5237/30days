//
//  UserHomepageHeaderView.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/11.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import FSPagerView
//import Reusable

class UserHomepageHeaderView: BaseView,FSPagerViewDelegate,FSPagerViewDataSource{
    
    var photoView: FSPagerView!
    //        didSet{
    //            photoView.delegate = self
    //            photoView.dataSource = self
    //            photoView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    //        }
    //    }
    var pageControl: FSPageControl!
    //        didSet{
    //            pageControl.currentPage = 0
    //            pageControl.backgroundColor = .clear
    //            pageControl.setFillColor(k999Color, for: .normal)
    //            pageControl.setFillColor(.red, for: .selected)
    //            pageControl.contentHorizontalAlignment = .center
    //        }
    //    }
    
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var userInfoLabel: UILabel!
    var introLabel: UILabel!
    
    
    override func initSubView() {
        self.backgroundColor = .white
        
        nameLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kMediumFontSize(20)
        }
        
        locationLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kFontSize(12)
        }
        
        userInfoLabel = UILabel().then{
            $0.textColor = k999Color
            $0.font = kFontSize(12)
        }
        
        introLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kFontSize(14)
            $0.numberOfLines = 0
        }
        
        photoView = FSPagerView().then{
            $0.delegate = self
            $0.dataSource = self
            $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
        
        pageControl = FSPageControl().then{
            $0.currentPage = 0
            $0.backgroundColor = .clear
            $0.setFillColor(k999Color, for: .normal)
            $0.setFillColor(.red, for: .selected)
            $0.contentHorizontalAlignment = .center
        }
        
        self.addSubview(nameLabel)
        self.addSubview(locationLabel)
        self.addSubview(userInfoLabel)
        self.addSubview(photoView)
        self.addSubview(pageControl)
        self.addSubview(introLabel)
    }
    
    override func initLayout() {
        photoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(kScreenWidth)
        }
        pageControl.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.bottom.equalTo(photoView).offset(-10)
            make.height.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(20)
            make.left.right.equalTo(nameLabel)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp_bottomMargin).offset(15)
            make.left.right.equalTo(nameLabel)
        }
        
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp_bottomMargin).offset(15)
            make.left.right.equalTo(nameLabel)
            make.bottom.equalTo(-20)
        }
    }
    
    var userModel: UserModel!{
        didSet{
            configViewData()
        }
    }
    
    func configViewData() {
        nameLabel.text = userModel.userName
        let location = (userModel.locationCity ?? "") + " " + (userModel.locationDistrict ?? "")
        let locationStr = String(format: "%.2f", 0.00) + "km " + location
        let locationAttStr = NSMutableAttributedString.init(string: locationStr)
        locationAttStr.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], range: NSRange(location: 0, length: 4))
        
        userInfoLabel.text = "\(String(describing: userModel.genderStr)) \(userModel.age ?? 0)岁 \(userModel.constellation ?? "")"
        introLabel.text = userModel.introduction
        locationLabel.attributedText = locationAttStr
        pageControl.numberOfPages = userModel.profilePhotos.count
        pageControl.isHidden = userModel.profilePhotos.count <= 1
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return userModel.profilePhotos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let urlString = userModel.profilePhotos[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadUrlImageFromNetwork(urlString)
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }

}
