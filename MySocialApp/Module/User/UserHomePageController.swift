//
//  UserHomePageController.swift
//  MySocialApp
//
//  Created by lukey on 2021/1/4.
//  Copyright © 2021 lujian. All rights reserved.
//

import UIKit

class UserHomePageController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    var user:UserModel!
    var tableView:UITableView!
    var headerView:HomepageHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    override func initSubView() {
        self.headerView = HomepageHeaderView(user: self.user)
        self.headerView.frame = .init(origin: .zero, size: .init(width: kScreenWidth, height: kScreenWidth + 45))
        
        self.tableView = UITableView.init(frame: .zero, style: .grouped).then{
            $0.tableHeaderView = self.headerView
            if #available(iOS 11.0, *){
                $0.contentInsetAdjustmentBehavior = .never
            }
            $0.delegate = self
            $0.dataSource = self
            $0.register(HomepageItemCell.self, forCellReuseIdentifier: NSStringFromClass(HomepageItemCell.self))
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(kTopHeight)
            make.left.right.bottom.equalTo(0)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HomepageItemCell.self), for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .random
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    
    override func initData() {
//        api.request(.userInfo(userId: self.userId)) { result in
//
//        }
        
        
    }
    
    
   

}
