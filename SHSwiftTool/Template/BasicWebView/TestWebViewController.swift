//
//  TestWebViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/07/09.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
import WebKit

class TestWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        setWebView()
    }

    func setWebView() {
        //设置对象
        let preferences = WKPreferences()
        //最小字体大小
        preferences.minimumFontSize = 0
        //设置是否js
        preferences.javaScriptEnabled = true
        //js自动打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        //网页适配对象
        let configuration = WKWebViewConfiguration()
        //是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        configuration.allowsInlineMediaPlayback = true
        
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        //      configuration.applicationNameForUserAgent = "MyUserAgent"
        
        //        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  
        let appVersion = getAppVersion()
        //set userAgent
        let userAgent = "^APPNAME:MVOTING,OS:IOS,APPVER:\(appVersion))^ eSeoulApp"
        webView.customUserAgent = userAgent
        //enable swipe to back
        webView.allowsBackForwardNavigationGestures = true
        //是否支持交互
        webView.isUserInteractionEnabled = true
        
//        //set url
//        if let url = URL(string: "http://mvoting.seoul.go.kr:8080/mvoting/main/main.do") {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        //set url
//        if let url = URL(string: "http://mvoting.seoul.go.kr:8080/mvoting/main/main.do") {
//           let request = URLRequest(url: url)
//           webView.load(request)
//            ILog.debug(tag: #file, content: "loading!!!! \(url)")
//        }
        
        //set url
        if let url = URL(string: "https://www.naver.com") {
            let request = URLRequest(url: url)
            webView.load(request)
            ILog.debug(tag: #file, content: "loading!!!! \(url)")
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        showActivityIndicator(show: false)
    }
    
    /**
     webview打开新窗口
     */
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if(!(navigationAction.targetFrame?.isMainFrame ?? false)){
            webView.load(_:navigationAction.request)
        }
        
        return nil
    }
    
    /**
     拦截alert
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        
        if(message.contains("qrOpen")){
//            showCamera()
            completionHandler()
        }
        
        else if(message.contains("siminAppOpen,")){
            completionHandler()
            let urlStr = "itms-apps://itunes.apple.com/app/apple-store/id375380948?mt=8"
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(URL(string: urlStr)!)
            }
        }
        
        else{
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /**
     拦截confirm
     */
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let messages = message.components(separatedBy: "||")
        let content = messages[0]
        let confirm = messages[1]
        let cancel = messages[2]
        
        let alertController = UIAlertController(title: "알림", message: content, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: confirm, style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: cancel, style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /**
     拦截输入框
     */
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            completionHandler(nil)
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message:String,okTitle:String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletion(message:String,okTitle:String,cancelTitle:String?,completionBlock:@escaping (_ okPressed:Bool)->()){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (ok) in
            completionBlock(true)
        }
        alertController.addAction(okAction)
        if let cancelTitle = cancelTitle{
            let cancelOption = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (axn) in
                completionBlock(false)
                
            })
            alertController.addAction(cancelOption)
        }
        
        self.present(alertController, animated: true, completion: nil)
        
        //        if let topController = UIWindow.topViewController(){
        //          topController.present(alertController, animated: true, completion: nil)
        //        }
        
    }
    
    /**
     get app version
     */
    func getAppVersion()->String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "default"
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




//
//
////
////  MainViewController.swift
////  MyHybridDemo
////
////  Created by ntsys on 2020/06/02.
////  Copyright © 2020 ntsys. All rights reserved.
////
//
//import UIKit
//import WebKit
//
//import CoreLocation
//
//class MainViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet var mainWebView:WKWebView!
//    /**
//     loadingBar
//     */
//    var activityIndicator: UIActivityIndicatorView!
//
//    // 1.創建 locationManager
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //定位权限方面的委托
//        locationManager.delegate = self
//        //webView视图界面的委托
//        mainWebView.uiDelegate = self
//        //添加loadingBar的委托
//        mainWebView.navigationDelegate = self
//        //添加locationManager的委托
//        locationManager.delegate = self
//
//        setLocationManager()
//
//        setLoadingBar()
//
//        setWebView()
//
//        // 4. 加入測試數據
//        //        setData()
//
//        //        showAlertWithCompletion(message: "这是第一个", okTitle: "确定", cancelTitle: "取消") { (Bool) in
//        //            self.showAlert(message: "这是第二个 \(Bool)", okTitle: "确认")
//        //        }
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
////        checkLocationPermission()
//        startGetLocationWhenInUse()
//    }
//
//    func setLocationManager(){
//        // 2. 配置 locationManager
//        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
//        //期望精度
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    }
//
//    func setLoadingBar(){
//        activityIndicator = UIActivityIndicatorView()
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = .large
//        view.addSubview(activityIndicator)
//    }
//
//    func setWebView(){
//        //设置对象
//        let preferences = WKPreferences()
//        //最小字体大小
//        preferences.minimumFontSize = 0
//        //设置是否js
//        preferences.javaScriptEnabled = true
//        //js自动打开窗口
//        preferences.javaScriptCanOpenWindowsAutomatically = true
//
//        //网页适配对象
//        let configuration = WKWebViewConfiguration()
//        //是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
//        configuration.allowsInlineMediaPlayback = true
//
//        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
//        //      configuration.applicationNameForUserAgent = "MyUserAgent"
//
//        //        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//        let appVersion = getAppVersion()
//
//        //set userAgent
//        let userAgent = "^APPNAME:MVOTING,OS:IOS,APPVER:\(appVersion))^ eSeoulApp"
//        mainWebView.customUserAgent = userAgent
//        //enable swipe to back
//        mainWebView.allowsBackForwardNavigationGestures = true
//        //是否支持交互
//        mainWebView.isUserInteractionEnabled = true
//
//        //set url
//        if let url = URL(string: "http://mvoting.seoul.go.kr:8080/mvoting/main/main.do"){
//            let request = URLRequest(url: url)
//            mainWebView.load(request)
//        }
//    }
//
////    func checkLocationPermission(){
////        // 1. 還沒有詢問過用戶以獲得權限
////        if CLLocationManager.authorizationStatus() == .notDetermined {
////            locationManager.requestAlwaysAuthorization()
////            print("還沒有詢問過用戶以獲得權限")
////        }
////            // 2. 用戶不同意
////        else if CLLocationManager.authorizationStatus() == .denied {
////            print("用戶不同意")
////
////            goAppSetting()
////        }
////            // 3. 用户点击了使用时授权
////        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
////            print("用户点击了使用时授权")
////            locationManager.startUpdatingLocation()
////        }
////            // 4. 用戶始终授权
////        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
////            print("用戶已經点击了始终授权")
////            locationManager.startUpdatingLocation()
////        }
////    }
//
//    /**
//     到下面的几个方法全是进度条相关
//     */
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        showActivityIndicator(show: false)
//    }
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        showActivityIndicator(show: true)
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        showActivityIndicator(show: false)
//    }
//
//    func showActivityIndicator(show: Bool) {
//        if show {
//            activityIndicator.startAnimating()
//        } else {
//            activityIndicator.stopAnimating()
//        }
//    }
//
//    /**
//     webview打开新窗口
//     */
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if(!(navigationAction.targetFrame?.isMainFrame ?? false)){
//            webView.load(_:navigationAction.request)
//        }
//
//        return nil
//    }
//
////    /**
////    *  在发送请求之前，决定是否跳转
////    *
////    *  @param webView          实现该代理的webview
////    *  @param navigationAction 当前navigation
////    *  @param decisionHandler  是否调转block
////    */
////    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
////        if (navigationAction.navigationType == .linkActivated){
////            decisionHandler(.cancel)
////        } else {
////            decisionHandler(.allow)
////        }
////    }
//
//    /**
//     拦截alert
//     */
//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//
//
//        if(message.contains("qrOpen")){
//            showCamera()
//            completionHandler()
//
//        }
//
//        else if(message.contains("siminAppOpen,")){
//            completionHandler()
//            let urlStr = "itms-apps://itunes.apple.com/app/apple-store/id375380948?mt=8"
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
//
//            } else {
//                UIApplication.shared.openURL(URL(string: urlStr)!)
//            }
//        }
//
//        else{
//
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//
//        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//            completionHandler()
//        }))
//
//        self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    /**
//     拦截confirm
//     */
//    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
//
//        let messages = message.components(separatedBy: "||")
//        let content = messages[0]
//        let confirm = messages[1]
//        let cancel = messages[2]
//
//        let alertController = UIAlertController(title: "알림", message: content, preferredStyle: .alert)
//
//        alertController.addAction(UIAlertAction(title: confirm, style: .default, handler: { (action) in
//            completionHandler(true)
//        }))
//
//        alertController.addAction(UIAlertAction(title: cancel, style: .default, handler: { (action) in
//            completionHandler(false)
//        }))
//
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    /**
//     拦截输入框
//     */
//    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
//
//        alertController.addTextField { (textField) in
//            textField.text = defaultText
//        }
//
//        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//            if let text = alertController.textFields?.first?.text {
//                completionHandler(text)
//            } else {
//                completionHandler(defaultText)
//            }
//
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
//
//            completionHandler(nil)
//
//        }))
//
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlert(message:String,okTitle:String){
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func showAlertWithCompletion(message:String,okTitle:String,cancelTitle:String?,completionBlock:@escaping (_ okPressed:Bool)->()){
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: okTitle, style: .default) { (ok) in
//            completionBlock(true)
//        }
//        alertController.addAction(okAction)
//        if let cancelTitle = cancelTitle{
//            let cancelOption = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (axn) in
//                completionBlock(false)
//
//            })
//            alertController.addAction(cancelOption)
//        }
//
//        self.present(alertController, animated: true, completion: nil)
//
//        //        if let topController = UIWindow.topViewController(){
//        //          topController.present(alertController, animated: true, completion: nil)
//        //        }
//
//    }
//
//    /**
//     get app version
//     */
//    func getAppVersion()->String{
//        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "default"
//    }
//
//    func setData(){
//        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
//
//        }else {
//            print("System can't track regions")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let latestLocation: CLLocation = locations[locations.count - 1]
//
//        print("latitude: \(latestLocation.coordinate.latitude)")
//        print("longitude: \(latestLocation.coordinate.longitude)")
//
//        //        if startLocation == nil {
//        //            startLocation = latestLocation
//        //        }
//        //
//        //        let distanceBetween: CLLocationDistance =
//        //            latestLocation.distance(from: startLocation)
//        //
//        //        distance.text = String(format: "%.2f", distanceBetween)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//    }
//
//    /**
//     定位权限的回调
//     */
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if(status == .authorizedAlways || status == .authorizedWhenInUse){
//            locationManager.startUpdatingLocation()
//        }else if(status == .denied){
//            goAppSetting()
//        }
//    }
//
//    func goAppSetting(){
//        // initialise a pop up for using later
//        let alertController = UIAlertController(title: nil, message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
//        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
//            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                return
//            }
//
//            print(settingsUrl)
//
//            if UIApplication.shared.canOpenURL(settingsUrl) {
//                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                    print("Settings opened: \(success)") // Prints true
//                })
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//        alertController.addAction(cancelAction)
//        alertController.addAction(settingsAction)
//
//        // check the permission status
//        switch(CLLocationManager.authorizationStatus()) {
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("Authorize.")
//        // get the user location
//        case .notDetermined, .restricted, .denied:
//            // redirect the users to settings
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    func backupGoSetting(){
//        if #available(iOS 10, *) {
//            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:],
//                                      completionHandler: {
//                                        (success) in
//            })
//        }
//        else {
//            UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
//        }
//    }
//
//
//    func showCamera(){
//        let photoController = UIAlertController(title: nil, message: "请选择获取图片方式", preferredStyle: .actionSheet)
//
//        let cameraAction = UIAlertAction(title: "相机", style: .default, handler: { (action) in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .camera
//                imagePicker.delegate = self
//
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        })
//
//        let photoLibraryAction = UIAlertAction(title: "相册", style: .default, handler: { (action) in
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .photoLibrary
//                imagePicker.delegate = self
//
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        })
//
//        photoController.addAction(cameraAction)
//        photoController.addAction(photoLibraryAction)
//
//        present(photoController, animated: true, completion: nil)
//    }
//
//    /**
//     select image callback
//     */
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
////            photoImageView.image = selectedImage
////            photoImageView.contentMode = .scaleAspectFill
////            photoImageView.clipsToBounds = true
//        }
//    }
//
//    func startGetLocationWhenInUse(){
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func startGetLocationAlways(){
//        locationManager.stopUpdatingLocation()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//}
