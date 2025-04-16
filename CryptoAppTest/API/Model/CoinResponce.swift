//
//  CoinResponce.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 11.04.2025.
//

import Foundation

struct Response: Codable {
    let data: CoinResponce
}

struct CoinResponce: Codable {
    let name: String
    let symbol: String
    let marketData: MarketData
    let marketcap: Marketcap
    let roiData: [String: Double]
    let supply: Supply
    
    enum CodingKeys: String, CodingKey {
        case name, symbol
        case marketData = "market_data"
        case marketcap
        case roiData = "roi_data"
        case supply
    }
    
    
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast1_Hour: Double
    let percentChangeUsdLast24_Hours: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast1_Hour = "percent_change_usd_last_1_hour"
        case percentChangeUsdLast24_Hours = "percent_change_usd_last_24_hours"
    }
}

struct Marketcap: Codable {
    let currentMarketcapUsd: Double


    enum CodingKeys: String, CodingKey {
        case currentMarketcapUsd = "current_marketcap_usd"
    }
}

struct Supply: Codable {
    let circulating: Double

    enum CodingKeys: String, CodingKey {
        case circulating
    }
}

struct RoiData{
    let changeLastWeek: Double
    let changeLastMonth: Double
    let changeLast3Months: Double
    let changeLastYear: Double

    init(dictionary: [String: Double]) {
        let changeLastWeek = dictionary["percent_change_last_1_week"] ?? 0.0
        let changeLastMonth = dictionary["percent_change_last_1_month"] ?? 0.0
        let changeLast3Months = dictionary["percent_change_last_3_months"] ?? 0.0
        let changeLastYear = dictionary["percent_change_last_1_year"] ?? 0.0
        
        self.changeLastWeek = changeLastWeek
        self.changeLastMonth = changeLastMonth
        self.changeLast3Months = changeLast3Months
        self.changeLastYear = changeLastYear
    }
}
