//
//  Movie.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    let name: String
    let rightsOwner: String
    let price: String
    let link: String
    let releaseDate: String
    let URLString: String
    init(json: JSON) {
        self.name = json["im:name"]["label"].stringValue
        self.rightsOwner = json["rights"]["label"].stringValue
        self.URLString = json["im:image"][2]["label"].stringValue
        self.price = json["im:rentalPrice"]["label"].stringValue
        self.link = json["link"][0]["attributes"]["href"].stringValue
        self.releaseDate = json["im:releaseDate"]["label"].stringValue
    }
}
