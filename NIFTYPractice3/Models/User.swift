//
//  User.swift
//  NIFTYPractice3
//
//  Created by 今井咲江 on 2018/11/30.
//  Copyright © 2018 imai sakie. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    //LoginViewControllerにmessageが渡される
    func signUp(callback: @escaping (_ message: String?) -> Void) {
        //ニフクラが提供しているうユーザー管理のためのクラス(userName, passwordがプロパティとして定義されている)
        let user = NCMBUser()
        user.userName = name
        user.password = password
        
        //サインアップの処理。成功するとニフクラのデータベースに新しくUserオブジェクトが作成され、userNameに代入した名前が保存される
        user.signUpInBackground { (error) in
            let nserror = error as NSError?
            callback(_ : nserror?.userInfo["NSLocalizedDescription"] as? String)
        }
    }

}
