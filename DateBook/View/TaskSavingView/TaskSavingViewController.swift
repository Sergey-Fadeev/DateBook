//
//  TaskSavingViewController.swift
//  DateBook
//
//  Created by Sergey on 16.10.2021.
//

import UIKit
import RealmSwift

class TaskSavingViewController: UIViewController {

    let realm = try! Realm()
    var items: Results<Task>!
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(Task.self)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func taskSaving(_ sender: Any)
    {
        let task = Task(value: [taskName.text!, taskDescription.text!, datePicker.date, datePicker.date])
        
        try! realm.write {
            realm.add(task)
        }
        
        
        let indexValue = items.firstIndex(where: { (item) -> Bool in
            item.dateStart == datePicker.date // test if this is the item you're looking for
          })
        
        print(items)
        print(items[indexValue!])
        navigationController?.popViewController(animated: true)
        
    }
}
