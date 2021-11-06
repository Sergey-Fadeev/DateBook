//
//  TaskModel.swift
//  DateBook
//
//  Created by Sergey on 14.10.2021.
//

import Foundation
import RealmSwift


class TaskModel: ObservableObject {
    
    var objectWillChange: PublisherProtocol = EventPublisher()
    let taskLoadSucceed: EventPublisher = .init()
    
    var tasksLoadSucceedCancellable: Cancellable?
    
    var dataProvider = DataProvider()
    var providerCancellable: Cancellable? = nil
    
    var tasksList: TasksList? = nil
    
    let realm = try! Realm()
    var items: Results<TaskDayModel>!
    
    init() {
    }
    
    func getTasks(selectedDate: Date) {
        
        let taskPublisher = dataProvider.getTasks(selectedDate: selectedDate)
        providerCancellable = taskPublisher.sink { [self] in
            let jsonResult = taskPublisher.data
            self.tasksList = TasksList.init(dataRepo: jsonResult)
            
            taskLoadSucceed.notify()
        }
    }
    
    func addTasks (startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
        dataProvider.saveTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
     }
    
//    func getTasks(selectedDate: Date) {
//    //        let taskPublished = dataProvider.getTasks(selectedDate: selectedDate)
//    //        providerCancellable = taskPublished.sink { [self] in
//    //            let jsonResult = taskPublished.data
//    //            if let tasksList = TasksList.init(dataRepo: jsonResult){
//    //                self.tasksList = tasksList.tasksList
//    //                taskLoadSucceed.notify()
//    //            }
//    //        }
//        }
    
    
//    func addTasks (startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
//        let taskPublished = dataProvider.fetchTasks(startDate: startDate, stopDate: stopDate, taskName: taskName, taskDescription: taskDescription)
//        providerCancellable = taskPublished.sink { [self] in
//            let jsonResult = taskPublished.data
//            if let tasksList = TasksList.init(dataRepo: jsonResult){
//                self.tasksList = tasksList.tasksList
//                taskLoadSucceed.notify()
//            }
//        }
//    }
}






//class TaskJSON {
//    
//    @Published var newModel: NewModel!
//    var viewModelCancellable: Cancellable? = nil
//    
//    
//    
//    
//    init() {
//    }
//
//    
//    func addModel(selectedDate: Date) {
//        
//        
//        let realm = try! Realm()
//        var items: Results<Task>!
//        items = realm.objects(Task.self)
//        
//        var _tasksForDayArray = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
//        
//        var count: Int = 0
//        while count <= 23 {
//            for item in items {
//                
//                let dateTaskString = CalendarHelper().dayMonthYearString(date: item.dateStart)
//                let selectedDateString = CalendarHelper().dayMonthYearString(date: selectedDate)
//                let hourOfDay = CalendarHelper().hourOfDay(date: item.dateStart)
//        
//                if dateTaskString == selectedDateString && count == hourOfDay {
//                        _tasksForDayArray[count] = item.name
//                }
//                else if dateTaskString == selectedDateString{
//                    _tasksForDayArray[count] = ""
//                }
//            }
//            count += 1
//                
//        }
//        
//        
//    }
//}

