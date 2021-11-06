//
//  TaskModel.swift
//  DateBook
//
//  Created by Sergey on 14.10.2021.
//

import Foundation
import RealmSwift


class Model: ObservableObject {
    
    var objectWillChange: PublisherProtocol = EventPublisher()
    
    let tasksModel = TasksModel()
    
    
    init() {
    }

}
