//
//  szczegolyMusicVideoVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 12.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication


class szczegolyMusicVideoVC: UIViewController  {

    @IBOutlet weak var tytułVideo: UILabel!
    @IBOutlet weak var obrazekVideo: UIImageView!
    @IBOutlet weak var gatunekVideo: UILabel!
    @IBOutlet weak var cenaVideo: UILabel!
    @IBOutlet weak var prawaVideo: UILabel!
    
    var videos: MusicVideos!
    //var switchBezpieczeństwa: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bezpieczeństwo = NSUserDefaults.standardUserDefaults().boolForKey("ustawieniaBezpieczeństwa")
//        
//        if bezpieczeństwo == true {
//            
//        }

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
    
    func sprawdzenieTouchId(){
        
    }
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
       /* switchBezpieczeństwa = NSUserDefaults.standardUserDefaults().boolForKey("ustawieniaBezpieczeństwa") //musi być bool bo sprawdzamy czy jest czy nie i zapisujemy do nsuserdefaults, wcześniej to deklarowaliśmy przy switchu
        
        switch switchBezpieczeństwa {
        case true:
            sprawdzenieTouchId() //kiedy ust bezpieczenstwa są włączone to sprawdzamy czy touchid się zgadza
        default:
            pokażZnajomym() //jeżeli nie jest ustawiony socialmedia działa
        } */
        pokażZnajomym()
    }
    
    
    func pokażZnajomym(){ //musimy zrobić funkcje ponieważ mam ustawienia bezpieczenstwa i w zaleznosci czy włączone czy nie będzie działać
        
        let wiadomość1 = "Sprawdź ten teledysk, jest naprawdę super!"
        
        let aktywnośćViewController: UIActivityViewController = UIActivityViewController(activityItems: [wiadomość1], applicationActivities: nil) //wiadomość do wpisania jak koomuś coś udostępniasz
        
//        aktywnośćViewController.excludedActivityTypes = [
//        UIActivityTypePostToFacebook,
//        UIActivityTypePostToTwitter,
//        UIActivityTypeMessage,
//        UIActivityTypeMail,
//        UIActivityTypePrint,
//        UIActivityTypeCopyToPasteboard,
//        UIActivityTypeAssignToContact,
//        UIActivityTypeSaveToCameraRoll,
//        UIActivityTypeAddToReadingList,
//        UIActivityTypePostToFlickr,
//        UIActivityTypePostToVimeo]
        
        aktywnośćViewController.completionWithItemsHandler = {
            (aktywność, sukces, item, error) in //tutaj w momencie gdy skończymy wybór można coś zrobić
            
            if aktywność == UIActivityTypeMail {
                print("mail wybrany")
            }
        }
        self.presentViewController(aktywnośćViewController, animated: true, completion: nil)
    }
    
    @IBAction func odtwarzajVideo(sender: AnyObject) {
        
        let url = NSURL(string: videos.urlVideoV)
        let odtwarzacz = AVPlayer(URL: url!)
        let odtwarzaczViewController = AVPlayerViewController()
        odtwarzaczViewController.player = odtwarzacz //pokazujemy co ma odtwarzać
        self.presentViewController(odtwarzaczViewController, animated: true) { 
            odtwarzaczViewController.player?.play()
        }
    }
    
}
