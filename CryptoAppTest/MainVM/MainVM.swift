//
//  MainVM.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit

final class MainVM: NSObject {
    
    var coins = [CoinResponce]()
    
    private var apiClass = APIClass()
    
    private var selectedSortMethod: SortingKey = .price
    
    var onChange: (() ->Void)? = {}
    
    /// Функция загрузки данных о монетах
    func load() {
        apiClass.loadAll{ [weak self] coins in
            guard
                let self,
                let onChange
            else {
                return }
            DispatchQueue.main.async(execute: {
                self.coins = coins
                self.sort()
                onChange()
            })
        }
    }
    
    /// Функция сортировки
    private func sort() {
        guard let onChange else  {return }
        switch selectedSortMethod {
        case .price:
            coins.sort(by: {
                $0.marketData.priceUsd > $1.marketData.priceUsd
            })
        case .growthToday:
            coins.sort(by: {
                $0.marketData.percentChangeUsdLast1_Hour > $1.marketData.percentChangeUsdLast1_Hour
            })
        case .fallToday:
            coins.sort(by: {
                $0.marketData.percentChangeUsdLast1_Hour < $1.marketData.percentChangeUsdLast1_Hour
            })
        }
        DispatchQueue.main.async {
            onChange()
        }
    }
    
    /// Выбор способа сортировки
    func selectSortMetod(sortingKey: SortingKey) {
        selectedSortMethod = sortingKey
        sort()
    }

    func logout(){
        LoginManager.shared.unlog()
    }
}

extension MainVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CoinCell else {
            fatalError()
        }
        cell.update(coinData: coins[indexPath.item])
        return cell
    }
}

enum SortingKey: String, CaseIterable {
    case price = "Цена"
    case growthToday = "Рост сегодня"
    case fallToday = "Падение сегодня"
}
