//
//  LikeService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    private var endpoint: RestClient<Like>?
    var isLiked: Bool = false

    init(post: Post) {
        guard let postId = post.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        self.isLiked = post.liked
    }

    mutating func execute(completion: @escaping (Bool) -> Void) {
        if isLiked {
            likePost(completion: completion)
        } else {
            dislikePost(completion: completion)
        }
        self.isLiked = !self.isLiked
    }

    private func likePost(completion: @escaping (Bool) -> Void) {
        endpoint?.create { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async { completion(true) }
            case .failure(let err):
                #if DEBUG
                debugPrint(err)
                #endif
                DispatchQueue.main.async { completion(false) }
            }
        }
    }

    private func dislikePost(completion: @escaping (Bool) -> Void) {
        endpoint?.delete { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async { completion(false) }
            case .failure(let err):
                #if DEBUG
                debugPrint(err)
                #endif
                DispatchQueue.main.async { completion(true) }
            }
        }
    }
}
