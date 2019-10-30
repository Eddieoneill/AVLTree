//
//  Tree.swift
//  TreeTestingApp
//
//  Created by Edward O'Neill on 10/30/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import Foundation

class AVLNode<Element> {
    var value: Element
    var leftChild: AVLNode?
    var rightChild: AVLNode?
    var height = 0
    
    var balanceFacter: Int {
        return leftHeight - rightHeight
    }
    
    var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    
    var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    
    
    init(value: Element) {
        self.value = value
    }
}

extension AVLNode {
    var min: AVLNode {
        return leftChild?.min ?? self
    }
}

extension AVLNode: CustomStringConvertible {
    public var description: String {
        return diagram(for: self)
    }
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
+ root + "\(node.value)\n"
    + diagram(for: node.leftChild,
              bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

struct AVLTree<Element: Comparable> {
    var root: AVLNode<Element>?
}

extension AVLTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

extension AVLTree {
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    private func balance(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFacter {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFacter == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFacter == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}

extension AVLTree {
    mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return AVLNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        let balancedNode = balance(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLTree {
    mutating func remove(_ value: Element) {
        root = remove(from: root, value: value)
    }
    
    func remove(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
//        print("removing \(value) from node with value: \(node?.value)")
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(from: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(from: node.leftChild, value: value)
        } else {
            node.rightChild = remove(from: node.rightChild, value: value)
        }
        let balancedNode = balance(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLTree {
    func contains(_ value: Element) -> Bool {
        var current = root
        
        while let node = current {
            if value == node.value {
                return true
            } else if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}


