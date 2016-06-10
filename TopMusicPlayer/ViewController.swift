//
//  ViewController.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 15.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [MusicVideos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=10/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane
        
        
    }
    
    func zaladowalDane(videos: [MusicVideos]){ //kiedy wykona się api wtey załaduje tą funkcje
        
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
    
}

