//
//  ViewController.swift
//  rxSwiftDemo
//
//  Created by Lio on 8/13/19.
//  Copyright © 2019 thinhngo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var serchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let allCities = ["An Giang", "Bà Rịa - Vũng Tàu",
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
    var result = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        processing()
    }
    
    func processing(){
        let searchReult = serchBar.rx.text.orEmpty
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .flatMapLatest { (query) -> Observable<[String]> in
                if query.isEmpty{
                    return .just([])
                }
                return .just(self.allCities.filter { $0.lowercased().hasPrefix(query.lowercased())})
        }.observeOn(MainScheduler.instance)
        
        searchReult.bind(to: tableView.rx.items(cellIdentifier: "cell")){
            (index, element: String, cell) in
            cell.textLabel?.text = element
        }.disposed(by: disposeBag)
    }
    
    func processing2(){
        //serchBar
        //            .rx.text // Observable property thanks to RxCocoa
        //            .orEmpty // Make it non-optional
        //            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
        //            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
        //            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
        //            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
        //                self.result = self.allCities.filter { $0.lowercased().hasPrefix(query.lowercased())}
        //
        //
        //
        //            })
        //            .disposed(by: disposeBag)
        //
        //        let dataSource = Observable.of(result)
        //
        //        dataSource.bind(to: tableView.rx.items) {
        //            (tableView: UITableView, index: Int, element: String) in
        //            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //            cell.textLabel?.text = element
        //            return cell
        //        }.disposed(by: disposeBag)
    }

}

