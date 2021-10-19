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
    @IBOutlet weak var timePickerStart: UIDatePicker!
    @IBOutlet weak var timePickerFinish: UIDatePicker!
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerFinish: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(Task.self)

    }
    

    @IBAction func taskSaving(_ sender: Any)
    {
        saving()
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func saving() {
        
        let fullDateStart =  datePickerStart.date.addingTimeInterval(timePickerStart.date.timeIntervalSinceNow)
        
        let task = Task(value: [taskName.text!, taskDescription.text!, fullDateStart, timePickerStart.date])
        print("\(timePickerStart.date) - datePickerStart!!!!!!!!!!!!!")
        try! realm.write {
            realm.add(task)
        }
    }
}
