//
//  NYViewController.swift
//  niuyao
//
//  Created by niuyao on 2019/10/22.
//  Copyright © 2019 joymates. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NYViewController: UIViewController {

    //tableView对象
    var tableView: UITableView!
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        view.addSubview(button)
        
        let bag = DisposeBag()
        button.rx.tap.subscribe { (event) in
            
        }.disposed(by: bag)
        
        
        button.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.center.equalTo(view)
        }
        
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
            make.top.left.equalTo(view).offset(20)
            make.width.lessThanOrEqualTo(200) //设置最大宽度为200
            make.width.greaterThanOrEqualTo(50) //设置最小宽度为50
        }
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        
        //创建约束 makeConstraints
        redView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            
            
        }
        
        //跟新约束 updateConstraints
        redView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(50)
        }
        
        //重新设置约束 remakeConstraints
        redView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: -60, right: -20))
        }
        
        //label宽度自适应(不设置宽度即可)
        let label = UILabel()
        self.view.addSubview(label)
        label.text = "这是一个绿色的label"
        label.backgroundColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 15)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-60)
        }
        //同样的，高度自适应不设置高度即可。
        
        //并排的两个label，优先让其中一个宽度自适应（别扯我）
        // 左边的label
        let leftLabel = UILabel()
        self.view.addSubview(leftLabel)
        leftLabel.backgroundColor = UIColor.lightGray
        leftLabel.text = "这是左边的label"
        leftLabel.font = UIFont.systemFont(ofSize: 12)

        // 右边的label
        let rightLabel = UILabel()
        self.view.addSubview(rightLabel)
        rightLabel.backgroundColor = UIColor.orange
        rightLabel.text = "这是右边的label，优先宽度自适应内容"
        rightLabel.font = UIFont.systemFont(ofSize: 12)
        // 别扯我，谢谢(这就是右边label优先宽度自适应的关键代码)
//        rightLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal);

        rightLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(-20)
            make.height.equalTo(20)
        }

        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right)
            make.bottom.height.equalTo(leftLabel)
            make.right.equalToSuperview()
        }
        
        //SnapKit动画
        UIView.animate(withDuration: 0.2) {
            redView.snp.updateConstraints { (make) in
                make.centerX.equalTo(200)
            }
            redView.superview?.layoutIfNeeded()
        }
        
        
//        tableView.rx.modelSelected(Music.self).subscribe
        
    }
    @objc func clickButton() -> Void {
        
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

extension NYViewController: UITableViewDataSource{
    //返回对应的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
        let music = musicListViewModel.data[indexPath.row]
        cell.textLabel?.text = music.name
        cell.detailTextLabel?.text = music.singer
        return cell
        
    }
    //返回单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListViewModel.data.count
    }
}

extension NYViewController: UITableViewDelegate{
    //单元格点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你选中的歌曲信息「 \(musicListViewModel.data[indexPath.row]) 」")
    }
}
