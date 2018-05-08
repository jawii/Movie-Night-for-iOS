//
//  PersonResults.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 06/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import TMDBSwift

extension PersonResults: Equatable {
    public static func == (lhs: PersonResults, rhs: PersonResults) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.popularity == rhs.popularity
    }
}

extension GenresMDB: Equatable {
    public static func == (lhs: GenresMDB, rhs: GenresMDB) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
}

extension KnownForMovie: Equatable {
    public static func == (lhs: KnownForMovie, rhs: KnownForMovie) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
extension KnownForMovie: Hashable {
    public var hashValue: Int {
        return self.id
    }
}

