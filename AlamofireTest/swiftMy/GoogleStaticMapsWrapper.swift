//
//  GoogleStaticMapsWrapper.swift
//  AlamofireTest
//
//  Created by zdaecqze zdaecq on 10.06.16.
//  Copyright © 2016 zdaecqze zdaecq. All rights reserved.
//

import UIKit

enum GoogleMapsScale : String {
    case one = "1"
    case two = "2"
}

enum GoogleMapsType : String {
    case Roadmap    = "roadmap"
    case Satellite  = "satellite"
    case Hybrid     = "hybrid"
    case Terrain    = "terrain"
}

enum GoogleMapsImageFormat : String {
    case png = "png"
    case gif = "gif"
    case jpg = "jpg"
}

class GoogleStaticMapsWrapper {
    
    //private let baseURL = "https://maps.google.com/maps/api/staticmap?center="
    private let baseURL = "https://maps.googleapis.com/maps/api/staticmap?center="
    
    var place : String
    var width : Int
    var height : Int
    var zoom : Int
    
    var setMarker = true
    var mapType = GoogleMapsType.Roadmap
    var imageFormat = GoogleMapsImageFormat.png
    var imageScale = GoogleMapsScale.one
    
    var markerIconURL : String?
    var language = "en"
    
    private let AND = "%7C"
    
    
    init(place: String, width: Int, height: Int, zoom: Int) {
        self.place = place
        self.width = width
        self.height = height
        self.zoom = zoom
    }
    
    //private var allowedPlace : String {
        //return place.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    //}
    
    //private var zoomString : String {
        //return "&zoom=" + String(zoom)
    //}
    
    //private var sizeString : String {
        //return "&size=\(width)x\(height)"
    //}
    
    var image : UIImage {
        
        let zoomString          = "&zoom=" + String(zoom)
        let mapTypeString       = "&maptype=" + mapType.rawValue
        let imageFormatString   = "&format=" + imageFormat.rawValue
        let imageScaleString    = "&scale=" + imageScale.rawValue
        let languageString      = "&language=" + language
        var sizeString          = "&size=\(width)x\(height)"
        //&visual_refresh=true
        
        if imageScale == .two {
            sizeString          = "&size=\(width/2)x\(height/2)"
        }
        
        let allowedPlace = place.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        //----------------------------------
        var urlString = baseURL + allowedPlace + zoomString + sizeString + mapTypeString + imageFormatString + imageScaleString + languageString
        //----------------------------------
        
        if setMarker {
            var marker = "&markers="
            
            if let markerURL = markerIconURL {
                let markerURLAllowed = markerURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                marker += "icon:\(markerURLAllowed)%7C"
            }
            
            marker += allowedPlace
            urlString += marker
        }
        
        let url = NSURL(string: urlString)
        return UIImage(data: NSData(contentsOfURL: url!)!)!
    }
    
    
    func getImage() -> UIImage {
        return image
    }

}