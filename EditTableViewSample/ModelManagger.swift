//
//  ModelManagger.swift
//  EditTableViewSample
//
//  Created by maru on 2017/12/01.
//  Copyright © 2017年 mbyk. All rights reserved.
//

import UIKit

struct Item {
    var name: String
}

class ModelManagger: NSObject {

    static var shared = ModelManagger()
    
    var items = [Item]()
    
    private override init() {
        items = (0..<50).map {
            Item(name: "title_\($0)")
        }
    }
    
    func addChannel(item: Item) {
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
}
