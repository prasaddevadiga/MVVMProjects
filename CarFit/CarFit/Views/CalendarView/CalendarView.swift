//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: Date)
}
let nextButtoonTag = 111
let previousButtoonTag = 112

class CalendarView: UIView {

    @IBOutlet weak var monthAndYear: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    var vm = CalenderViewModel()
    
    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.daysCollectionView.register(nib, forCellWithReuseIdentifier: self.cellID)
        self.daysCollectionView.delegate = self
        self.daysCollectionView.dataSource = self
        vm.populateCalenderForDate(currentDate: Date())
        monthAndYear.text = vm.monthMetaData()
        scrollToShowSelectedDate()
    }
    
    //MARK:- Change month when left and right arrow button tapped
    @IBAction func arrowTapped(_ sender: UIButton) {
        if sender.tag == nextButtoonTag {
            vm.getNextMonth()
        } else if sender.tag == previousButtoonTag {
            vm.getPreviousMonth()
        }
        daysCollectionView.reloadData()
        monthAndYear.text = vm.monthMetaData()
        scrollToShowSelectedDate()
    }
    
    func scrollToShowSelectedDate() {
        guard let selectedIndex = vm.selectedDateIndex() else {
            self.daysCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            return
        }
        self.daysCollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .left, animated: true)
    }
}

//MARK:- Calendar collection view delegate and datasource methods
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfDays()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! DayCell
        if let dayVM = vm.day(at: indexPath.row) {
            cell.day.text = dayVM.dateNumber
            cell.weekday.text = dayVM.weekDay
            cell.dayView.backgroundColor = dayVM.isDateSelected ? UIColor.daySelected : UIColor.clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex = vm.selectedDateIndex(),
           let selectedCell = collectionView.cellForItem(at: IndexPath(row: selectedIndex, section: 0)) as? DayCell {
            selectedCell.dayView.backgroundColor = .clear
        }
        
        if let dayVM = vm.day(at: indexPath.row),
           let cell = collectionView.cellForItem(at: indexPath) as? DayCell{
            
            vm.selectedDate = dayVM.date
            cell.dayView.backgroundColor = dayVM.date == vm.selectedDate ? UIColor.daySelected : UIColor.clear
            delegate?.getSelectedDate(dayVM.date)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DayCell {
            cell.dayView.backgroundColor = UIColor.clear
        }
    }
}

//MARK:- Add calendar to the view
extension CalendarView {
    
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
}
