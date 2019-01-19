//
//  ViewController.swift
//  TimeLine
//
//  Created by dd on 2019/1/19.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
import SwiftyJSON

class TimeLineViewController: UIViewController {

    private var dataArray: [Article] = [Article]()
    private var cellStates: [CellState]?
    private lazy var tableView: UITableView = {[unowned self] in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.contentInset = UIEdgeInsets(top: -0.1, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TimeLineCell.self, forCellReuseIdentifier: "\(TimeLineCell.self)")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        loadData()
    }

    func loadData(){
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try? JSON(data: data! as Data)["articleList"].array
        for dict in json!! {
            let model = Article.deserialize(from: dict.dictionaryObject)
            dataArray.append(model!)
        }
        self.cellStates = Array(repeating: .collapsed, count: dataArray.count)
    }
    
    deinit {
        print("deint")
    }
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TimeLineCell.self)", for: indexPath) as! TimeLineCell
        cell.model = dataArray[indexPath.row]
        cell.topLineView.isHidden = indexPath.row == 0
        
        return cell
    }
}

