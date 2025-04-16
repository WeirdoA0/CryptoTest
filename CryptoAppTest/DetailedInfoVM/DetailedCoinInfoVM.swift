//
//  DetailedCoinInfoVM.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//
import Foundation

final class DetailedCoinInfoVM {
    
    let coin: CoinResponce
    
    let roiData: RoiData
    
    init(coin: CoinResponce) {
        self.coin = coin
        self.roiData = RoiData(dictionary: coin.roiData)
    }

    var growth: Double = 0.0
    
    var onChange: (() -> Void)? = {}
    
    func updatePage(period: Periods) {
        guard let onChange else { return }
        switch period {
        case .day:
            growth = coin.marketData.percentChangeUsdLast1_Hour
        case .week:
            growth = roiData.changeLastWeek
        case .month:
            growth = roiData.changeLastMonth
        case .months:
            growth = roiData.changeLast3Months
        case .year:
            growth = roiData.changeLastYear
        }
        DispatchQueue.main.async {
            onChange()
        }
    }
    
    func logout(){
        LoginManager.shared.unlog()
    }

}

enum Periods: String, CaseIterable {
    case day = "24H"
    case week = "1W"
    case month = "M"
    case months = "3M"
    case year = "Y"
}
