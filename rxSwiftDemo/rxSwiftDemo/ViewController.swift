//
//  ViewController.swift
//  rxSwiftDemo
//
//  Created by Lio on 8/10/19.
//  Copyright © 2019 thinhngo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["An Giang",
                     "Bà Rịa - Vũng Tàu",
                     "Bắc Giang",
                     "Bắc Kạn",
                     "Bạc Liêu",
                     "Bắc Ninh",
                     "Bến Tre",
                     "Bình Định",
                     "Bình Dương",
                     "Bình Phước",
                     "Bình Thuận",
                     "Cà Mau",
                     "Cao Bằng",
                     "Đắk Lắk",
                     "Đắk Nông",
                     "Điện Biên",
                     "Đồng Nai",
                     "Đồng Tháp",
                     "Gia Lai",
                     "Hà Giang",
                     "Hà Nam",
                     "Hà Tĩnh",
                     "Hải Dương",
                     "Hậu Giang",
                     "Hòa Bình",
                     "Hưng Yên",
                     "Khánh Hòa",
                     "Kiên Giang",
                     "Kon Tum",
                     "Lai Châu",
                     "Lâm Đồng",
                     "Lạng Sơn",
                     "Lào Cai",
                     "Long An",
                     "Nam Định",
                     "Nghệ An",
                     "Ninh Bình",
                     "Ninh Thuận",
                     "Phú Thọ",
                     "Quảng Bình",
                     "Quảng Nam",
                     "Quảng Ngãi",
                     "Quảng Ninh",
                     "Quảng Trị",
                     "Sóc Trăng",
                     "Sơn La",
                     "Tây Ninh",
                     "Thái Bình",
                     "Thái Nguyên",
                     "Thanh Hóa",
                     "Thừa Thiên Huế",
                     "Tiền Giang",
                     "Trà Vinh",
                     "Tuyên Quang",
                     "Vĩnh Long",
                     "Vĩnh Phúc",
                     "Yên Bái",
                     "Phú Yên",
                     "Cần Thơ",
                     "Đà Nẵng",
                     "Hải Phòng",
                     "Hà Nội",
                     "TP HCM"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.lowercased().hasPrefix(query.lowercased())} // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
}

