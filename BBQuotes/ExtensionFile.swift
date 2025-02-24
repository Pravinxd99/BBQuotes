//
//  ExtensionFile.swift
//  BBQuotes
//
//  Created by S, Praveen (Cognizant) on 18/08/24.
//

import Foundation

extension String{
    
    
    func removespaces() -> String{
        self.replacingOccurrences(of: " ", with: "")
    }
    
    
    func removecaseandspace() -> String{
        self.removespaces().lowercased()
    }
}
