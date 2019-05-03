//
//  MemoListTableViewController.swift
//  Memo
//
//  Created by home on 2018/08/29.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    // メモデータを格納する配列
    var memoList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // セクションの個数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクション内の行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 配列memoListの値の個数
        return memoList.count
    }
    
    // セルを作る
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // テーブルのセルを参照
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // テーブルにmemoListのデータを表示
        let memoData = memoList[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = memoData
        
        return cell
    }

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

    // セグエで移動する前にデータを受け渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // セグエがshowWebPageのときの処理
        if segue.identifier == "showMemoPage" {
            // タップした行番号を取り出す
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // 行のデータを取り出す
                let memoData = memoList[(indexPath as NSIndexPath).row]
                // 移動先のビューコントローラのテキストファイルのパスに値を設定する
                (segue.destination as! ViewController).thePass = memoData
            }
        }
    }
}
