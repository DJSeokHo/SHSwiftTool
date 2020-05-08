//
//  KADBWrapper.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import SQLite3

class KADBWrapper {
    
    private static let instance = KADBWrapper()
    
    private init() {
        
    }
    
    public static func getInstance() -> KADBWrapper {
        return instance
    }
    
    private var db: OpaquePointer!
    private var dbPath: String!
    
    
    public func initDB() {
        dbPath = fetchLibraryPath()
        db = openDatabase()
        
        createTable()
    }
    
    private func fetchLibraryPath() -> String {
        if let libraryPathString = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first {
            let pathURL = URL(fileURLWithPath: libraryPathString).appendingPathComponent("KADB.sqlite")
            return pathURL.path
        }
        
        return ""
    }

    private func openDatabase() -> OpaquePointer? {
        
        if dbPath == "" {
            return nil
        }
        
        var db: OpaquePointer?
        // use "SQLITE_OPEN_READWRITE|SQLITE_OPEN_FULLMUTEX" to keep sqlite safe under multi-thread
        if sqlite3_open_v2(dbPath, &db, SQLITE_OPEN_READWRITE|SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK {
          
            ILog.debug(tag: #file, content: "open success，path is：\(dbPath ?? "")")
            return db
        }
        else {
            ILog.debug(tag: #file, content: "open error，path is：\(dbPath ?? "no path")")
            
            // sqlite3_open can create db file
            // sqlite3_open_v2 can only load db file
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
              
                ILog.debug(tag: #file, content: "open and create success，path：\(dbPath ?? "")")
                
                sqlite3_close(db)
                
                if sqlite3_open_v2(dbPath, &db, SQLITE_OPEN_READWRITE|SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK {
                  
                    ILog.debug(tag: #file, content: "open success v2，path：\(dbPath ?? "")")
                    return db
                }
                else {
                    return nil
                }
                
            }
            else {
                 ILog.debug(tag: #file, content: "open error")
                return nil
            }
        }
        
    }
    
    public func closeDatabase() {
        sqlite3_close(db)
    }

    private func createTable() {
      
        let sql = """
            CREATE TABLE IF NOT EXISTS KEEP_ACCOUNT_LIST (
            UUID TEXT NOT NULL PRIMARY KEY,
            TITLE TEXT,
            CATEGORY TEXT,
            AMOUNT TEXT,
            CONTENT TEXT,
            DATETIME TEXT,
            IMAGE_URL TEXT,
            LATITUDE TEXT,
            LONGITUDE TEXT
            DONE TEXT);
            """
        
        ILog.debug(tag: #file, content: sql)
        
        // 1
        var createTableStatement: OpaquePointer?
       
        // 2
        if sqlite3_prepare_v2(db, sql, -1, &createTableStatement, nil) == SQLITE_OK {
        
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                ILog.debug(tag: #file, content: "create table success")
            }
            else {
                ILog.debug(tag: #file, content: "create table error")
            }
        }
        else {
            ILog.debug(tag: #file, content: "create table error")
        }
       
        // 4
        sqlite3_finalize(createTableStatement)
    }

    // insert: change string to NSString utf8
    public func insert(keepAccountInfoBean: KeepAccountInfoBean) {
        let sql = """
            INSERT INTO KEEP_ACCOUNT_LIST (UUID, TITLE, CATEGORY, AMOUNT, CONTENT, DATETIME, IMAGE_URL, LATITUDE, LONGITUDE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """
        
        ILog.debug(tag: #file, content: sql)
        
        var insertStatement: OpaquePointer?
            // 1
            if sqlite3_prepare_v2(db, sql, -1, &insertStatement, nil) == SQLITE_OK {
              
                // 2
                sqlite3_bind_text(insertStatement, 1, NSString(string: keepAccountInfoBean.uuid).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, NSString(string: keepAccountInfoBean.title).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, NSString(string: keepAccountInfoBean.category).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, NSString(string: String(keepAccountInfoBean.amount)).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, NSString(string: keepAccountInfoBean.content).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, NSString(string: keepAccountInfoBean.dateTime).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 7, NSString(string: keepAccountInfoBean.imageUrl).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 8, NSString(string: String(keepAccountInfoBean.latitude)).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 9, NSString(string: String(keepAccountInfoBean.longitude)).utf8String, -1, nil)
                
                // 3
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    ILog.debug(tag: #file, content: "insert success")
                }
                else {
                    ILog.debug(tag: #file, content: "insert error")
                }
            }
            else {
                ILog.debug(tag: #file, content: "insert error")
            }
        
            // 4
            sqlite3_finalize(insertStatement)
    }
    
    public func updateData(keepAccountInfoBean: KeepAccountInfoBean) {
        
        let sql = """
        UPDATE KEEP_ACCOUNT_LIST SET
        TITLE = '\(keepAccountInfoBean.title!)',
        CATEGORY = '\(keepAccountInfoBean.category!)',
        AMOUNT = '\(keepAccountInfoBean.amount!)',
        CONTENT = '\(keepAccountInfoBean.content!)',
        DATETIME = '\(keepAccountInfoBean.dateTime!)',
        IMAGE_URL = '\(keepAccountInfoBean.imageUrl!)',
        LATITUDE = '\(keepAccountInfoBean.latitude!)',
        LONGITUDE = '\(keepAccountInfoBean.longitude!)'
        WHERE UUID = '\(keepAccountInfoBean.uuid!)';
        """
        
        ILog.debug(tag: #file, content: sql)
        
        var updateStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &updateStatement, nil) == SQLITE_OK {
            
            // 2
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                ILog.debug(tag: #file, content: "update success")
            }
            else {
                ILog.debug(tag: #file, content: "update error")
            }
        }
        else {
            ILog.debug(tag: #file, content: "update error")
        }
        
        // 3
        sqlite3_finalize(updateStatement)
    }

    public func deleteData(keepAccountInfoBean: KeepAccountInfoBean) {
        let sql = """
        DELETE FROM KEEP_ACCOUNT_LIST WHERE UUID = '\(keepAccountInfoBean.uuid!)';
        """

        ILog.debug(tag: #file, content: sql)
        
        var deleteStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &deleteStatement, nil) == SQLITE_OK {
            
            // 2
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                ILog.debug(tag: #file, content: "delete success")
            
            }
            else {
               ILog.debug(tag: #file, content: "delete error")
           }
        }
        else {
            ILog.debug(tag: #file, content: "delete error")
        }
        
        // 3
        sqlite3_finalize(deleteStatement)
    }

    public func getDataArray(offset: String, limit: String, category: String) -> [KeepAccountInfoBean]! {
        
        var kaInfoArray: [KeepAccountInfoBean]
        kaInfoArray = [KeepAccountInfoBean]()
        
        let sql = """
            SELECT * FROM KEEP_ACCOUNT_LIST WHERE CATEGORY = '\(category)' ORDER BY DATETIME DESC LIMIT \(limit) OFFSET \(offset);
            """
        
        ILog.debug(tag: #file, content: sql)
        
        var queryStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &queryStatement, nil) == SQLITE_OK {
            
            // 2
            while(sqlite3_step(queryStatement) == SQLITE_ROW) {
                
                // 3
                let uuidCol = sqlite3_column_text(queryStatement, 0)
                let titleCol = sqlite3_column_text(queryStatement, 1)
                let categoryCol = sqlite3_column_text(queryStatement, 2)
                let amountCol = sqlite3_column_text(queryStatement, 3)
                let contentCol = sqlite3_column_text(queryStatement, 4)
                let dateTimeCol = sqlite3_column_text(queryStatement, 5)
                let imageUrlCol = sqlite3_column_text(queryStatement, 6)
                let latitudeCol = sqlite3_column_text(queryStatement, 7)
                let longitudeCol = sqlite3_column_text(queryStatement, 8)
                
                let uuid = String(cString: uuidCol!)
                let title = String(cString: titleCol!)
                let category = String(cString: categoryCol!)
                let amount = String(cString: amountCol!)
                let content = String(cString: contentCol!)
                let dateTime = String(cString: dateTimeCol!)
                let imageUrl = String(cString: imageUrlCol!)
                let latitude = String(cString: latitudeCol!)
                let longitude = String(cString: longitudeCol!)
                
                
                let keepAccountInfoBean = KeepAccountInfoBean()
                keepAccountInfoBean.uuid = uuid
                keepAccountInfoBean.title = title
                keepAccountInfoBean.category = category
                keepAccountInfoBean.amount = (amount as NSString).floatValue
                keepAccountInfoBean.content = content
                keepAccountInfoBean.dateTime = dateTime
                keepAccountInfoBean.imageUrl = imageUrl
                keepAccountInfoBean.latitude = (latitude as NSString).doubleValue
                keepAccountInfoBean.longitude = (longitude as NSString).doubleValue
                
                kaInfoArray.append(keepAccountInfoBean)
            
            }
        }
        
        // 4
        sqlite3_finalize(queryStatement)
        
        return kaInfoArray
    }
}

