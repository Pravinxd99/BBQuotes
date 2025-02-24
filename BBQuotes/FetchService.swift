//
//  FetchService.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 27/07/24.
//

import Foundation

struct FetchService {
   private enum FetchError : Error{
        case badResponse
    }
    
   private let baseurl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(_from show : String) async throws -> Quote{
        
        
        //  build fetch url
        
        let quoteURL = baseurl.appending(path: "quotes/random")
        
        
        let fetchURL = quoteURL.appending(queryItems:[URLQueryItem(name: "production", value: show)] ) //production is just the name of the query
        
        
        // fetch data
        // its a tuple
        //Networking function are mostly asynchronous so be vary of using wait when running the function
        //(Async throws) , (try await ) type of sibling keywords
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        
        // decode data
        // decode is a function and you pass quote as the parameter and attach .self to represent the type of argument which a function expects
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        
        
        // return quote
        return quote
        
    }
    
    func fetchCharacter (_ name : String )async throws  -> Character {
        
        let characterURL = baseurl.appending(path: "characters")
        
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data,response ) = try await URLSession.shared.data (from: fetchURL)
        
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)// above there is just one quote but here there is a collection of characters
        //try typing walter in browser with the base url you'll get some error as of now but if you search walter+white you'll receive a collection of names walter white and walter junior so that's it
        // we know its only one but it's just how they've provide
        // check in fetch service we decode array of character byt in viewmodel we decode only character string bcz in sample data we have as expected but not in api
        
        return characters[0]
        
        }
    
    func fetchDeath(for character : String) async throws -> Death?
    {
        let fetchURL = baseurl.appending(path:"deaths")
        
        let (data,response ) = try await URLSession.shared.data (from: fetchURL)
        
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        
        for death in deaths{
            if death.character == character{
                return death
            }
        }
        return nil
    }
    
    func fetchEpisode(_from show : String) async throws -> Episode?{
        
        let EpisodeURL = baseurl.appending(path: "episodes")
        
        let fetchURL = EpisodeURL.appending(queryItems:[URLQueryItem(name: "production", value: show)] )
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episode = try decoder.decode([Episode].self, from: data)
        
        return episode.randomElement()
        
    }
   
    
}
