//
//  TasksTableViewCell.swift
//  DateBook
//
//  Created by Sergey on 16.10.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var startStopTimeLabel: UILabel!
    @IBOutlet weak var backgroundViewCell: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
