//
//  FileDownloadWebViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/01/15.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit
import WebKit


class FileDownloadWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var urlString: String?
   
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initWebView()
    }
    
    
    private func initWebView() {
      
        let configuration = createConfiguration()
        
        webView = createWebView(configuration: configuration)
        
        ILog.debug(tag: #file, content: urlString!)
        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        self.view.addSubview(webView)
    }
    
    private func createConfiguration() -> WKWebViewConfiguration {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.javaScriptEnabled = true
      
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        // 메모리에서 랜더링 후 보여줌 Defalt = false
        // true 일경우 랜더링 시간동안 Black 스크린이 나옴
        configuration.suppressesIncrementalRendering = false
        
        // 기본값 false : HTML5 Video 형태로 플레이
        // true  : native full-screen play
        configuration.allowsInlineMediaPlayback = false
        
        // whether AirPlay is allowed.
        configuration.allowsAirPlayForMediaPlayback = false
        
        // 기본값 : true;
        // whether HTML5 videos can play picture-in-picture.
        configuration.allowsPictureInPictureMediaPlayback = true
        
        // LocalStorage 사용하도록 설정
        configuration.websiteDataStore = WKWebsiteDataStore.default()

        // 기본값 : true
        // true : 사용자가 시작 , false : 자동시작
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes.all
        
        return configuration
    }
    
    private func createWebView(configuration: WKWebViewConfiguration) -> WKWebView {
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), configuration: configuration)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.scrollView.scrollsToTop = true
        webView.scrollView.bounces = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.backgroundColor = UIColor.white
        
        return webView
    }
    
    private func parsingJSInterfaceMessage(message: WKScriptMessage) -> Dictionary<String, Any> {
        
        guard message.body as! String != "" else {
            return Dictionary<String, Any>()
        }
        
        let infoArray = (message.body as! String).split(separator: ",")
        
        var dict: Dictionary<String, Any> = Dictionary<String, Any>()
        
        for info in infoArray {
            
            let infoKV = info.replacingOccurrences(of: " ", with: "").split(separator: ":")
            
            let key = infoKV[0]
            var value: String
            if infoKV.count > 1 {
                value = String(infoKV[1])
            }
            else {
                value = ""
            }
           
            dict[String(key)] = value
            
        }
        
        return dict
    }
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
        self.webView = createWebView(configuration: configuration)
        
        self.view.addSubview(self.webView!)
        return self.webView
        
    }
    
    
    // can jump or not
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
    
        let navigationUrlString = navigationAction.request.url?.absoluteString ?? ""
        
        if navigationUrlString == "" {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.allow)
        return
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        ILog.debug(tag: #file, content: "response")
        if let mimeType = navigationResponse.response.mimeType {
            ILog.debug(tag: #file, content: mimeType)
            
            if mimeType == "text/html" {
                // just page
                decisionHandler(.allow)
                return
            }
            
            if let url = navigationResponse.response.url {
                
                let name = getFileNameFromResponse(navigationResponse.response)
                ILog.debug(tag: #file, content: "file name = \(name.removingPercentEncoding ?? "default.file")")
              
                downloadData(fromURL: url, fileName: name) {
                    success, destinationURL in
                    
                    if destinationURL != nil {
                        DispatchQueue.main.async {
                            
                            webView.goBack()
                            
                            let activityVC = UIActivityViewController(activityItems: [destinationURL!], applicationActivities: nil)
                            activityVC.popoverPresentationController?.sourceView = self.view
                            activityVC.popoverPresentationController?.sourceRect = self.view.frame
                            activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
                            self.present(activityVC, animated: true, completion: nil)
                        }
                    }
                    
                }
            }

        }
        decisionHandler(.allow)
    }

    private func downloadData(fromURL url:URL, fileName:String, completion:@escaping (Bool, URL?) -> Void) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies() { cookies in
            let session = URLSession.shared
            session.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: nil)
            let task = session.downloadTask(with: url) { localURL, urlResponse, error in
                if let localURL = localURL {
                    let destinationURL = self.moveDownloadedFile(url: localURL, fileName: fileName)
                    completion(true, destinationURL)
                }
                else {
                    completion(false, nil)
                }
            }

            task.resume()
        }
    }
    
    private func moveDownloadedFile(url:URL, fileName:String) -> URL {
        let tempDir = NSTemporaryDirectory()
        let destinationPath = tempDir + fileName.removingPercentEncoding!
        let destinationURL = URL(fileURLWithPath: destinationPath)
        try? FileManager.default.removeItem(at: destinationURL)
        try? FileManager.default.moveItem(at: url, to: destinationURL)
        return destinationURL
    }
    
    private func getFileNameFromResponse(_ response:URLResponse) -> String {
        if let httpResponse = response as? HTTPURLResponse {
            let headers = httpResponse.allHeaderFields
            if let disposition = headers["Content-Disposition"] as? String {
                let components = disposition.components(separatedBy: " ")
                if components.count > 1 {
                    let innerComponents = components[1].components(separatedBy: "=")
                    if innerComponents.count > 1 {
                        if innerComponents[0].contains("filename") {
                            
                            if innerComponents[1].contains(";") {
                                let fileNameArray = innerComponents[1].split(separator: ";")
                                return fileNameArray[0].replacingOccurrences(of: "\"", with: "")
                            }
                            else {
                                return innerComponents[1]
                            }
                        }
                    }
                }
            }
        }
        return "default.file"
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ILog.debug(tag: #file, content: "start \(webView.url?.absoluteString ?? "empty url")")
    }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        ILog.debug(tag: #file, content: "fail \(webView.url?.absoluteString ?? "empty url")")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ILog.debug(tag: #file, content: "commit \(webView.url?.absoluteString ?? "empty url")")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ILog.debug(tag: #file, content: "finish \(webView.url?.absoluteString ?? "empty url")")
    }

    deinit {
        ILog.debug(tag: #file, content: "deinit")
        
        if webView != nil {
          
            webView!.removeFromSuperview()
            webView = nil
        }
    }
   
//    private func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
//    }

//    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
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
