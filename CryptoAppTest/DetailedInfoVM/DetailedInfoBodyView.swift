//
//  DetailedInfoBodyView.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit

final class DetailedInfoBodyView: UIView {
    
    weak var viewModel: DetailedCoinInfoVM?
    
    var selected = 1
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 20
        stack.backgroundColor = .systemGray2
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        fillStackView()
        didSelectPeriod(newSelected: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fillStackView() {
        Periods.allCases.forEach { period in
            let btn = UIButton()
            btn.setTitle(period.rawValue, for: .normal)
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 20
            btn.addAction(UIAction{ [weak self] _ in
                guard let self else { return }
                guard let num = Periods.allCases.firstIndex(of: period) else {
                    return
                }
                if num == selected { return }
                self.viewModel?.updatePage(period: period)
                self.didSelectPeriod(newSelected: num)
            }, for: .touchUpInside)
            btn.backgroundColor = .systemGray2
            btn.setTitleColor(.gray, for: .normal)
            stackView.addArrangedSubview(btn)
        }
    }
    
    private func layout() {
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func didSelectPeriod(newSelected: Int) {
        guard
            let newBtn = stackView.arrangedSubviews[newSelected] as? UIButton ,
            let oldBtn = stackView.arrangedSubviews[selected] as? UIButton
        else { return }
        
        newBtn.backgroundColor = .white
        newBtn.setTitleColor(.black, for: .normal)
        
        
        oldBtn.backgroundColor = .systemGray2
        oldBtn.setTitleColor(.gray, for: .normal)
        
        selected = newSelected
    }
    
}
