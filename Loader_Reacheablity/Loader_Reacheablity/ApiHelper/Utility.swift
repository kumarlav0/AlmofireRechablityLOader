//
//  Utility.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/18/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//


import UIKit

class Utility {
    
  // if you need to find First Letter of String use this Method
    class func firstLetter(_ str:String) -> String? {
           guard let firstChar = str.first else {
               return nil
           }
           return String(firstChar)
       }
    
    // Trim  String to remove spaces
          static func Trim(_ value: String) -> String {
              let value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
              return value
          }
    
    // checks whether string value exists or it contains null or null in string
         static func stringExists(_ str: String) -> Bool {
             var strString : String? = str
             
             if strString == nil {
                 return false
             }
             
             if strString == String(describing: NSNull()) {
                 return false
             }
             if (strString == "<null>") {
                 return false
             }
             if (strString == "(null)") {
                 return false
             }
             strString = Utility.Trim(str)
             if (str == "") {
                 return false
             }
             if strString?.count == 0 {
                 return false
             }
             return true
         }
    
    
    // returns string value after removing null and unwanted characters
    
    static func getStringValue(_ str: AnyObject) -> String {
        if str is NSNull {
            return ""
        }
        else{
          
            var strString : String? = str as? String
            if Utility.stringExists(strString!) {
                strString = strString!.replacingOccurrences(of: "\t", with: " ")
                strString = Utility.Trim(strString!)
                if (strString == "{}") {
                    strString = ""
                }
                if (strString == "()") {
                    strString = ""
                }
                if (strString == "null") {
                    strString = ""
                }
                return strString!
            }
            return ""
        }
    }
    
    
    // Reload UITableView With Animation.
    static func reloadTableViewDataAnimated(_ tableView: UITableView){
           UIView.transition(with: tableView, duration: 0.55, options: .transitionCrossDissolve, animations:
                         { () -> Void in
                         tableView.reloadData()
                         }, completion: nil);
           
           tableView.reloadData()
          }
       
    // Use this method to blure Image easily.
    static func makeBlurImage(_ targetView:UIView?)
    {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetView!.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetView?.addSubview(blurEffectView)
    }
    
    
    // Get Integer Value from Any Obj or Any type.
    static func getIntegerFromAny(_ value: Any) -> Int {
        var strValue: String
        var ret = 0
        if value != nil {
            strValue = "\(value)"
            if !(strValue == "") && !(strValue == "null") {
                ret = Int((strValue as NSString ?? "0").intValue)
            }
        }
        return ret
    }
    
    // Get Float Value from Any Obj or Any type.
    static func getFloatFromAny(_ value: Any) -> Float {
          var strValue: String
        var ret:Float = 0.0
          if value != nil {
              strValue = "\(value)"
              if !(strValue == "") && !(strValue == "null") {
                  ret = Float((strValue as NSString ?? "0").floatValue)
              }
          }
          return ret
      }
    
    // Get Double Value from Any Obj or Any type.
    static func getDoubleFromAny(_ value: Any) -> Double {
           var strValue: String
         var ret:Double = 0.0
           if value != nil {
               strValue = "\(value)"
               if !(strValue == "") && !(strValue == "null") {
                   ret = Double((strValue as NSString ?? "0").doubleValue)
               }
           }
           return ret
       }
    
    
    // Get Array Value from Any Obj or Any type.
    static func getArrayFromAny(_ value: Any) -> NSArray {
        guard  value != nil,let input = value as? NSArray else { return [] }
        return input
    }
    
    
    // Get Dictionary Value from Any Obj or Any type.
       static func getDictionaryFromAny(_ value: Any) -> NSDictionary {
        guard  value != nil,let input = value as? NSDictionary else { return [:] }
           return input
       }
    
    
    
}
