//
//  APIManager.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 09.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation

class APIManager {
    
    func zaladujDane(urlStr: String, completion: [MusicVideos] -> Void) {
        
        let konfiguracja = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let sesja = NSURLSession(configuration: konfiguracja) //bardzo ważna rzecz tutaj, jeżeli pobieramy jakiekowiek api w przypadku braku połączenia z internetem ponieważ na dysku zapisują się cookie (cashing) ciągle będziemy mieć te dane, a my chcemy w takim momencie wyświetlić użytkownikowi komunikat(err) że nie można pobrać bo nie ma dostępu do internetu
        
        let url = NSURL(string: urlStr)! //pobieramy nasz adres z parametru funkcji
        let zadanie = sesja.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
                if error != nil{
                    print(error!.localizedDescription) //czyli jeżeli jest błąd pokażemy jaki ! - bo błąd musi być
                }else{
                    
                    do{
                        //konwertujemy data do jsona, do try catch, zamieniamy na słownik
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray{
                            
                            var videos = [MusicVideos]()
                            for (index, entry) in entries.enumerate(){
                                let entry = MusicVideos(data: entry as! JSONDictionary)
                                entry.rankowanie = index + 1 //zawsze będzie dodawał +1, więc jak jest 0 będzie 1 ale musi być enumerate, robimy tutaj żeby móc w każdej chwili dodać kolejne dane do jsona
                                videos.append(entry)
                                //robimy loopa dla każdego elementu i wsadzamy do naszego arraya
                            }
                            
                            let ilePobranych = videos.count
                            print("liczba pobranych elementów: \(ilePobranych)\n")
                            
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0), {
                                dispatch_async(dispatch_get_main_queue(), {
                                    completion(videos)
                                    //więc jeżeli wszystko jest okej to powinno wyświetlić się powiodło, priority oznacza ważność - tutaj concurrency, współbierzność, chodzi o to że mamy dużo wątków i chcemy żeby nasze zadanie miało główny pierwszą ważność jeżeli mamy inne rzeczy działające w tle, 0 jest dla przyszłego wykorzystania
                                })
                            })
                            
                        }
                    }catch{
                        dispatch_async(dispatch_get_main_queue(), {
                            print("NSJSONSerializtion nie powiodło się")
                        })
                    }
                }
            }.resume()//zawsze musi być bo inaczej nie wykona, zadanie zaczyna się w "zawieszonym stanie" dopiero resume sprawia że się wykonuje
    }
}