//
//  AnnouncesListViewUikit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 04/01/23.
//
import Combine
import SDWebImage
import UIKit

class AnnouncesListViewUikit: UIViewController {

    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var filtersOnlyStack: UIStackView!
    
    let isSearchFiltered: Bool
    let searchText: String
    let category: String
    let minPrice: Double
    let maxPrice: Double
    let noOlderThanDate: Date
    
    let announceListVM = AnnouncesListVM()
    
    let coordinator: GetAnnounceCoordinator!
    
    var cancellables = Set<AnyCancellable>()
    
    init(coordinator: GetAnnounceCoordinator, isSearchFiltered: Bool = false, searchText: String = "", category: String = "Any", minPrice: Double = 0, maxPrice: Double = 1000, noOlderThanDate: Date = Calendar.current.date(byAdding: .day, value: -300, to: Date()) ?? Date()) {
        
        self.isSearchFiltered = isSearchFiltered
        self.searchText = searchText
        self.category =  category
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.noOlderThanDate = noOlderThanDate
        
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set up collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AnnounceCell", bundle: nil), forCellWithReuseIdentifier: "AnnounceCell")
        
        suscribeToAnnouncesList()
        announceListVM.suscribeToAnnounceRepoArray()
        announceListVM.CheckNewAnnounces()
        
        suscribeToFavouriteList()
        
        
        fillFilterStack()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        announceListVM.getFavourite()
    }
    
    func suscribeToAnnouncesList(){
        announceListVM.$announces
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func suscribeToFavouriteList(){
        announceListVM.$favourites
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func fillFilterStack(){
        filtersOnlyStack.subviews.forEach({ $0.removeFromSuperview() })
        if isSearchFiltered == false {
            filterStackView.isHidden = true
        } else {
            if category != "Any" {
                let categoryLabel = UILabel()
                categoryLabel.text = "Category: \(category)"
                filtersOnlyStack.addArrangedSubview(createBackGroundViewForFilter(label: categoryLabel))
            }
            
            if minPrice > 0 {
                let minPriceLabel = UILabel()
                minPriceLabel.text = "Min price: \(String(minPrice))"
                filtersOnlyStack.addArrangedSubview(createBackGroundViewForFilter(label: minPriceLabel))
            }
            
            if maxPrice < 1000 {
                let maxPriceLabel = UILabel()
                maxPriceLabel.text = "Max price: \(String(maxPrice))"
                filtersOnlyStack.addArrangedSubview(createBackGroundViewForFilter(label: maxPriceLabel))
            }
        }
    }

    func createBackGroundViewForFilter(label: UILabel) ->UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        let padding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
        
        return view
    }
    
}


extension AnnouncesListViewUikit: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == announceListVM.announces.count - 1 && isSearchFiltered == false{
            announceListVM.checkForMoreAnnouces()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.showAnnounceDetailView(announce: announceListVM.announces[indexPath.row])
    }
    
}

extension AnnouncesListViewUikit: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        announceListVM.announces.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnounceCell", for: indexPath) as! AnnounceCell
        
        cell.announce = announceListVM.announces[indexPath.row]
        cell.coordinator = coordinator
        cell.announceListVM = announceListVM

        let heartView = UIImage(systemName: announceListVM.isAFavouriteAnnounce(announceId: announceListVM.announces[indexPath.row].id ?? "") ? "heart.fill" : "heart")
        cell.heartViewBtn.setImage(heartView, for: .normal)
   
        cell.imageAnnounce.sd_setImage(with: URL(string: announceListVM.announces[indexPath.row].imageRefs[0]), placeholderImage: UIImage(systemName: "camera"))

        cell.titleLabel.text = announceListVM.announces[indexPath.row].title
        cell.priceLabel.text = String(announceListVM.announces[indexPath.row].price) + "€"
        cell.addressLabel.text = announceListVM.announces[indexPath.row].city_PostCode
        
        var dateUpdated = announceListVM.announces[indexPath.row].lastUpdatedAt!.formatted(.dateTime.day().month())
        dateUpdated = dateUpdated + " a " + announceListVM.announces[indexPath.row].lastUpdatedAt!.formatted(.dateTime.hour().minute())
        cell.dateLabel.text = dateUpdated

        return cell
    }
}

extension AnnouncesListViewUikit: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 175, height: 350)
    }
    
    
}
