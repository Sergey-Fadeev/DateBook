//
//  Model.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var descriptionTask: String = ""
    @Persisted var dateStart: Date?
    @Persisted var dateFinish: Date?
    

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

