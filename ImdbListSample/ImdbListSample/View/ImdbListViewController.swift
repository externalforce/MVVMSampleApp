//
//  ImdbListViewController.swift
//  ImdbListSample
//
//  Created by Muhammet Gokhan Yavuz on 14.12.2021.
//

import UIKit
import SnapKit

protocol ImdbListOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Film])
}

final class ImdbListViewController: UIViewController {
    private let headerTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    private lazy var filmList: [Film] = []

    lazy var viewModel: ImdbListProtocol = ImdbListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure() {
        view.addSubview(headerTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        prepare()
        setupUI()
    }

    private func prepare() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImdbListTableViewCell.self, forCellReuseIdentifier: ImdbListTableViewCell.cellName)
        tableView.rowHeight = 150
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.headerTitle.font = .boldSystemFont(ofSize: 25)
            self.headerTitle.text = "Search Results"
            self.indicator.color = .blue
        }
        indicator.startAnimating()
    }

}

extension ImdbListViewController: ImdbListOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func saveDatas(values: [Film]) {
        filmList = values
        tableView.reloadData()
    }
}

extension ImdbListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ImdbListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImdbListTableViewCell.cellName) as? ImdbListTableViewCell else {
            return UITableViewCell()

        }
        cell.saveModel(model: filmList[indexPath.row])
        return cell

    }
}
extension ImdbListViewController {

    private func setupUI() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(headerTitle)
        }
        
        headerTitle.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        indicator.snp.makeConstraints { (make) in
            make.height.equalTo(headerTitle)
            make.right.equalTo(headerTitle).offset(-5)
            make.top.equalTo(headerTitle)
        }
    }
}
