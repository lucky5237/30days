//
//  UserHomepageHeaderView.swift
//  MySocialApp
//
//  Created by lukey on 2021/1/4.
//  Copyright © 2021 lujian. All rights reserved.
//

import UIKit
import FSPagerView
import TagListView


class HomepageHeaderView: UIView,FSPagerViewDelegate,FSPagerViewDataSource  {

    var banner:FSPagerView!{
        didSet {
            self.banner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    var pageControl:UIPageControl!
    var nameLabel:UILabel!
    var infoLabel:UILabel!
    var introLabel:UILabel!
    var tagView:TagListView!
    
    var user:UserModel?
    
    public init(user: UserModel){
        super.init(frame: .zero)
        self.user = user
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.banner = FSPagerView()
        self.banner.delegate = self
        self.banner.dataSource = self
        self.banner.transformer =  FSPagerViewTransformer(type: .linear)
        self.banner.itemSize = .init(width: kScreenWidth - 48, height: kScreenWidth - 48)
        self.addSubview(self.banner)
        self.banner.snp.makeConstraints{
            $0.top.equalTo(24)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(kScreenWidth - 24)
        }
        
        self.pageControl = UIPageControl().then{
            $0.currentPage = 0
            $0.numberOfPages = self.user?.profilePhotos.count ?? 0
            $0.pageIndicatorTintColor = kHexColor(hex: "#F6F5F0")!
            $0.currentPageIndicatorTintColor = kThemeColor
        }
        
        self.nameLabel = UILabel().then{
            $0.textColor = kMainTextColor
            $0.font = kMediumFontSize(24)
        }
        
        self.infoLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kFontSize(14)
        }
        
        self.addSubview(self.pageControl)
        self.addSubview(self.nameLabel)
        self.addSubview(self.infoLabel)
        
        self.pageControl.snp.makeConstraints {
            $0.top.equalTo(self.banner.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.banner.snp.bottom).offset(0)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
            $0.height.equalTo(24)
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(2)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
            $0.height.equalTo(19)
        }
        
        
        self.nameLabel.text = user?.userName
        
        let info = NSMutableString.init()
        
        if let age = user?.age{
            info.append("\(age) / ")
        }
        
        if let height = user?.height{
            info.append("\(height)cm / ")
        }
        
        if let constellation = user?.constellation{
            info.append("\(constellation) / ")
        }
        
        if info.hasSuffix("/ ") {
            info.deleteCharacters(in: .init(location: info.length - 2, length: 2))
        }
        
        self.infoLabel.text = info as String
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.user?.profilePhotos.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.cornerRadius = 24
        let imageUrl = self.user?.profilePhotos[index]
        cell.imageView?.loadUrlImageFromNetwork(imageUrl)
        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
   

}
