//
//  UserInfoViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/11.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
//import Reusable

class UserInfoViewController: BaseTableViewController<DynamicModel,MainUserInfoTableViewCell> {
    
    var userModel:UserModel?{
        didSet{
            headerView.userModel = userModel
        }
    }
    
    lazy var headerView:UserHomepageHeaderView! = UserHomepageHeaderView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
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
        tableView.snp.updateConstraints{
            $0.top.equalToSuperview()
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        print("autolayout height is \(size)")
        headerView.frame = CGRect(origin: headerView.frame.origin, size: size)
        tableView.tableHeaderView = headerView
    }
    
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView().then{
            $0.backgroundColor = kBackgroundColor
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
