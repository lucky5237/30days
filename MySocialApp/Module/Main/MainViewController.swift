//
//  MainViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/10.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import Koloda

class MainViewController: BaseViewController,KolodaViewDelegate,KolodaViewDataSource {
    
    var dataArray:[UserModel] = []
    var slideView:KolodaView!
    var likeBtn:BaseIconButton!
    var dislikeBtn:BaseIconButton!
    var chatBtn:BaseIconButton!
    var lastDirection:SwipeResultDirection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        setup()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(redrawSwipe))
    }
    
    override func initData() {
        dataArray.removeAll()
        self.showLoading()
        for i in 1..<10{
            let user = UserModel()
            user.userName = "name \(i)"
            user.userId = i
            user.userAvatar = "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2631334549,246605465&fm=26&gp=0.jpg"
            dataArray.append(user)
        }
        
        slideView.reloadData()
        self.hideLoading()
    }
    
    
    func setup(){
        slideView = KolodaView(frame: CGRect(x: 24, y: kTopHeight + 24, width: kScreenWidth - 48, height: kSafeAreaHeight -  48 - kScaleHeight(117)))
        slideView.backgroundCardsTopMargin = 0
        slideView.countOfVisibleCards = 2
        slideView.delegate = self
        slideView.dataSource = self
        self.view.addSubview(slideView)
        
        self.dislikeBtn = BaseIconButton(iconName: "不喜欢")
        self.likeBtn = BaseIconButton(bgColor: kThemeColor, iconName: "喜欢")
        self.chatBtn = BaseIconButton(bgColor: kHexColor(hex: "#59EDB7")!, iconName: "喜欢")
        
        likeBtn.addClickCallback { sender in
            self.lastDirection = .right
            self.slideView.swipe(.right)
        }
        
        dislikeBtn.addClickCallback { sender in
            self.lastDirection = .left
            self.slideView.swipe(.left)
        }
        
        chatBtn.addClickCallback { sender in
            
        }
        
        self.view.addSubview(dislikeBtn)
        self.view.addSubview(likeBtn)
        self.view.addSubview(chatBtn)
        
        dislikeBtn.snp.makeConstraints{
            $0.top.equalTo(slideView.snp_bottomMargin).offset(kScaleHeight(48))
            $0.width.height.equalTo(kScaleHeight(64))
            $0.centerX.equalToSuperview().offset(-kScaleHeight(96))
        }
        
        likeBtn.snp.makeConstraints{
            $0.top.equalTo(slideView.snp_bottomMargin).offset(kScaleHeight(48))
            $0.width.height.equalTo(kScaleHeight(64))
            $0.centerX.equalToSuperview().offset(kScaleHeight(96))
        }
        
        chatBtn.snp.makeConstraints{
            $0.top.equalTo(slideView.snp_bottomMargin).offset(kScaleHeight(48))
            $0.width.height.equalTo(kScaleHeight(64))
            $0.centerX.equalToSuperview()
        }
        
        self.view.bringSubviewToFront(slideView)
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataArray.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let user:UserModel = dataArray[index]
        return SlideItemView(user: user)
    }
    
    //    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    //        return .default
    //    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        let user = self.dataArray[index]
        switch direction {
        case .left:
            print("左滑了用户" + (user.userName ?? ""))
        case .right:
            print("右滑了用户" + (user.userName ?? ""))
        default:
            break
        }
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
        self.initData()
    }
    
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        let seed = Int.random(in: 0..<2)
//        koloda.swipe(seed == 0 ? .left : .right, force: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func redrawSwipe(){
        if let lastDirection = self.lastDirection {
            slideView.revertAction(direction: lastDirection)
            self.lastDirection = nil
        }else{
            self.showMessage("请选滑动一张卡片", type: .warning)
        }
        
    }
    
    @objc override func backBtnTapped() {
        
    }
    
}
