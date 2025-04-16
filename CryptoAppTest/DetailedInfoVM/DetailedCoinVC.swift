//
//  DetailedCoinVC.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit
import SnapKit

final class DetailedCoinVC: UIViewController {
    
    private var viewModel: DetailedCoinInfoVM
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.text = viewModel.coin.name + " (\(viewModel.coin.symbol))"
        return lbl
    }()
    
    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .black
        lbl.text = viewModel.coin.marketData.priceUsd.formatted(.currency(code: "USD"))
        return lbl
    }()
    
    private lazy var growthLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var growIcon = UIImageView()
    
    private lazy var selector = DetailedInfoBodyView()
    
    private lazy var infoPage = DetailedInfoPage()
    
    private lazy var logoutButton: UIButton = {
        let btn = UIButton()
        
        btn.addAction(UIAction { [weak self] _ in
            self?.viewModel.logout()
            self?.navigationController?.setViewControllers([LoginVC()], animated: true)
        }, for: .touchUpInside)
        
        btn.setTitle("Logout", for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitleColor(.red, for: .normal)
        
        return btn
    }()
    
    init(viewModel: DetailedCoinInfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        tuneView()
        setupVM()
        selector.viewModel = viewModel
        (viewModel.onChange ?? { })()
        updatePage()
        
    }
    
    private func layout() {
        [nameLabel, priceLabel, growthLabel, growIcon, selector, infoPage, logoutButton].forEach {
            view.addSubview($0)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(25)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        growthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        growIcon.snp.makeConstraints { make in
            make.centerY.equalTo(growthLabel)
            make.right.equalTo(growthLabel.snp.left).offset(-5)
            make.height.equalTo(20)
        }
        
        selector.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(growthLabel.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        infoPage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
        logoutButton.snp.makeConstraints{ make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
    }
    
    private func tuneView() {
        infoPage.backgroundColor = .white
        view.backgroundColor = .systemGray4
        infoPage.clipsToBounds = true
        infoPage.layer.cornerRadius = 30
    }
    
    private func updatePage(){
        let supply: Double = viewModel.coin.supply.circulating
        infoPage.update(capitalization: viewModel.coin.marketcap.currentMarketcapUsd, supply: supply, tag: viewModel.coin.symbol)
    }
    
    private func updateIcon(grow: Double){
        if grow < 0 {
            growIcon.tintColor = .red
            growIcon.image = UIImage(systemName: "chevron.down")
        } else {
            growIcon.tintColor = .green
            growIcon.image = UIImage(systemName: "chevron.up")
        }
    }
    
    private func setupVM() {
        viewModel.onChange = { [weak self] in
            guard let self else { return }
            let percenetString = String(viewModel.growth).split(separator: ".")
            
            var text = "0.0"
            
            if percenetString.count == 2 {
                text = percenetString[0] + "." + String(percenetString[1].prefix(2))
            } else if percenetString.count == 1 {
                text = String(percenetString.first ?? "0")
            }
            growthLabel.text = text
            
            updateIcon(grow: viewModel.growth)
        }
    }
}
