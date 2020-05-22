# AVLTree

## Description

- This is a AVLTree visualization app for insertion and removal 

![Dec-24-2019 13-38-34](https://user-images.githubusercontent.com/42211866/71422798-c1463900-2652-11ea-882d-2b03f8c74b2a.gif)

## Challenges

- The most challenging part for this app was to create the rotation method for self balancing

```swift
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
```
## 1304. Find N Unique Integers Sum up to Zero

```swift
    func sumZero(_ n: Int) -> [Int] {
        guard n > 1 else { return [0]}
        var result: [Int] = []
        
        if n % 2 != 0 {
            result.append(0)
        }
        
        for num in 1...n/2 {
            result.append(num)
            result.append(-num)
        }
        
        return result 
    }
```
