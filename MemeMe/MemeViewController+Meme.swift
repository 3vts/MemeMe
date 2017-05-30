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
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        setBarsVisibility(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        setBarsVisibility(false)
        
        return memedImage
    }
    
    func setBarsVisibility(_ visible: Bool){
        navigationBar.isHidden = visible
        toolBar.isHidden = visible
    }
    
    func saveMeme() {
        // Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextView.text!, bottomText: bottomTextView.text!, originalImage: imgMeme.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.photoAlbum.append(memedImage)
        appDelegate.memes.append(meme)
        insertImage(meme.memedImage)
    }
    
}

