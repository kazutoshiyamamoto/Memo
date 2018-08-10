//
//  ViewController.swift
//  Memo
//
//  Created by home on 2018/08/04.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textMemoryField: UITextField!
    @IBOutlet weak var showLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textMemoryField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ユーザーデフォルトに保存する
    @IBAction func memorizeText(_ sender: Any) {
        let writtenText = textMemoryField.text! as NSString
        let defaults = UserDefaults.standard
        defaults.set(writtenText, forKey: "memo")
        view.endEditing(true)
    }
    // 保存したテキストをラベルに表示する
    @IBAction func readText(_ sender: Any) {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: "memo")
        showLabel.text = value
    }
    // タップでキーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 編集中に変更があるたびに呼び出されるデリゲートメソッド
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        let tmpStr = writeMemo.text! as NSString
    //        let replaceString = tmpStr.replacingCharacters(in: range, with: string)
    //        if replaceString != "" {
    //            // ユーザーデフォルトに保存する
    //            let defaults = UserDefaults.standard
    //            defaults.set(tmpStr, forKey: "edit")
    //        } else {
    //            // エラー処理
    //            print("Error")
    //        }
    //        // テキストフィールドを更新する
    //        return true
    //    }
    
    // クリアボタンがタップされると呼ばれるデリゲートメソッド
    //    func textFieldShouldClear(_ textField: UITextField) -> Bool {
    //        writeMemo.text = ""
    //        return true
    //    }
    
}

