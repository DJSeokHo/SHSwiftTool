//
//  BasicAlumbImagePickerViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/04.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class BasicAlumbImagePickerViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        self.imagePicker = ImagePicker(presentationController: self)
       
        self.imagePicker.didSelect = {
            (image: UIImage) in
            
            self.imageView.image = image
        }
    }
    
    @IBAction func onButtonCloseClick(_ sender: Any) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    @IBAction func onButtonPickClick(_ sender: Any) {
//        imageFormPhotosAlbum()
        
        self.imagePicker.present(from: sender as! UIView)
    }
 
    
//
//    func imageFormPhotosAlbum() {
//
//        let picker = UIImagePickerController()
//
//        //设置代理
//        picker.delegate = self
//
//        //设置数据源(从相册或者相机)
//        picker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
//
//        self.present(picker, animated: true, completion: nil)
//    }
//
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        //根据UIImagePickerControllerOriginalImage从info里边取值
//
//        ILog.debug(tag: #file, content: info[UIImagePickerController.InfoKey.originalImage.rawValue].debugDescription)
//        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
//
//        imageView.image = image
//        picker .dismiss(animated: true, completion: nil)
//
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//        print("取消了")
//
//        picker.dismiss(animated: true, completion: nil)
//
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
