//
//  LoginInfoModel.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 03/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class LoginInfoModel {
    
    private static let TAG = "LoginInfoModel"
    
    private var userID: String
    private var userPassword: String
    private var autoLogin: Bool
    
    init(userID: String, userPassword: String, autoLogin: Bool) {
        self.userID = userID
        self.userPassword = userPassword
        self.autoLogin = autoLogin
    }
    deinit {
        ILog.debug(tag: LoginInfoModel.TAG, content: "deinit")
    }
    
    public func getUserID() -> String {
        return self.userID
    }
    
    public func getUserPassword() -> String {
        return self.userPassword
    }
    
    public func getAutoLogin() -> Bool {
        return self.autoLogin
    }
    
}
