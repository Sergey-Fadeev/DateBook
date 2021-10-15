//
//  MainViewController.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import UIKit

var selectedDate = Date()

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    
    var totalSquares = [Int]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        print(totalSquares)
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        print("\(daysInMonth) дней в текущем месяце")
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        print(firstDayOfMonth)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        print("\(startingSpaces) - starting spaces")
        
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        
        if totalSquares[indexPath.item] != 0 {
            cell.dayOfMonth.text = String(totalSquares[indexPath.item])
            let date = totalSquares[indexPath.item]
            if CalendarHelper().collectionDate(day: date) == selectedDate
            {
                cell.backgroundColor = UIColor.systemGreen
            }
            else
            {
                cell.backgroundColor = UIColor.white
            }
            
        }
        else{
            cell.dayOfMonth.text = ""
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedDate = CalendarHelper().collectionDate(day: totalSquares[indexPath.item])
        collectionView.reloadData()
//            tableView.reloadData()
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
