//
//  ViewController.swift
//  DDBlackWhiteExample
//
//  Created by Dmitriy Dotsenko on 10/03/2019.
//  Copyright © 2019 Dmitriy Dotsenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filteredImageView: UIImageView!
    
    var image: UIImage?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                       target: self,
                                       action: #selector(openEdit))
        
        let libraryItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                          target: self,
                                          action: #selector(openLibrary))
        
        self.navigationItem.leftBarButtonItem = libraryItem
        self.navigationItem.rightBarButtonItem = editItem
        
        if (self.image == nil) {
            openLibrary()
        }
    }
    
    @objc func openLibrary() {
        let pickerView = UIImagePickerController.init()
        pickerView.delegate = self
        pickerView.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        present(pickerView, animated: true, completion: nil)
    }
    
    @objc func openEdit() {
        guard let image = image else {
            return
        }
        self.edit(image: image)
    }
    
    func edit(image: UIImage) {
        performSegue(withIdentifier: "ShowBlackWhite", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DDBlackWhiteViewController {
            vc.inputImage = image
            vc.completionClosure = { [weak weakSelf = self] (image) in
                weakSelf?.imageView.image = weakSelf?.image
                weakSelf?.filteredImageView.image = image
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.image = image
        picker.dismiss(animated: true) {
            self.edit(image: image)
        }
    }
}

