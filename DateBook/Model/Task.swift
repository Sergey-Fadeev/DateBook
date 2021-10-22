//
//  Model.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import Foundation
import RealmSwift

var tasksList = [Task]()

class Task: Object {
    @Persisted var name: String = ""
    @Persisted var descriptionTask: String = ""
    @Persisted var dateStart: Date
    @Persisted var dateFinish: Date
    
    convenience init(name: String, description: String, dateStart: Date, dateFinish: Date) {
        self.init()
    }
    
    
    func tasksForDate(date: Date) -> [Task] {
        var daysTasks = [Task]()
        for task in tasksList
        {
            if(Calendar.current.isDate(task.dateStart, inSameDayAs:date))
            {
                daysTasks.append(task)
            }
        }
        return daysTasks
    }
}
