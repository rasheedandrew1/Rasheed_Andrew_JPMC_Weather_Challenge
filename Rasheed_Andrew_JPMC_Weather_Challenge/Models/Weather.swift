//
//  Weather.swift
//  Rasheed_Andrew_JPMC_Weather_Challenge
//
//  Created by rasheed andrew on 5/26/23.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
