//
//  TableViewHeader.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit
import SnapKit

final class TableViewHeader: UIView {
    
    private var menu: UIMenu?
    
    //MARK: Subviews
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Trending"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        
        return lbl
    }()
    
    private lazy var sortButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        btn.menu = menu
        btn.showsMenuAsPrimaryAction = true
        btn.imageView?.contentMode = .scaleToFill
        return btn
    }()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [label, sortButton].forEach{
            addSubview($0)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        
        sortButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
    }
    
    func setupMenu(menu: UIMenu){
        sortButton.menu = menu
    }
}
