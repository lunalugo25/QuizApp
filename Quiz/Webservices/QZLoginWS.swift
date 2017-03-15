//
//  QZLoginWS.swift
//  Quiz
//
//  Created by jorge luna on 14/03/17.
//  Copyright © 2017 Jorge Luna. All rights reserved.
//

import Foundation

class QZLoginWS {
    class func validate(user: String, password: String, onCompletion:@escaping (Bool, String, [String:AnyObject]) -> Void) {
        /*
        let json: [String: String] = ["user": user,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        */
        
        let urlString = "http://pruebas.softco.mx/api/movil/login?user=\(user)&password=\(password)"
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                onCompletion(false,"No se obtuvo respuesta", [String: AnyObject]())
                return
            }
            
            var isValid = false
            var message = "Hubo un problema, favor de intentar nuevamente"
            var arrayInfo = [String: AnyObject]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                if let isValidServer = json["result"] as? Bool {
                    if isValidServer {
                        if let information = json["data"] as? [String: AnyObject] {
                            arrayInfo = information
                        }
                    } else {
                        if let messageServer = json["message"] as? String {
                            message = messageServer
                        }
                    }
                    isValid = isValidServer
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            onCompletion(isValid, message, arrayInfo)
            

            /*
             if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Int] {
             if let isValid = json?["result"] {
             print(isValid)
             }
             }
             
             
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            
            if let isValid = responseJSON?["result"] as? Bool {
                if let responseJSON = responseJSON["data"] as? [String: Any] {
                    print(responseJSON)
                }
            }
            */
        }
        
        task.resume()
    }
}
