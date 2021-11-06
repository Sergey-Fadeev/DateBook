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

    
    func getTasks (selectedDate: Date) -> DataPublisher<TaskDayModel> {
        
        var tasks = TaskDayModel()
        let tasksList = List<TaskHourModel>()
        var results: Results<TaskDayModel>!
        results = realm.objects(TaskDayModel.self)
        var counter = 0
        
        var isAdded: Bool = false
        
        
        guard !realm.isEmpty else {
            while counter <= 23 {
                tasksList.append(TaskHourModel(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                counter += 1
            }
            
            tasks.taskObjectArray = tasksList
            let tasksPublisher = DataPublisher(initial: tasks, observableObject: nil)
            return tasksPublisher
        }
        
        for item in results {
            if item.date == CalendarHelper().dayMonthYearString(date: selectedDate){
                tasks = item
                isAdded = true
            }
        }
        
        if !isAdded {
            var _counter = 0
            while _counter <= 23 {
                tasksList.append(TaskHourModel(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                _counter += 1
            }
            tasks.taskObjectArray = tasksList
        }
        
        let tasksPublisher = DataPublisher(initial: tasks, observableObject: nil)
        return tasksPublisher
    }
    
    
    
    func saveTasks(startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
        
        var counter = 0
        let hourOfDay = CalendarHelper().hourOfDay(date: startDate)
        let items = List<TaskHourModel>()
        let itemsTasks = TaskDayModel()
        
        var isAdded: Bool = false
        
        guard !realm.isEmpty else {
            while counter <= 23 {
                if counter != hourOfDay{
                    items.append(TaskHourModel(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                }else{
                    items.append(TaskHourModel(value: ["dt_start": startDate, "dt_stop": stopDate, "taskName": taskName, "taskDescription": taskDescription]))
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
        
        
        var results: Results<TaskDayModel>!
        results = realm.objects(TaskDayModel.self)
        
        
        for item in results {
            let selectedDateString = CalendarHelper().dayMonthYearString(date: startDate)
            let dateInTasksList = item.date
            
            if dateInTasksList == selectedDateString {
                try! realm.write{
                    for task in item.taskObjectArray{
                        if task.dt_start != nil && CalendarHelper().hourOfDay(date: task.dt_start!) == CalendarHelper().hourOfDay(date: startDate){
                            task.taskName = taskName
                            task.taskDescription = taskDescription
                            task.dt_stop = stopDate
                            isAdded = true
                        }
                    }
                }
            }
        }
        
        
        if !isAdded {
            let _items = List<TaskHourModel>()
            let _itemsTasks = TaskDayModel()
            var _counter = 0
            while _counter < 23 {
                if _counter != hourOfDay{
                    _items.append(TaskHourModel(value: ["dt_start": nil, "dt_stop": nil, "taskName": "", "taskDescription": ""]))
                    
                }else{
                    _items.append(TaskHourModel(value: ["dt_start": startDate, "dt_stop": stopDate, "taskName": taskName, "taskDescription": taskDescription]))
                }
                _counter += 1
            }
            _itemsTasks.taskObjectArray = _items
            _itemsTasks.date = CalendarHelper().dayMonthYearString(date: startDate)
            try! realm.write{
                realm.add(_itemsTasks)
            }
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
