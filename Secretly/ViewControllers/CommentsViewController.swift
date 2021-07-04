//
//  CommentsViewController.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 03/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(post?.content ?? "--")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
