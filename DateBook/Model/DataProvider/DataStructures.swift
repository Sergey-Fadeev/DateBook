//
//  Model.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import Foundation
import RealmSwift


class TaskDayModel: Object {
    @objc dynamic var date: String?
    dynamic var taskObjectArray = List<TaskHourModel>()
}


class TaskHourModel: Object {
    @objc dynamic var dt_start: Date?
    @objc dynamic var dt_stop: Date?
    @objc dynamic var taskName: String? = ""
    @objc dynamic var taskDescription: String? = ""
}



