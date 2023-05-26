//
//  MainView.swift
//  Rasheed_Andrew_JPMC_Weather_Challenge
//
//  Created by rasheed andrew on 5/26/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = weatherViewModel()
  //  @State private var isLoading: Bool = false
    var body: some View {
        VStack {
        searchFieldAndButtonRow
        contentView
            Spacer()
        }
        .padding()
        .onAppear {
            // Auto-load the last city searched upon app launch
            if let lastSearchedCity = UserDefaults.standard.string(forKey: "lastSearchedCity") {
                viewModel.cityName = lastSearchedCity
                viewModel.searchWeather()
            }
        }
    }
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    
    private var searchField : some View {
        TextField("Enter city name", text: $viewModel.cityName)
            .padding(.horizontal, 5)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
    private var searchButton : some View {
        Image(systemName: "paperplane.fill")
            .onTapGesture {
                print("tapped")
                viewModel.searchWeather()
            }
        
    }
    private var searchFieldAndButtonRow : some View {
        HStack {
            searchField
            searchButton
        }
        .padding()
     }
    private var contentView : some View {
        Group {
            if  viewModel.isLoading {
                loadingView
            } else {
                VStack {
                    cityNameText
                    weatherIcon
                    temperature
                    tempDescription
                }
            }
            }
        }
    
    private var loadingView : some View {
        ProgressView()
            .padding()
        }
    private var cityNameText : some View {
        Group{
            if let data =  viewModel.weatherData {
                Text(data.name)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
    private var weatherIcon : some View {
        Group{
            if let data =  viewModel.weatherData {
                Image(systemName:  viewModel.getWeatherIconName(iconCode: data.weather.first?.icon))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
     }
    private var temperature : some View {
        Group{
            if let data =  viewModel.weatherData {
                Text("\(data.main.temp) °F")
                    .font(.system(size: 20))
                    .padding()
            }
        }
     }
    private var tempDescription : some View {
        Group{
            if let data =  viewModel.weatherData {
                Text(data.weather.first?.description ?? "")
                    .font(.subheadline)
                    .padding()
          }
        }
     }
    
}
