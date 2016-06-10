//
//  ViewController.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 15.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var reachabilityText: UILabel!
    
    var videos = [MusicVideos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "reachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=10/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane
        
        
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
//        albo tak samo będzie jak wpiszesz
//        for i in 0..<videos.count{
//            let video = videos[i]
//            print("id: \(i), nazwa: \(video.nazwaV)")
//        }
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case brakDostępuWifi: view.backgroundColor = UIColor.redColor()
            reachabilityText.text = "brak dostepu wifi"
        case wifiDziała: view.backgroundColor = UIColor.greenColor()
        reachabilityText.text = "wifi działa"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
        reachabilityText.text = "dostęp poprzez sieć komórkową"

        default:
            return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachStatusChanged", object: nil)
    }
}

