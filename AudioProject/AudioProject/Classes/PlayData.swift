//
//  File.swift
//  AudioProject
//
//  Created by Xcode User on 2019-04-06.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import Foundation

class PlayData{
    
    var id :Int!
    var songname :String!
    var artist :String!
    var time :String!
    var songimage :String!
    
    func initWithData(theRow i:Int, theName n:String, theArtist a:String, theTime p:String,theImage img:String){
        
        id = i
        songname = n
        artist = a
        time = p
        songimage = img
        
        
    }
    
    
}
