//
//  DetailedInfoPage.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit
import SnapKit

final class DetailedInfoPage: UIView {
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        lbl.text = "Market Statistic"
        return lbl
    }()
    
    private lazy var volumeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .gray
        lbl.text = "Market capitalization"
        return lbl
    }()
    
    private lazy var circularLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .gray
        lbl.text = "Circulation Suply"
        return lbl
    }()
    
    private lazy var capitalValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var circularValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        [titleLabel, volumeLabel, circularLabel, capitalValueLabel, circularValueLabel].forEach{
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(25)
        }
        volumeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        
        circularLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(volumeLabel.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        
        capitalValueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.height.equalTo(volumeLabel)
        }
        
        circularValueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.height.equalTo(circularLabel)
        }
    }
    
    func update(capitalization: Double, supply: Double, tag: String) {
        capitalValueLabel.text = capitalization.formatted(.currency(code: "USD"))
        circularValueLabel.text = String(supply) + " " + tag
    }
}
