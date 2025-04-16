//
//  MainVC.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 09.04.2025.
//

import UIKit
import SnapKit

final class MainVC: UIViewController {
    
    private let viewModel = MainVM()
    
    //MARK: Subviews
    
    private lazy var activitiIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Home"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    
    private lazy var utilityButton: UIButton = {
        let btn = UIButton()
        btn.menu = buildMenu()
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = viewModel
        table.register(CoinCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        return table
    }()
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        tuneViews()
        setupVM()
        viewModel.load()
        showActivity()
    }
    
    //MARK: View Setup
    
    private func layout() {
        [titleLabel, utilityButton, tableView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(40)
        }
        
        utilityButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
        }
    }
    
    private func tuneViews() {
        view.backgroundColor = .systemGray4
        tableView.backgroundColor = .white
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20
        utilityButton.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
    }
    
    //MARK: Actions
    
    private func setupVM() {
        viewModel.onChange = { [weak self] in
            self?.tableView.reloadData()
            self?.hideActivity()
        }
    }
    
    private func buildMenu() -> UIMenu {
        
        let reloadAtcion = UIAction(
            title: "Update",
            image: UIImage(systemName: "arrow.counterclockwise.circle")) { [weak self] _ in
                DispatchQueue.main.async(execute: {
                    self?.showActivity()
                })
            self?.viewModel.load()
        }
        
        let logoutAtcion = UIAction(
            title: "Log out",
            image: UIImage(systemName: "return")) { [weak self] _ in
                self?.viewModel.logout()
                self?.navigationController?.setViewControllers([LoginVC()], animated: true)
        }
        
        return UIMenu(children: [reloadAtcion, logoutAtcion])
    }
    
    private func buildMenuForHeader() -> UIMenu {
        var actions = [UIAction]()
        SortingKey.allCases.forEach { sort in
            actions.append(UIAction(title: sort.rawValue) { [weak self] _ in
                
                self?.viewModel.selectSortMetod(sortingKey: sort)
            })
        }
        return UIMenu(children: actions)
    }
    
    private func showActivity() {
        view.addSubview(activitiIndicator)
        activitiIndicator.center = view.center
        activitiIndicator.startAnimating()
    }
    
    private func hideActivity() {
        activitiIndicator.stopAnimating()
        activitiIndicator.removeFromSuperview()
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeader()
        let menu = buildMenuForHeader()
        view.setupMenu(menu: menu)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CoinCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = DetailedCoinInfoVM(coin: viewModel.coins[indexPath.item])
        self.navigationController?.pushViewController(DetailedCoinVC(viewModel: vm), animated: true)
    }
}
