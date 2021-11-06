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
    
    
    lazy var tasksList: DataPublisher<TasksList?> = .init(initial: nil, observableObject: self)
    

    init(){
    }
    
    
    private func getTasks(selectedDate: Date){
        tasksSingletone.getTasks(selectedDate: selectedDate)
    }
     
    
    
    func addTask(startDate: Date, stopDate: Date, taskName: String, taskDescription: String) {
        let newModel = tasksSingletone.addTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
    }
    
}
