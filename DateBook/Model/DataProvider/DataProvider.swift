//
//  DataProvider.swift
//  DateBook
//
//  Created by Sergey on 22.10.2021.
//

import Foundation
import RealmSwift


class DataProvider {
    
    let realm = try! Realm()
//    var resultsItems: Results<Tasks>!
//
//    var taskItems = List<Task>()
    
//    func getTasks(selectedDate: Date) -> DataPublisher<Tasks>{
//
//        items = realm.objects(Tasks.self)
//        taskItems.append(Task(value: ["dt_start": "\(Date())", "dt_stop": "\(Date())", "taskName": "", "taskDescription": ""]))
//
//
//        let taskPublisher = DataPublisher(initial: tasksList, observableObject: nil)
//        var counter = 0
//
//        guard items != nil else {
//            let _tasksList = Tasks()
//            while counter < 23 {
//                tasksList.taskObjectArray.append(Task())
//                counter += 1
//            }
//            taskPublisher.data = tasksList
//            return taskPublisher
//        }
//
//        for item in items {
//            let selectedDateString = CalendarHelper().dayMonthYearString(date: selectedDate)
//
//            let dateInTasksList = CalendarHelper().dayMonthYearString(date: item.taskObjectArray.first!.dt_start!)
//
//            if dateInTasksList == selectedDateString {
//
//                taskPublisher.data = item
//            }
//        }
//        return taskPublisher
//    }
    
    
    
    func saveTasks(startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
        
        var counter = 0
        let hourOfDay = CalendarHelper().hourOfDay(date: startDate)
        let items = List<Task>()
        let itemsTasks = Tasks()
        
        guard !realm.isEmpty else {
            while counter <= 23 {
                if counter != hourOfDay{
                    items.append(Task(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                }else{
                    items.append(Task(value: ["dt_start": startDate, "dt_stop": stopDate, "taskName": taskName, "taskDescription": taskDescription]))
                }
                counter += 1
            }
            itemsTasks.taskObjectArray = items
            itemsTasks.date = CalendarHelper().dayMonthYearString(date: startDate)
            try! realm.write{
                realm.add(itemsTasks)
            }
            return
        }
        
        
        var results: Results<Tasks>!
        results = realm.objects(Tasks.self)
        
        
        for item in results {
            let selectedDateString = CalendarHelper().dayMonthYearString(date: startDate)
            let dateInTasksList = item.date
            
            if dateInTasksList == selectedDateString {
                try! realm.write{
                    for task in item.taskObjectArray{
                        if  CalendarHelper().hourOfDay(date: task.dt_start!) == CalendarHelper().hourOfDay(date: startDate){
                            task.taskName = taskName
                            task.taskDescription = taskDescription
                            task.dt_stop = stopDate
                        }
                    }
                }
            }
        }
        
        let _items = List<Task>()
        let _itemsTasks = Tasks()
        var _counter = 0
        while _counter < 23 {
            if _counter != hourOfDay{
                _items.append(Task(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                
            }else{
                _items.append(Task(value: ["dt_start": startDate, "dt_stop": stopDate, "taskName": taskName, "taskDescription": taskDescription]))
            }
            _counter += 1
        }
        _itemsTasks.taskObjectArray = _items
        _itemsTasks.date = CalendarHelper().dayMonthYearString(date: startDate)
        try! realm.write{
            realm.add(_itemsTasks)
        }
    }
    
    
    
//    func fetchTasks(startDate: Date, stopDate: Date, taskName: String, taskDescription: String)  -> DataPublisher<Tasks>{
//
//        items = realm.objects(Tasks.self)
//
//        let taskPublisher = DataPublisher(initial: Tasks.placeholder, observableObject: nil)
//        var counter = 0
//        let hourOfDay = CalendarHelper().hourOfDay(date: selectedDate)
//
//
//        guard items != nil else {
//            let tasksList = Tasks()
//            while counter < 23 {
//                if counter != hourOfDay{
//                    tasksList.taskObjectArray.append(Task())
//                }else{
//                    tasksList.taskObjectArray.append(Task())
//                }
//                counter += 1
//            }
//            taskPublisher.data = tasksList
//            return taskPublisher
//        }
//
//
//        for item in items {
//            let selectedDateString = CalendarHelper().dayMonthYearString(date: startDate)
//
//            let dateInTasksList = CalendarHelper().dayMonthYearString(date: item.taskObjectArray.first!.dt_start!)
//
//            if dateInTasksList == selectedDateString {
//
//                try! realm.write{
//                    for task in item.taskObjectArray{
//                        if  CalendarHelper().hourOfDay(date: task.dt_start!) == CalendarHelper().hourOfDay(date: startDate){
//                            task.taskName = taskName
//                            task.taskDescription = taskDescription
//                            task.dt_stop = stopDate
//                        }
//                    }
//                }
//            }
//            taskPublisher.data = item
//        }
//        return taskPublisher
//    }
}
