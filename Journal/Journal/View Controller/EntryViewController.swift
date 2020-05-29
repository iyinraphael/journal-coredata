//
//  EntryViewController.swift
//  Journal
//
//  Created by Iyin Raphael on 5/29/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    // MARK: - Properties
    var titleTextField: UITextField?
    var bodyTextView: UITextView?
    var segmentedControl: UISegmentedControl?
    var entry: Entry?
    var wasEdited: Bool? = false
       
       // MARK: - View
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
            setUpView()
            updateView()
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if wasEdited == true {

        }
    }
    private func setUpView() {
        view.backgroundColor = .white
        title = "Entry Details"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditing))
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15.0
        view.addSubview(stackView)
        
        let titleTextField = UITextField()
        titleTextField.borderStyle = .none
        titleTextField.translatesAutoresizingMaskIntoConstraints = true
        titleTextField.font = .systemFont(ofSize: 17)
        titleTextField.placeholder = "Jorunal Entry Title"
        stackView.addArrangedSubview(titleTextField)
        self.titleTextField = titleTextField
        
        let stackView3 = UIStackView()
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.axis = .vertical
        stackView3.alignment = .fill
        stackView3.distribution = .fill
        stackView3.spacing = 2.0
        stackView.addArrangedSubview(stackView3)
        
        let labelPriority = UILabel()
        labelPriority.translatesAutoresizingMaskIntoConstraints = false
        labelPriority.text = "Priority"
        stackView3.addArrangedSubview(labelPriority)
        
        let segmentedControl = UISegmentedControl(items: [Mood.normal.rawValue, Mood.sad.rawValue, Mood.happy.rawValue])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        stackView3.addArrangedSubview(segmentedControl)
        self.segmentedControl = segmentedControl
        
        let stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.axis = .vertical
        stackView2.alignment = .fill
        stackView2.distribution = .fill
        stackView2.spacing = 8.0
        stackView.addArrangedSubview(stackView2)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Entry"
        stackView2.addArrangedSubview(label)
        
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = .gray
        stackView2.addArrangedSubview(bView)
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.backgroundColor = .systemGray6
        textView.font = .systemFont(ofSize: 14)
        stackView2.addArrangedSubview(textView)
        self.bodyTextView = textView
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            bView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        
        
    }
    
        
    private func updateView() {
        guard let entry = entry else {return}
        
        titleTextField?.text = entry.title
        bodyTextView?.text = entry.bodyText
        segmentedControl?.isUserInteractionEnabled = isEditing
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing == true {
            wasEdited = true
            
            titleTextField?.isUserInteractionEnabled = editing
            bodyTextView?.isUserInteractionEnabled = editing
            segmentedControl?.isUserInteractionEnabled = editing
            navigationItem.hidesBackButton = editing
        }
    }

}
