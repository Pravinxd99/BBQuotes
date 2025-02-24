//
//  Episode.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 18/08/24.
//

import Foundation

struct Episode : Decodable {
    
    let episode: Int
    let title : String
    let image : URL
    let synopsis : String
    let writtenBy : String
    let directedBy : String
    let airDate : String
    
    var seasonEpisode : String {
        
        var episodestring = String(episode) // "101
        let seasonstring  = episodestring.removeFirst() //episodestring = "01" seasonstring = "1
        
        
        if episodestring.first == "0" {
            episodestring = String(episodestring.removeLast())
        }
        else {
            episodestring = String(episodestring)
        }
            
       return "Season \(seasonstring) , Episode \(episodestring)"
    }
}
