//
//  EpisosdeView.swift
//  BBQuotes
//
//  Created by S, Praveen on 20/08/24.
//

import SwiftUI

struct EpisodeView: View {
    
    
    
    var episode : Episode
    var body: some View {
        
        VStack(alignment : .leading){
            
            Text(episode.title)
                .font(.title)
            Text(episode.seasonEpisode)
            
            AsyncImage(url: episode.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
                
            }placeholder: {
                ProgressView()
            }
            
            
            Text(episode.synopsis)
                .padding(.bottom)
                
            Text("Written by: \(episode.writtenBy)")
            Text("Directed by: \(episode.directedBy)")
            
            Text("Aired: \(episode.airDate)")
                }
        
       
        .padding()
        
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
         }
    }

#Preview {
    EpisodeView(episode: Viewmodel().episode)
}
