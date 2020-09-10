//
//  ApiManager.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/17/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//

import Foundation
import KRProgressHUD // Used to Present Loader when Api will call.
import Reachability // To check Internet Connection and Wifi Connection Dynamically
import Alamofire // Almofire is used to Request, Upload & Download Data From Server. which is a Library to do it very easly.

// Singleton Class to Call Apis and Upload Images to the Server.
class WebServices {
    
    // shared obj to access globally in project
    static let shared = WebServices()
    
    // MARK:- getApi Method
    // pass all data and url to call Api using GET method.
    // success, failure are typealias
    func getApi(_ context:UIViewController,urlStr:String,Success success: @escaping success, Failure failure: @escaping failure)
    {
        if checkInternet(context){
            presentIndicator()
            
            Alamofire.request(urlStr, method: .get)
                .validate()
                .responseJSON
                {
                    response in
                    self.dismissIndicator()
                    switch response.result
                    {
                    case .success:
                        print(response.result.value!)
                        if response.result.value is NSDictionary
                        {
                            success((response.result.value as? NSDictionary)!)
                        }
                    case .failure(let error):
                        
                        let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                        print(responseString)
                        
                        failure(error as NSError)
                    } // End of switch statment
            }// End of JSON
            
        } // End of checkInternet Connection Method
        
    } // End of getApi  Method
    
    
    
    
    
    
    // MARK:- getApi Method with Method Overloading (Parameter changed)
    // pass all data and url to call Api using GET method.
    // dictPost, success, failure are typealias
    func getApi(_ context:UIViewController,urlStr:String,_ dictPost: dictPost,Success success: @escaping success, Failure failure: @escaping failure)
    {
        if checkInternet(context){
            presentIndicator()
            Alamofire.request(ApiNames.DEFAULT_URL+urlStr, method: .get,parameters: dictPost)
                .validate()
                .responseJSON
                {
                    response in
                    self.dismissIndicator()
                    switch response.result
                    {
                    case .success:
                        print(response.result.value!)
                        if response.result.value is NSDictionary
                        {
                            success((response.result.value as? NSDictionary)!)
                        }
                    case .failure(let error):
                        
                        let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                        print(responseString)
                        
                        failure(error as NSError)
                    } // End of switch statment
            }// End of JSON
            
            
        } // End of checkInternet Connection Method
        
        
    } // End of getApi  Method
    
    
    // MARK:- postApi Method
    // pass all data and url to call Api using GET method.
    // dictPost, success, failure are typealias
    func postApi(_ context:UIViewController,urlStr:String,_ dictPost: dictPost,Success success: @escaping success, Failure failure: @escaping failure)
    {
        if checkInternet(context){
            presentIndicator()
            Alamofire.request(ApiNames.DEFAULT_URL+urlStr, method: .post,parameters: dictPost, headers: ["Apikey" : ApiNames.API_KEY])
                .validate()
                .responseJSON
                {
                    response in
                    self.dismissIndicator()
                    switch response.result
                    {
                    case .success:
                        print(response.result.value!)
                        if response.result.value is NSDictionary
                        {
                            success((response.result.value as? NSDictionary)!)
                        }
                    case .failure(let error):
                        
                        let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                        print(responseString)
                        
                        failure(error as NSError)
                    } // End of switch statment
            }// End of JSON
            
            
        } // End of checkInternet Connection Method
        
    }  // End of postApi  Method
    
    
    // MARK:- uploadImageWithData Method
    // Uploading Single image with Data to Server Using Alomofire Frafwork With Multipart Technique
    func uploadImageWithData(_ context:UIViewController,strURL:String, Dictionary dictPost:dictPost,image: UIImage, imageParameterName imageName:String,progressCompletion: @escaping (_ percent: Float) -> Void,Success success: @escaping success, Failure failure: @escaping failure) {
        if checkInternet(context){
            presentIndicator()
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Could not get JPEG representation of UIImage")
                return
            }
            let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
            // Start Uploading Image to Server
            // import image to request
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData,
                                         withName: imageName,
                                         fileName: "\(self.getUniqueName()).jpg",
                    mimeType: "image/jpeg")
                
                // import parameters
                for (key, value) in dictPost {
                    let stringValue = value as! String
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                }
                
                
            }, with: URL, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress { progress in
                        progressCompletion(Float(progress.fractionCompleted))
                    }
                    
                    upload.validate()
                    upload.responseJSON
                        {
                            response in
                            self.dismissIndicator()
                            switch response.result
                            {
                            case .success:
                                print(response.result.value!)   // result of response serialization
                                if response.result.value is NSDictionary
                                {
                                    success((response.result.value as? NSDictionary)!)
                                }
                                
                            case .failure(let error):
                                let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                print(responseString)
                                
                                failure(error as NSError)
                            }
                            //  hud.hide(animated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    //  hud.hide(animated: true)
                }
            })
        } // End of checkInternet Connection Method
    } // End of uploadImageWithData  Method
    
    
    // MARK:- uploadImage Method
    // Uploading Single image to Server Using Alomofire Frafwork With Multipart Technique
    // Only Single Image can send to the Server.
    func uploadImage(_ context:UIViewController,image: UIImage, strURL:String, imageParameterName imageName:String, progressCompletion: @escaping (_ percent: Float) -> Void, completion: @escaping (_ tags: [String]?) -> Void) {
        
        if checkInternet(context){
            presentIndicator()
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Could not get JPEG representation of UIImage")
                return
            }
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData,
                                         withName: imageName,
                                         fileName: "\(self.getUniqueName()).jpg",
                    mimeType: "image/jpeg")
            },
                             to: ApiNames.DEFAULT_URL+strURL,
                             headers: ["Apikey": ApiNames.API_KEY],
                             encodingCompletion: { encodingResult in
                                
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.uploadProgress { progress in
                                        progressCompletion(Float(progress.fractionCompleted))
                                    }
                                    upload.validate()
                                    upload.responseJSON { response in
                                        self.dismissIndicator()
                                        guard response.result.isSuccess,let value = response.result.value else {
                                            print("Error while uploading file: \(String(describing: response.result.error))")
                                            completion(nil)
                                            return
                                        }
                                        print("Response Value:",value)
                                        // let firstFileID = JSONDecoder(value)["uploaded"][0]["id"].stringValue
                                        //print("Content uploaded with ID: \(firstFileID)")
                                        completion(nil)
                                    }
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            })
        } // End of checkInternet Connection Method
    }// End of uploadImage  Method
    
    
    
    
    
    /*
     ALAMOFIRE Post method with multiple image paramter
     strURl             = Pass the request URl of the method Api
     dictPost           = Pass the dicticnary of the parameter else pass nil
     viewController     = Pass the view of the view controller
     APIKey             = Pass the API key or header key of the server
     Response           = Response is of dictionary class
     outletImageArray   = Pass the array of uiimage
     imageName          = Pass the name of parameter which is to be send to server
     */
    
    func requestPostUrlWithMultipleImage(_ context:UIViewController,strURL:String, Dictionary dictPost:[String: AnyObject], AndImage outletImageArray:NSArray, forImageParameterName imageName:NSString, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void , progressCompletion: @escaping (_ percent: Float) -> Void  )
    {
        
        if checkInternet(context){
            presentIndicator()
            // Begin upload
            let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                for image in outletImageArray
                {
                    // import image to request
                    let img = image as! UIImage
                    if let imageData = img.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: imageName as String, fileName: "myImage\(self.getUniqueName()).jpg", mimeType: "image/jpeg")
                    }
                    
                }
                
                // import parameters
                for (key, value) in dictPost
                {
                    if value is String
                    {
                        let stringValue = value as! String
                        multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                    }
                }
                
            }, with: URL, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress { progress in
                        progressCompletion(Float(progress.fractionCompleted))
                    }
                    
                    upload.responseJSON
                        {
                            response in
                            self.dismissIndicator()
                            switch response.result
                            {
                            case .success:
                                print(response.result.value!)   // result of response serialization
                                if response.result.value is NSDictionary
                                {
                                    success((response.result.value as? NSDictionary)!)
                                }
                                
                            case .failure(let error):
                                let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                print(responseString)
                                
                                failure(error as NSError)
                            }
                            
                            
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    
                }
            })
            
            
        } // End of checkInternet Connection Method
        
        
    } // End of requestPostUrlWithMultipleImage Method
    
    
    
    /*
     ALAMOFIRE Post method with single image paramter
     strURl             = Pass the request URl of the method Api
     dictPost           = Pass the dicticnary of the parameter else pass nil
     viewController     = Pass the view of the view controller
     APIKey             = Pass the API key or header key of the server
     Response           = Response is of dictionary class
     filePath           = Pass the name of parameter which is to be send to server
     fileName           = Pass the file name
     */
    
    func requestPostUrlWithFile(_ context:UIViewController,strURL:String, Dictionary dictPost:[String: AnyObject], AndFilePath filePath:URL, forFileParameterName fileName:String, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void , progressCompletion: @escaping (_ percent: Float) -> Void   )
    {
        
        if checkInternet(context){
            presentIndicator()
            // Begin upload
            // Begin upload
            let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(filePath, withName: fileName)
                
                // import parameters
                for (key, value) in dictPost {
                    let stringValue = value as! String
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                }
            }, with: URL, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress { progress in
                        progressCompletion(Float(progress.fractionCompleted))
                    }
                    
                    upload.responseJSON
                        {
                            response in
                            self.dismissIndicator()
                            switch response.result
                            {
                            case .success:
                                print(response.result.value!)   // result of response serialization
                                if response.result.value is NSDictionary
                                {
                                    success((response.result.value as? NSDictionary)!)
                                }
                                
                            case .failure(let error):
                                let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                print(responseString)
                                
                                failure(error as NSError)
                            }
                            
                            
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    
                }
            })
            
            
        } // End of checkInternet Connection Method
        
        
    } // End of requestPostUrlWithFile Method
    
    
    
    
    /*
     ALAMOFIRE Post method with single image paramter
     strURl             = Pass the request URl of the method Api
     dictPost           = Pass the dicticnary of the parameter else pass nil
     viewController     = Pass the view of the view controller
     APIKey             = Pass the API key or header key of the server
     Response           = Response is of dictionary class
     outletImage        = Pass the uiimage
     imageName          = Pass the name of parameter which is to be send to server
     filePath           = Pass the name of parameter which is to be send to server
     fileName           = Pass the file name
     
     */
    
    func requestPostUrlWithImageAndFile(_ context:UIViewController,strURL:String, Dictionary dictPost:[String: AnyObject], AndImage outletImage:UIImage, forImageParameterName imageName:String, AndFilePath filePath:URL, forFileParameterName fileName:String, Success success:@escaping (_ responce: NSDictionary) ->Void, Failure failure:@escaping (_ error: NSError) ->Void   )
    {
        
        if checkInternet(context){
            presentIndicator()
            // Begin upload
            let URL = try! URLRequest(url: ApiNames.DEFAULT_URL + strURL , method: .post, headers: ["Apikey" : ApiNames.API_KEY])
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(filePath, withName: fileName)
                
                // import image to request
                if let imageData = outletImage.jpegData(compressionQuality: 0.5)
                {
                    
                    multipartFormData.append(imageData, withName: imageName, fileName: "\(self.getUniqueName()).jpg", mimeType: "image/jpeg")
                }
                
                // import parameters
                for (key, value) in dictPost {
                    let stringValue = value as! String
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                }
            }, with: URL, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON
                        {
                            response in
                            self.dismissIndicator()
                            switch response.result
                            {
                            case .success:
                                print(response.result.value!)   // result of response serialization
                                if response.result.value is NSDictionary
                                {
                                    success((response.result.value as? NSDictionary)!)
                                }
                                
                            case .failure(let error):
                                let responseString:String = String(data: response.data!, encoding: String.Encoding.utf8)!
                                print(responseString)
                                
                                failure(error as NSError)
                            }
                            
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    
                }
            })
            
            
        } // End of checkInternet Connection Method
    } // End of requestPostUrlWithImageAndFile Method
    
    
    
    
    
    
    
    
    
    // MARK:- checkInternet Method
    // when Api start calling just before chacking Internet connection isAvailable or not.
    private func checkInternet(_ context:UIViewController) -> Bool {
        guard ReachabilityManager.shared.isReachable else {
            context.alertWithOk(title: "No Internet", body: "Please conect your mobile to Wifi or Internet.")
            return false
        }
        return true
    }
    
    // MARK:- displayLoader Method
    // Presenting Loader on the basic of User Conditions.
    private func displayLoader(_ shouldDisplay: Bool, show: Bool) {
        if shouldDisplay {
            if show {
                // display loader
                presentIndicator()
            } else {
                // hide loader
                dismissIndicator()
            }
        }
    }
    
    // MARK:- printLog Method
    // PritLog is a method to print Any kind of Value. basically it is Variadic Function
    private func printLog(_ values: Any...) {
        if Constant.isDebugingEnabled {
            _ = values.map({ print($0) })
        }
    }
    
    
    //MARK:- dismissIndicator Method
    //Dismissing Loader inside Main Thread Because it is related to UI.
    private func dismissIndicator() {
        DispatchQueue.main.async {
            // AppDelegate.appDelegate().window.isUserInteractionEnabled = true
            KRProgressHUD.dismiss()
        }
    }
    
    // MARK:- presentIndicator Method
    //Presenting Loader inside Main Thread Because it is related to UI.
    private func presentIndicator() {
        DispatchQueue.main.async {
            //  AppDelegate.appDelegate().window?.isUserInteractionEnabled = false
            KRProgressHUD.show()
        }
    }
    
    private func getUniqueName() -> String {
        let uuidStr = UUID().uuidString
        return "\(ApiNames.APP_NAME)_imgId"+uuidStr
    }
    
}
