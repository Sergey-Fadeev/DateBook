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
        let dateString = CalendarHelper().dayMonthYearString(date: datePicker.date)
        let task = Task(value: [taskName.text!, taskDescription.text!, dateString, dateString])
        
        try! realm.write {
            realm.add(task)
        }
        
        
        let indexValue = items.firstIndex(where: { (item) -> Bool in
            item.dateStart == dateString // test if this is the item you're looking for
          })
        
        print(items)
        print(items[indexValue!])
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
