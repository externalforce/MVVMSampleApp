//
//  ImdbListTableViewCell.swift
//  ImdbListSample
//
//  Created by Muhammet Gokhan Yavuz on 14.12.2021.
//

import UIKit
import AlamofireImage

class ImdbListTableViewCell: UITableViewCell {
    
    private let poster: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let year: UILabel = UILabel()
    private let type: UILabel = UILabel()
    
    static let cellName: String = "ImdbListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(poster)
        addSubview(title)
        addSubview(year)
        addSubview(type)
        self.selectionStyle = .none
        title.font = .boldSystemFont(ofSize: 18)
        title.numberOfLines = 2
        year.font = .systemFont(ofSize: 12)
        type.font = .systemFont(ofSize: 12)
        
        poster.snp.makeConstraints { (make) in
            make.height.equalTo(130)
            make.width.equalTo(100)
            make.top.equalTo(contentView).offset(10)
            make.left.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(poster.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(poster.snp.top)
        }

        year.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.right.left.equalTo(title)
        }
        
        type.snp.makeConstraints { (make) in
            make.top.equalTo(year.snp.bottom).offset(5)
            make.right.left.equalTo(title)
        }
    }
    
    func saveModel(model: Film) {
        title.text = model.title
        year.text = model.year
        poster.af.setImage(withURL: URL(string: model.poster)!)
        type.text = model.type
    }    
}
