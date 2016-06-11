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
        obrazekVideo.image = UIImage(named: "niedostepne")
    }

}
