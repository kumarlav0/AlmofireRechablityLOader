//
//  ExtensionVC.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/17/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController
{
    
    func alertWithOk(title:String,body:String)
       {
           let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
           
           let ok = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) in
               alert.dismiss(animated: true, completion: nil)
           })
        
            alert.addAction(ok)
           self.present(alert, animated: true, completion: nil)
       }
    
    
    func alertWithAction(buttonTitle:String,title:String,body:String,response: @escaping(_ isOk:Bool)-> Void )
       {
           let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
           
           let ok = UIAlertAction(title: buttonTitle, style: .default, handler: {(action:UIAlertAction) in
               response(true)
               alert.dismiss(animated: true, completion: nil)
           })
           
          let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
            alert.addAction(ok)
            alert.addAction(no)
           self.present(alert, animated: true, completion: nil)
       }
    
    
    func alertActionOk(title:String,body:String,response: @escaping(_ isOk:Bool)-> Void )
          {
              let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
              
              let ok = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) in
                  response(true)
                  alert.dismiss(animated: true, completion: nil)
              })
           
               alert.addAction(ok)
              self.present(alert, animated: true, completion: nil)
          }
    
    func openURL(urlString:String)
       {
           guard let url = URL(string: urlString) else {
                return
            }
           if UIApplication.shared.canOpenURL(url) {
               // UIApplication.shared.open(url, options: [:], completionHandler: nil)
               let svc = SFSafariViewController(url: url)
               present(svc, animated: true, completion: nil)
            }
       }
    
    
    
}


extension UITextField {
    
   private func setInputViewDatePicker(target: Any, selector: Selector,datePickerMode: UIDatePicker.Mode) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = datePickerMode //2
        if datePicker.datePickerMode == .date{
             
            datePicker.minimumDate = Date()
                //Calendar.current.date(byAdding: .day, value: 0, to: Date())
        }
      
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    
    
}
