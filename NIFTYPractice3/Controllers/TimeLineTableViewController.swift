//
//  TimeLineTableViewController.swift
//  NIFTYPractice3
//
//  Created by 今井咲江 on 2018/11/24.
//  Copyright © 2018 imai sakie. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    @IBOutlet weak var textFiled: UITextField!
    //TweetManagerクラスのインスタンスを定義
    let tweetManager = TweetManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //セルの登録
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tweetManager.fetchTweets { () in
            //callback()まできたらここの処理を実行する
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .plain, target: self, action: #selector(TimeLineTableViewController.post))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(TimeLineTableViewController.logout))
    }
    
    //viewDidAppear()メソッドはビューが表示された後に処理される。つまり、ビューが表示された後に遷移することになる
    //viewDidLoad()やviewWillAppear()に記述してもエラーは起きないが、警告が出る。これは、ビューがまだ表示されていない状態で他の画面に背にすることが推奨されていない
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NCMBUser.current() == nil {      //current()メソッドは。現在ログインしているユーザーを取得するためのもの
            performSegue(withIdentifier: "modalLoginViewController", sender: self)
        }
    }
    
    @objc func post() {
        print("投稿ボタンをタップしました")
        let tweet = Tweet(text: textFiled.text!)
        textFiled.text = ""
        textFiled.resignFirstResponder()
        tweet.save { () in
            self.tweetManager.fetchTweets { () in
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func logout() {
        NCMBUser.logOut()
        performSegue(withIdentifier: "modalLoginViewController", sender: self)
    }

    // MARK: - Table view data source

    //セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //セル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetManager.tweets.count
    }
    
    //セルの内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = tweet.user?.name
        cell.tweetLabel.text = tweet.text
        return cell
    }
    
    //セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        textFiled.resignFirstResponder()
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
