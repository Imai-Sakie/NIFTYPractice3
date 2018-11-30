//
//  Tweet.swift
//  NIFTYPractice3
//
//  Created by 今井咲江 on 2018/11/24.
//  Copyright © 2018 imai sakie. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    //ツイートのテキストを保持するためのtextプロパティの設定
    var text: String
    //TweetがUserをプロパティとして保持している状態になる
    var user: User?
    
    init(text: String) {
        self.text = text
    }
    
    func save(callback: @escaping () -> Void) {
        //引数に指定した文字列の名前でオブジェクトがニフクラ上に生成される
        let tweetObject = NCMBObject(className: "Tweet")
        //第一引数に保存したいデータを、第二引数にはそのキーを指定する
        tweetObject?.setObject(text, forKey: "text")
        tweetObject?.setObject(NCMBUser.current(), forKey: "user")
        //実際にニフクラ上にデータを保存するためのメソッド(非同期通信)
        tweetObject?.saveInBackground { (error) in
            if error == nil {
                print("保存完了！")
                callback()
            }
        }
    }
}
