//
//  QuoteView.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 28/07/24.
//

import SwiftUI

struct FetchData: View {
    
    let vm = Viewmodel()
    let show : String
    @State var showcharacterview : Bool =  false
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                
                Image(show.removecaseandspace())
                    .resizable()
                
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .Quoteviewsuccess:
                            
                            
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            
                            
                            ZStack(alignment:.bottom){
                                
                                
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                                
                                Text(vm.character.name)
                                    .frame(width: .infinity)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                
                                
                                
                                
                            }
                            
                            .onTapGesture {
                                showcharacterview.toggle()
                            }
                            
                            .sheet(isPresented: $showcharacterview){
                                
                                CharacterView(character: vm.character, show: show )
                            }
                            .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            
                            
                        case .Episodeviewsuccess:
                            
                            EpisodeView(episode: vm.episode)
                            
                           
                            
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                            
                            
                            
                            
                            Spacer()
                        }
                        
                        
                        HStack{
                            Button{
                                Task{
                                    await vm.getQuoteData(for: show)
                                    
                                }
                            }
                        label:{
                            
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("\(show.removespaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color:Color("\(show.removespaces())Shadow"), radius: 2)
                        }
                            
                        .padding(.trailing)
                            Button{
                                Task{
                                    await vm.getEpisodeData(for: show)
                                    
                                }
                            }
                        label:{
                            
                            Text("Get Random Episode")
                            
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("\(show.removespaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color:Color("\(show.removespaces())Shadow"), radius: 2)
                        }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 95)
                            
                    
                }
               
                
                .frame(width: geo.size.width,height: geo.size.height)
            }
                
                .frame(width: geo.size.width,height: geo.size.height)
                
                
                
            }
            .ignoresSafeArea()
            
        }
    }

#Preview {
    FetchData(show: Constants.bbname)
        .preferredColorScheme(.dark)
}
