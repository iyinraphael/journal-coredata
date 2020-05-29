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
    var entry: Entry?{
        didSet{
            updateView()
        }
    }
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpviews()
    }
    
    static let reusIdentifier = "cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Update
    
    private func setUpviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        
        let stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = false
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
        bodyTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            bodyTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            bodyTextView.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
        
        
    }
    
    private func updateView() {
        guard let entry = entry else {return}
        
        let df = DateFormatter()
        df.dateStyle = .full

        
        titleLabel.text = entry.title
        timestampLabel.text = df.string(from: entry.timestamp ?? Date())
        bodyTextView.text = entry.bodyText
        
    }
    
    
}
