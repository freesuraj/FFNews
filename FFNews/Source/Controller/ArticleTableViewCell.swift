//
//  ArticleTableViewCell.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    private static let imageDimension: CGFloat = 80
    
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var imageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var abstractLabel: UILabel!
    
    static var identifier: String {
        return String(describing: ArticleTableViewCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        articleImageView.clipsToBounds = true
        imageWidthConstraint.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customize(with article: Article) {
        headlineLabel.text = article.headline
        authorLabel.text = article.byLine
        timeLabel.text = Date(timeIntervalSince1970: article.timeStamp/1000).readableFormatted
        abstractLabel.text = article.abstract
        if let imageUrl = article.relatedImageUrl {
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.articleImageView.image = image
                self?.imageWidthConstraint.constant = ArticleTableViewCell.imageDimension
            }
        } else {
            imageWidthConstraint.constant = 0
        }
    }

}

extension Date {
    
    var readableFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
}
