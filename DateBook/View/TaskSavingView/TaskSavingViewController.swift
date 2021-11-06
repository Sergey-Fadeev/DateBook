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
    var items: Results<TaskDayModel>!
    
    var viewModel: TasksListVM! = nil
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var timePickerStart: UIDatePicker!
    @IBOutlet weak var timePickerFinish: UIDatePicker!
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerFinish: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(TaskDayModel.self)
        viewModel = .init()

    }
    

    @IBAction func taskSaving(_ sender: Any)
    {
        saving()
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func saving() {
        
        let fullDateStart =  datePickerStart.date.addingTimeInterval(timePickerStart.date.timeIntervalSinceNow)
        let fullDateFinish =  datePickerFinish.date.addingTimeInterval(timePickerFinish.date.timeIntervalSinceNow)
        
        
        viewModel.addTask(startDate: fullDateStart, stopDate: fullDateFinish, taskName: taskName.text!, taskDescription: taskDescription.text)
        
        
    }
}
