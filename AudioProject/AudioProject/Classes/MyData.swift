//
//  MyData.swift
//  AudioProject
//
//  Created by Xcode User on 2019-04-02.
//  Copyright © 2019 Xcode User. All rights reserved.
//  Author: Paras Patel

import UIKit

class MyData: NSObject {

    var id : Int?
    var songName : String?
    var artist : String?
    var time : String?
    var songImg : String?
    
    
    func initWithData(theRow i:Int, theName n:String, theArtist a:String, theTime p:String, theSongImage e:String)
    {
        id = i
        songName = n
        artist = a
        time = p
        songImg = e
    }
    
}
