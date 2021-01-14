//
//  KACapturePictureViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/06.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
import AVFoundation

class KACapturePictureViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    private let session = AVCaptureSession()
    private var camera: AVCaptureDevice?
    private var cameraPreviewPlayer: AVCaptureVideoPreviewLayer?
    private var cameraCaptureOhotoOutput: AVCapturePhotoOutput?
    
    /// white status bar text color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)

        initObserver()
        initalizeCaptureSession()
        
    }
    
    private func initObserver() {
        
        NotificationUtil.addObserver(name: KANotificationConstants.REQUEST_CONFRIM_IMAGE, observer: self, selector: #selector(observerConfirmImage))
        
    }
    @objc func observerConfirmImage(notfication: NSNotification) {
      
        ViewControllerUtil.finishSelf(view: self)
    }
    

    private func initalizeCaptureSession() {
        
        // 相片质量
        session.sessionPreset = AVCaptureSession.Preset.high
        camera = AVCaptureDevice.default(for: AVMediaType.video)
        
        // guard 不满足条件时，执行 else 后括号里部分的语句
        guard let cameraCaptureInput = try? AVCaptureDeviceInput(device: camera!) else {
            return
        }
      
        cameraCaptureOhotoOutput = AVCapturePhotoOutput()

        session.addInput(cameraCaptureInput)
        session.addOutput(cameraCaptureOhotoOutput!)
        
        cameraPreviewPlayer = AVCaptureVideoPreviewLayer(session: session)
        cameraPreviewPlayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewPlayer?.frame = CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height)
        cameraPreviewPlayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        
        // addsubview时都是在最上面面添加
        // insertSubView可以控制将view添加到指定的层
       
        // addSublayer时都是在最上面面添加
//        view.layer.addSublayer(cameraPreviewPlayer!)
        // insertSublayer可以控制将view添加到指定的层
        view.layer.insertSublayer(cameraPreviewPlayer!, at: 0)
        
        session.startRunning()
    }
    
    @IBAction func onButtonTakePictureClick(_ sender: Any) {
        takePicture()
    }
    
    private func takePicture() {
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = AVCaptureDevice.FlashMode.auto
        
        cameraCaptureOhotoOutput?.capturePhoto(with: settings, delegate: self)
    }
 
    private func displayCatpurePhoto(image: UIImage) {
        
        let kaPictureResultViewController = KAPictureResultViewController()
        kaPictureResultViewController.capturedImage = image
        NavigationUtil.navigationToNext(from: self, target: kaPictureResultViewController, animated: true)
    }
    
    // from  iOS 11
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let imageData = photo.fileDataRepresentation() {
            
            if let finalImage = UIImage(data: imageData) {
                      
                      displayCatpurePhoto(image: finalImage)
                      
                  }
        }
    }
    
    // before iOS 11
//    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
//                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
//                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
//        resolvedSettings: AVCaptureResolvedPhotoSettings,
//        bracketSettings: AVCaptureBracketedStillImageSettings?,
//        error: Error?)
//    {
//
//        if let unwrapperError = error {
//            ILog.debug(tag: #file, content: unwrapperError.localizedDescription)
//        }
//        else {
//
//            if let sampleBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
//
//                if let finalImage = UIImage(data: dataImage) {
//
//                    displayCatpurePhoto(image: finalImage)
//
//                }
//            }
//
//        }
//    }
    
    @IBAction func onButtonCloseClick(_ sender: Any) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    deinit {
        NotificationUtil.removeAllObserver(observer: self)
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
