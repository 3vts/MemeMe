//
//  MemeDisplayViewController.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/29/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import UIKit

class MemeDisplayViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var memeImage: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.memeImageView.image = self.memeImage
        UIView.animate(withDuration: 1.5) {
            self.memeImageView.alpha = 1;
        }
    }
}
