//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/22/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    
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
        setTextField(topTextView, withTextAttributes: memeTextAttributes)
        setTextField(bottomTextView, withTextAttributes: memeTextAttributes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //Set Functions

    func setTextField(_ textField: UITextField, withTextAttributes: [String:Any]){
        textField.defaultTextAttributes = withTextAttributes
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
    }
    
    func setPickController(_ source: UIImagePickerControllerSourceType){
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType =  source
        self.present(pickController, animated: true, completion: nil)
    }
    
    //IBActions
    @IBAction func PickImage(_ sender: UIBarButtonItem) {
        setPickController(.camera)

    }
    @IBAction func TakePicture(_ sender: UIBarButtonItem) {
        setPickController(.photoLibrary)
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

