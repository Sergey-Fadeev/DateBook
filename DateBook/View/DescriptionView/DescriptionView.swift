//
//  DescriptionView.swift
//  DateBook
//
//  Created by Sergey on 21.10.2021.
//

import UIKit

class DescriptionView: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var descriptionTask: String = ""
    var dateStart: String = ""
    var dateFinish: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = descriptionTask

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
