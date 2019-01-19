//
//  CCContentCell.swift
//  TimeLine
//
//  Created by dd on 2019/1/19.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
import SnapKit

private let LineSpacing: Int = 5
private let MaxLineCount: Int = 5

enum CellState {
    case expanded
    case collapsed
}


class TimeLineCell: UITableViewCell {
    
    
    private lazy var topLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.hexInt(999999)
        return lineView
    }()

    private lazy var pointView: UIView = {
        let pointView = UIView()
        pointView.backgroundColor = UIColor.hexInt(999999)
        pointView.layer.cornerRadius = 3.5
        pointView.layer.masksToBounds = true
        return pointView
    }()
    
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.hexInt(999999)
        return lineView
    }()
    //标题
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.hexInt(333333)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    //内容
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = UIColor.hexInt(666666)
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.numberOfLines = 5
        return contentLabel
    }()
    //日期
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor.hexInt(666666)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        return dateLabel
    }()
    //折叠
    private lazy var foldingBtn: UIButton = {
        let foldingBtn = UIButton(type: .custom)
        foldingBtn.setImage(UIImage(named: "express_up"), for: .normal)
        foldingBtn.setImage(UIImage(named: "express_down"), for: .selected)
        foldingBtn.addTarget(self, action: #selector(foldingAction(sender:)), for: .touchUpInside)
        return foldingBtn
    }()
    // 利好
    private lazy var bullBtn: UIButton = {
        let bullBtn = UIButton(type: .custom)
        bullBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        bullBtn.setImage(UIImage(named: "express_good_normal"), for: .normal)
        bullBtn.setImage(UIImage(named: "express_good_selected"), for: .selected)
        bullBtn.setTitleColor(UIColor.hexInt(999999), for: .normal)
        bullBtn.contentHorizontalAlignment = .left
        bullBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        bullBtn.addTarget(self, action: #selector(bullAction(sender:)), for: .touchUpInside)
        bullBtn.setTitle("利好", for: .normal)
        return bullBtn
    }()
    // 利空
    private lazy var bearBtn: UIButton = {
        let bearBtn = UIButton(type: .custom)
        bearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        bearBtn.setImage(UIImage(named: "express_bad_normal"), for: .normal)
        bearBtn.setImage(UIImage(named: "express_bad_selected"), for: .selected)
        bearBtn.setTitleColor(UIColor.hexInt(999999), for: .normal)
        bearBtn.contentHorizontalAlignment = .left
        bearBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        bearBtn.addTarget(self, action: #selector(bearAction(sender:)), for: .touchUpInside)
        bearBtn.setTitle("利空", for: .normal)
        return bearBtn
    }()
    //分享
    private lazy var shareBtn: UIButton = {
        let shareBtn = UIButton(type: .custom)
        shareBtn.setImage(UIImage(named: "share_dig"), for: .normal)
        shareBtn.setTitle("分享挖矿", for: .normal)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        shareBtn.setTitleColor(UIColor.hexInt(999999), for: .normal)
        shareBtn.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        shareBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        return shareBtn
    }()
    
    var model: Article?{
        didSet{
            dateLabel.text = model?.publishTime
            titleLabel.text = model?.title
            contentLabel.text = model?.content
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(pointView)
        pointView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(14)
            make.width.height.equalTo(7)
        }
        
        contentView.addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(pointView)
            make.width.equalTo(0.5)
            make.centerX.equalTo(pointView)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(pointView)
            make.bottom.equalToSuperview()
            make.width.equalTo(0.5)
            make.centerX.equalTo(pointView)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pointView.snp.right).offset(23)
            make.width.equalTo(100)
            make.height.equalTo(15)
            make.centerY.equalTo(pointView)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(dateLabel)
            
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(titleLabel).priority(.high)
        }
        
        contentView.addSubview(foldingBtn)
        foldingBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(22)
        }
        
        let btnsView = UIView()
        contentView.addSubview(btnsView)
        btnsView.snp.makeConstraints { (make) in
            make.top.equalTo(foldingBtn.snp.bottom).offset(10)
            make.left.equalTo(dateLabel)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-36).priority(.high)
        }
        
        btnsView.addSubview(bullBtn)
        bullBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalToSuperview()
        }
        
        btnsView.addSubview(bearBtn)
        bearBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bullBtn.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalToSuperview()
        }
        
        btnsView.addSubview(shareBtn)
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalToSuperview()
        }
    }
    
   
    
    @objc private func foldingAction(sender: UIButton){
        sender.isSelected = !sender.isSelected
        
    }
    
    @objc private func bullAction(sender: UIButton){
        
    }
    
    @objc private func bearAction(sender: UIButton){
        
    }
    
    @objc private func shareAction(sender: UIButton){
        
    }
}
