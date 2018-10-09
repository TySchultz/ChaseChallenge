//
//  MasterViewController.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import Alamofire

class MasterViewController: UIViewController,
    ListAdapterDataSource,
    UISearchBarDelegate,
    InitialEmptyViewDelegate,
    SchoolSectionControllerDelegate,
    dataStoreDelegate{
    
    private let searchBar = UISearchBar()
    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
        return view
    }()
    
    enum State {
        case idle
        case filtering(String)
    }
    
    var state: State = .idle
    
    var schoolStore : [School] = []
    var satStore : [SAT] = []
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Styles.Colors.background
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        searchBar.delegate = self
        searchBar.placeholder = "Search For School"
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        
        searchBar.resignWhenKeyboardHides()
        
        downloadData()
    }
    
    func downloadData() {
        let dataStore = DataStore(delegate: self)
        
        dataStore.downloadSchools()
        dataStore.downloadScores()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: collectionView)
        update(animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let bounds = view.bounds
        if bounds != collectionView.frame {
            collectionView.frame = bounds
            collectionView.collectionViewLayout.invalidateForOrientationChange()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    
    private func update(animated: Bool) {
        adapter.performUpdates(animated: animated)
    }
    
    func filter(term: String?) {
        defer {
            update(animated: true)
        }
        
        guard let term = term?.trimmingCharacters(in: .whitespacesAndNewlines), !term.isEmpty else {
            state = .idle
            return
        }
        
        state = .filtering(term)
    }

    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let width = view.bounds.width
        var schools: [ListDiffable]
        switch state {
        case .idle:
            schools = schoolStore.compactMap {
                SchoolViewModel(school: $0, width : width)
            }
        case .filtering(let term):
            schools = filtered(array: schoolStore, query: term)
                .compactMap {
                    SchoolViewModel(school: $0, width : width)
            }
        }
        return schools
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError() }
        
        if object is SchoolViewModel {
            return SchoolSectionController(delegate: self)
        }
        
        fatalError("Could not find section controller for object")
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        guard schoolStore.isEmpty else { return nil }
        
        let view = InitialEmptyView(
            imageName: "",
            title: NSLocalizedString("Downloading Schools", comment: ""),
            description: NSLocalizedString("NYC Schools updating automatically,\n Downloading Now.", comment: "")
        )
        view.delegate = self
        return view
    }
    
    
    // MARK: School Section Controller Delegate
    
    func didSelect(SchoolSectionController: SchoolSectionController, viewModel: SchoolViewModel) {
        guard let SAT = satStore.first(where: {$0.dbn == viewModel.school.dbn}) else {
            showErrorMessage(title: "SAT Scores Misssing", message: "Oops, looks like we do not have SAT scores for this school");
            return
        }
        
        let destinationViewController = UIStoryboard.init(name: "Main", bundle: self.nibBundle).instantiateViewController(withIdentifier: "DetailController") as! DetailViewController
        destinationViewController.detailSAT    = SAT
        destinationViewController.detailSchool = viewModel.school
        let navigation = UINavigationController(rootViewController: destinationViewController)
        showDetailViewController(navigation, sender: nil)
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(term: searchBar.text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filter(term: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        state = .idle
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        update(animated: true)
    }
    
    // MARK: InitialEmptyViewDelegate
    
    func didTap(emptyView: InitialEmptyView) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    // MARK: Error Message
    
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Data Store Delegate
    
    func didDownloadSchools(schools: [School]) {
        self.schoolStore = schools
        self.update(animated: true)
    }
    
    func didDownloadScores(scores: [SAT]) {
        self.satStore = scores
        self.update(animated: true)
    }
    
    func errorDownloadingData(error: Error?) {
        if let err = error {
            showErrorMessage(title: "An Error has occured", message: error.debugDescription)
        }
    }
    
}


