//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/22/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Delegates
    let textFieldDelegate = TextFieldDelegate()
    
    //Variables
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    //Outlets
    @IBOutlet weak var imgMeme: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextView: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var bottomTextView: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    //Overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextView.defaultTextAttributes = memeTextAttributes
        topTextView.textAlignment = .center
        topTextView.delegate = textFieldDelegate
        bottomTextView.defaultTextAttributes = memeTextAttributes
        bottomTextView.textAlignment = .center
        bottomTextView.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imgMeme.image = pickedImage
        dismiss(animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    
    //IBActions
    @IBAction func PickImage(_ sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        self.present(pickController, animated: true, completion: nil)
    }
    @IBAction func TakePicture(_ sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .camera
        self.present(pickController, animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        imgMeme.image = nil
        topTextView.text = "TOP"
        bottomTextView.text = "BOTTOM"
        shareButton.isEnabled = false
        view.resignFirstResponder()
    }
    
    @IBAction func ShareMeme(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.popoverPresentationController?.barButtonItem = shareButton
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            self.saveMeme()
        }
        self.present(controller, animated: true, completion: nil)
    }
}

