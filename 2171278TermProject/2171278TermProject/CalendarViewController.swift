//
//  ViewController.swift
//  2171278TermProject
//
//  Created by 남기철 on 2024/06/04.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource {
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var mainCalendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

