//
//  ModelManagger.swift
//  EditTableViewSample
//
//  Created by maru on 2017/12/01.
//  Copyright © 2017年 mbyk. All rights reserved.
//

import UIKit

struct InfoItem {
    var name: String
}

protocol EditItemProvider: class {
    associatedtype Item
    var items: [Item] { get set}
    
    func addItem(item: Item)
    func insertItem(item: Item,  atIndex index: Int)
    func removeItemAtIndex(_ index: Int)
    func moveItemAtIndex(fromIndex: Int, toIndex: Int)
    func removeAllItmes()
}

extension EditItemProvider {
    
    func addItem(item: Item) {
        items.append(item)
    }
    
    func insertItem(item: Item,  atIndex index: Int) {
        guard index >= 0 && index <= items.count else { return }
        items.insert(item, at: index)
    }
    
    func removeItemAtIndex(_ index: Int) {
        guard index >= 0 && index < items.count else { return }
        items.remove(at: index)
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        guard fromIndex >= 0 && fromIndex < items.count else { return }
        guard toIndex >= 0 && toIndex <= items.count else { return }
        
        let item = items[fromIndex]
        items.remove(at: fromIndex)
        items.insert(item, at: toIndex)
    }
    
    func removeAllItmes() {
        items.removeAll()
    }
}

class ModelManagger {

    static var shared = ModelManagger()
    var items = [InfoItem]()
    
    private init() {
        items = (0..<50).map {
            Item(name: "title_\($0)")
        }
    }
    
}

extension ModelManagger: EditItemProvider {}
