//
//  MemoEditViewController.swift
//  Memo
//
//  Created by home on 2019/05/03.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class MemoEditViewController: UIViewController {

    @IBOutlet weak var textMemoryView: UITextView!
    
    // テキストファイルのパス
    var thePass = NSHomeDirectory() + "/Documents/myTextfile.txt"
    // テキストビューのframe
    var originalFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ファイルから読み込む
        readFromFile()
        
        // 通知センターのオブジェクトを作る
        let notification = NotificationCenter.default
        
        // キーボードが登場した
        notification.addObserver(self, selector: #selector(MemoEditViewController.keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        // キーボードのframeが変更された
        notification.addObserver(self, selector: #selector(MemoEditViewController.keyboardChangeFrame(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        
        // キーボードが退場した
        notification.addObserver(self, selector: #selector(MemoEditViewController.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // テキストビューの元のframeを保存する
        originalFrame = textMemoryView.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ファイルへ保存
    @IBAction func saveToFile(_ sender: Any) {
        // キーボードを下げる
        view.endEditing(true)
        // 保存するテキストデータ
        let textData = textMemoryView.text
        // テキストデータの保存をトライする
        do {
            try textData?.write(toFile: thePass, atomically: true, encoding: String.Encoding.utf8)
            self.showSavingAlert()
        } catch let error as NSError {
            print("保存に失敗。 \n \(error)")
        }
        // 保存したテキストデータを配列に格納する
        let memoListTableViewController: MemoListTableViewController = MemoListTableViewController()
        memoListTableViewController.memoList.append(textData!)
    }
    
    private func showSavingAlert() {
        let alert: UIAlertController = UIAlertController(title: "保存しました", message: "", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    // タップでキーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        // キーボードを下げる
        view.endEditing(true)
        // 保存するテキストデータ
        let textData = textMemoryView.text
        // テキストデータの保存をトライする
        do {
            try textData?.write(toFile: thePass, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("保存に失敗。 \n \(error)")
        }
    }
    
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        // キーボードを下げる
        view.endEditing(true)
        // 保存するテキストデータ
        let textData = textMemoryView.text
        // テキストデータの保存をトライする
        do {
            try textData?.write(toFile: thePass, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("保存に失敗。 \n \(error)")
        }
    }
    
    // ファイルからの読み込み
    func readFromFile() {
        do {
            let textData = try String(contentsOfFile: thePass, encoding: String.Encoding.utf8)
            textMemoryView.text = textData
        } catch let error as NSError {
            print("保存に失敗。 \n \(error)")
        }
    }
    
    // キーボードが表示された時に実行する
    @objc func keyboardDidShow(_ notification: Notification) {
        // keyboardChangeFrameも発生するのでそちらで処理する
    }
    
    // キーボードのサイズが変化した時の処理
    @objc func keyboardChangeFrame(_ notification: Notification) {
        // キーボードのframeを調べる
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // キーボードで隠れないようにテキストビューの高さを変更する
        var textViewFrame = textMemoryView.frame
        textViewFrame.size.height = keyboardFrame.minY - textViewFrame.minY - 5
        textMemoryView.frame = textViewFrame
    }
    
    // キーボードが退場した時の処理
    @objc func keyboardDidHide(_ notification: Notification) {
        // テキストビューのサイズを戻す
        textMemoryView.frame = originalFrame!
    }
}
