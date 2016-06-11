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
        dispatch_async(dispatch_get_main_queue(), { //musimy wrzucić do głównego wątku bo bez tego pokazujemy alert w momencie gdy viewdidload załadował się raz ale jescze niezaładował view dlatego go tam nie ma a my chcemy na to wsadzić alert
        let alert = UIAlertController(title: "Brak połączenia wifi", message: "Sprawdź swoje połaczenie wifi", preferredStyle: .Alert)
            
            let przyciskAnulowania = UIAlertAction(title: "Anuluj", style: .Default, handler: { (UIAlertAction) in
                print("Anuluj")
            })
            
            let przyciskUsuwania = UIAlertAction(title: "Usuń", style: .Destructive, handler: { (UIAlertAction) in
                print("Usuń")
            })
            
            let przyciskOk = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) in
                print("Ok")
                
                //tutaj wpisz co chcesz wykonać po naciśnięciu ok
            })
            
            alert.addAction(przyciskOk)
            alert.addAction(przyciskAnulowania)
            alert.addAction(przyciskUsuwania)
            //kolejność ma znaczenie
            
            self.presentViewController(alert, animated: true, completion: nil)//pokazujemy vc
            })
        default:
            view.backgroundColor = UIColor.greenColor()
            
            if videos.count > 0 { //ponieważ chcemy żeby api wykonało się po włączeniu a nie na samym początku ustawiamy liczbę video na więcej niż zero co oznaczać będzie że już został włączony
            print("nie odświeżaj API")
            }else{
                wykonajApi()
            }
        }
    }
    
    func wykonajApi(){
        let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=100/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane
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
