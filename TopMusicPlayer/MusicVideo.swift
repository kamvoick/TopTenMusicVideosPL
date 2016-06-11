//
//  MusicVideo.swift
//  TopMusicPlayer
//
//  Created by Kamil Wójcik on 10.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation

class MusicVideos {
    
    var rankowanie = 0 //ponieważ mamy 0-based liczenie -> przejdz do jsona
    
    private var _nazwaV: String
    private var _prawaV: String
    private var _cenaV: String
    private var _urlObrazV: String
    private var _artystaV: String
    private var _urlVideoV: String
    private var _imIdV: String
    private var _rodzajV: String
    private var _linkDoItunesV: String
    private var _dataWydaniaV: String
    
    var daneObrazka: NSData?
    
    var nazwaV: String{
        return _nazwaV
    }
    var urlObrazV: String{
        return _urlObrazV
    }
    var urlVideoV: String{
        return _urlVideoV
    }
    var prawaV: String{
        return _prawaV
    }
    var cenaV: String{
        return _cenaV
    }
    var artystaV: String{
        return _artystaV
    }
    var imIdV: String{
        return _imIdV
    }
    var rodzajV: String{
        return _rodzajV
    }
    var linkDoItunesV: String{
        return _linkDoItunesV
    }
    var dataWydaniaV: String{
        return _dataWydaniaV
    }
    
    init(data: JSONDictionary){
        if let nazwa = data["im:name"] as? JSONDictionary,
            nazwaV = nazwa["label"] as? String {
            self._nazwaV = nazwaV
        }else{
            self._nazwaV = "" //w każdym przypadku nie musimy robić else bo itunes raczej nie zmieni nazw ale dla bezpieczeństwa możemy wyzerować w przypadku gdyby tak się stało
        }
        
        if let obraz = data["im:image"] as? JSONArray,
            obrazV = obraz[2] as? JSONDictionary,
            obrazVV = obrazV["label"] as? String{
            self._urlObrazV = obrazVV.stringByReplacingOccurrencesOfString("100x100", withString: "300x300") //możemy zrobić taki trik że zamienimy rozdzielczość, itunes akurat ma taką opcje że niezaleznie co wsadzimy będzie w dobrej rozdzielczości
        }else{
            self._urlObrazV = "" //podobnie jak wyżej
        }
        
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String{
            self._urlVideoV = vVideoUrl
        }else{
            _urlVideoV = "" //jak wyżej
        }
        
        if let prawa = data["rights"] as? JSONDictionary,
            prawaV = prawa["label"] as? String{
            self._prawaV = prawaV
        }else{
            self._prawaV = ""
        }
        
        if let cena = data["im:price"] as? JSONDictionary,
            cenaV = cena["label"] as? String{
            self._cenaV = cenaV
        }else{
            self._cenaV = ""
        }
        
        if let artysta = data["im:artist"] as? JSONDictionary,
            artystaV = artysta["label"] as? String{
            self._artystaV = artystaV
        }else{
            self._artystaV = ""
        }
        
        if let imId = data["id"] as? JSONDictionary,
            imIdV = imId["attributes"] as? JSONDictionary,
            imIdVV = imIdV["im:id"] as? String{
            self._imIdV = imIdVV
        }else{
            self._imIdV = ""
        }
        
        if let rodzaj = data["category"] as? JSONDictionary,
            rodzajV = rodzaj["attributes"] as? JSONDictionary,
        rodzajVV = rodzajV["term"] as? String{
            self._rodzajV = rodzajVV
        }else{
            self._rodzajV = ""
        }
        
        if let linkDoItunes = data["link"] as? JSONArray,
            vUrl = linkDoItunes[0] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String{
            self._linkDoItunesV = vVideoUrl
        }else{
            _linkDoItunesV = "" //jak wyżej
        }
        
        if let dataWydania = data["im:releaseDate"] as? JSONDictionary,
            dataWydaniaV = dataWydania["attributes"] as? JSONDictionary,
        dataWydaniaVV = dataWydaniaV["label"] as? String{
            self._dataWydaniaV = dataWydaniaVV
        }else{
            self._dataWydaniaV = ""
        }

    }
}
