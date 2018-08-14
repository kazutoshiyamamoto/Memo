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
    let thePass = NSHomeDirectory() + "/Documents/myTextfile.txt"
    // テキストビューのframe
    var originalFrame: CGRect?
    
    
    override func viewDidAppear(_ animated: Bool) {
        // テキストビューの元のframeを保存する
        originalFrame = textMemoryView.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ファイルから読み込む
        readFromFile()
        
        // 通知センターのオブジェクトを作る
        let notification = NotificationCenter.default
        
        
        
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
    
    
    
    
    
}

