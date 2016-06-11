//
//  MusicVideoTVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 11.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    
    var videos = [MusicVideos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "reachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=100/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane
        
        
    }
    
    func zaladowalDane(videos: [MusicVideos]){ //kiedy wykona się api wtey załaduje tą funkcje
        
        print(reachabilityStatus)
        
        self.videos = videos //musimy pozwolić aby nasze wartości zapisywały się do videów(ja mówić polski...) więc zwiększamy zakres przypisując te videa do zmiennych zadeklarowanych wyżej czyli self
        
        //        for element in videos {
        //            print("nazwa: \(element.nazwaV)")
        //        }
        
        for (index, element) in videos.enumerate(){
            print("id: \(index), nazwa: \(element.nazwaV)")
        }
        
        tableView.reloadData()
        
        
        //        albo tak samo będzie jak wpiszesz
        //        for i in 0..<videos.count{
        //            let video = videos[i]
        //            print("id: \(i), nazwa: \(video.nazwaV)")
        //        }
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case brakDostępuWifi: view.backgroundColor = UIColor.redColor()
        //reachabilityText.text = "brak dostepu wifi"
        case wifiDziała: view.backgroundColor = UIColor.greenColor()
        //reachabilityText.text = "wifi działa"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
        //reachabilityText.text = "dostęp poprzez sieć komórkową"
            
        default:
            return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachStatusChanged", object: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let komórka = tableView.dequeueReusableCellWithIdentifier("komórka", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        komórka.textLabel?.text = "\(indexPath.row + 1)"
        
        komórka.detailTextLabel?.text = "\(video.nazwaV)"
        
        
        
        
        return komórka
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
