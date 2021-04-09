//
//  FavouriteLeagues.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/29/21.
//

import Foundation

struct FavoriteLeague {
    var id: String?
    var name: String?
    var image: String?
    var youtubeUrl: String?
    
    init(id: String, name: String, image: String, youtubeUrl: String) {
        self.id = id
        self.name = name
        self.image = image
        self.youtubeUrl = youtubeUrl
    }
}
/*
struct FavoriteLeague {
    var id: String?
    var name: String?
    var youtubeURL: String?
}
*/
