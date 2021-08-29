//
//  CheckoutVC.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 29/08/21.
//

import UIKit
import RxSwift

class CheckoutVC: UIViewController {
    
    var checkoutPresenter: ViewToPresenterCheckoutProtocol?
    
    @IBOutlet weak var lblTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        showTotal()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showTotal() {
        let sumQuantity = arrCart.map({$0.price!}).reduce(0, +)
        lblTotal.text = String(sumQuantity) + " usd"
    }
}

extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
        let menu = arrCart[indexPath.row]
        cell.lblName.text = menu.name
        cell.lblPrice.text = String(menu.price!) + " usd"
        cell.imgVwItem.image = UIImage(named: menu.image!)
        
        cell.btnDelete.rx.tap
            .bind {
                arrCart.remove(at: indexPath.row)
                if arrCart.count > 0 {
                    tableView.reloadData()
                    self.showTotal()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: cell.disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class CheckoutCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgVwItem: UIImageView!
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
