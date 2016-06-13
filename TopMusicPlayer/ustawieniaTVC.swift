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
    @IBOutlet weak var liczbaWyświetlanychTel: UILabel!
    @IBOutlet weak var ustawLiczbęTel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.alwaysBounceVertical = false //nie chcemy żeby się odbijało
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ustawieniaTVC.zmieniłaSięWielkośćCzcionek), name: UIContentSizeCategoryDidChangeNotification, object: nil)//notif odnośnie czcionek
        
        title = "ustawienia"
        
        //tu pobieramy switcha
        touchIdSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("ustawieniaBezpieczeństwa")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("sliderLiczbaMusicVideo") != nil){ //musimy sprawdzić czy coś tam już jest bo będzie crash
            let wartość = NSUserDefaults.standardUserDefaults().objectForKey("sliderLiczbaMusicVideo") as! Int //jeżeli nie zcastujemy to będzie dowolny obiekt
            liczbaMusicVideo.text = "\(wartość)"
            sliderLiczbaMusicVideo.value = Float(wartość) //bo tutaj jest zawsze float a my bierzemy z int
        }else{
            sliderLiczbaMusicVideo.value = 10.0 //musimy ustawić pierwszą wartość jeżeli jej nie ma
            liczbaMusicVideo.text = "\(Int(sliderLiczbaMusicVideo.value))"
        }
    }
    @IBAction func zmieniaczLiczbyWideo(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults() //zapisujemy do nsuserdefaults
        defaults.setObject(Int(sliderLiczbaMusicVideo.value), forKey: "sliderLiczbaMusicVideo") //do int bo to float
        liczbaMusicVideo.text = "\(Int(sliderLiczbaMusicVideo.value))"
    }

    //tutaj ustawiamy switcha i zapisujemy w nsuderdefaults
    @IBAction func touchID(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchIdSwitch.on {
            defaults.setBool(touchIdSwitch.on, forKey: "ustawieniaBezpieczeństwa")//spradzamy czy włączony
        }else{
            defaults.setBool(false, forKey: "ustawieniaBezpieczeństwa")
        }
    }
    
    
    func zmieniłaSięWielkośćCzcionek() {
        informacjeLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bezpieczenstwoLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        jakoscZdjecLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        liczbaMusicVideo.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        liczbaWyświetlanychTel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        ustawLiczbęTel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        

        print("zmieniła się wielkość czcionek")
    }
    
    deinit{        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)//usuwamy obserwatora
    }
}
