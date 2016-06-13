//
//  MusicVideoTVC.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 11.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {
    
    
    var videos = [MusicVideos]()
    var limit = 10
    
    //szukajka
    var filtrowanaSzukajka = [MusicVideos]()
    var rezultatySearchController = UISearchController(searchResultsController: nil)// jeżeli chcesz wyświetlić rezultaty w tym samym oknie w którym wyszukujesz i nie otwierać nowego
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: "reachStatusChanged", object: nil)//notif odnośnie wifi
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "zmieniłaSięWielkośćCzcionek", name: UIContentSizeCategoryDidChangeNotification, object: nil)//notif odnośnie czcionek
        
        reachabilityStatusChanged()
        
        
    }
    
    func zmieniłaSięWielkośćCzcionek() {
        print("zmieniła się wielkość czcionek")
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
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        title = "\(limit) najpopularniejszych video w Polsce"
        
        tableView.reloadData()
        
        rezultatySearchController.searchResultsUpdater = self //musimy założyć naszą delegacje
        
        definesPresentationContext = true //szukajka nie przejdzie na nastepny vc jeżeli użytkownik tam przejdzie
        rezultatySearchController.dimsBackgroundDuringPresentation = false //przy true kiedy  wyszukujesz teledysk nie będzie można nic wybrać i przejsc do szczegółów to na odwórót
        rezultatySearchController.searchBar.placeholder = "Wyszukaj artystę" //placeholder
        rezultatySearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent //cmd na prominent
        
        tableView.tableHeaderView = rezultatySearchController.searchBar //dodajemy do tableview szukajke
        
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus {
        case brakDostępuWifi:
            //view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue(), { //musimy wrzucić do głównego wątku bo bez tego pokazujemy alert w momencie gdy viewdidload załadował się raz ale jescze niezaładował view dlatego go tam nie ma a my chcemy na to wsadzić alert
                let alert = UIAlertController(title: "Brak połączenia wifi", message: "Sprawdź swoje połaczenie wifi", preferredStyle: .Alert)
                
                /* let przyciskAnulowania = UIAlertAction(title: "Anuluj", style: .Default, handler: { (UIAlertAction) in
                 print("Anuluj")
                 })
                 
                 let przyciskUsuwania = UIAlertAction(title: "Usuń", style: .Destructive, handler: { (UIAlertAction) in
                 print("Usuń")
                 })
                 */
                let przyciskOk = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) in
                    print("Ok")
                    
                    //tutaj wpisz co chcesz wykonać po naciśnięciu ok
                })
                
                alert.addAction(przyciskOk)
                /* alert.addAction(przyciskAnulowania)
                 alert.addAction(przyciskUsuwania)*/
                //kolejność
                
                self.presentViewController(alert, animated: true, completion: nil)//pokazujemy vc
            })
        default:
            //view.backgroundColor = UIColor.greenColor()
            
            if videos.count > 0 { //ponieważ chcemy żeby api wykonało się po włączeniu a nie na samym początku ustawiamy liczbę video na więcej niż zero co oznaczać będzie że już został włączony
                print("nie odświeżaj API")
            }else{
                wykonajApi()
            }
        }
    }
    
    
    @IBAction func odświeżanie(sender: AnyObject) {
        refreshControl?.endRefreshing() //mamy to takie kółko - spinner i chcemy żeby się zatrzymało
        
        if rezultatySearchController.active{
            refreshControl?.attributedTitle = NSAttributedString(string: "odświeżanie zatrzymane dla wyszukiwania")
        }else{
        wykonajApi()
        }
    }
    
    func pobierzLiczbęVideo(){ //pobieramy dane przy odświeżaniu z góry
        if (NSUserDefaults.standardUserDefaults().objectForKey("sliderLiczbaMusicVideo") != nil){ //sprawdzamy czy coś już jest zapisane, jeżeli tak to
            let wartość = NSUserDefaults.standardUserDefaults().objectForKey("sliderLiczbaMusicVideo") as! Int
            limit = wartość
        }
        let formatowanie = NSDateFormatter() //tutaj kod formatowania daty
        formatowanie.dateFormat = "h:mm a" //unicod
        let odświeżanieDaty = formatowanie.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(odświeżanieDaty)") //odświeżanie z góry z dodatkową nazwą
    }
    
    func wykonajApi(){
        
        pobierzLiczbęVideo() //pobieramy ile ma być pobranych video z naszego slidera, func wyżej
        
        let API = APIManager()
        API.zaladujDane("https://itunes.apple.com/pl/rss/topmusicvideos/limit=\(limit)/json", completion: zaladowalDane)//kiedy zaladowanie jest ukonczone wykona func zaladowaldane, 200 to max dla itunes
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachStatusChanged", object: nil)//usuwamy obserwatora
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)//usuwamy obserwatora
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rezultatySearchController.active{
            return filtrowanaSzukajka.count
        }else{
            return videos.count
        }
    }
    
    private struct storyboard{
        static let cellReusableIdentifier = "komórka" //żebyśmy nie musili za każdym razem wpisywać komórka do wykorzystanej komórki niżej możesz wpisać storyboard.cellreusableidentifier, dobre jeżeli mamy dużo komórek różnych, struct bo robimy nową strukturę prywatną, jeszcze nie klasę
        static let segueIdentifier = "szczegolyMusicVideoVC"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let komórka = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReusableIdentifier, forIndexPath: indexPath) as! MusicVideoTVCell //musimy tą komórke zcastować na nasz zcustomizowaną komórke
        
        
        if rezultatySearchController.active {
            komórka.video = filtrowanaSzukajka[indexPath.row]
        }else{
            
            komórka.video = videos[indexPath.row]//w tym momencie bierzemy nasze video i przechodzimy do komórki -> musicvideotvcell i tam dalej
            
        }
        
        
        
        
        return komórka
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier{ //ponieważ możemy mieć segueja w wielu miejscach musimy się odnieść do tego że o ten konkretny nam chodzi ze szczegolamimvVC
            
            if let indexPath = tableView.indexPathForSelectedRow{//zależnie od tego którą komórke wybierzemy wpiszemy jej index do indexpath i nastepnie wyciągniemy to video z arraya z tą liczbą
                let video: MusicVideos //deklarujemy typ
                
                if rezultatySearchController.active{
                    video = filtrowanaSzukajka[indexPath.row]
                }else{
                    video = videos[indexPath.row]
                }
                let dvc = segue.destinationViewController as! szczegolyMusicVideoVC //przeznaczonym vc będzie nasz szczegolymvVC
                dvc.videos = video //no i video w naszym dvc to będzie to video
                
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text?.lowercaseString //weź wszystko co wyszukuje zamień na małelitery
        filtrujSzukanie(searchController.searchBar.text!) //wrzucamy to do szukamy do funkcji \/
    }
    
    func filtrujSzukanie(searchText: String){
        filtrowanaSzukajka = videos.filter {videos in //bierzemy wszystko co wyszukujemy do naszego arraya
            return videos.artystaV.lowercaseString.containsString(searchText.lowercaseString) //i zwracamy to co zawiera znaki jakie wpisaliśmy
        }
        tableView.reloadData() //i przeładuj
    }
}
