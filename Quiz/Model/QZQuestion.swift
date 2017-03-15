//
//  QZQuestion.swift
//  Quiz
//
//  Created by jorge luna on 14/03/17.
//  Copyright © 2017 Jorge Luna. All rights reserved.
//

import Foundation

enum TypeQuestion: Int {
    case open = 1
    case file
    case location
    case checkList
    case choose
}

class QZQuestion {
    var id: Int?
    var title: String?
    var type: TypeQuestion = .open
    var answers: [QZAnswer]?
    
    init(dictionary: [String: AnyObject]) {
        guard let id = dictionary["IdPregunta"] as? Int, let title = dictionary["Titulo"] as? String, let type = dictionary["Tipo"] as? Int else {
            return
        }
        
        self.id = id
        self.title = title
        self.answers = [QZAnswer]()
        
        switch type {
        case 1: self.type = .open
        case 2: self.type = .file
        case 3: self.type = .location
        case 4: self.type = .checkList
        case 5: self.type = .choose
        default: self.type = .open
        }
        
        
        switch self.type {
        case .checkList, .choose:
            let answers = dictionary["Respuestas"] as? [[String: AnyObject]]
            var answersList = [QZAnswer]()
            
            for item in answers! {
                let answer = QZAnswer(dictionary: item)
                answersList.append(answer)
            }
            
            self.answers = answersList
            
        default: self.answers = [QZAnswer]()
        }
    }
}


class QZAnswer {
    var id: Int?
    var title: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["IdRespuesta"] as? Int
        self.title = dictionary["Titulo"] as? String
    }
}
