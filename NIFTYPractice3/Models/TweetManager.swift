//
//  TweetManager.swift
//  NIFTYPractice3
//
//  Created by 今井咲江 on 2018/11/24.
//  Copyright © 2018 imai sakie. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    //static letを使用して、TweetManagerクラスのインスタンスをシングルトン(インスタンスが１個しか生成されない)にする
    static let sharedInstance = TweetManager()
    
    //このクラスのインスタンスを生成すると、どこでもいつでも同じインスタンスを取得することができインスタンスが持つtweetsプロパティも同じものを使用することができる(シングルトンのおかげ)
    var tweets: [Tweet] = []
    
    //ツイートを複数取得するためのメソッド
    func fetchTweets(callback: @escaping () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        //includeKey()メソッドは引数に指定したカラムの型がリレーションの場合、その中に格納されているオブジェクトを同時に取得できる
        query?.includeKey("user")
        query?.order(byDescending: "createDate")
        //objectsで実際に取得したNCMBObjectの配列が取得される。取得失敗したらerrorで失敗した理由を取得する
        query?.findObjectsInBackground { (objects, error) in
            //取得の処理が成功した時のみ後に続く処理を行う
            if error == nil {
                //ツイートを管理する配列の中身を空にする
                self.tweets = []
                for object in objects! {
                    //保存時に設定したキー(text)をobjectメソッドの引数に指定することで値を取得できる
                    let text = (object as AnyObject).object(forKey: "text") as! String
                    let tweet = Tweet(text: text)
                    let userObject = (object as AnyObject).object(forKey: "user") as! NCMBUser
                    print(userObject.userName!)
                    let user = User(name: userObject.userName!, password: "")
                    tweet.user = user
                    self.tweets.append(tweet)
                    //取得したツイートが配列に追加された後にコールバックを呼ぶ
                    callback()
                }
            }
        }
    }
}
