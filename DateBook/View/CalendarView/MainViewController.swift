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

    let realm = try! Realm()
    var items: Results<Task>!
    
    let testArray: [String] = ["08:00 - 09:00", "09:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 13:00", "13:00 - 14:00", "14:00 - 15:00", "15:00 - 16:00", "16:00 - 17:00", "17:00 - 18:00", "18:00 - 19:00", "19:00 - 20:00", "20:00 - 21:00", "21:00 - 22:00", "22:00 - 23:00", "23:00 - 00:00"]
    
    var totalSquares = [Int]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        items = realm.objects(Task.self)
        
        taskTable.register(UINib(nibName: "TasksTableViewCell", bundle: nil), forCellReuseIdentifier: "tasksTableViewCell")
        taskTable.delegate = self
        taskTable.dataSource = self
        
        setCellsView()
        setMonthView()
        
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
        {                    //оставляет пустыми ячейки(заполняя массив пробелами): при первом                   условии перед 1-м числом месяца от понедельника, при втором                         условии после последнего числа месяца до 42 ячейки
            
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append(0)
            }
            else
            {                //начинается заполнение ячеек между отступами
                totalSquares.append(count - startingSpaces)
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    
    @IBAction func previousMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
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
        
        collectionView.reloadData()
        taskTable.reloadData()
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable
            .dequeueReusableCell(withIdentifier: "tasksTableViewCell")! as! TasksTableViewCell
        cell.timeLabel.text = testArray[indexPath.row]
        
        
        for item in items {
            let dateTaskString = CalendarHelper().dayMonthYearString(date: item.dateStart)
            let selectedDateString = CalendarHelper().dayMonthYearString(date: selectedDate)
            
            print("\(dateTaskString) - dateTask")
            print("\(selectedDateString) - selectedDateString")
            
            
            if dateTaskString == selectedDateString {
                cell.taskNameLabel.text = item.name
                break
            }
            else{
                cell.taskNameLabel.text = ""
            }
        }
        
        return cell
    }
}
