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
    var isLoadingMore = false
    var firstID: Int?

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

        network(page: 1)

    }

    @objc func itemSearch() {

        let resultVC = SearchResultViewController()
        resultVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resultVC, animated: true)

    }

    @objc func refreshData() {

        network(page: 1)
        
    }

    func loadMore() {

        guard isLoadingMore else {
            isLoadingMore = true
            network(page: page)
            return
        }

    }

    func network(page: Int) {

        NetworkTools.request(URLString: apiURL+"&image_type=photo&per_page=20&page="+"\(page)",
                             method: .get,
                             paramet: nil,
                             finishedCallback:
            { [weak self] (result) in

                let json = JSON(result)

                var indexPaths = [IndexPath]()
                for (index, item) in MainModel(fromJson: json).hits.enumerated() {
                    if page == 1 && index == 0 {
                        if self?.firstID == item.id {
                            self?.endRefreshing()
                            return
                        }
                        self?.firstID = item.id
                    }
                    let indexPath = IndexPath(row: (self?.hits.count)!+index, section: 0)
                    indexPaths.append(indexPath)
                }

                self?.hits.append(contentsOf: MainModel(fromJson: json).hits)

                DispatchQueue.main.async {
                    self?.endRefreshing()
                    self?.tableView.insertRows(at: indexPaths, with: .automatic)
                }

                self?.page = (self?.page)! + 1
                self?.isLoadingMore = false

        }) { [weak self] (error) in

            print("error ==", error)
            self?.endRefreshing()

        }
    }

    func endRefreshing() {
        if refreshControl?.isRefreshing == true {
            refreshControl?.endRefreshing()
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

        if indexPath.row == hits.count-3 {
            loadMore()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}



