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

    var page = 2
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
        refreshControl?.addTarget(self, action: #selector(refreshControlChanged), for: .valueChanged)

        registerForPreviewing(with: self, sourceView: tableView)

        refreshNewData()

    }

    @objc func itemSearch() {

        let resultVC = SearchResultViewController()
        resultVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resultVC, animated: true)

    }

    @objc func refreshControlChanged() {

        refreshNewData()

    }

    func loadMore() {

        guard isLoadingMore else {
            isLoadingMore = true
            loadMoreData()
            return
        }

    }

    func refreshNewData() {

        NetworkTools.request(URLString: getMainURL(pageNum: 1),
                             method: .get,
                             paramet: nil,
                             finishedCallback:
            { [weak self] (result) in

                let json = JSON(result)

                var indexPaths = [IndexPath]()
                for (index, item) in MainModel(fromJson: json).hits.enumerated() {
                    if index == 0 {
                        if self?.firstID == item.id {
                            self?.endRefreshing()
                            return
                        }
                        self?.firstID = item.id
                    }

                    self?.hits.insert(item, at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    indexPaths.insert(indexPath, at: index)
                }

                DispatchQueue.main.async {
                    self?.endRefreshing()
                    self?.tableView.insertRows(at: indexPaths, with: .top)
                }

        }) { [weak self] (error) in

            print("error ==", error)
            self?.endRefreshing()

        }
    }

    func loadMoreData() {

        NetworkTools.request(URLString: getMainURL(pageNum: page),
            method: .get,
            paramet: nil,
            finishedCallback:
            { [weak self] (result) in

                let json = JSON(result)

                var indexPaths = [IndexPath]()
                for (_, item) in MainModel(fromJson: json).hits.enumerated() {
                    self?.hits.append(item)
                    let indexPath = IndexPath(row: (self?.hits.count)!-1, section: 0)
                    indexPaths.append(indexPath)
                }

                DispatchQueue.main.async {
                    self?.tableView.insertRows(at: indexPaths, with: .top)
                }

                self?.page = (self?.page)! + 1
                self?.isLoadingMore = false

        }) { (error) in

            print("error ==", error)

        }

    }

    func getMainURL(pageNum: Int) -> String {
        return apiURL+"&image_type=photo&per_page=20&page="+"\(pageNum)"
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

        let previewVC = PreviewViewController()
        previewVC.mainHit = hits[indexPath.row]
        navigationController?.pushViewController(previewVC, animated: true)
    }


}

extension MainViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else { return nil }

        let mainCell: MainViewTableViewCell = cell as! MainViewTableViewCell
        previewingContext.sourceRect = mainCell.frame

        let previewVC = PreviewViewController()
        previewVC.mainHit = hits[indexPath.row]
        previewVC.placeholder_image = mainCell.imageView?.image

        return previewVC
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {

        showDetailViewController(viewControllerToCommit, sender: nil)

    }

}



