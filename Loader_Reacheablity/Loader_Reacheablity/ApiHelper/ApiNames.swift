//
//  ApiNames.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/17/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//

import Foundation


struct ApiNames
{

    //Put your App-Name here to get anywhere in the project.
    static let APP_NAME                          = "MyApp"
    //Pur here Default url of your API . an example is given below just remove it and put your own url here.
    static let DEFAULT_URL                       = "http://saudicalendar.com/api/user/"
    // Put here the name of your Cover image placeholder name which is going to use in whole project.
    static let COVER_IMAGE                       = "placeholder_cover"
    // Put here the name of your Square image placeholder name which is going to use in whole project. if you need anything else just create a new one below.
    static let SQUARE_IMAGE                      = "placeholder_square"
    // if in your Project API key required to call any API than put it below.
    static let API_KEY                           = ""
    
    static let NO_INTERNET_MESSAGE               = "No Internet Connection"
    static let API_LOADING_MESSAGE               = "Loading..."
    
    // MARK:- App SocialMedia Accounts
    // Magic Rise Social Ids.
    static let FACEBOOK_URL                      = "https://www.facebook.com/magicrisewellness/"
    static let INSTAGRAM_URL                     = "https://www.instagram.com/magicrisewellness/"
    static let TWITTER_URL                       = "https://twitter.com/magicriseparty"
    static let YOUTUBE_URL                       = ""
    
    static let PAYMENT_GATEWAY_URL               = ""
    
// An example of API placing is kept below. use the way that is given below create your own API NAME.
// These all are Static Let variable thats why it must be in CAPITAL LETTER. you are not suppose to change the value of any variables decleared here any where in the project only you can access these variable any where in the project just because of static and let. Some of the placeholder API name given below if you don't need it just remove it and write your own
    
// MARK:- APIs Collection
//  STATIC LET NAME                               API_NAME                                    API_COUNT
    static let LOGIN                             = "login"                                     // 01
    static let REGISTER                          = "register"                                  // 02
    static let FORGET_PASSWORD                   = "forget_password"                           // 03
    static let GET_EVENT_DETAILS                 = "getEventDetail"                            // 04
    
    
    
}  // End of ApiNames structure
