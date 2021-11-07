//
//  DescriptionView.swift
//  DateBook
//
//  Created by Sergey on 21.10.2021.
//

import UIKit

class DescriptionView: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskTime: UILabel!
    
    var VMList = TaskHourModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskName.text = VMList.taskName
        taskDescriptionLabel.text = VMList.taskDescription
        
        let dateStartString = CalendarHelper().dayMonthYearString(date: VMList.dt_start!)
        let timeStartString = CalendarHelper().timeString(date: VMList.dt_start!)
        let timeStopString = CalendarHelper().timeString(date: VMList.dt_stop!)
        
        taskTime.text = "\(dateStartString) \(timeStartString)-\(timeStopString)"

        // Do any additional setup after loading the view.
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
