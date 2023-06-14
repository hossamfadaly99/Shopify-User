//
//  HomeViewController.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewModel : HomeViewModel?
    var brandsList : [SmartCollection] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var adsImagesArray = [UIImage(named: "ad1"),UIImage(named: "ad2"),UIImage(named: "ad3"),UIImage(named: "ad4"),UIImage(named: "ad5")]
    var timer  : Timer?
    var currentCellIndex = 0
    //@IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        registerCells()
        
        self.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader ")
        
        let layout = UICollectionViewCompositionalLayout{ index, environment in
            if(index == 0){
                return self.drawTheTopSection()
            }else{
                return self.drawTheBottomSection()
            }
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
//        pageControl.numberOfPages = adsImagesArray.count
//        print(adsImagesArray.count)
        
        // Do any additional setup after loading the view.
        startTimer()
    }
    
    @IBAction func navigateSearch(_ sender: Any) {
        print("jjjjjjjj")
         let storyboard = UIStoryboard(name: "Search_SB", bundle: nil)
         let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SEARCH) as! Search_VC
        nextViewController.destination = Constants.HOME_SEARCH_ICON
        nextViewController.modalPresentationStyle = .fullScreen
         present(nextViewController, animated: true, completion: nil)
    }
    
    func registerCells(){
        var  nib = UINib(nibName: "AdsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ads")
        
        nib = UINib(nibName: "BrandCustomViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "brand")
    }
    func startTimer (){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextAd), userInfo: nil, repeats: true)
    }
    @objc func moveToNextAd(){
        if currentCellIndex < adsImagesArray.count - 1{
            currentCellIndex = currentCellIndex + 1
        }else{
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
       // pageControl.currentPage = currentCellIndex
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel=HomeViewModel()
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.brandsList = self?.viewModel?.result ?? []
                self?.collectionView.reloadData()
            }
        }
        viewModel?.getItems()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return adsImagesArray.count
        }else {
            return brandsList.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ads", for: indexPath) as! AdsCollectionViewCell
            cell.adImg.image = adsImagesArray[indexPath.row]
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandCustomViewCell
            let url = URL(string: brandsList[indexPath.row].image?.src ?? "")
            
            cell.brandImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team1"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            cell.brandNameLabel.text=brandsList[indexPath.row].rules?[0].condition
            
            cell.brandImg.frame = cell.brandImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.brandImg.layer.borderWidth = 2
            cell.brandImg.layer.borderColor = UIColor.black.cgColor
            cell.brandImg.layer.cornerRadius = 25
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width), height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 10
    }
    func drawTheTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }
    
    func drawTheBottomSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            if indexPath.section == 0{
                sectionHeader.sectionHeaderLabel.text = "Ads"
            }else{
                sectionHeader.sectionHeaderLabel.text = "Brands"
            }
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click")
        if indexPath.section == 1{
            
            let products = self.storyboard?.instantiateViewController(withIdentifier: "products") as! ProductsViewController
            products.brandName = brandsList[indexPath.row].rules?[0].condition
            self.navigationController?.pushViewController(products, animated: true)
        }
    }
}
