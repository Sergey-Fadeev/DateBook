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

    func getTasks (selectedDate: Date) -> TaskDayModel {
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
            return tasks
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
        return tasks
    }
    
    
    
    func saveTasks(startDate: Date, stopDate: Date, taskName: String, taskDescription: String){
        
        let hourOfDay = CalendarHelper().hourOfDay(date: startDate)
        let items = List<TaskHourModel>()
        let itemsTasks = TaskDayModel()
        
        var counter = 0
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
                    
                    item.taskObjectArray[hourOfDay].dt_start = startDate
                    item.taskObjectArray[hourOfDay].taskName = taskName
                    item.taskObjectArray[hourOfDay].taskDescription = taskDescription
                    item.taskObjectArray[hourOfDay].dt_stop = stopDate
                    
                    isAdded = true
                }
            }
        }
        
        
        if !isAdded {
            let _items = List<TaskHourModel>()
            let _itemsTasks = TaskDayModel()
            var _counter = 0
            while _counter <= 23 {
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
    
    
    func deleteTask (selectedDate: Date) {
        var results: Results<TaskDayModel>!
        results = realm.objects(TaskDayModel.self)
        
        for item in results {
            let selectedDateString = CalendarHelper().dayMonthYearString(date: selectedDate)
            let dateInTasksList = item.date
            if dateInTasksList == selectedDateString {
                try! realm.write {
                    realm.delete(item)
                }
            }
        }
    }
    
    
    func contains(_selectedDate: Date)->Bool {
        var contains: Bool = false
        var results: Results<TaskDayModel>!
        results = realm.objects(TaskDayModel.self)
        
        guard !realm.isEmpty else{
            return contains
        }
        for item in results {
            if item.date == CalendarHelper().dayMonthYearString(date: _selectedDate) && item.taskObjectArray[CalendarHelper().hourOfDay(date: _selectedDate)].dt_start != nil{
                contains = true
            }
        }
        return contains
    }
}
