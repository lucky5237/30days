//
//  ViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/6.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import RxSwift
import HandyJSON
//import Reusable
import SKPhotoBrowser
//import SnapKit

class ViewController: BaseTableViewController<DynamicModel,MainUserInfoTableViewCell>{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kAppdelegate.startRequestLocation()
        self.title = "Home"
        self.pageEnable = true
    }
    
    
    
    override func customRequestApi() -> API? {
        return .dynamicList(page: currentPage, size: pageSize)
    }
    
    override func customConfigCell(currentTableView tableView: UITableView, currentIndexPath indexPath: IndexPath, currentCell cell: MainUserInfoTableViewCell, currentModel model: DynamicModel) {
        cell.selectPhotoCallback = { index in
            self.launchPhotoBrowser(photos: model.photos, currentIndex: index)
        }
        cell.model = model
    }
    
    override func customTableView() {
        self.tableView.snp.updateConstraints { make in
            make.bottom.equalTo(-kTabbarHeight)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = currentModelForIndex(at: indexPath).user
        let userHomepageVC = UserInfoViewController()
        userHomepageVC.userModel = user
        self.navigationController?.pushViewController(userHomepageVC, animated: true)
    }
    
    @objc func injected(){
        print("I've been injected: \(self)")

    }
}

