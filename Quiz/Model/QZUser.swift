//
//  QZUser.swift
//  Quiz
//
//  Created by jorge luna on 14/03/17.
//  Copyright © 2017 Jorge Luna. All rights reserved.
//

import Foundation

final class Singleton {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: Singleton = Singleton()
    
    //MARK: Local Variable
    
    var emptyStringArray : [String] = []
    
}


final class QZUser {
    
    static let shared: QZUser = QZUser()
    
    var name: String? = nil
    var cookie: String? = nil
    var quiz: [QZQuestion]? = nil
    
    private convenience init() {
        self.init(dictionary : [String: AnyObject]())
    }
    
    init( dictionary : [String: AnyObject]) {
        guard let usuario = dictionary["usuario"] as? [String: AnyObject], let name = usuario["nombre"] as? String, let cookie = usuario["cookie"] as? String, let questions = usuario["cuestionario"] as? [[String:AnyObject]] else {
            return
        }
        self.name = name
        self.cookie = cookie
        
        var questionArray = [QZQuestion]()
        
        for item in questions {
            let question = QZQuestion(dictionary: item)
            questionArray.append(question)
        }
        
        self.quiz = questionArray.reversed()
    }
}
