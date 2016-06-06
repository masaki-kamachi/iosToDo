//
//  ViewController.swift
//  SampleNotStoryBoard
//
//  Created by masakikamachi on 2016/06/05.
//  Copyright © 2016年 masakikamachi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ナビバーの右上ボタンを用意
    var addBtn: UIBarButtonItem!
    
    // テーブルを用意
    var tableView: UITableView!
    
    // テーブルに表示するアイテムの配列を用意
    var memos = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        // addBtnを設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn
        
        // 画面サイズを取得
        let width: CGFloat! = self.view.bounds.width
        let height: CGFloat! = self.view.bounds.height
        
        // テーブルを用意して、表示
        tableView = UITableView(frame: CGRectMake(0, 0, width, height))
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "data")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    
    // viewDidLoadは最初の一回しか呼ばれないので、viewWillAppearを使うよ
    override func viewWillAppear(animated: Bool) {
        
        // CoreDataからデータを読み込んで配列memosに格納する
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let toDoContext: NSManagedObjectContext = appDel.managedObjectContext
        let toDoRequest: NSFetchRequest = NSFetchRequest(entityName: "ToDoStore")
        // 並び順をdateの、昇順としてみる
        toDoRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        toDoRequest.returnsObjectsAsFaults = false
        //3
        let results = try! toDoContext.executeFetchRequest(toDoRequest)
        memos = results as! [NSManagedObject]
        // テーブル情報を更新する
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // addBtnをタップしたときのアクション
    func onClick() {
        let second = EditViewController()
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    // セルの行数を指定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    // セルの値を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("data", forIndexPath: indexPath) as UITableViewCell
        let memo = memos[indexPath.row]
        cell.textLabel!.text = memo.valueForKey("memo") as? String
        return cell
    }
}

