//
//  ContentView.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 25/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            
            
            
            FetchData(show:"Breaking Bad")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            FetchData(show: Constants.bcsname)
            
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsname ,systemImage: "briefcase")
                }
                    
            FetchData(show: Constants.ecname)
                    
                        .toolbarBackground(.visible, for: .tabBar)
                        .tabItem {
                            Label(Constants.ecname ,systemImage: "car")
                        }
                }
                .preferredColorScheme(.dark)
        }
        
    }

#Preview {
    ContentView()
}
