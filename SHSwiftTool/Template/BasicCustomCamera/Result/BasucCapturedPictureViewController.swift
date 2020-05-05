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
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        if capturedImage == nil {
            NavigationUtil.navigationToPrev(from: self, animated: true)
        }
        
        imageView.image = capturedImage!
        
        hideProgress()
        
        
        StorageUtil.deleteFile(pathName: StorageUtil.getLibraryDirectory(), folderName: "Test", fileName: "test_image.png")
        
        ILog.debug(tag: #file, content: StorageUtil.exists(path: NSString(string: NSString(string: StorageUtil.getLibraryDirectory()).appendingPathComponent("Test")).appendingPathComponent("test_image.png")))
        
        StorageUtil.deleteFolder(pathName: StorageUtil.getLibraryDirectory(), folderName: "Test")
        ILog.debug(tag: #file, content: StorageUtil.exists(path: NSString(string: StorageUtil.getLibraryDirectory()).appendingPathComponent("Test")))
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
            self.orientation = imageInfo.2
            
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
        
        return StorageUtil.loadImageFile(
            pathName: StorageUtil.getLibraryDirectory(),
            folderName: "Test",
            imageName: "test_image.png",
            orientation: orientation)
        
    }
   
    private func saveToFolder() -> (String, String, UIImage.Orientation) {
        
        return StorageUtil.saveImageFile(
            pathName: StorageUtil.getLibraryDirectory(),
            folderName: "Test",
            imageName: "test_image.png",
            image: capturedImage!)
      
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
