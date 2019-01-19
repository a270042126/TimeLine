//
//  ViewController.swift
//  TimeLine
//
//  Created by dd on 2019/1/19.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = TimeLineViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
