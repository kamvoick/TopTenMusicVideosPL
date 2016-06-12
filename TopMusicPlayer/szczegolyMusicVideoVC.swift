//
//  szczegolyMusicVideoVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 12.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class szczegolyMusicVideoVC: UIViewController {

    @IBOutlet weak var tytułVideo: UILabel!
    @IBOutlet weak var obrazekVideo: UIImageView!
    @IBOutlet weak var gatunekVideo: UILabel!
    @IBOutlet weak var cenaVideo: UILabel!
    @IBOutlet weak var prawaVideo: UILabel!
    
    var videos: MusicVideos!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = videos.artystaV
        tytułVideo.text = videos.nazwaV
        gatunekVideo.text = "Gatunek: \(videos.rodzajV)"
        cenaVideo.text = "Cena: \(videos.cenaV)"
        prawaVideo.text = videos.prawaV
        
        if videos.daneObrazka != nil {
            obrazekVideo.image = UIImage(data: videos.daneObrazka!)
        }else{
            obrazekVideo.image = UIImage(named: "niedostepne")
        }
        obrazekVideo.clipsToBounds = true
        
        
    }
}
