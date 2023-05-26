//
//  WeatherData.swift
//  Rasheed_Andrew_JPMC_Weather_Challenge
//
//  Created by rasheed andrew on 5/26/23.
//

import Foundation

struct WeatherData: Codable {
    // Define the weather data model based on the API response
    let name: String
    let main: Main
    let weather: [Weather]
}
