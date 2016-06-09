//
//  APIManager.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 15.05.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation

class APIManager {
    
    func zaladujDane(urlStr: String, completion: (result: String) -> Void) {
        
        let konfiguracja = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let sesja = NSURLSession(configuration: konfiguracja) //bardzo ważna rzecz tutaj, jeżeli pobieramy jakiekowiek api w przypadku braku połączenia z internetem ponieważ na dysku zapisują się cookie (cashing) ciągle będziemy mieć te dane, a my chcemy w takim momencie wyświetlić użytkownikowi komunikat(err) że nie można pobrać bo nie ma dostępu do internetu
        
        let url = NSURL(string: urlStr)! //pobieramy nasz adres z parametru funkcji
        let zadanie = sesja.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            dispatch_async(dispatch_get_main_queue(), { //dispach czyli wrzucamy do głównego wątku
                if error != nil{
                    completion(result: error!.localizedDescription) //czyli jeżeli jest błąd pokażemy jaki ! - bo błąd musi być
                }else{
                    completion(result: "NSRULsession powiodło się")
                    print(data) //jeżeli nie ma błędów to pokazujemy dane
                }
            })
            
            
            
            
            
        }.resume()//zawsze musi być bo inaczej nie wykona, zadanie zaczyna się w "zawieszonym stanie" dopiero resume sprawia że się wykonuje
        
        
    
}
}