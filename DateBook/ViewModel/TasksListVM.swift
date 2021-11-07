//
//  TasksVM.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation
import RealmSwift

class TasksListVM: ObservableObject {
    

    var objectWillChange: PublisherProtocol = EventPublisher()
    var taskListChangeCancellable: Cancellable? = nil
    
    
    let taskDay = tasksSingletone.tasksModel.taskPublisher
    

    init(){
        taskListChangeCancellable = taskDay.sink {
            self.objectWillChange.notify()
        }
    }
    
    func selectDate(selectedDate: Date){
        tasksSingletone.tasksModel.load(selectedDate: selectedDate)
    }
     
    
    
    func addTask(startDate: Date, stopDate: Date, taskName: String, taskDescription: String) {
        tasksSingletone.tasksModel.addTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
    }
    
    func deleteTask(selectedDate: Date){
        tasksSingletone.tasksModel.deleteTask(selectedDate: selectedDate)
    }
    
}
