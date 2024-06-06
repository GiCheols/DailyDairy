//
//  EditViewController.swift
//  2171278TermProject
//
//  Created by 남기철 on 2024/06/05.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var diaryTextView: UITextView!
    let diaryManager = DiaryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        imageView.addGestureRecognizer(imageTapGesture)
        
        testSave()
        
        self.setUpTextField(textView: diaryTextView)
    }
    
    func testSave() {
        let testDate = Date.now
        let testTitle = "Sample Data"
        let testContent = "Sample Content"
        let testImage = UIImage(named: "exampleImageName")
        
        diaryManager.createDiary(date: testDate, title: testTitle, content: testContent, image: testImage)
    }
    
    @IBAction func saveDiary(_ sender: UIButton) {
        
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
}

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UITextViewDelegate {
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
