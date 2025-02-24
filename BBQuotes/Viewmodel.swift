//
//  Viewmodel.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 27/07/24.
//

import Foundation

@Observable

class Viewmodel {
    
    enum Fetchstatus {
        
        case notStarted
        
        case fetching
        
        case Quoteviewsuccess
        
        case Episodeviewsuccess
        
        case failed (error : Error)
    }
    
    private(set) var status : Fetchstatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote : Quote
    
    var episode : Episode
    
    var character : Character
    
 init(){
        
       
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        
        quote = try! decoder.decode(Quote.self, from : quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        
         character = try! decoder.decode(Character.self, from : characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        
        episode = try! decoder.decode(Episode.self, from : episodeData)
        
        
        
    }
    
    func getQuoteData( for show : String) async {
        status = .fetching
        
        do {
            
            quote = try await fetcher.fetchQuote(_from: show)
            
            character = try await fetcher.fetchCharacter(quote.character)
             
            character.death = try await fetcher.fetchDeath(for :character.name)
            
            status = .Quoteviewsuccess
        }
        catch{
            
            status = .failed(error: error)
        }
    }
    
    func getEpisodeData( for show : String) async {
        
        status = .fetching
        
        do{
             if let unwrappedEpisode = try await fetcher.fetchEpisode(_from: show){
                
                episode = unwrappedEpisode
                
                status = .Episodeviewsuccess
            }
        }
            catch{
                
                status = .failed(error: error)
            }
            
            
        }
    }


