//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/29/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import UIKit
import PhotosUI

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memeTableView: UITableView!
    
    var photoAlbum = [UIImage]()
    var memeAlbum: [Meme] = []
    var memeImageSelected: UIImage!
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.photoAlbum = MemeViewController().getImageArray()
        self.photoAlbum =  appDelegate.photoAlbum
        self.memeAlbum = (UIApplication.shared.delegate as! AppDelegate).memes
        memeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if memeAlbum.count == 0 {
            return photoAlbum.count
        }else {
            return self.memeAlbum.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell", for: indexPath)
        if memeAlbum.count == 0 {
            cell.imageView?.image = photoAlbum[indexPath.row]
            cell.textLabel?.text = "Meme \(indexPath.row)"
            if let detailedText = cell.detailTextLabel {
                detailedText.text = ""
            }
            
        }else {
            cell.imageView?.image  = memeAlbum[indexPath.row].memedImage
            cell.textLabel?.text = memeAlbum[indexPath.row].topText
            if let detailedText = cell.detailTextLabel {
                detailedText.text = memeAlbum[indexPath.row].bottomText
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDisplay"{
            let controller = segue.destination as! MemeDisplayViewController
            controller.memeImage = self.memeImageSelected
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        memeImageSelected = tableView.cellForRow(at: indexPath)?.imageView?.image
        performSegue(withIdentifier: "segueToDisplay", sender: self)
    }
}
