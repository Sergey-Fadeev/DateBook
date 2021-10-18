//
//  Model.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import Foundation
import RealmSwift


class Task: Object {
    @Persisted var name: String = ""
    @Persisted var descriptionTask: String = ""
    @Persisted var dateStart: Date
    @Persisted var dateFinish: Date
    
    convenience init(name: String, description: String, dateStart: String, dateFinish: String) {
        self.init()
    }
}
