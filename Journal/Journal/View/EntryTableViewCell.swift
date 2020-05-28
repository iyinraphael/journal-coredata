//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Iyin Raphael on 5/27/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: - Properties
    let titleLabel = UILabel()
    let timestampLabel = UILabel()
    let bodyTextView = UITextView()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Update
    
    private func setUpviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        self.addSubview(stackView)
        
        let stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = true
        stackView2.axis = .horizontal
        stackView2.alignment = .fill
        stackView2.distribution = .fillProportionally
        stackView.addArrangedSubview(stackView2)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        stackView2.addArrangedSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.font = .systemFont(ofSize: 14)
        timestampLabel.setContentHuggingPriority(.init(rawValue: 1000.0), for: .horizontal)
        stackView2.addArrangedSubview(timestampLabel)
        
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.font = .systemFont(ofSize: 16)
        bodyTextView.setContentHuggingPriority(.init(rawValue: 249.0), for: .vertical)
        stackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
    }
    
    
}
