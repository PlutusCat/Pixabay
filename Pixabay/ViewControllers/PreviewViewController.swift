//
//  PreviewViewController.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/13.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import UIKit

class PreviewViewController: BaseViewController {

    var mainHit: MainHit!
    var placeholder_image: UIImage!

    lazy var previewActions: [UIPreviewActionItem] = {
        let save = UIPreviewAction(title: "保存到相册", style: .default, handler: { (action, controller) in
            print("=== 保存到相册 ===")
            print("=== action ===", action)
            print("=== controller ===", controller)
        })
        return [save]
    }()

    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



