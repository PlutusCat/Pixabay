//
//  SearchResultViewController.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/12.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {

    lazy var searchController = UISearchController(searchResultsController:nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("Search", comment: "Search")
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false

        tableView.separatorInsetReference = .fromCellEdges
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchResultViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        print("\(searchController.searchBar.text!)")
    }

    
}
