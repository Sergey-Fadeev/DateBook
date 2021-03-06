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
    @IBOutlet weak var dayMonthLabel: UILabel!
    
    
    var alert = UIAlertController(title: "Внимание!", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskName.delegate = self
        items = realm.objects(TaskDayModel.self)
        viewModel = .init()
        timePickerStart.date = selectedDate
        timePickerFinish.date = selectedDate
        dayMonthLabel.text = "\(String(CalendarHelper().dayOfMonth(date: selectedDate)))  \(String(CalendarHelper().monthString(date: selectedDate)))"
        alert.addAction(ok)
    }
    

    @IBAction func taskSaving(_ sender: Any)
    {
        if !viewModel.contains(_selectedDate: timePickerStart.date){
            saving()
            navigationController?.popViewController(animated: true)
        }
        else{
            alert.message = "На выбранное время уже что то запланировано!"
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func saving() {
        viewModel.addTask(startDate: timePickerStart.date, stopDate: timePickerFinish.date, taskName: taskName.text!, taskDescription: taskDescription.text)
    }
}


extension TaskSavingViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
