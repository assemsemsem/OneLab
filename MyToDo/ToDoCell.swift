//
//  ToDoCell.swift
//  MyToDo
//
//  Created by Assem on 1/9/21.
//  Copyright © 2021 Assem. All rights reserved.
//
import SnapKit

final class ToDoCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let dueDate = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.font = .systemFont(ofSize: 15)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(dueDate)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
        }
        subtitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        dueDate.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(10)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}


    
