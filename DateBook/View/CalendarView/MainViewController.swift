//
//  MainViewController.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import UIKit
import RealmSwift

var selectedDate = Date()

class MainViewController: UIViewController
{
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var taskTable: UITableView!
    
    
    var totalSquares: [Int] = []
    
    
    var viewModel: TasksListVM! = .init()
    var vmCancellable: Cancellable? = nil
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        taskTable.register(UINib(nibName: "TasksTableViewCell", bundle: nil), forCellReuseIdentifier: "tasksTableViewCell")
        taskTable.delegate = self
        taskTable.dataSource = self
    
        vmCancellable = viewModel
            .objectWillChange
            .sink { [self] in
                DispatchQueue.main.async { [weak self] in
                    if self != nil{
                        taskTable.reloadData()
                    }
                }
        }
        
        setCellsView()
        setMonthView()
        viewModel.selectDate(selectedDate: selectedDate)
    }
    
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    
    func setMonthView()
    {
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().lastDateOfThePreviousMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append(0)
            }
            else
            {                //заполнение ячеек между отступами
                totalSquares.append(count - startingSpaces)
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        taskTable.reloadData()
    }
    
    
    @IBAction func previousMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        viewModel.selectDate(selectedDate: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        viewModel.selectDate(selectedDate: selectedDate)
        setMonthView()
    }
    
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        
        if totalSquares[indexPath.item] != 0 && CalendarHelper().collectionDate(day: date, fullDate: selectedDate) == selectedDate {
            
            cell.dayOfMonth.text = String(totalSquares[indexPath.item])
            cell.backgroundColor = UIColor.systemGreen
        }
        else if totalSquares[indexPath.item] != 0 {
            
            cell.dayOfMonth.text = String(totalSquares[indexPath.item])
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor.white
            cell.dayOfMonth.text = ""
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedDate = CalendarHelper().collectionDate(day: totalSquares[indexPath.item], fullDate: selectedDate)
        
        viewModel.selectDate(selectedDate: selectedDate)
        collectionView.reloadData()
        taskTable.reloadData()
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskDay.data?.taskObjectArray.count ?? 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timeForDayArray: [String] = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"]
        let cell = taskTable
            .dequeueReusableCell(withIdentifier: "tasksTableViewCell")! as! TasksTableViewCell
        
        cell.timeLabel.text = timeForDayArray[indexPath.row]
        cell.taskNameLabel.text = ((viewModel.taskDay.data?.taskObjectArray[indexPath.row].taskName) ?? "")
        let data = viewModel.taskDay.data
        guard data != nil && ((data?.taskObjectArray[indexPath.row].dt_start) != nil) else{
            cell.startStopTimeLabel.text = ""
            cell.backgroundColor = .clear
            return cell
        }
        cell.startStopTimeLabel.text = "\(CalendarHelper().timeString(date: (data!.taskObjectArray[indexPath.row].dt_start!)))-\(CalendarHelper().timeString(date: (data!.taskObjectArray[indexPath.row].dt_stop!)))"
        cell.backgroundColor = #colorLiteral(red: 0.6625885367, green: 0.8203471303, blue: 0.8733372688, alpha: 1)
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteCity = UIContextualAction(style: .destructive, title: "Удалить") { action, view, success in
            self.taskTable.reloadData()
            DispatchQueue.main.async {
                self.viewModel.deleteTask(selectedDate: selectedDate, numberCell: indexPath.row)
            }
        }
        let conf = UISwipeActionsConfiguration(actions: [deleteCity])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.taskDay.data?.taskObjectArray[indexPath.row].dt_start != nil{
            performSegue(withIdentifier: "descriptionSegue", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let selectedIndex = self.taskTable.indexPath(for: cell)!.row
            if segue.identifier == "descriptionSegue" {
                let vc = segue.destination as! DescriptionView
                vc.VMList = (viewModel.taskDay.data?.taskObjectArray[selectedIndex])!
            }
        }
    }
    

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        taskTable.reloadData()
    }
}
