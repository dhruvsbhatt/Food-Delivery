//
//  DashboardVC.swift
//  FoodDeliveryApp
//
//  Created by Dhruv Bhatt on 23/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class DashboardVC: UIViewController {
    
    var arrMenu: Menu!
    let disposeBag = DisposeBag()
    var presentor: ViewToPresenterProtocol?
    let discountContent = ["Monday discount", "Tuesday discount", "Wednesday discount"]
    
    @IBOutlet weak var uiTableView: UITableView!
    @IBOutlet weak var vwCart: UIView!
    @IBOutlet weak var clxnVw: UICollectionView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var pgControl: UIPageControl!
    @IBOutlet weak var btnCart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentor?.startFetchingMenu()
        showProgressIndicator(view: self.view)
        lblCount.isHidden = true
        uiTableView.delegate = self
        uiTableView.dataSource = self
        
        btnCart.rx.tap
            .bind {
                if arrCart.count > 0 {
                    self.presentor?.showCheckoutController(navigationController: self.navigationController!)
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Your cart is empty", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblCount.text = String(arrCart.count)
        self.lblCount.isHidden = arrCart.count > 0 ? false : true
    }
}

extension DashboardVC: PresenterToViewProtocol {
    
    func showMenu(menuArray: Menu) {
        self.arrMenu = menuArray
        self.uiTableView.reloadData()
        hideProgressIndicator(view: self.view)
    }
    
    func showError() {
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = arrMenu, let menu = arr.menu {
            return menu.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        
        if let arr = arrMenu, let arrMenu = arr.menu {
            let menu = arrMenu[indexPath.row]
            
            cell.imgVwItem.image = UIImage(named: menu.image!)
            cell.lblName.text = menu.name
            cell.lblIngredients.text = menu.ingredients
            cell.lblDimension.text = menu.dimensions
            cell.btnPrice.setTitle(String(menu.price!) + " usd", for: .normal)
            cell.btnPrice.rx.tap
                .bind {
                    cell.btnPrice.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    cell.btnPrice.setTitle("added + 1", for: .normal)
                    arrCart.append(menu)
                    self.lblCount.text = String(arrCart.count)
                    self.lblCount.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        cell.btnPrice.backgroundColor = UIColor.black
                        cell.btnPrice.setTitle(String(menu.price!) + " usd", for: .normal)
                    }
                }
                .disposed(by: cell.disposeBag)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        vwCart.isHidden = scrollView.contentOffset.y > 10 ? false : true
    }
}

class DashboardCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var lblDimension: UILabel!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var imgVwItem: UIImageView!
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

class DashboardRequestCell: UICollectionViewCell {
    @IBOutlet weak var lblDiscountText: UILabel!
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discountContent.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let clxnCell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "clxnCellRequests",
                    for: indexPath) as? DashboardRequestCell else {
            return UICollectionViewCell()
        }
        
        clxnCell.lblDiscountText.text = discountContent[indexPath.item]
        
        return clxnCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 480)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pgControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
