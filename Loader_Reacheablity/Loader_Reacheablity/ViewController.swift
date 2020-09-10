//
//  ViewController.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/16/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    let user_id = "00"
    let event_id = "12"
    let long = "78.1245"
    let lat = "28.1245"
    let arr = [123,4567,667,778,000]
    let anyVal:Any = 6789
    let nsDD:NSDictionary? = nil
    let aa:Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          ReachabilityManager.shared.startListening()
        
            // print("Get Val::",Utility.getIntegerFromAny(anyVal))
         print("Get Val::",Utility.getFloatFromAny(arr))
        Utility.makeBlurImage(img)
        
         print("Get Array::",Utility.getArrayFromAny(arr))
         print("Get Dict::",Utility.getDictionaryFromAny(nsDD))
        
        
//        for (int i = -10 ; i < -9 ; i--) {
//        print("Hello")
//        }
//
//
//        for (int i = -10 ; i < -9 ; i++) {
//        print("Kumar",i)
//        }

        
        

    }
    
  

    @IBAction func callAction(_ sender: Any) {
      getAllData(true)
    }
    
}

class BB {
    func MMM()  {
       // MyName()
        MyName()
        MyName()
    }
    
    
    
}

 func MyName()  {
    
}

class CCC: BB {
    
}

extension ViewController{
    
    func getAllData() {
        let url = "\(ApiNames.DEFAULT_URL)\(ApiNames.GET_EVENT_DETAILS)?user_id=\(user_id)&event_id=\(event_id)&longitude=\(long)&latitude=\(lat)"
        WebServices.shared.getApi(self, urlStr: url, Success: { (success) in
            print("Success:",success)
        }) { (error) in
            print("Error:",error.localizedDescription)
        }
    }
    
    func getAllData(_ haveData:Bool)  {
        
        let dict = ["user_id":"00" as Any,"event_id":"12" as Any,"longitude":"78.1245" as Any,"latitude":"28.1245" as Any]
        print("haveData::",haveData,":::",dict)
        
        WebServices.shared.getApi(self, urlStr: ApiNames.GET_EVENT_DETAILS, dict, Success: { (success) in
             print("Success:",success)
        }) { (error) in
             print("Error:",error.localizedDescription)
        }
        
        
    }
    
    
    
    
}
