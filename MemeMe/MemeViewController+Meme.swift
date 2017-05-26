//
//  MemeViewController+Meme.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/25/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController{
    
    struct Meme {
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        // Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextView.text!, bottomText: bottomTextView.text!, originalImage: imgMeme.image!, memedImage: memedImage)
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
    }
    
}

