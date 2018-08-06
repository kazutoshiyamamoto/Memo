//
//  ViewController.swift
//  Memo
//
//  Created by home on 2018/08/04.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var writeMemo: UITextField!
    @IBOutlet weak var readMemo: UITextField!
    @IBOutlet weak var editCompletion: UIButton!
    
    // 編集終了でキーボードを下げる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        writeMemo.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 編集中に変更があるたびに呼び出されるデリゲートメソッド
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let tmpStr = textField.text! as NSString
        let replaceString = tmpStr.replacingCharacters(in: range, with: string)
        if replaceString == "" {
            // エラー処理or何もしない
        } else {
            // ユーザーデフォルトに保存する
        }
        // テキストフィールドを更新する
        return true
    }
    
    // クリアボタンがタップされると呼ばれるデリゲートメソッド
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        writeMemo.text = ""
        return true
    }
    
    @IBAction func editCompletionButton(_ sender: Any) {
        view.endEditing(true)
    }
    
}

