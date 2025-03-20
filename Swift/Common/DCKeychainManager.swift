//
//  DCKeychainManager.swift
//  钥匙串测试
//
//  Created by peodgo on 3/20/25.
//

import UIKit
import Valet
class DCKeychainManager: NSObject {
    static let dc_manager = DCKeychainManager()
    override init() {
        super.init()
        dc_createKeychainManagerAction(dc_identifier: "dc_keychain_id")
    }
    //MARK: - lazy
    var dc_keychainManager:Valet?
    func dc_createKeychainManagerAction(dc_identifier:String) {
        /*
         常规数据 ➔ whenUnlocked
         后台服务数据 ➔ afterFirstUnlock
         设备唯一敏感数据 ➔ whenUnlockedThisDeviceOnly
         生物识别关联数据 ➔ whenPasscodeSetThisDeviceOnly
         */
        dc_keychainManager = Valet.valet(with: Identifier(nonEmpty:dc_identifier)!, accessibility: .whenUnlocked)
    }
    func dc_keychainSaveSrAction(dc_key: String,dc_value:String) {
        try? dc_keychainManager?.setString(dc_value, forKey: dc_key)
    }
    func dc_keychaingetSrAction(dc_key: String) -> String? {
        return try? dc_keychainManager?.string(forKey: dc_key)
    }
}
