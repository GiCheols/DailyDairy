import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    @IBOutlet weak var beforeDate: UIButton!
    @IBOutlet weak var nextDate: UIButton!
    @IBOutlet weak var changeScopeButton: UIButton!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var mainCalendar: FSCalendar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    let diaryManager = DiaryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCalendar(calendar: mainCalendar)
    }

    func setCalendar(calendar : FSCalendar) {
        mainCalendar.delegate = self
        mainCalendar.dataSource = self
        
        mainCalendar.scrollEnabled = true
        mainCalendar.scrollDirection = .horizontal
        
        mainCalendar.backgroundColor = .white
        
        mainCalendar.appearance.headerTitleFont = .systemFont(ofSize: 15.0)
        mainCalendar.appearance.headerDateFormat = "yyyy년 MM월"
        mainCalendar.calendarHeaderView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        mainCalendar.appearance.weekdayFont = .systemFont(ofSize: 15.0)
    }
    
    @IBAction func clickChangeScope(_ sender: UIButton) {
        if self.mainCalendar.scope == .month {
            self.changeCalendarScope(calendar: self.mainCalendar, month: false)
            self.changeScopeButton.setTitle("월간 달력 보기", for: .normal)
            self.beforeDate.setTitle("저번 주", for: .normal)
            self.nextDate.setTitle("다음 주", for: .normal)
            
        } else {
            self.changeCalendarScope(calendar: self.mainCalendar, month: true)
            self.changeScopeButton.setTitle("주간 달력 보기", for: .normal)
            self.beforeDate.setTitle("저번 달", for: .normal)
            self.nextDate.setTitle("다음 달", for: .normal)
        }
    }
    
    func changeCalendarScope(calendar: FSCalendar, month: Bool) {
        calendar.setScope(month ? .month : .week, animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            calendar.reloadData()
        }
    }
    
    @IBAction func beforeDate(_ sender: UIButton) {
        self.actionMoveDate(calendar: self.mainCalendar, moveUp: false)
    }
    
    @IBAction func afterDate(_ sender: UIButton) {
        self.actionMoveDate(calendar: self.mainCalendar, moveUp: true)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            if let diary = diaryManager.getDiary(for: date) {
                titleLabel.text = diary.title
                contentView.text = diary.content
                if let imageData = diary.image {
                    imageView.image = UIImage(data: imageData)
                } else {
                    imageView.image = nil
                }
            } else {
                titleLabel.text = "제목"
                contentView.text = "일기 내용"
                imageView.image = nil
            }
        }
    
    func actionMoveDate(calendar: FSCalendar, moveUp: Bool) {
        let moveDirection = moveUp ? 1 : -1
        
        if calendar.scope.rawValue == 0 {
            if let newDate = Calendar.current.date(byAdding: .month, value: moveDirection, to: calendar.currentPage) {
                calendar.setCurrentPage(newDate, animated: true)
            }
        } else {
            if let newDate = Calendar.current.date(byAdding: .weekOfMonth, value: moveDirection, to: calendar.currentPage) {
                calendar.setCurrentPage(newDate, animated: true)
            }
        }
    }
}

