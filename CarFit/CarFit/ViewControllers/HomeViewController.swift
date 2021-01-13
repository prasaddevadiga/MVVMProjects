//
//  ViewController.swift
//  Calendar
//
//  Test Project
//

import UIKit

class HomeViewController: UIViewController, AlertDisplayer {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var calendarView: UIView!
    @IBOutlet weak var calendar: UIView!
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    @IBOutlet weak var workOrderTableView: UITableView!
    @IBOutlet weak var tableViewTopConstriant: NSLayoutConstraint!
    @IBOutlet weak var calenderViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var calenderViewHieghtConstraint: NSLayoutConstraint!
    
    private let cellID = "HomeTableViewCell"
    
    var cleanerListVM = CleanerListViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
        self.navBar.items?.first?.title = Date().getCalenderDateString()
        let guesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        guesture.cancelsTouchesInView = false
        workOrderTableView.addGestureRecognizer(guesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        loadCleaners()
    }
    
    @objc func viewTapped()  {
        UIView.animate(withDuration: 0.2) {
            self.calenderViewHieghtConstraint.constant = 0
            self.tableViewTopConstriant.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK:- Loads the cleaner list from json
    private func loadCleaners() {
        WebService().load(resource: CleanerData.all) { [weak self] result in
            switch result {
            case .success(let cleanerList):
                self?.cleanerListVM.cleanerListVM = cleanerList.data?.map { CleanerViewModel.init(with: $0) } ?? []
                self?.cleanerListVM.selectedDate(date: Date())
                self?.workOrderTableView.reloadData()
            case .failure(let error):
                self?.displayAlert(with: "Error", message: error.localizedDescription)
            }
        }
    }
    
    //MARK:- Add calender to view
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendar) {
            calendar.delegate = self
        }
    }

    //MARK:- UI setups
    private func setupUI() {
        self.navBar.transparentNavigationBar()
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.workOrderTableView.register(nib, forCellReuseIdentifier: self.cellID)
        self.workOrderTableView.rowHeight = UITableView.automaticDimension
        self.workOrderTableView.estimatedRowHeight = 170
    }
    
    //MARK:- Show calendar when tapped, Hide the calendar when tapped outside the calendar view
    @IBAction func calendarTapped(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.2) {
            self.calenderViewHieghtConstraint.constant = 200
            self.tableViewTopConstriant.constant = 120
            self.view.layoutIfNeeded()
        }
    }
}

//MARK:- Tableview delegate and datasource methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanerListVM.totalCleaningTask()
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! HomeTableViewCell
        let vm = self.cleanerListVM.cleaner(at: indexPath.row)
        cell.customer.text = vm.houseOwnerName
        cell.destination.text = vm.houseOwnerAddress
        cell.tasks.text = vm.taks
        cell.timeRequired.text = vm.duration
        cell.statusView.backgroundColor = vm.taskStatusColor
        cell.status.text = vm.taskStatus
        cell.arrivalTime.text = vm.arrivalTime
        cell.distance.text = self.cleanerListVM.distanceToNextTask(at: indexPath.row)
        return cell
    }
    
}

//MARK:- Get selected calendar date
extension HomeViewController: CalendarDelegate {
    
    func getSelectedDate(_ date: Date) {
        self.cleanerListVM.selectedDate(date: date)
        self.workOrderTableView.reloadData()
        navBar.items?.first?.title = date.getCalenderDateString()
    }
}
