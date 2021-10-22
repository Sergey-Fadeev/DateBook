//
//  TaskSavingViewController.swift
//  DateBook
//
//  Created by Sergey on 16.10.2021.
//

import UIKit
import RealmSwift

class TaskSavingViewController: UIViewController {

    let getData = GetData()
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var timePickerStart: UIDatePicker!
    @IBOutlet weak var timePickerFinish: UIDatePicker!
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerFinish: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func taskSaving(_ sender: Any)
    {
        let fullDateStart = datePickerStart.date.addingTimeInterval(timePickerStart.date.timeIntervalSinceNow)
        let fullDateFinish = datePickerFinish.date.addingTimeInterval(timePickerFinish.date.timeIntervalSinceNow)
        
        getData.saving(taskName: taskName.text ?? "", descriptionTask: taskDescription.text, dateStart: fullDateStart, dateFinish: fullDateFinish)
        
        navigationController?.popViewController(animated: true)
        
    }
}
