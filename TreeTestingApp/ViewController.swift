//
//  ViewController.swift
//  TreeTestingApp
//
//  Created by Edward O'Neill on 10/30/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bst = AVLTree<Int>()
    var visualTree = UITextView()
    var instraction = UILabel()
    var usedNumber = UITextView()
    
    fileprivate func setupTextView() {
        
        visualTree.backgroundColor = UIColor(displayP3Red: 0.3, green: 0.5, blue: 0.9, alpha: 0.5)
        visualTree.textColor = .white
        
        //MARK: ToolBar Method
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(insertNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeNumberPad))]
        numberToolbar.sizeToFit()
        
        //MARK: Tree Layout initiolizer
        visualTree.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.addSubview(visualTree)
        visualTree.translatesAutoresizingMaskIntoConstraints = false

        [
            visualTree.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            visualTree.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualTree.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualTree.heightAnchor.constraint(equalToConstant: 300)
            ].forEach { $0.isActive = true }
        
        usedNumber.frame = CGRect(x: 0, y: 350, width: 400, height: 30)
        usedNumber.backgroundColor = .lightGray
        usedNumber.keyboardType = .numberPad
        usedNumber.inputAccessoryView = numberToolbar
        view.addSubview(usedNumber)
        usedNumber.translatesAutoresizingMaskIntoConstraints = false

    }
    
//    fileprivate func setupStackView() {
//        let stackView = UIStackView(arrangedSubviews: [visualTree, usedNumber])
//        stackView.axis = .vertical
//        stackView.spacing = 8
//        view.addSubview(stackView)
//
//        // enables auto layout
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomArr = (0..<10).map { _ in Int.random(in: 1...100)}
        
        for num in randomArr {
            bst.insert(num)
        }
        
        visualTree.text = "\(bst)"
        
        view.addSubview(instraction)
        
        instraction.text = "Please enter the number below"
        instraction.font = UIFont(name: "Helvetica", size: 18)
        instraction.numberOfLines = 0
        instraction.translatesAutoresizingMaskIntoConstraints = false
        instraction.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instraction.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        instraction.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        
        setupTextView()
    }
    
    // MARK: ToolBar Insert/Remove Method
    @objc func insertNumberPad() {
        guard let number = Int(usedNumber.text) else { return usedNumber.text = "" }
        bst.insert(number)
        visualTree.text = "\(bst)"
        usedNumber.text = ""
        usedNumber.resignFirstResponder()
    }
    
    @objc func removeNumberPad() {
        guard let number = Int(usedNumber.text) else { return usedNumber.text = "" }
        bst.remove(number)
        visualTree.text = "\(bst)"
        usedNumber.text = ""
        usedNumber.resignFirstResponder()
    }
    
}

