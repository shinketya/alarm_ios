//
//  ViewController.swift
//  Alarm_ios
//
//  Created by b1017105 on 2018/11/07.
//  Copyright © 2018年 b1017105. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UNUserNotificationCenterDelegate, UITextFieldDelegate{

    
    
    @IBOutlet weak var timesavefield: UITextField!
    
    
    @IBAction func setNotification(_ sender: Any) {
        let textfieldNum:Int? = Int(timesavefield.text!)
        // タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = "時間です"
        content.subtitle = "10秒経過しました"
        content.body = "タップしてアプリを開いてください"
        content.sound = UNNotificationSound.default
        
        // seconds後に起動するトリガーを保持
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(textfieldNum ?? 10), repeats: false)
        
        // 識別子とともに通知の表示内容とトリガーをrequestに内包する
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        // UNUserNotificationCenterにrequestを加える
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // UItextField以外の部分タッチでキーボード非表示
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.timesavefield.isFirstResponder) {
            self.timesavefield.resignFirstResponder()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // フォアグランドの場合でも通知を表示する
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent willPresentnotification: UNNotification, withCompletionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        withCompletionHandler([.alert, .badge, .sound])
    }


}

