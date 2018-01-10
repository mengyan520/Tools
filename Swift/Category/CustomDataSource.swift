//
//  CustomDataSource.swift
//  AsyncDisplayKitDemo
//
//  Created by Carden on 2018/1/9.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
typealias CellConfigBlock = (_ cell:Any,_ data:Any)->()
class CustomDataSource: NSObject {
    var arrays:[Any]?
    var cellIdentifier:String?
    var configBlock:CellConfigBlock?
    
  //MARK:- init
    init(arrays:[Any],cellIdentifier:String,configBlock:@escaping CellConfigBlock) {
        super.init()
        self.arrays = arrays
        self.cellIdentifier = cellIdentifier
        self.configBlock = configBlock
    }
    func dataAtIndexPath(indexPath:IndexPath) -> Any {
        return arrays![indexPath.row]
    }
}
//MARK:- UITableViewDataSource
extension CustomDataSource:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrays?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        configBlock!(cell,self.dataAtIndexPath(indexPath: indexPath))
        return cell
    }
}
//MARK:- UICollectionViewDataSource
extension CustomDataSource:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrays?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)
        configBlock!(cell,self.dataAtIndexPath(indexPath: indexPath))
        return cell
    }
}
