//
//  BasucCapturedPictureViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/04.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
import Photos

class BasucCapturedPictureViewController: UIViewController {

    public var capturedImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private var orientation: UIImage.Orientation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if capturedImage == nil {
            NavigationUtil.navigationToPrev(from: self, animated: true)
        }
        
        imageView.image = capturedImage!
        
        hideProgress()
    }


    @IBAction func onButtonBackClick(_ sender: Any) {
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    @IBAction func onButtonSaveClick(_ sender: Any) {
        
        saveToAlumb()
    }
    
    @IBAction func onButtonSaveToFolderClick(_ sender: Any) {
        
        showProgress()
        
        ThreadUtil.startThread {
            
            // need image info
            let imageInfo = self.saveToFolder()
            ILog.debug(tag: #file, content: "\(imageInfo.0) \(imageInfo.1) \(imageInfo.2)")
            
            ThreadUtil.startUIThread(runnable: {
                
                self.hideProgress()
                ILog.debug(tag: #file, content: "success")
            }, after: 0)
        }
    }
    
    @IBAction func onButtonLoadFromFolderClick(_ sender: Any) {
        
        showProgress()
        ThreadUtil.startThread {
            
            let tempImage = self.loadFromFolder()
            
            let newImage = UIImage(cgImage: tempImage.cgImage!, scale: tempImage.scale, orientation: self.orientation)
            
            ILog.debug(tag: #file, content: newImage.imageOrientation.rawValue)
            
            ThreadUtil.startUIThread(runnable: {
                self.imageView.image = newImage
                self.hideProgress()
                ILog.debug(tag: #file, content: "success")
            }, after: 0)
        }
    }
    
    private func loadFromFolder() -> UIImage {
        
        let folderPath = NSString(string: StorageUtil.getLibraryDirectory()).appendingPathComponent("Test")
        
        let imagePath = NSString(string: folderPath).appendingPathComponent("test_image.png")
        
        let image = UIImage(contentsOfFile: imagePath)
        
        return image!
    }
    /*
     Image Orientations
     case up
     The original pixel data matches the image's intended display orientation.

     case down
     The image has been rotated 180° from the orientation of its original pixel data.

     case left
     The image has been rotated 90° counterclockwise from the orientation of its original pixel data.

     case right
     The image has been rotated 90° clockwise from the orientation of its original pixel data.

     case upMirrored
     The image has been horizontally flipped from the orientation of its original pixel data.

     case downMirrored
     The image has been vertically flipped from the orientation of its original pixel data.

     case leftMirrored
     The image has been rotated 90° clockwise and flipped horizontally from the orientation of its original pixel data.

     case rightMirrored
     The image has been rotated 90° counterclockwise and flipped horizontally from the orientation of its original pixel data.
     */
    private func saveToFolder() -> (String, String, UIImage.Orientation) {
        
        ILog.debug(tag: #file, content: StorageUtil.getLibraryDirectory())
        
        let folderName = "Test"
        
        StorageUtil.createFolder(parentFolder: StorageUtil.getLibraryDirectory(), withName: folderName)
        
        // ex: /var/mobile/Containers/Data/Application/8BDD45E8-4629-4CC2-8317-5B135A6BC25C/Library/Test
        ILog.debug(tag: #file, content: "path ??? \(FileManager.default.fileExists(atPath: "\(NSString(string: StorageUtil.getLibraryDirectory()).appendingPathComponent(folderName))"))")
        
        let folderPath = NSString(string: StorageUtil.getLibraryDirectory()).appendingPathComponent(folderName)
        
        ILog.debug(tag: #file, content: folderPath)
        
        let imageName = "test_image.png"
        
        let imagePath = NSString(string: folderPath).appendingPathComponent(imageName)
        
        ILog.debug(tag: #file, content: imagePath)
      
        let imageData = UIImage.pngData(capturedImage!)
        
        orientation = capturedImage!.imageOrientation
        
        FileManager.default.createFile(atPath: imagePath, contents: imageData(), attributes: nil)
        
        ILog.debug(tag: #file, content: capturedImage!.imageOrientation.rawValue)
        
        return (folderName, imageName, orientation)
    }
    
    private func saveToAlumb() {
        
        // should disable save button at here!!
        
        showProgress()
        
        ThreadUtil.startThread {
            
            UIImageWriteToSavedPhotosAlbum(self.capturedImage!, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
            
        }
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
           
        if error == nil {
         
            ILog.debug(tag: #file, content: "save success")
            
            ThreadUtil.startUIThread(runnable: {
                self.hideProgress()
                
                NavigationUtil.navigationToPrev(from: self, animated: true)
                
            }, after: 0)
        }
    }
    
    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
