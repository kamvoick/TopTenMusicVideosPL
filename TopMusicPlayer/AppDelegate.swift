//
//  AppDelegate.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 09.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

var reachability: Reachability?

var reachabilityStatus = ""
//globalne zmienne

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var połączenieInternetowe: Reachability?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        
        połączenieInternetowe = Reachability.reachabilityForInternetConnection()
        połączenieInternetowe?.startNotifier()
        //więc tak, najpierw dodajemy obserwatora który będzie sprawdzał nasze połączenie, najpierw dodajemy kreachabilitychangednotif a potem wykona się reachabilitychanged(niżej), a tutaj dodajemy metode działania i obserwatora dla polaczenie internetowego i musimy go również usunąć gdy wyłączymy apke na dole
        statusChangedWithReachability(połączenieInternetowe!) //chodzi o to że za pierwszym razem kiedy odpalamy apke status jest "" i on zapamiętuje to jako pierwsze więc nie dodaje faktu że połączenie zostało zmienione, więc musimy zainicjować pierwszą dostępność internetową a potem w vc wykonają się kolejne, będzie aktualizowało
        
        return true
    }
    
    func reachabilityChanged(notification: NSNotification){
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
        
    }
    
    func statusChangedWithReachability(currentReachabilityStatus: Reachability){
        
        let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        
        switch networkStatus.rawValue{
        case NotReachable.rawValue: reachabilityStatus = brakDostępuWifi
        case ReachableViaWiFi.rawValue: reachabilityStatus = wifiDziała
        case ReachableViaWWAN.rawValue: reachabilityStatus = WWAN
        default:return
        }
        //pokazujemy kiedy jest dostepne połączenie z internetem taki jest kodzik, rav value bo jak cmd zrobisz to mamy 3 wartości przypisujemy w cesach przypadki
        
        NSNotificationCenter.defaultCenter().postNotificationName("reachStatusChanged", object: nil)
        //wsadzamy powiadomienie które wykona kolejne działanie, czyli jeżeli zmieni się status sieci to zrób coś...
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
    }
}