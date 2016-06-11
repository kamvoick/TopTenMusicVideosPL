//
//  MusicVideoTVCell.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 11.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class MusicVideoTVCell: UITableViewCell {

    var video: MusicVideos?{
        didSet{
            aktualizujKomórke()
        }
    }
    
    @IBOutlet weak var obrazekVideo: UIImageView!
    @IBOutlet weak var pozycjaVideo: UILabel!
    @IBOutlet weak var tytułVideo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func aktualizujKomórke(){
        tytułVideo.text = video?.nazwaV
        pozycjaVideo.text = "\(video!.rankowanie)"
        
        if video?.daneObrazka != nil{ //jeżeli w szeregu są jakieś dane to pobierz ostatni zapisany obrazek
            print("pobieranie danych z arraya...")
            obrazekVideo.image = UIImage(data: (video?.daneObrazka)!) //i to będzie nasz obrazek/jako data
        }else{
            print("pobieranie danych w tle")
            pobierzObrazVideo(video!, imageView: obrazekVideo)//jeżeli nie ma danych, czyli np. włączyliśmy aplikacje od nowa ale nie z backgroundu to pobierze nowe dane z naszego arryau video=musicvideos/z urluobrazku i wstawi go do obrazekVideo
        }
        obrazekVideo.clipsToBounds = true
    }
    
    func pobierzObrazVideo(video: MusicVideos, imageView: UIImageView){ //wsadzamy dwa parametry, pierwszy to nasz szereg videów, drugi to nasz imageview gdzie będzie obrazek
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { //wsadzamy priorytetowo do średniego szczebla, wczesniej wsadzilismy do high nasze połaczenie wifi, ale to jest mniej ważne, bo w sumie gdy nie będzie internetu nie będzie danych, default to standardowy priorytet dla podobnych do tej operacji
            let data = NSData(contentsOfURL: NSURL(string: video.urlObrazV)!) //wsadzamy nasze obrazki z arraya do daty żebyśmy mogli wsadzić obrazek do imageview
            
            var obraz: UIImage? //deklarujemy obrazek jako uiimageview, opcjonalnie, przeciez nie musi być
            if data != nil {
                video.daneObrazka = data
                obraz = UIImage(data: data!)//jeżeli dane są pobrane to wtedy nasze zamienione dane z urla do daty wsadzamy do arraya do danychobrazka i dopiero możemy wsadz jako nasz obraz tak zamienione dane w postaci daty, nie możemy tego zrobić tak że url to uiimage, chodzi o cały ten proces
            }
            
            dispatch_async(dispatch_get_main_queue(), { //to nie jest else tylko dalszy ciąg po wykonaniu poprzedniego, terazwrzucamy wszystko do głównego wątku i wracamy do niego
                imageView.image = obraz
            })
            
            //chodzi w tym wszystkim o to że powyżej get main queue robimy wszystko w backgroundzie, czyli w tyle, i dopiero na koncu wrzucamy tylko te ważne rzeczy jak że obrazek nasz bedzie wchodził do iamgeview BARDZO ISTOTNE
            
        }
    }

}
