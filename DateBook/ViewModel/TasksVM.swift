//
//  TasksVM.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation
import RealmSwift


class GetData {
    
    let realm = try! Realm()
    var items: Results<Task>!
    
    func saving(taskName: String, descriptionTask: String, dateStart: Date, dateFinish: Date) {
        
        let task = Task(name: taskName, description: descriptionTask, dateStart: dateStart, dateFinish: dateFinish)
        
        try! realm.write {
            realm.add(task)
        }
    }
}
