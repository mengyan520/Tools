//
//  DCBaseTableViewController.swift
//  SwiftDemo
//
//  Created by ma on 2018/10/18.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit
import MJRefresh
class DCBaseTableViewController: DCBaseViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tableView = UITableView.init(frame: CGRect.zero, style: self.tableViewStyle())
        self.tableView?.backgroundColor = self.backgroundColor()
        self.tableView?.estimatedSectionFooterHeight = 0;
        self.tableView?.estimatedSectionHeaderHeight = 0;
        self.tableView?.estimatedRowHeight = 200;
        self.tableView?.separatorColor = UIColor.init(red: 242, green: 242, blue: 242, alpha: 1)
        self.tableView?.tableFooterView = UIView.init()
        self.tableView?.delegate = self as UITableViewDelegate
        self.tableView?.dataSource = self as UITableViewDataSource
        //        拖动退出键盘
        self.tableView?.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.dataArrays = NSMutableArray.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView!)
        let topView = self.topView()
        if (topView != nil) {
            self.view.addSubview(topView!)
            topView?.frame = CGRect.init(x:0, y:topView!.frame.origin.y, width:self.view.bounds.size.width, height: topView!.bounds.size.height)
        }
        let bottomView = self.bottomView()
        if (bottomView != nil) {
            self.view.addSubview(bottomView!)
            bottomView?.frame = CGRect.init(x: 0, y:bottomView!.frame.origin.y, width: self.view.bounds.size.width, height: bottomView!.bounds.size.height)
        }
        let tableViewY = self.tableViewEdgeInsets().top + (self.topView()?.frame.size.height ?? 0) + (self.topView()?.frame.origin.y ?? 0)
        self.tableView?.frame = CGRect.init(x:self.tableViewEdgeInsets().left, y: tableViewY, width: self.view.bounds.size.width-self.tableViewEdgeInsets().left*2, height: self.view.bounds.size.height-self.tableViewEdgeInsets().bottom-(self.bottomView()?.frame.size.height ?? 0)-tableViewY)
        self.configRefreshUI()
    }
    // MARK: - 公共属性和方法
///    tableView
    var tableView:UITableView?
///    数据源
    var dataArrays:NSMutableArray?
///    默认返回UITableViewStylePlain
    func tableViewStyle() -> UITableView.Style {
        return UITableView.Style.plain
    }
    
    /// 如果想定制顶部固定的view，子类需要重写此方法
    func topView() -> UIView? {
        return nil
    }
    /// 如果想定制底部固定的view，子类需要重写此方法
    func bottomView() -> UIView? {
        return nil
    }
    
    /// 如果想定制UITableView相对于四边的缩进，子类需要重写此方法
    /// - Returns: 默认返回UIEdgeInsetsZero
    func tableViewEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    /// 如果不想要下拉刷新，子类需要重写这个方法并返回NO
    func shouldShowRefresh() -> Bool {
        return false
    }
    /// 如果不想要上拉刷新，子类需要重写这个方法并返回NO
    func shouldShowGetMore() -> Bool {
        return false
    }
    /// 子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
    @objc func requestRefresh() {
        
    }
    /// 子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
    @objc func requestGetMore() {
        
    }
    /// 触发刷新刷新动作
    func toTriggerRequestRefresh() {
        self.tableView?.mj_header.beginRefreshing()
    }
    /// 触发上拉加载动作
    func toTriggerRequestGetMore() {
        self.tableView?.mj_footer.beginRefreshing()
    }
    /// 请求完成，不管成功或者失败必须手动调用此方法结束刷新动画
    func finishRequest() {
        if self.tableView!.mj_header.isRefreshing  {
            self.tableView?.mj_header.endRefreshing()
        }else if self.tableView!.mj_footer.isRefreshing {
            self.tableView?.mj_footer.endRefreshing()
        }
    }
    /// 配置列表header和footer刷新数据的UI，已经有默认配置
    func configRefreshUI() {
        if self.shouldShowRefresh() {
            let refreshheader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.requestRefresh))
            refreshheader?.lastUpdatedTimeLabel.isHidden = true
            self.tableView?.mj_header = refreshheader
        }
        if self.shouldShowGetMore() {
            let refreshfooter = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.requestGetMore))
            self.tableView?.mj_footer = refreshfooter
        }
    }
}
// MARK: - UITableViewDelegate/UITableViewDataSource
extension DCBaseTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        return cell
    }
}
