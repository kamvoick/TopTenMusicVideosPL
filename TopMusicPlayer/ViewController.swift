//
//  ViewController.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 15.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=10/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane
    
    
    }

    func zaladowalDane(result: String){
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let przyciskOk = UIAlertAction(title: "Ok", style: .Default) { (action) in
            //tutaj możemy wykonać coś po naciśnięciu ok
        }
        
        alert.addAction(przyciskOk)//dodaj tą akcje
        self.presentViewController(alert, animated: true, completion: nil)//pokaż tą akcję
    }

}

