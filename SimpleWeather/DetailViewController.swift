//
//  DetailViewController.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/23/21.
//

import UIKit

enum DetailMode {
    case unsaved(cityName: String)
    case saved(cityName: String)
}

final class DetailViewController: UITableViewController {
    
    // MARK: Views
    
    @IBOutlet weak private var detailView: DetailView!
    @IBOutlet weak private var callToActionButton: UIBarButtonItem!
    
    // MARK: Data
    
    var mode: DetailMode?
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
        loadData()
    }
    
    private func configure() {
        refreshControl?.addTarget(self, action: #selector(DetailViewController.handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl?.beginRefreshing()
        updateViewState()
    }
    
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        loadData()
    }
    
    private func loadData() {
        guard let mode = self.mode else {
            return
        }
        switch mode {
        case .saved(let cityName), .unsaved(let cityName):
            print(cityName)
            NetworkManager.shared.apollo.fetch(query: CityDetailsQuery(name: cityName)) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    defer {
                        self.refreshControl?.endRefreshing()
                    }
                    switch result {
                    case .failure(let error):
                        print("NETWORK ERROR: \(error)")
                        self.showAlert(title: R.string.localizable.alertError(), message: error.localizedDescription)
                    case .success(let graphQLResult):
                        if let city = graphQLResult.data?.getCityByName {
                            self.detailView.configure(for: city)
                            self.callToActionButton.isEnabled = true
                        } else {
                            self.callToActionButton.isEnabled = false
                            self.showAlert(title: R.string.localizable.alertError(), message: R.string.localizable.alertErrorDescription())
                        }
                    if let errors = graphQLResult.errors {
                        print("GRAPHQL ERRORS: \(errors)")
                        self.showAlert(title: R.string.localizable.alertError(), message: R.string.localizable.alertErrorDescription())
                    }
                  }
                }
            }
        }
    }
    
    @IBAction private func callToActionPressed(_ sender: UIBarButtonItem) {
        guard let mode = self.mode else {
            return
        }
        switch (mode) {
        case .unsaved(let cityName):
            DataManager.shared.add(value: cityName, forKey: DataKey.cities)
            self.mode = .saved(cityName: cityName)
        case .saved(let cityName):
            DataManager.shared.remove(value: cityName, forKey: DataKey.cities)
            self.mode = .unsaved(cityName: cityName)
        }
        updateViewState()
    }
    
    private func updateViewState() {
        guard let mode = self.mode else {
            return
        }
        switch mode {
        case .unsaved:
            callToActionButton.title = R.string.localizable.callToActionSave()
        case .saved:
            callToActionButton.title = R.string.localizable.callToActionDelete()
        }
    }
}
