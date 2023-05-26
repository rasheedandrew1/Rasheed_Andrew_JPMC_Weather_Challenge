//
//  weatherViewModel.swift
//  Rasheed_Andrew_JPMC_Weather_Challenge
//
//  Created by rasheed andrew on 5/26/23.
//

import Foundation


class weatherViewModel : ObservableObject {
    
   @Published var cityName: String = ""
    @Published var weatherData: WeatherData?
    @Published var isLoading: Bool = false
    
    
    
    func searchWeather() {
        guard !cityName.isEmpty else { return }
        
        isLoading = true
        
        let urlString = "\(Constants.apiURL)?q=\(cityName)&appid=\(Constants.apiKey)"
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                self.isLoading = false
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherData = decodedData
                    self.isLoading = false
                    
                    // Cache the last searched city
                    UserDefaults.standard.set(self.cityName, forKey: "lastSearchedCity")
                }
            } else {
                self.isLoading = false
            }
        }
        .resume()
    }
    
    
    
    func getWeatherIconName(iconCode: String?) -> String {
        guard let iconCode = iconCode else {
            return "questionmark"
        }
        
        switch iconCode {
        case "01d", "01n":
            return "sun.max.fill"
        case "02d", "02n":
            return "cloud.sun.fill"
        case "03d", "03n":
            return "cloud.fill"
        case "04d", "04n":
            return "cloud"
        case "09d", "09n":
            return "cloud.heavyrain.fill"
        case "10d", "10n":
            return "cloud.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.rain.fill"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return "questionmark"
        }
    }
    
    
    
    
}
