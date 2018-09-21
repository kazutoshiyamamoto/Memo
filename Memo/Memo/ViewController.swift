//
//  ViewController.swift
//  Memo
//
//  Created by home on 2018/08/04.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textMemoryView: UITextView!
    
    // テキストファイルのパス
    var thePass = NSHomeDirectory() + "/Documents/myTextfile.txt"
    // テキストビューのframe
    var originalFrame: CGRect?
    
    override func viewDidAppear(_ animated: Bool) {
        // テキストビューの元のframeを保存する
        originalFrame = textMemoryView.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ファイルから読み込む
        readFromFile()
        
        // 通知センターのオブジェクトを作る
        let notification = NotificationCenter.default
        
        // キーボードが登場した
        notification.addObserver(self, selector: #selector(ViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        // キーボードのframeが変更された
        notification.addObserver(self, selector: #selector(ViewController.keyboardChangeFrame(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
        // キーボードが退場した
        notification.addObserver(self, selector: #selector(ViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        } catch let error as NSError {
            print("保存に失敗。 \n \(error)")
        }
        // 保存したテキストデータを配列に格納する
        let memoListTableViewController: MemoListTableViewController = MemoListTableViewController()
        memoListTableViewController.memoList.append(textData!)
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
    
    // 編集キャンセルボタン
    @IBAction func cansel(_ sender: UIBarButtonItem) {
        // キーボードを下げる
        view.endEditing(true)
        // ファイルから読み込む
        readFromFile()
    }
    
    // キーボードが表示された時に実行する
    @objc func keyboardDidShow(_ notification: Notification) {
        // keyboardChangeFrameも発生するのでそちらで処理する
    }
    
    // キーボードのサイズが変化した時の処理
    @objc func keyboardChangeFrame(_ notification: Notification) {
        // キーボードのframeを調べる
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
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
}

