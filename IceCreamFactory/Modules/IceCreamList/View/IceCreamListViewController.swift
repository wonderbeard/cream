//
//  IceCreamListViewController.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 09.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

class IceCreamListViewController: UIViewController, IceCreamListViewInput {
    
    weak var output: IceCreamListViewOutput?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var itemViewModels: [IceCreamListItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    func setListItems(_ items: [IceCreamListItemViewModel]) {
        itemViewModels = items
        tableView?.reloadData()
    }
    
    func setErrorMessage(_ error: String?) {
        // TODO:
    }
    
}

extension IceCreamListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IceCreamListTableViewCell
        let itemViewModel = itemViewModels[indexPath.row]
        cell.apply(itemViewModel)
        return cell
    }
    
}
