//
//  CreateEntryViewController.swift
//  Journal
//
//  Created by Iyin Raphael on 5/27/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    // MARK: - Properties
    var titleTextField: UITextField?
    var bodyTextView: UITextView?
    var segmentedControl: UISegmentedControl?
    var entryController: EntryController?
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        title = "Create Entry"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
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

    // MARK: - Actions
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        guard let title = titleTextField?.text, !title.isEmpty,
        let priorityIndex = segmentedControl?.selectedSegmentIndex else {return}
        let priority = Mood.allCases[priorityIndex]
        
        let entry = Entry(title: title, bodyText: bodyTextView?.text, mood: priority)
        
        entryController?.sendEntryToServer(entry: entry) { result in
            
            guard let _ = try? result.get() else { return}
            
            let context = CoreDataStack.shared.mainContext
            
            context.performAndWait {
                do {
                    try CoreDataStack.shared.mainContext.save()
                } catch {
                    NSLog("Unable to save Entry: \(error)")
                }
            }
            
        }
        dismiss(animated: true, completion: nil)
    }

}
