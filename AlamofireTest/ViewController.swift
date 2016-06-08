//
//  ViewController.swift
//  AlamofireTest
//
//  Created by zdaecqze zdaecq on 04.06.16.
//  Copyright © 2016 zdaecqze zdaecq. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireJsonToObjects
import EVReflection

class WeatherResponse: Mappable {
    var location: String?
    var threeDayForecast: [Forecast]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}

class Forecast: Mappable {
    var day: String?
    var temperature: Int?
    var conditions: String?
    
    required convenience init?(_ map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}

class WeatherResponse2: EVObject {
    var location: String?
    var three_day_forecast: [Forecast2] = [Forecast2]()
}

class Forecast2: EVObject {
    //var day: String?
    var temperature: NSNumber?
    var conditions: String?
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*{
            "data": {
                "location": "Toronto, Canada",
                "three_day_forecast": [
                {
                "conditions": "Partly cloudy",
                "day" : "Monday",
                "temperature": 20
                },
                {
                "conditions": "Showers",
                "day" : "Tuesday",
                "temperature": 22
                },
                {
                "conditions": "Sunny",
                "day" : "Wednesday",
                "temperature": 28 
                }
                ]
            }
        }*/
        
        /*[
         {
         "conditions": "Partly cloudy",
         "day" : "Monday",
         "temperature": 20
         },
         {
         "conditions": "Showers",
         "day" : "Tuesday",
         "temperature": 22
         },
         {
         "conditions": "Sunny",
         "day" : "Wednesday",
         "temperature": 28
         }
         ]*/
        
        /*{  "location": "Toronto, Canada",
         "three_day_forecast": [
         { "conditions": "Partly cloudy",
         "day" : "Monday",
         "temperature": 20
         }, {
         "conditions": "Showers",
         "day" : "Tuesday",
         "temperature": 22
         }, {
         "conditions": "Sunny",
         "day" : "Wednesday",
         "temperature": 28
         }
         ]
         }*/
        
        
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
        let URL2 = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/f583be1121dbc5e9b0381b3017718a70c31054f7/sample_array_json"
        let URL3 = "https://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/sample_json"
        
        let efer = URL.length
        
        LoadingView.sharedInstance.showInCenterOfView(view) 
        Alamofire.request(.GET, URL3).validate().responseObject{ (response: Response<WeatherResponse, NSError>) in
            LoadingView.sharedInstance.hide()
            switch response.result {
            case .Success(let value):
                let jsonString  = Mapper().toJSONString(value, prettyPrint: true)!
                let object      = Mapper<WeatherResponse>().map(jsonString)!
                print(object)
                print(jsonString)

            case .Failure(let error):
                print(error)
            }
        }
        
        //Alamofire.request(.GET, URL3).validate().responseObject { (response: Result<WeatherResponse2, NSError>) in
            //print("2")
        //}
        
        //Alamofire.request(.GET, URL2).responseArray { (response: Response<[Forecast], NSError>) in
            
        //}.responseDebugPrint()

        //Alamofire.request(.GET, URL2).responseArray { (response: Result<[Forecast2], NSError>) in
            
        //}.responseDebugPrint()
        
        
        let phone = "+79882477572"
        let password = "111111"
        
        let postDictionary = [
            "phone" : phone,
            "password" : password
        ]
        let stagingBaseURL = "http://52.58.6.127/api/v1/"
        //    static let stagingBaseURL = "http://192.168.10.123:3005/api/v1/"
        
        //let registerUserURL = stagingBaseURL + "users"
        let loginUserURL = stagingBaseURL + "users/login"
        
        //Alamofire.request(.POST, loginUserURL, parameters: postDictionary).responseObject{ (response: Response<WeatherResponse, NSError>) in
            
            //switch response.result {
                //case .Success(let value):
                //print(value)
                //case .Failure(let error):
                //print(error)
            //}
        //}
        
        
        
        
        //Alamofire.request(.POST, loginUserURL, parameters: postDictionary)
            //.validate()
            //.responseJSON { response in
                
                //if response.result.isSuccess {
                    //guard let token = response.result.value!["id"] as? String else {return}
                    //print(token)
                //} else {
                    //print("error")
                //}
                
                //switch response.result {
                //case .Success(let JSON):
                    //guard let token = JSON["id"] as? String else {return}
                    //print(token)
                //case .Failure(_):
                    //print("error")
                //}
                
                ///*switch response.result {
                //case .Success(let JSON):
                    //if let token = JSON["id"] as? String {
                        ////completion(token, nil)
                    //}
                //case .Failure(let error):
                    
                    //print(error)
                    ////if let data = response.data where response.data?.length != 0 {
                        ////let errorJSONString = NSString(data: data, encoding:NSUTF8StringEncoding)
                        ////print(errorJSONString)
                        //////let error = Mapper<OCError>().map(errorJSONString!)
                        //////completion(nil, error)
                    ////} else {
                        //////let error = OCError(name: "Error", statusCode: 0, message: "Check your internet connection and try again later", code: "CONNECTION_PROBLEMS")
                        //////completion(nil, error)
                    ////}
                //}*/
        //}.responseDebugPrint()
        
        



        //Alamofire.request(.GET, URL2).responseArray { (response: Response<[Forecast], NSError>) in
            
            //let forecastArray = response.result.value
            //print(forecastArray)
            ////if let forecastArray = forecastArray {
                ////for forecast in forecastArray {
                    ////print(forecast.day)
                    ////print(forecast.temperature)
                ////}
            ////}
        //}
        
        

        
        

        //Alamofire.request(.GET, URL3)
            //.responseObject { (response: Result<WeatherResponse2, NSError>) in
                //if let result = response.value {
                    //let str = result.toJsonString(.DefaultNSCoding)
                    
                    ////let dic = result.toDictionary()
                    //print(str)
                    ////print(dic)
                    ////print(result)
                //}
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

