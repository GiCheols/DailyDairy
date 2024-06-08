import UIKit

class EditViewController: UIViewController {
    var diary: Diary?

    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var editTitleLabel: UITextField!
    @IBOutlet weak var editDiaryButton: UIButton!
    @IBOutlet weak var editContentTextView: UITextView!
    
    @IBOutlet weak var editBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var editTopConstraint: NSLayoutConstraint!
    var isShowKeyboard = false
    
    let diaryManager = DiaryManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        editImageView.addGestureRecognizer(imageTapGesture)
        
        if let receivedDiary = diary {
            editTitleLabel.text = receivedDiary.title
            editContentTextView.text = receivedDiary.content
            if let imageData = receivedDiary.image {
                editImageView.image = UIImage(data: imageData)
            }
        }
        
        self.navigationController?.navigationBar.topItem?.title = "뒤로가기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain,target: self, action: #selector(deleteDiary))
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationController?.navigationBar.backgroundColor = .white
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
    }
    
    
    @IBAction func saveEditedDiary(_ sender: UIButton) {
        if let diary = diary {
            diaryManager.updateDiary(diary: diary, withTitle: editTitleLabel.text ?? "", withContent: editContentTextView.text, andImage: editImageView.image ?? nil)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DiarySaved"), object: nil)
        
        navigationController?.popViewController(animated: true)
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
    
    @objc func deleteDiary() {
        let alertController = UIAlertController(title: "삭제 확인", message: "해당 날짜의 Diary를 삭제하겠습니까?", preferredStyle: .alert)
            
        let confirmAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            if let diaryToDelete = self.diary, let diaryDate = diaryToDelete.date {
                self.diaryManager.deleteDiary(for: diaryDate)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DiarySaved"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
                
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(Sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main){ notification in
            if self.isShowKeyboard == false {
                self.isShowKeyboard = true
                self.editTopConstraint.constant -= 150
                self.editBottomConstraint.constant -= 150
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main){ notification in
            self.editTopConstraint.constant += 150
            self.editBottomConstraint.constant += 150
            self.isShowKeyboard = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification,object:nil)
    NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification,object:nil)
    }
}

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        editImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
