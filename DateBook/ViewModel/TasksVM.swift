//
//  TasksVM.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation
import RealmSwift

class TasksVM: ObservableObject {
    
    
    var objectWillChange: PublisherProtocol = EventPublisher()
    var modelChangeCancellable: Cancellable? = nil
    
    var provider = DataProvider()
    
    
    var taskList: TasksList?
    
    
    init(model: TaskModel){
        taskList?.tasksList = model.tasksList
        modelChangeCancellable = tasksSingletone
            .objectWillChange
            .sink { [weak self] in
                self!.taskList!.tasksList = model.tasksList!
                
                self!.objectWillChange.notify()
            }
    }
    
//    func getTasks(selectedDate: Date){
//        tasksSingletone.getTasks(selectedDate: selectedDate)
//    }
     
    
    func addTasks(startDate: Date, stopDate: Date, taskName: String, taskDescription: String) {
        tasksSingletone.addTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
        
    }
    
}
