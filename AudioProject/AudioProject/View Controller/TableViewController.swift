//
//  TableViewController.swift
//  AudioProject
//
//  Created by Xcode User on 2019-03-14.
//  Copyright © 2019 Xcode User. All rights reserved.
//  Author: Paras Patel

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var playData:PlayData!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let tableCell : SiteCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        
        tableCell.primaryLabel.text = mainDelegate.song[rowNum].songName
        tableCell.secondaryLabel.text = mainDelegate.song[rowNum].artist
        tableCell.thirdLabel.text = mainDelegate.song[rowNum].time
        
        
        tableCell.myImageView.image = UIImage(named: mainDelegate.song[rowNum].songImg!)
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index:Int = indexPath[1]+1
        let songName:String = mainDelegate.song[indexPath[1]].songName!
        let artist:String = mainDelegate.song[indexPath[1]].artist!
        let time:String = mainDelegate.song[indexPath[1]].time!
        let image:String = mainDelegate.song[indexPath[1]].songImg!
        
        
        playData = PlayData.init()
        
        playData.initWithData(theRow: index, theName: songName, theArtist: artist, theTime: time, theImage: image)
        
        self.performSegue(withIdentifier: "Play", sender: playData) // Use of unresolved identifier "performSegue"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Play" {
            if let playViewController = segue.destination as? PlayViewController {
                playViewController.playData = sender as? PlayData
                print("song")
                print(playViewController.playData.songname)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToTableVC(sender : UIStoryboardSegue){
        
        
        
    }
    
     // Do any additional setup after loading the view.
    /*
    var listData = ["Jays","Leafs","Raptors", "FC", "Marlies"];
    var imageData = ["jays.jpg", "leafs.png", "raptors.jpg", "fc.png", "marlies.jpeg"]
    
    var siteData = ["http://www.bluejays.com",
                    "http://www.torontomapleleafs.com",
                    "http://www.torontoraptors.com",
                    "http://www.marlies.ca",
                    "http://www.torontofc.ca"
    ]
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
