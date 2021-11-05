//
//  Model.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import Foundation
import RealmSwift


//class Task: Object {
//    @Persisted var name: String = ""
//    @Persisted var descriptionTask: String = ""
//    @Persisted var dateStart: Date
//    @Persisted var dateFinish: Date
//
//    convenience init(name: String, description: String, dateStart: String, dateFinish: String) {
//        self.init()
//    }
//}

class Task: Object {
    @objc dynamic var dt_start: Date?
    @objc dynamic var dt_stop: Date?
    @objc dynamic var taskName: String? = ""
    @objc dynamic var taskDescription: String? = ""
    
}


class Tasks: Object {
    @objc dynamic var date: String?
    dynamic var taskObjectArray = List<Task>()
}
