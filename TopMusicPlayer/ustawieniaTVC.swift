//
//  ustawieniaTVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 12.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class ustawieniaTVC: UITableViewController {

    @IBOutlet weak var informacjeLbl: UILabel!
    @IBOutlet weak var bezpieczenstwoLbl: UILabel!
    @IBOutlet weak var touchIdSwitch: UISwitch!
    @IBOutlet weak var jakoscZdjecLbl: UILabel!
    @IBOutlet weak var jakoscZdjecSwitch: UISwitch!
    @IBOutlet weak var liczbaMusicVideo: UILabel!
    @IBOutlet weak var sliderLiczbaMusicVideo: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.alwaysBounceVertical = false //nie chcemy żeby się odbijało
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ustawieniaTVC.zmieniłaSięWielkośćCzcionek), name: UIContentSizeCategoryDidChangeNotification, object: nil)//notif odnośnie czcionek
        
    }

    func zmieniłaSięWielkośćCzcionek() {
        informacjeLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bezpieczenstwoLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        jakoscZdjecLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        liczbaMusicVideo.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)

        print("zmieniła się wielkość czcionek")
    }
    
    deinit{        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)//usuwamy obserwatora
    }
}