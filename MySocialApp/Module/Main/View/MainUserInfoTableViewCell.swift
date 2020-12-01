//
//  MainUserInfoTableViewCell.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/11.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import FSPagerView
import SKPhotoBrowser
import Then
import SnapKit

class MainUserInfoTableViewCell: BaseTableViewCell,FSPagerViewDelegate,FSPagerViewDataSource {
    
    var userAvatarImgView:UIImageView!
    var userNameLabel:UILabel!
    var createTimeLabel:UILabel!
    var photoView:FSPagerView!
    var pageControl:FSPageControl!
    var praiseBtn:UIButton!
    var chatBtn:UIButton!
    var praiseNumLabel:UILabel!
    var contentLabel:UILabel!
    var moreBtn:UIButton!
    var model:DynamicModel!{
        didSet{
            configCellData()
        }
    }
    var selectPhotoCallback:((Int) -> Void)?

    override func initSubView() {
        userAvatarImgView = UIImageView().then{
            $0.cornerRadius(22.5)
        }
        
        userNameLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kMediumFontSize(14)
        }
        
        createTimeLabel = UILabel().then{
            $0.textColor = k999Color
            $0.font = kFontSize(12)
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
        
        praiseBtn = UIButton().then{
            $0.setImage(R.image.icon_praise(), for: .normal)
            $0.setImage(R.image.icon_praised(), for: .selected)
            $0.addClickCallback{ button in
                button.isSelected = !button.isSelected
            }
        }
        
        chatBtn = UIButton().then{
            $0.setImage(R.image.icon_chat(), for: .normal)
            $0.addClickCallback{ button in
                print("点击了聊天")
            }
        }
        
        praiseNumLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kFontSize(12)
        }
        
        contentLabel = UILabel().then{
            $0.textColor = k222Color
            $0.font = kFontSize(16)
            $0.numberOfLines = 0
        }
        
        moreBtn = UIButton().then{
            $0.setImage(R.image.icon_more(), for: .normal)
            $0.addClickCallback{ button in
                print("点击了更多")
            }
        }
        
        self.contentView.addSubview(userAvatarImgView)
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(createTimeLabel)
        self.contentView.addSubview(photoView)
        self.contentView.addSubview(pageControl)
        self.contentView.addSubview(praiseBtn)
        self.contentView.addSubview(chatBtn)
        self.contentView.addSubview(praiseNumLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(moreBtn)
    }
    
    override func initLayout(){
        userAvatarImgView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.height.width.equalTo(45)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userAvatarImgView).offset(5)
            make.right.equalTo(-10)
            make.left.equalTo(userAvatarImgView.snp_rightMargin).offset(8)
        }
        
        createTimeLabel.snp.makeConstraints { make in
            make.left.right.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp_bottomMargin).offset(10)
        }
        
        photoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(userAvatarImgView.snp_bottomMargin).offset(10)
            make.height.equalTo(kScreenWidth)
        }
        
        chatBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(photoView.snp_bottomMargin).offset(15)
            make.width.height.equalTo(32)
        }
        
        praiseBtn.snp.makeConstraints { make in
            make.left.equalTo(chatBtn.snp_rightMargin).offset(20)
            make.top.equalTo(chatBtn)
            make.width.height.equalTo(32)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp_bottomMargin).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        praiseNumLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(chatBtn.snp_bottomMargin).offset(15)
            make.right.equalTo(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(praiseNumLabel.snp_bottomMargin).offset(20)
            make.bottom.equalTo(-25)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(userAvatarImgView)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: FSPagerView delegate && datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return model.photos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadUrlImageFromNetwork(model.photos[index])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let selectCallback = selectPhotoCallback{
            selectCallback(index)
        }
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
    
    func configCellData(){
        userAvatarImgView.loadUrlImageFromNetwork(model.user?.userAvatar)
        userNameLabel.text = model.user?.userName
        createTimeLabel.text = model.createTime
        praiseBtn.isSelected = model.praised ?? false
        praiseNumLabel.text = String(model.praiseNum) + " 次赞"
        contentLabel.text = model.content
        pageControl.numberOfPages = model.photos.count
        pageControl.isHidden = model.photos.count <= 1
        photoView.reloadData()
    }
    
}
