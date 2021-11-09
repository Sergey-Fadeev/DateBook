//
//  TasksForDate.swift
//  DateBook
//
//  Created by Sergey on 01.11.2021.
//

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
    
    func deleteTask(selectedDate: Date, numberCell: Int){
        dataProvider.deleteTask(selectedDate: selectedDate, numberCell: numberCell)
        load(selectedDate: selectedDate)
    }
    
    func contains(_selectedDate: Date) -> Bool{
        let contains = dataProvider.contains(_selectedDate: _selectedDate)
        return contains
    }
}
