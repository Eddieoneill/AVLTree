//
//  ViewController.swift
//  TreeTestingApp
//
//  Created by Edward O'Neill on 10/30/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visualTree: UITextView!
    @IBOutlet weak var usedNumber: UITextView!
    var bst = AVLTree<Int>()
    override func viewDidLoad() {
        super.viewDidLoad()

        for num in 0..<5 {
            bst.insert(num)
        }
        visualTree.text = "\(bst)"
        visualTree.textColor = .white
    }
    @IBAction func treeInsertion(_ sender: UIButton) {
        guard let number = Int(usedNumber.text) else { return usedNumber.text = "" }
        bst.insert(number)
        visualTree.text = "\(bst)"
        usedNumber.text = ""
    }
    @IBAction func treeRemoval(_ sender: UIButton) {
        guard let number = Int(usedNumber.text) else { return usedNumber.text = "" }
        bst.remove(number)
        visualTree.text = "\(bst)"
        usedNumber.text = ""
    }
    

}

