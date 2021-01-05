//
//  UserHomePageController.swift
//  MySocialApp
//
//  Created by lukey on 2021/1/4.
//  Copyright © 2021 lujian. All rights reserved.
//

import UIKit

class UserHomePageController: BaseViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    var user:UserModel!
    var collectionView:UICollectionView!
    var headerView:HomepageHeaderView!
    var userInfoArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: (kScreenWidth - 72) / 2, height: 75)
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: kScreenWidth)
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 24
        
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout).then{
           
            if #available(iOS 11.0, *){
                $0.contentInsetAdjustmentBehavior = .never
            }
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = kBackgroundColor
//            $0.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            
            $0.register(HomepageItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(HomepageItemCell.self))
            
            $0.register(HomepageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HomepageHeaderView.self))
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(kTopHeight)
            make.left.right.bottom.equalTo(0)
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(HomepageHeaderView.self), for: indexPath) as! HomepageHeaderView
        header.user = user
        
        return header
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HomepageItemCell.self), for: indexPath) as! HomepageItemCell
        let info:String = self.userInfoArray[indexPath.row] as! String
        let array = info.split(separator: ":")
        
        cell.name = String(array[0])
        cell.des = String(array[1])
        
        return cell
    }
   
   
    override func initData() {
//        api.request(.userInfo(userId: self.userId)) { result in
//
//        }
        self.userInfoArray = NSMutableArray()
        
        if let age = user.age {
            self.userInfoArray.add("年龄:\(age)岁")
        }
        
        if let constellation = user.constellation {
            self.userInfoArray.add("星座:" + constellation)
        }
        
        if let height = user.height {
            self.userInfoArray.add("身高:\(height)cm")
        }
        
        if let weight = user.weight {
            self.userInfoArray.add("体重:\(weight)kg")
        }
    
        
        if let provice = user.locationProvince, let city = user.locationCity{
            if provice == city {
                self.userInfoArray.add("城市:" + provice)
            }else{
                self.userInfoArray.add("城市:" + provice + "," + city)
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    
   

}
