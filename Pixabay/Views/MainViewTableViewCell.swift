//
//  MainViewTableViewCell.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/11.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let ViewTableViewCell_ID = "ViewTableViewCell_ID"
let cellHeight: CGFloat = 300.0

class MainViewTableViewCell: UITableViewCell {

    open lazy var pixabay_imageView : UIImageView = {

        let x: CGFloat = 6.0
        let y: CGFloat = 4.0
        let w: CGFloat = SCREEN_WIDTH-2*x
        let h: CGFloat = cellHeight-2*y

        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.clipRectCorner(direction: .allCorners, cornerRadius: 10.0)
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear

        contentView.addSubview(pixabay_imageView)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData(with model: MainHit) {

        pixabay_imageView.kf.setImage(with: URL(string: "\(model.webformatURL!)"),
                                      placeholder: nil,
                                      options: [.transition(.fade(0.15))],
                                      progressBlock: nil,
                                      completionHandler: nil)

    }

}
