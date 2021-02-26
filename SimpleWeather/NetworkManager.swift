//
//  NetworkManager.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/23/21.
//

import Foundation
import Apollo

final class NetworkManager {
    static let shared = NetworkManager()
    
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        
        // Cache
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent("simple_weather_db.sqlite")
        let cache = try! SQLiteNormalizedCache(fileURL: sqliteFileURL)
        
        let store = ApolloStore(cache: cache)
        let provider = LegacyInterceptorProvider(store: store)
        let url = URL(string: "https://graphql-weather-api.herokuapp.com/")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: transport, store: store)
    }()
}
