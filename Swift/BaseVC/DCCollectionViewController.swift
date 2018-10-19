//
//  DCCollectionViewController.swift
//  SwiftDemo
//
//  Created by ma on 2018/10/19.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit
import MJRefresh
class DCCollectionViewController: DCBaseViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        let layout = self.layout()
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout:layout)
        layout.itemSize = self.itemSize()
        //垂直间距
        layout.minimumLineSpacing = 10
        //水平间距
        layout.minimumInteritemSpacing = 10
        self.collectionView?.backgroundColor = self.backgroundColor()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        //拖动退出键盘
        self.collectionView?.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        //点击退出键盘
        let collectionViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(collectionViewTouchInSide))
        collectionViewGesture.numberOfTapsRequired = 1
        collectionViewGesture.cancelsTouchesInView = false
        self.collectionView?.addGestureRecognizer(collectionViewGesture)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCellID")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView!)
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
        let collectionViewY = self.collectionViewEdgeInsets().top + (self.topView()?.frame.size.height ?? 0) + (self.topView()?.frame.origin.y ?? 0)
        self.collectionView?.frame = CGRect.init(x:self.collectionViewEdgeInsets().left, y: collectionViewY, width: self.view.bounds.size.width-self.collectionViewEdgeInsets().left*2, height: self.view.bounds.size.height-self.collectionViewEdgeInsets().bottom-(self.bottomView()?.frame.size.height ?? 0)-collectionViewY-iPhoneX_HomeIndicator)
        self.configRefreshUI()
    }
    @objc private func collectionViewTouchInSide() {
        self.collectionView?.endEditing(true)
    }
    // MARK: - 公共属性和方法
    ///    collectionView
    private(set) var collectionView:UICollectionView?
    ///    数据源
    var dataArrays:Array<Any> = Array.init()
    
    /// 设置layout
    func layout() -> UICollectionViewFlowLayout {
        return UICollectionViewFlowLayout()
    }
    ///  设置itemSize
    func itemSize() -> CGSize {
        return CGSize.zero
    }
    /// 如果想定制顶部固定的view，子类需要重写此方法
    func topView() -> UIView? {
        return nil
    }
    /// 如果想定制底部固定的view，子类需要重写此方法
    func bottomView() -> UIView? {
        return nil
    }
    /// 如果想定制UICollectionView相对于四边的缩进，子类需要重写此方法
    /// - Returns: 默认返回UIEdgeInsetsZero
    func collectionViewEdgeInsets() -> UIEdgeInsets {
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
        self.collectionView?.mj_header.beginRefreshing()
    }
    /// 触发上拉加载动作
    func toTriggerRequestGetMore() {
        self.collectionView?.mj_footer.beginRefreshing()
    }
    /// 请求完成，不管成功或者失败必须手动调用此方法结束刷新动画
    func finishRequest() {
        if self.collectionView!.mj_header.isRefreshing  {
            self.collectionView?.mj_header.endRefreshing()
        }else if self.collectionView!.mj_footer.isRefreshing {
            self.collectionView?.mj_footer.endRefreshing()
        }
    }
    /// 配置列表header和footer刷新数据的UI，已经有默认配置
    func configRefreshUI() {
        if self.shouldShowRefresh() {
            let refreshheader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.requestRefresh))
            refreshheader?.lastUpdatedTimeLabel.isHidden = true
            self.collectionView?.mj_header = refreshheader
        }
        if self.shouldShowGetMore() {
            let refreshfooter = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.requestGetMore))
            self.collectionView?.mj_footer = refreshfooter
        }
    }
    override func backgroundColor() -> UIColor {
        return RGB(r: 245, g: 245, b: 245)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension DCCollectionViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellID", for: indexPath)
        return cell
    }
}
