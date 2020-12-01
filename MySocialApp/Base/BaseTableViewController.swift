//
//  BaseTableViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import HandyJSON
import MJRefresh
import RxDataSources
import RxSwift
import UITableView_FDTemplateLayoutCell

enum TableViewRefreshType {
    case none
    case onlyHeader
    case onlyFooter
    case all
}


//T->model类型 ，R->自定义CEll的类型 使用cell只有一种类型时候
class BaseTableViewController<T:HandyJSON,R:UITableViewCell>: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    var refreshType: TableViewRefreshType = .onlyHeader
    var pageEnable: Bool = false//是否分页
    var currentPage = kFirstPageNum
    let pageSize = kPageSize
    var dataArray: Array<T> = []
    var refreshHeader: MJRefreshHeader?
    var refreshFooter: MJRefreshFooter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MArRK: override
    override func initSubView() {
        createTableView()
        customTableView()
    }
    
    override func initData() {
        
        guard let header = refreshHeader else{
            self.loadData(isPullToRefresh: true)
            return
        }
        
        header.beginRefreshing()
    }
    
    func currentModelForIndex(at indexPath:IndexPath) -> T{
        return self.dataArray[indexPath.row]
    }
    
    //生成tablewview
    func createTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        if #available(iOS 11.0, *){
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(kTopHeight)
            make.left.right.bottom.equalTo(0)
        }
//        tableView.sectionHeaderHeight = 0.01
//        tableView.sectionFooterHeight = 0.01
        tableView.register(cellWithClass: R.self)
        setupHeaderAndFooter()
    }
    
    //设置header && footer
    fileprivate func setupHeaderAndFooter() {
        switch refreshType{
        case .onlyHeader:
            addHeader()
            break
        case .onlyFooter:
            addFooter()
            break
        case .all:
            addHeader()
            addFooter()
            break
        default:
            break
        }
    }
    
    //添加header
    fileprivate func addHeader() {
        let header = MJRefreshNormalHeader {
            [weak self] in
            self?.loadData(isPullToRefresh: true)
        }
        refreshHeader = header
        tableView.mj_header = refreshHeader
    }
    
    //添加footer
    fileprivate func addFooter() {
        let footer = MJRefreshBackStateFooter {
            [weak self] in
            self?.loadData(isPullToRefresh: false)
        }
        refreshFooter = footer
        tableView.mj_footer = refreshFooter
    }
    
    //加载数据
    func loadData(isPullToRefresh:Bool) {
        if isPullToRefresh || !pageEnable {
            currentPage = kFirstPageNum
        }else{
            currentPage += 1
        }
        var params:[String:Any] = [:]
        if pageEnable {
            params[kPageParamKey] = currentPage
            params[kPageSizeParamKey] = kPageSize
        }
        
        customRuquestData(isPullToRefresh: isPullToRefresh, params: params, successCallback: {
            self.handleAfterRequestData(isPullToRefresh: isPullToRefresh, responseDataArray: $0)
        }, failureCallback:{ error in
            self.refreshHeader?.endRefreshing()
            self.refreshFooter?.endRefreshing()
        })
    }
    
    //自定义修改tableView
    func customTableView() {
        
    }
    
    //自定义的请求
    func customRuquestData(isPullToRefresh:Bool,params:[String:Any],successCallback:@escaping ([T]) -> (),failureCallback: @escaping ((Error)->Void)){
        if let api = customRequestApi(){
            request(api, responseType: [T].self, successCallback: {
                successCallback($0)
            },failureCallback:{
                failureCallback($0)
            })
        }
    }
    
    //自定义请求的api，数据,来自网络请求时使用这个
    func customRequestApi() -> API?{
        return nil
    }
    
    //自定义cell的处理
    func customConfigCell(currentTableView tableView :UITableView,currentIndexPath indexPath: IndexPath, currentCell cell: R,currentModel model: T){
    
    }
    
    //请求后处理数据
    fileprivate func handleAfterRequestData(isPullToRefresh:Bool,responseDataArray:[T]){
        refreshHeader?.endRefreshing()
        if isPullToRefresh {
            dataArray.removeAll()
        }
        dataArray.append(contentsOf: responseDataArray)
        
        //如果是下拉刷新并且没数据
        if isPullToRefresh && responseDataArray.count == 0 {
            tableView.reloadData {
                [weak self] in
                self?.refreshFooter?.endRefreshingWithNoMoreData()
            }
            return
        }
        
        if responseDataArray.count < kPageSize || !pageEnable{
            tableView.reloadData {
                [weak self] in
                self?.refreshFooter?.endRefreshingWithNoMoreData()
            }
        }else{
            tableView.reloadData {
                [weak self] in
                self?.refreshFooter?.endRefreshing()
            }
        }
    }
    
    // MARK: tableview datasource && delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: R.self)
        cell.selectionStyle = .none
        customConfigCell(currentTableView: tableView, currentIndexPath: indexPath, currentCell: cell, currentModel: self.currentModelForIndex(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = tableView.fd_heightForCell(withIdentifier: String(describing: R.self), cacheBy: indexPath, configuration: { cell in
//            if let cell = cell as? R {
//                self.customConfigCell(currentTableView: tableView, currentIndexPath: indexPath, currentCell: cell, currentModel: self.currentModelForIndex(at: indexPath))
//            }
//        })
//        
//        return height
//    }
}


