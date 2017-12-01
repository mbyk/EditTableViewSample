//
//  ViewController.swift
//  EditTableViewSample
//
//  Created by maru on 2017/12/01.
//  Copyright © 2017年 mbyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavigationItemAnimated(animated)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: animated)
        updateNavigationItemAnimated(animated)
    }
    
    private func updateNavigationItemAnimated(_ animated: Bool) {
        if isEditing {
            navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.done)), animated: animated)
        } else {
            navigationItem.setRightBarButton(UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(ViewController.edit)), animated: animated)
        }
    }
        
    @objc func done() {
        setEditing(false, animated: true)
    }
    
    @objc func edit() {
        setEditing(true, animated: true)
    }
}

extension ViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManagger.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            fatalError()
        }

        let item = ModelManagger.shared.items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        ModelManagger.shared.removeItemAtIndex(indexPath.row)
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
        }
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        ModelManagger.shared.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ModelManagger.shared.items[indexPath.row]
        NSLog("didSelectItem: \(item)")
    }
}
