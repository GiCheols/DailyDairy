import UIKit

class EditViewController: UIViewController {
    var diary: Diary?

    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var editTitleLabel: UITextField!
    @IBOutlet weak var editDiaryButton: UIButton!
    @IBOutlet weak var editContentTextView: UITextView!
    
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
