//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/29/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import UIKit
import PhotosUI

class MemeCollectionViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var memeFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    var photoAlbum = [UIImage]()
    var memeAlbum: [Meme] = []
    var memeImageSelected: UIImage!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 3.0
        
        memeFlowLayout.minimumInteritemSpacing = space
        memeFlowLayout.minimumLineSpacing = space
        memeFlowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.photoAlbum = MemeViewController().getImageArray()
        self.photoAlbum =  appDelegate.photoAlbum
        self.memeAlbum = (UIApplication.shared.delegate as! AppDelegate).memes
        memeCollectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if memeAlbum.count == 0 {
            return photoAlbum.count
        }else {
            return self.memeAlbum.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        if memeAlbum.count == 0 {
            cell.memeImage.image = photoAlbum[indexPath.row]
            return cell
        }else{
            cell.memeImage.image = memeAlbum[indexPath.row].memedImage
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDisplay" {
            let controller = segue.destination as! MemeDisplayViewController
            controller.memeImage = self.memeImageSelected
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MemeCollectionViewCell
        memeImageSelected = cell.memeImage.image
        performSegue(withIdentifier: "segueToDisplay", sender: self)
    }
}
