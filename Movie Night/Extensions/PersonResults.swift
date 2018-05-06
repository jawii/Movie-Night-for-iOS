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
        return lhs.name == lhs.name && lhs.id == lhs.id && lhs.popularity == rhs.popularity
    }
}
