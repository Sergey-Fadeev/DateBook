//
//  Ефыл.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

//import Foundation
//import RealmSwift
//
//
//class GetData {
//    
//    let realm = try! Realm()
//    var items: Results<Task>!
//    
//    func saving() {
//        
//        let task = Task(value: [taskName.text!, taskDescription.text!, datePickerStart.date, datePickerStart.date])
//        print("\(datePickerStart.date) - datePickerStart!!!!!!!!!!!!!")
//        try! realm.write {
//            realm.add(task)
//        }
//        
//        let indexValue = items.firstIndex(where: { (item) -> Bool in
//            item.dateStart == datePickerStart.date
//          })
//        
//        print(items)
//        print(items[indexValue!])
//    }
//}
