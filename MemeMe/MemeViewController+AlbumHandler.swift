//
//  MemeViewController+AlbumHandler.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/29/17.
//  Copyright © 2017 3vts. All rights reserved.
//  Taken From https://stackoverflow.com/a/33794869/3571692 and modified to work on Swift 3

import UIKit
import PhotosUI

extension MemeViewController {
    
    func insertImage(_ image : UIImage, intoAlbumNamed albumName : String = "Memes") {
        
        //Fetch a collection in the photos library that has the title "albumNmame"
        let collection = fetchAssetCollectionWithAlbumName(albumName)
        
        if collection == nil {
            //If we were unable to find a collection named "albumName" we'll create it before inserting the image
            PHPhotoLibrary.shared().performChanges({PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)}, completionHandler: { (success: Bool, error: Error?) in
                if error != nil {
                    print("Error: " + error!.localizedDescription)
                }
                if success {
                    //Fetch the newly created collection (which we *assume* exists here)
                    let newCollection = self.fetchAssetCollectionWithAlbumName(albumName)
                    self.insertImage(image, intoAssetCollection: newCollection!)
                }
                
            })
        } else {
            //If we found the existing AssetCollection with the title "albumName", insert into it
            self.insertImage(image, intoAssetCollection: collection!)
        }
    }
    
    func fetchAssetCollectionWithAlbumName(_ albumName : String = "Memes") -> PHAssetCollection? {
        
        //Provide the predicate to match the title of the album.
        let fetchOption = PHFetchOptions()
        fetchOption.predicate = NSPredicate(format: "title == '\(albumName)'")
        
        //Fetch the album using the fetch option
        let fetchResult = PHAssetCollection.fetchAssetCollections(
            with: PHAssetCollectionType.album,
            subtype: PHAssetCollectionSubtype.albumRegular,
            options: fetchOption)
        
        //Assuming the album exists and no album shares it's name, it should be the only result fetched
        let collection = fetchResult.firstObject
        
        
        return collection
    }
    
    func insertImage(_ image : UIImage, intoAssetCollection collection : PHAssetCollection) {
        
        //Changes for the Photos Library must be maded within the performChanges block
        PHPhotoLibrary.shared().performChanges({
            
            //This will request a PHAsset be created for the UIImage
            let creationRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)
            
            //Create a change request to insert the new PHAsset in the collection
            let request = PHAssetCollectionChangeRequest(for: collection)
            
            //Add the PHAsset placeholder into the creation request.
            //The placeholder is used because the actual PHAsset hasn't been created yet
            if request != nil && creationRequest.placeholderForCreatedAsset != nil {
                request!.addAssets([creationRequest.placeholderForCreatedAsset!] as NSFastEnumeration)
            }
            
        },completionHandler: { (success : Bool, error : Error?) in
            if error != nil {
                print("Error: " + error!.localizedDescription)
            }
        })
    }
    
    func getImageArray() -> [UIImage] {
        let assetCollection = fetchAssetCollectionWithAlbumName()
        var collection = [UIImage]()
        let imageCollection = PHAsset.fetchAssets(in: assetCollection!, options: nil)
        for asset in  0...imageCollection.count - 1  {
            var img: UIImage?
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.version = .original
            options.isSynchronous = true
            manager.requestImageData(for: imageCollection.object(at: asset), options: options) { data, _, _, _ in
                if let data = data {
                    img = UIImage(data: data)
                    collection.append(img!)
                }
            }
        }
        return collection
    }
}
