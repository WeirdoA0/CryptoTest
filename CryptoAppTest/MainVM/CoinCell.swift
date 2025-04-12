//
//  CoinCell.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit
import SnapKit

final class CoinCell: UITableViewCell {
    
    //MARK: Constants
    
    static var height = nameHeight + tagHeight + nameToTagOffset + topToNameOffset + offsetToBottom
    
    private static let nameHeight = 20.0
    
    private static  let tagHeight = 10.0
    
    private static  let nameToTagOffset = 5.0
    
    private static  let topToNameOffset = 15.0
    
    private static  var offsetToBottom = 15.0
    
    //MARK: Subviews
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    private let tagLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = .gray
        return lbl
    }()
    
    private let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    private let percentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.textColor = .gray
        return lbl
    }()
    
    private let growIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        contentView.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Setup
    
    private func layout() {
        [nameLabel, tagLabel, priceLabel, growIcon, percentLabel].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CoinCell.topToNameOffset)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(CoinCell.nameHeight)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).offset(CoinCell.nameHeight + CoinCell.nameToTagOffset)
            make.height.equalTo(CoinCell.tagHeight)
            make.left.equalTo(nameLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(CoinCell.nameHeight)
            make.top.equalToSuperview().offset(CoinCell.topToNameOffset)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(CoinCell.tagHeight)
            make.top.equalTo(priceLabel).offset(CoinCell.nameHeight + CoinCell.nameToTagOffset)
        }
        
        growIcon.snp.makeConstraints { make in
            make.centerY.equalTo(percentLabel)
            make.right.equalTo(percentLabel.snp.left).offset(-5)
            make.height.width.equalTo(15)
        }
    }
    
    //MARK: Update

    private func updateIcon(grow: Double){
        if grow < 0 {
            growIcon.tintColor = .red
            growIcon.image = UIImage(systemName: "chevron.down")
        } else {
            growIcon.tintColor = .green
            growIcon.image = UIImage(systemName: "chevron.up")
        }
    }
    
    func update(coinData: CoinResponce) {
        self.nameLabel.text = coinData.name
        self.tagLabel.text = coinData.symbol
        self.priceLabel.text = coinData.marketData.priceUsd.formatted(.currency(code: "USD"))
        
        let percenetString = String(coinData.marketData.percentChangeUsdLast1_Hour).split(separator: ".")
        
        var text = "0.0"
        
        if percenetString.count == 2 {
            text = percenetString[0] + "." + String(percenetString[1].prefix(2))
        } else if percenetString.count == 1 {
            text = String(percenetString.first ?? "0")
        }
        
        text += "%"
        self.percentLabel.text = text
        
        updateIcon(grow: coinData.marketData.percentChangeUsdLast1_Hour)
    }

}
