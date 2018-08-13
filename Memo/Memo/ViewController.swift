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
    @IBOutlet weak var showLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // textFieldDidChangeを識別するよう指定する
        textMemoryView.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 入力したテキストをユーザーデフォルトに保存
    @objc func textFieldDidChange(_ textField: UITextField) {
        let writtenText = textMemoryView.text! as NSString
        let defaults = UserDefaults.standard
        defaults.set(writtenText, forKey: "memo")
    }

    // 保存したテキストをラベルに表示する
    @IBAction func readText(_ sender: Any) {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: "memo")
        showLabel.text = value
    }
    
    // 編集完了する
    @IBAction func memorizeText(_ sender: Any) {
        view.endEditing(true)
    }
    
    // タップでキーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // クリアボタンがタップされると呼ばれるデリゲートメソッド
    //    func textFieldShouldClear(_ textField: UITextField) -> Bool {
    //        writeMemo.text = ""
    //        return true
    //    }
    
}

