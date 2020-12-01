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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        setupSlideView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(redrawSwipe))
    }
    
    override func initData() {
        dataArray.removeAll()
        self.showLoading()
        for i in 1..<10{
            let user = UserModel()
            user.userName = "name \(i)"
            user.userId = i
            user.userAvatar = "http://lorempixel.com/400/200/sports/\(i)/"
            dataArray.append(user)
        }
        
        slideView.reloadData()
        self.hideLoading()
    }
    
    //设置左右滑动视图
    func setupSlideView(){
        slideView = KolodaView(frame: CGRect(x: 20, y: kTopHeight + 20, width: kScreenWidth - 40, height: kSafeAreaHeight - 20))
        slideView.backgroundCardsTopMargin = 1
        slideView.cornerRadius = 10
        slideView.delegate = self
        slideView.dataSource = self
        self.view.addSubview(slideView)
    }
    
    //MARK: koloda delegate && datasource
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataArray.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView()
        imageView.loadUrlImageFromNetwork(dataArray[index].userAvatar ?? "")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
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
        let seed = Int.random(in: 0..<2)
        koloda.swipe(seed == 0 ? .left : .right, force: true)
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
        slideView.revertAction(direction: .left)
    }
    
    @objc override func backBtnTapped() {
        
    }
    
}
