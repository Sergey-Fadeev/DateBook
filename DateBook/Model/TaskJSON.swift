//
//  TaskModel.swift
//  DateBook
//
//  Created by Sergey on 14.10.2021.
//

import Foundation

struct TaskJSON: Codable {
    
    let id: String
    let date_start : Date
    let date_finish : Date
    let name: String
    let description: String
}
