//
//  MainViewController.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/11.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UITableViewController {

    var page = 1
    var hits = [MainHit]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Pixabay"
        tableView.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .always

        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(itemSearch))
        navigationItem.rightBarButtonItem = item

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: ViewTableViewCell_ID)

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        network()

    }

    @objc func itemSearch() {

        let resultVC = SearchResultViewController()
        resultVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resultVC, animated: true)

    }

    @objc func refreshData() {

        guard let refreshing = refreshControl?.isRefreshing, refreshing == false else {
            network()
            return
        }

    }

    func network() {
        /// &q=yellow+flowers

        let url = apiURL+"&image_type=photo&per_page=20&page="+"\(page)"

        NetworkTools.request(URLString: url,
                             method: .get,
                             paramet: nil,
                             finishedCallback:
            { [weak self] (result) in

                let json = JSON(result)

                print(json)

                var indexPaths = [IndexPath]()
                for (index, item) in MainModel(fromJson: json).hits.enumerated() {

                    autoreleasepool(invoking: {
                        self?.hits.insert(item, at: index)
                        let indexPath = IndexPath(row: index, section: 0)
                        indexPaths.insert(indexPath, at: index)
                    })

                }

                self?.tableView.insertRows(at: indexPaths, with: .automatic)

                if self?.refreshControl?.isRefreshing == true {
                    self?.refreshControl?.endRefreshing()
                }

                self?.page = (self?.page)! + 1

        }) { [weak self] (error) in

            print("error ==", error)
            if self?.refreshControl?.isRefreshing == true {
                self?.refreshControl?.endRefreshing()
            }

        }
    }

}

extension MainViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ViewTableViewCell_ID, for: indexPath) as! MainViewTableViewCell
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let mainCell: MainViewTableViewCell = cell as! MainViewTableViewCell
        mainCell.reloadData(with: hits[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

