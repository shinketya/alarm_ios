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

    
    
    
    @IBOutlet weak var timesavesecond: UITextField!
    @IBOutlet weak var timesaveminute: UITextField!
    @IBOutlet weak var timesavehour: UITextField!
    
    
    @IBAction func setNotification(_ sender: Any) {
        let textfieldSecond:Int? = Int(timesavesecond.text!)
        let textfieldMinute:Int? = Int(timesaveminute.text!)
        let textfieldHour:Int? = Int(timesavehour.text!)
        
        let content = UNMutableNotificationContent()
        content.title = "時間です"
        if (textfieldSecond != nil && textfieldMinute == nil && textfieldHour == nil) {
            content.subtitle = "\(Int(textfieldSecond!))秒経過しました"
        } else if (textfieldSecond != nil && textfieldMinute != nil && textfieldHour == nil){
            content.subtitle = "\(Int(textfieldMinute!))分\(Int(textfieldSecond!))秒経過しました"
        } else if (textfieldSecond != nil && textfieldMinute != nil && textfieldHour != nil) {
            content.subtitle = "\(Int(textfieldHour!))時間\(Int(textfieldMinute!))分\(Int(textfieldSecond!))秒経過しました"
        }
        content.body = "タップしてアプリを開いてください"
        content.sound = UNNotificationSound.default
        
        // seconds後に起動するトリガーを保持
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(textfieldSecond ?? 10) + TimeInterval(textfieldMinute ?? 0)*60 + TimeInterval(textfieldHour ?? 0)*3600, repeats: false)
        
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
        if (self.timesavesecond.isFirstResponder) {
            self.timesavesecond.resignFirstResponder()
        }
        if (self.timesaveminute.isFirstResponder) {
            self.timesaveminute.resignFirstResponder()
        }
        if (self.timesavehour.isFirstResponder) {
            self.timesavehour.resignFirstResponder()
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

