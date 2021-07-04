//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    var likeService: LikeService?
    var post: Post? {
        didSet {
            updateView()
        }
    }
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentCounter: UILabel!

    weak var viewController: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView() {
        heartImage.isHidden = true
        imageView.image = nil
        guard let post = post else { return }
        likeService = LikeService(post: post)
        if let color = UIColor(hex: post.backgroundColor) {
            self.backgroundColor = color
        }
        self.contentLabel.text = post.content
        self.commentCounter.text = String(describing: post.commentsCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { self.imageView.image = $0 }
        }
        self.authorView.author = post.user
        if post.liked {
            likeButton.setImage(UIImage(systemName: "heart.fill")!, for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart")!, for: .normal)
        }
    }

    @IBAction
    func onTapLike() {
        likeService?.execute { value in
            print(value)
        }
    }

    @IBAction
    func onTapComment() {
        viewController?.performSegue(withIdentifier: "viewComments", sender: self)
    }
}
