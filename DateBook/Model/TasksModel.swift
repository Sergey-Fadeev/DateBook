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

class TasksModel {
    
    let taskPublisher = DataPublisher<TaskDayModel?>.init(initial: nil, observableObject: nil)
    
    var dataProvider = DataProvider()
    var providerCancellable: Cancellable? = nil
    
    init() {
    }
    
    func load(selectedDate: Date) {
        let task = dataProvider.getTasks(selectedDate: selectedDate)
        taskPublisher.data = task
    }
    
    func addTasks (startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
            dataProvider.saveTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
        load(selectedDate: startDate)
    }
    
    func deleteTask(selectedDate: Date){
        dataProvider.deleteTask(selectedDate: selectedDate)
        load(selectedDate: selectedDate)
    }
}
