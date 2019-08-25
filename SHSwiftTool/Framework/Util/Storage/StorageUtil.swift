//
//  StorageUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 25/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation


/*
 
 Library/Preferences
 保存应用程序的偏好设置文件。NSUserDefaults类创建的数据和plist文件都放在这里；
 该目录的内容被iTunes和iCloud备份。
 
 */

class StorageUtil {
    
    private static let TAG = "StorageUtil"
    
    /*
     AppName.app
     应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以不能在运行时对这个目录中的内容进行修改，
     否则会导致应用程序无法启动。
    */
    public static func getAppSandBoxDirectory() -> String {
        // 获取app沙盒的根目录（home）
        let homePath = NSHomeDirectory()
        ILog.debug(tag: "\(StorageUtil.TAG) getAppSandBoxDirectory", content: homePath)
        return homePath
    }
    
    /*
     Tmp/
     使用此目录可以编写在应用程序启动之间不需要保留的临时文件，您的应用程序应在不再需要时删除此目录中的文件，
     但是，当您的应用未运行时，系统可能会清除此目录；iTunes或iCloud不会备份此目录下的内容。
    */
    public static func getTempDirectory() -> String {
        let tempPath = NSTemporaryDirectory()
        ILog.debug(tag: "\(StorageUtil.TAG) getTempDirectory", content: tempPath)
        return tempPath
    }
    
    /*
     Documents/
     保存应用程序的重要数据文件和用户数据文件等。用户数据基本上都放在这个位置(例如从网上下载的图片或音乐文件)，
     该文件夹在应用程序更新时会自动备份，在连接iTunes时也可以自动同步备份其中的数据；该目录的内容被iTunes和iCloud备份。
    */
    public static func getDocumentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        
        let documentPath = paths.first
        ILog.debug(tag: "\(StorageUtil.TAG) getDocumentDirectory", content: documentPath!)
        return documentPath!
    }
    
    /*
     Library/
     这个目录下有两个子目录,可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。
     该路径下的文件夹，除Caches以外，都会被iTunes备份;该目录的内容被iTunes和iCloud备份
    */
    public static func getLibraryDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let library = paths.last
        ILog.debug(tag: "\(StorageUtil.TAG) getLibraryDirectory", content: library!)
        return library!
    }
    
    /*
     Library/Caches
     保存应用程序使用时产生的支持文件和缓存文件(保存应用程序再次启动过程中需要的信息)，还有日志文件最好也放在这个目录；
     iTunes 不会备份该目录，并且该目录下数据可能被其他工具清理掉。
    */
    public static func getLibraryCachesDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        
        let libraryCaches = paths.last
        ILog.debug(tag: "\(StorageUtil.TAG) getLibraryCachesDirectory", content: libraryCaches!)
        return libraryCaches!
    }
}
