//
//  BasucCapturedPictureViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/04.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class BasucCapturedPictureViewController: UIViewController {

    public var capturedImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = capturedImage!
        
    }


    @IBAction func onButtonBackClick(_ sender: Any) {
        NavigationUtil.navigationToPrev(from: self, animated: true)
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
