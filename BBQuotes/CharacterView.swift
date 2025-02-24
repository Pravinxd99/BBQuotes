//
//  CharacterView.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 03/08/24.
//

import SwiftUI

struct CharacterView: View {
    var character : Character
    var show : String
    var body: some View {
        
        GeometryReader{ geo in
            
            ScrollViewReader{ proxy in
                ZStack(alignment: .top) {
                    
                    
                    
                    Image(show.removecaseandspace())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView{
                        
                        TabView{
                            ForEach (character.images , id: \.self){ characterURL in
                                
                                
                                
                                
                                AsyncImage(url: characterURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(.rect(cornerRadius: 15))
                                    
                                }placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2,height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top,60)
                        
                        VStack(alignment:.leading){
                            
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed by \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name)  Character Info ")
                                .font(.title2)
                            
                            Divider()
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            
                            ForEach(character.occupations,  id: \.self) { occupation in
                                
                                Text("•\(occupation)")
                            }
                            
                            Divider()
                            
                            Text("Nicknames:")
                            
                            if character.aliases.count>0
                            {
                                
                                ForEach(character.aliases,  id: \.self) { aliases in
                                    
                                    Text("•\(aliases)")
                                        .font(.subheadline)
                                }
                            }
                            else
                            {
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (spoiler alert)"){
                                
                                VStack(alignment: .leading){
                                    
                                    
                                    Text(character.status)
                                        .font(.title2)
                                    print(character.name)
                                    
                                    
                                    if let death = character.death{
                                        
                                        
                                        
                                        AsyncImage(url: death.image) { image in
                                            image
                                            
                                            
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 25))
                                            
                                                .onAppear{
                                                    withAnimation{
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                        
                                                    }
                                                }
                                            
                                        }placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("Death details : \(death.details)")
                                            .padding(.bottom,7)
                                        
                                        Text("Lastwords : \(death.lastWords)")
                                    }
                                    
                                    
                                }
                                .frame(maxWidth: .infinity , alignment : .leading)
                            }
                            .tint(.primary)
                            
                            
                            
                        }
                        
                        .frame(width: geo.size.width/1.25,alignment: .leading)
                        .padding(.bottom, 50)
                        
                        .id(1)
                        
                    }
                    .scrollIndicators(.hidden)
                    
                }
                
                
                
                
                
                
                
                
            }
        }
        
        .ignoresSafeArea()
        
    }
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

#Preview {
    CharacterView(character: Viewmodel().character,show: Constants.bbname)
}
