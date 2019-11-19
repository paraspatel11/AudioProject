//
//  AppDelegate.swift
//  AudioProject
//
//  Created by Xcode User on 2019-03-03.
//  Copyright © 2019 Xcode User. All rights reserved.
// Author: Paras Patel

import UIKit
import SQLite3
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    
    var databaseName : String? = "MySong.db"
    var databasePath : String?
    var song : [MyData] = []
 
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return Auth0.resumeAuth(url, options: options)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        
        databasePath = documentsDir.appending("/" + databaseName!)
        
        print("Database path is: " + databasePath!)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        return true
    }
    
    func checkAndCreateDatabase(){
        let filemanager = FileManager.default
        
        let success = filemanager.fileExists(atPath: databasePath!)
        if success
        {
            return
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? filemanager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
    }

    func readDataFromDatabase(){
        song.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("Opned Connection to databse at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select * from songs"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                print("Select statement executed")
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    
                    let csongname = sqlite3_column_text(queryStatement, 1)
                    let cartist = sqlite3_column_text(queryStatement, 2)
                    let ctime = sqlite3_column_text(queryStatement, 3)
                    let csongimage = sqlite3_column_text(queryStatement, 4)
                    
                    
                    
                    let songname = String(cString: csongname!)
                    let artist = String(cString: cartist!)
                    let time = String(cString: ctime!)
                    let songimage = String(cString: csongimage!)
                   
                    
                    let data : MyData = .init()
                    data.initWithData(theRow: id, theName: songname, theArtist: artist, theTime: time, theSongImage: songimage)
                   
                    song.append(data)
                    
                    print("Query Result: ")
                    print("\(id) | \(songname)| \(artist)| \(time) | \(songimage)")
                    
                    
                }
                sqlite3_finalize(queryStatement)
            }
            else{
                print("Select statement would not be prepared")
            }
            sqlite3_close(db)
        }
        else{
            print("Unable to Open Database")
        }
    }
    
    // This Class Does Not have a INSERT Method since this is just to read data
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

