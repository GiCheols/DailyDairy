import UIKit
import CoreData

class CreateDiaryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var diaryTitleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var diaryTextView: UITextView!
    let diaryManager = DiaryManager()
    
    @IBOutlet weak var createDiaryBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var createDiaryTopConstraint: NSLayoutConstraint!
    var isShowKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        imageView.addGestureRecognizer(imageTapGesture)
        
        self.setUpTextField(textView: diaryTextView)
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
    }
    
    @objc func dismissKeyboard(Sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func saveDiary(_ sender: UIButton) {
        guard let title = diaryTitleTextField.text, !title.isEmpty,
              let content = diaryTextView.text, !content.isEmpty else {
            showAlert(message: "제목과 내용을 모두 입력해주세요.")
            return
        }
        
        let date = datePicker.date
        let image = imageView.image
        
        if !diaryManager.createDiary(date: date, title: title, content: content, image: image) {
               showAlert(message: "해당 날짜에 이미 일기가 있습니다. 다른 날짜를 선택해주세요.")
               return
        }
        
        // 저장 성공
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DiarySaved"), object: nil)
        showAlert(message: "일기가 저장되었습니다.")
        resetInputFields()
        tabBarController?.selectedIndex = 0
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
    
    func setUpTextField(textView: UITextView) {
        textView.delegate = self
        
        textView.text = "내용을 입력하세요."
        textView.textColor = .lightGray
        
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func capturePicture(sender: UITapGestureRecognizer){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .savedPhotosAlbum
        }
        imagePickerController.sourceType = .savedPhotosAlbum
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        dateLabel.text = formatter.string(from: datePickerView.date)
    }
    
    func resetInputFields() {
        diaryTitleTextField.text = ""
        diaryTextView.text = "내용을 입력하세요."
        diaryTextView.textColor = .lightGray
        imageView.image = nil
        datePicker.date = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main){ notification in
            if self.isShowKeyboard == false {
                self.isShowKeyboard = true
                self.createDiaryTopConstraint.constant -= 200
                self.createDiaryBottomConstraint.constant -= 200
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main){ notification in
            self.createDiaryTopConstraint.constant += 200
            self.createDiaryBottomConstraint.constant += 200
            self.isShowKeyboard = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification,object:nil)
    NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification,object:nil)
    }

}

extension CreateDiaryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CreateDiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .lightGray else {return}
        textView.text = nil
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "내용을 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
