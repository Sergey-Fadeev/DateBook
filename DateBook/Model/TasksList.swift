//
//  TasksForDate.swift
//  DateBook
//
//  Created by Sergey on 01.11.2021.
//

//struct TasksList {
//    let hourlyTask: TasksList?
//    
//    init?(dataTask: Task){
//        var tasksArray: [Task]
//    }
//}

import Foundation
import RealmSwift

class TasksList {
    var tasksList: List<TaskHourModel>?
    
    init?(dataRepo: TaskDayModel) {
        self.tasksList = dataRepo.taskObjectArray
    }
}
