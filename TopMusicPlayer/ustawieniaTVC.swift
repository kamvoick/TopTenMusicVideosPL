//
//  ustawieniaTVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 12.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit
import MessageUI

class ustawieniaTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var informacjeLbl: UILabel!
    @IBOutlet weak var bezpieczenstwoLbl: UILabel!
    //@IBOutlet weak var touchIdSwitch: UISwitch!
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
        
        /*tu pobieramy switcha
        touchIdSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("ustawieniaBezpieczeństwa")*/
        
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

    /*tutaj ustawiamy switcha i zapisujemy w nsuderdefaults
    @IBAction func touchID(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchIdSwitch.on {
            defaults.setBool(touchIdSwitch.on, forKey: "ustawieniaBezpieczeństwa")//spradzamy czy włączony
        }else{
            defaults.setBool(false, forKey: "ustawieniaBezpieczeństwa")
        }
    }   jak odblokowujesz to to też wyżej switcha pobierasz*/
    
    
    func zmieniłaSięWielkośćCzcionek() {
        informacjeLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bezpieczenstwoLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        jakoscZdjecLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        liczbaMusicVideo.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        liczbaWyświetlanychTel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        ustawLiczbęTel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        

        print("zmieniła się wielkość czcionek")
    }
    
    //mail i wyślij sugestie
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let konfiguracjaMailaViewController = konfiguracjaMaila()
            if MFMailComposeViewController.canSendMail() {//musimy sprawdzić czy ta osoba ma konto utworzone
                self.presentViewController(konfiguracjaMailaViewController, animated: true, completion: nil)
            }else{
                //nie ma konta
                mailAlert()
            }
        }
    }
    
    func konfiguracjaMaila() -> MFMailComposeViewController{ //chcemy żeby wypluło nasz vc z już wpisanymi danymi
        
        let konfiguracjaMailaVC = MFMailComposeViewController()
        konfiguracjaMailaVC.mailComposeDelegate = self
        konfiguracjaMailaVC.setToRecipients(["kam.voick@gmail.com"])
        konfiguracjaMailaVC.setSubject("Sugestie i opinie")
        //konfiguracjaMailaVC.setMessageBody("", isHTML: false) //tu możemy wsadzić treść
        return konfiguracjaMailaVC
    }
    
    func mailAlert(){
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "Nie masz ustawionego konta poczty mail", preferredStyle: .Alert)
        let przyciskOk = UIAlertAction(title: "Ok", style: .Default) { (UIAlertAction) in
            //tutaj możemy coś wykonać, np przejsc do konfigur...
        }
        
        alertController.addAction(przyciskOk)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue { //tutaj wpisujemy do konsoli co się stało
        case MFMailComposeResultCancelled.rawValue:
            print("Mail anulowany")
        case MFMailComposeResultSaved.rawValue:
            print("Mail zapisany")
        case MFMailComposeResultFailed.rawValue:
            print("Błąd zapisu maila")
        case MFMailComposeResultSent.rawValue:
            print("Mail wysłany")
        default:
            print("Nieznany błąd")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    } //i musimy odwołać kontrollera bo nie zejdzie inaczej
    
    deinit{        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)//usuwamy obserwatora
    }
}
