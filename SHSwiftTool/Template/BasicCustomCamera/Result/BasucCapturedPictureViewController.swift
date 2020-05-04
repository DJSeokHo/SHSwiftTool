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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if capturedImage == nil {
            NavigationUtil.navigationToPrev(from: self, animated: true)
        }
        
        imageView.image = capturedImage!
        
    }


    @IBAction func onButtonBackClick(_ sender: Any) {
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    @IBAction func onButtonSaveClick(_ sender: Any) {
        
        saveToAlumb()
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
