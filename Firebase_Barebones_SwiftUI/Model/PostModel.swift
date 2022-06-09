//
//  PostModel.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import Foundation

class Post : Identifiable, ObservableObject {
    let id: String
    @Published var text: String
    let date: String
    
    init(id: String, text: String, date: String) {
        self.id = id
        self.text = text
        self.date = date
    }
}

// MARK: - BadWords Model

struct Badwords : Codable{
    var badwords: [String]
}
