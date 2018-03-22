//
//  XYWAPICenter.swift
//  jatiin
//
//  Created by 薛永伟 on 2018/3/15.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit

class XYWAPICenter: NSObject {
    // MARK: - 各个接口的地址
    static let host = "http://xyw.pub"
    
    // MARK: 获取基础URL，在此添加api版本等信息
    static func getBaseUrl() -> String {
        return host + self.getAppVersion()
    }
    
    // MARK: 获取用户信息的url
    static func getUserInfoUrl() -> String {
        return getBaseUrl() + "user/getinfo"
    }
    
    // MARK: 获取登陆的url
    static func getLoginUrl() -> String {
        return getBaseUrl() + "user/login"
    }
    
    
    
}


//=================================


// MARK: - 接口中可能需要的辅助信息
extension XYWAPICenter {
    
    // MARK: 获取app的版本信息
    fileprivate static func getAppVersion() -> String {
        //return "1.1.0"
        //版本号信息去掉持续集成附加的日期信息 "1.1.0.122_16080822"
        guard let infoDictionary = Bundle.main.infoDictionary else { return "" }
        let majorVersion : AnyObject = infoDictionary["CFBundleShortVersionString"] as AnyObject
        guard let appversion = majorVersion as? String else { return "" }
        let range=appversion.range(of: "_", options: NSString.CompareOptions())
        
        let strRange = (appversion.startIndex ..< ((range?.lowerBound) ?? appversion.endIndex))
        let version = String(appversion[strRange])
        
        return version
        
    }
    
    // MARK: 获取app的显示名
    fileprivate static func getAppDisplayName() -> String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "" }
        return infoDictionary["CFBundleDisplayName"] as? String ?? ""
    }
    
    // MARK: 获取uuid
    fileprivate static func getIdentifierNumber() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // MARK: 获取系统名 e.g. iOS
    fileprivate static func getSystemName() -> String {
        return UIDevice.current.systemName
    }
    
    // MARK: 获取系统版本 e.g. @"9.0"
    fileprivate static func getIosversion() -> String {
        return UIDevice.current.systemVersion
    }
}
