//
//  FavouriteViewUikit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 27/12/22.
//
import Combine
import NukeUI
import SDWebImage
import UIKit

class FavouriteViewUikit: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let favouriteVM = FavouriteVM()
    let router: AnnounceDetailViewDelegate!
    
    private var cancellables = Set<AnyCancellable>()
    
    init(router: AnnounceDetailViewDelegate){
        self.router = router
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up table view dataSource and delegate, register cell
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavouriteViewUikitCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        tableView.delegate = self
        
        //suscribe to viewModel array of favourite announce with Combine
        favouriteVM.getFavourites()
        favouriteVM.$favouriteAnnounces
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.tableView.reloadData()})
            .store(in: &cancellables)

        //display nav bar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Favourite"
    
    }
}

extension FavouriteViewUikit: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favouriteVM.favouriteAnnounces.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteViewUikitCell
        cell.favouriteVM = favouriteVM
        cell.announce = favouriteVM.favouriteAnnounces[indexPath.row]
        cell.titleLabel.text = favouriteVM.favouriteAnnounces[indexPath.row].title
        cell.PriceLabel.text = String(favouriteVM.favouriteAnnounces[indexPath.row].price) + "€"
        cell.categoryLabel.text = favouriteVM.favouriteAnnounces[indexPath.row].category
        cell.addressLabel.text = favouriteVM.favouriteAnnounces[indexPath.row].city_PostCode
        cell.deliveryLabel.text = favouriteVM.favouriteAnnounces[indexPath.row].deliveryType
        cell.ImageAnnounce.sd_setImage(with: URL(string: favouriteVM.favouriteAnnounces[indexPath.row].imageRefs[0]),
                                       placeholderImage: UIImage(systemName: "camera"))
 
        return cell
    }
}

extension FavouriteViewUikit: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showAnnounceDetailView(announce: favouriteVM.favouriteAnnounces[indexPath.row])
    }

}



