//
//  CLDBWrapper.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import SQLite3

class CLDBWrapper {
    
    private static let TAG = "CLDBWrapper"
    
    private static let instance = CLDBWrapper()
    
    private init() {
        
    }
    
    public static func getInstance() -> CLDBWrapper {
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
            let pathURL = URL(fileURLWithPath: libraryPathString).appendingPathComponent("CLDB.sqlite")
            return pathURL.path
        }
        
        return ""
    }

    private func openDatabase() -> OpaquePointer? {
        
        if dbPath == "" {
            return nil
        }
        
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
          
            ILog.debug(tag: CLDBWrapper.TAG, content: "成功打开数据库，路径：\(dbPath ?? "")")
            return db
        }
        else {
             ILog.debug(tag: CLDBWrapper.TAG, content: "打开数据库失败")
            return nil
        }
        
    }
    
    public func closeDatabase() {
        
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
          
            ILog.debug(tag: CLDBWrapper.TAG, content: "即将关闭数据库")
            sqlite3_close(db)
        }
        else {
             ILog.debug(tag: CLDBWrapper.TAG, content: "关闭数据库失败")
        }
    }

    private func createTable() {
        
        let sql = """
            CREATE TABLE IF NOT EXISTS CHECKLIST (
            UUID TEXT NOT NULL PRIMARY KEY,
            CONTENT TEXT,
            DATETIME TEXT,
            DONE TEXT);
            """
        
        ILog.debug(tag: CLDBWrapper.TAG, content: sql)
        
        // 1
        var createTableStatement: OpaquePointer?
       
        // 2
        if sqlite3_prepare_v2(db, sql, -1, &createTableStatement, nil) == SQLITE_OK {
        
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                ILog.debug(tag: CLDBWrapper.TAG, content: "成功创建表")
            }
            else {
                ILog.debug(tag: CLDBWrapper.TAG, content: "未成功创建表")
            }
        }
        else {
            ILog.debug(tag: CLDBWrapper.TAG, content: "未成功创建表")
        }
       
        // 4
        sqlite3_finalize(createTableStatement)
    }

    // insert 字符串时，需要把字符串包装成NSString然后转utf-8字符串
    public func insert(checkInfoBean: CheckInfoBean) {
        let sql = """
            INSERT INTO CHECKLIST (UUID, CONTENT, DATETIME, DONE) VALUES (?, ?, ?, ?);
            """
        
        ILog.debug(tag: CLDBWrapper.TAG, content: sql)
        
        var insertStatement: OpaquePointer?
            // 1
            if sqlite3_prepare_v2(db, sql, -1, &insertStatement, nil) == SQLITE_OK {
              
                // 2
                sqlite3_bind_text(insertStatement, 1, NSString(string: checkInfoBean.uuid).utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 2, NSString(string: checkInfoBean.content).utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 3, NSString(string: checkInfoBean.dateTime).utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 4, NSString(string: checkInfoBean.done).utf8String, -1, nil)
                
                // 3
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    ILog.debug(tag: CLDBWrapper.TAG, content: "插入数据成功")
                }
                else {
                    ILog.debug(tag: CLDBWrapper.TAG, content: "插入数据失败")
                }
            }
            else {
                ILog.debug(tag: CLDBWrapper.TAG, content: "插入数据失败")
            }
        
            // 4
            sqlite3_finalize(insertStatement)
    }
    
    public func updateData(checkInfoBean: CheckInfoBean) {
        let sql = """
        UPDATE CHECKLIST SET CONTENT = '\(checkInfoBean.content)', DONE = '\(checkInfoBean.done)' WHERE UUID = '\(checkInfoBean.uuid)';
        """
        
        ILog.debug(tag: CLDBWrapper.TAG, content: sql)
        
        var updateStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &updateStatement, nil) == SQLITE_OK {
            
            // 2
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                ILog.debug(tag: CLDBWrapper.TAG, content: "更新成功")
            }
            else {
                ILog.debug(tag: CLDBWrapper.TAG, content: "更新失败")
            }
        }
        else {
            ILog.debug(tag: CLDBWrapper.TAG, content: "更新失败")
        }
        
        // 3
        sqlite3_finalize(updateStatement)
    }

    public func deleteData(checkInfoBean: CheckInfoBean) {
        let sql = """
        DELETE FROM CHECKLIST WHERE UUID = '\(checkInfoBean.uuid)';
        """

        ILog.debug(tag: CLDBWrapper.TAG, content: sql)
        
        var deleteStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &deleteStatement, nil) == SQLITE_OK {
            
            // 2
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                ILog.debug(tag: CLDBWrapper.TAG, content: "删除成功")
            
            }
            else {
               ILog.debug(tag: CLDBWrapper.TAG, content: "删除失败")
           }
        }
        else {
            ILog.debug(tag: CLDBWrapper.TAG, content: "删除失败")
        }
        
        // 3
        sqlite3_finalize(deleteStatement)
    }

    public func getDataArray(offset: String, limit: String) -> [CheckInfoBean]! {
        
        var checkInfoArray: [CheckInfoBean]
        checkInfoArray = [CheckInfoBean]()
        
        let sql = """
            SELECT * FROM CHECKLIST ORDER BY DATETIME DESC LIMIT \(limit) OFFSET \(offset);
            """
        
        ILog.debug(tag: CLDBWrapper.TAG, content: sql)
        
        var queryStatement: OpaquePointer?
        
        // 1
        if sqlite3_prepare_v2(db, sql, -1, &queryStatement, nil) == SQLITE_OK {
            
            // 2
            while(sqlite3_step(queryStatement) == SQLITE_ROW) {
                
                // 3
                let uuidCol = sqlite3_column_text(queryStatement, 0)
                let contentCol = sqlite3_column_text(queryStatement, 1)
                let dateTimeCol = sqlite3_column_text(queryStatement, 2)
                let doneCol = sqlite3_column_text(queryStatement, 3)
                
                let uuid = String(cString: uuidCol!)
                let content = String(cString: contentCol!)
                let dateTime = String(cString: dateTimeCol!)
                let done = String(cString: doneCol!)
                
                let checkInfoBean = CheckInfoBean(uuid: uuid, content: content, dateTime: dateTime, done: done)
              
                checkInfoArray.append(checkInfoBean)
            
            }
        }
        
        // 4
        sqlite3_finalize(queryStatement)
        
        return checkInfoArray
    }

}
