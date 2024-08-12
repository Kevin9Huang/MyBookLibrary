//
//  AddBookViewController.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 12/08/24.
//

import Foundation
import UIKit

final class AddBookViewController: UIViewController {
    @IBOutlet weak var uploadBookButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var publicationTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private let bookSaver: BookSaverProtocol = BookSaverManager()
    private var selectedImage: UIImage?
    private var selectedPublishDate: Date?
    
    var onDismiss: (() -> Void)?
    
    static func make() -> AddBookViewController {
        let className = String(describing: self)
        return AddBookViewController(nibName: className, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        saveButton.layer.cornerRadius = 15
    }
    
    private func setupView() {
        setBorderColorTo(titleTextField)
        setBorderColorTo(authorTextField)
        setBorderColorTo(descriptionTextField)
    }
    
    private func setBorderColorTo(_ view: UIView) {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
    @IBAction func onSaveTapped(_ sender: Any) {
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              let bookDescription = descriptionTextField.text,
              let publicationDate = selectedPublishDate,
              !title.isEmpty,
              !author.isEmpty,
              !bookDescription.isEmpty
        else {
            self.showAlert(
                title: "Warning",
                message: "All fields must be filled"
            )
            return
        }
        
        
        var book = Book(id: Int.random(in: 1...1000), title: title, author: author, bookDescription: bookDescription, cover: "", publicationDate: publicationDate)
        
        if let selectedImage {
            if let imageData = selectedImage.pngData() {
                book.localImageData = imageData
            }
        }
        
        bookSaver.saveBook(book) { [weak self] in
            self?.showAlert(
                title: "Information",
                message: "Book saved successfully"
            )
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func uploadImageTapped(_ sender: Any) {
        presentImagePicker()
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag)
        onDismiss?()
    }
    
    @IBAction func onPublishDateSelected(_ sender: UIDatePicker) {
        self.selectedPublishDate = sender.date
    }
    
}

extension AddBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
            uploadBookButton.setTitle("Image had been set", for: .normal)
            uploadBookButton.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
