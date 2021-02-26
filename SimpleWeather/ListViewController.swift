//
//  ListViewController.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/23/21.
//

import UIKit
import MapKit
import Rswift

enum ListSection: Int, CaseIterable {
    case suggestedCities
    case savedCities
    
    var title: String {
        switch self {
        case .suggestedCities:
            return R.string.localizable.listSectionHeaderSuggestedCities()
        case .savedCities:
            return R.string.localizable.listSectionHeaderSavedCities()
        }
    }
}

final class ListViewController: UITableViewController {
    
    // MARK: Views
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Data
    
    private let searchCompleter = MKLocalSearchCompleter()
    private var completerResults = [MKLocalSearchCompletion]()
    private var savedCities = [String]()
    
    // MARK: Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            let listSection = ListSection(rawValue: selectedIndexPath.section)
        else {
            return
        }
        switch listSection {
        case .suggestedCities:
            let result = completerResults[selectedIndexPath.row]
            let resultText = result.subtitle.isEmpty ? result.title : result.subtitle
            
            if let city = resultText.split(separator: ",").first {
                if DataManager.shared.checkIfExists(value: String(city), forKey: DataKey.cities) {
                    destination.mode = .saved(cityName: String(city))
                } else {
                    destination.mode = .unsaved(cityName: String(city))
                }
            }
        case .savedCities:
            let city = savedCities[selectedIndexPath.row]
            if DataManager.shared.checkIfExists(value: city, forKey: DataKey.cities) {
                destination.mode = .saved(cityName: String(city))
            } else {
                destination.mode = .unsaved(cityName: String(city))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedCities = DataManager.shared.fetchAll(forKey: DataKey.cities)
        tableView.reloadData()
    }
    
    private func configure() {
        searchCompleter.resultTypes = .address
        searchCompleter.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ListSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let listSection = ListSection(rawValue: section) else {
            return nil
        }
        return listSection.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchCell.identifier),
            let listSection = ListSection(rawValue: indexPath.section)
        else {
            return UITableViewCell()
        }
        switch listSection {
        case .suggestedCities:
            let suggestion = completerResults[indexPath.row]
            cell.textLabel?.attributedText = suggestion.title.highlighted(rangeValues: suggestion.titleHighlightRanges)
            cell.detailTextLabel?.attributedText = suggestion.subtitle.highlighted(rangeValues: suggestion.subtitleHighlightRanges)
        case .savedCities:
            cell.textLabel?.text = savedCities[indexPath.row]
            cell.detailTextLabel?.text = nil
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = ListSection(rawValue: section) else {
            return 0
        }
        switch listSection {
        case .suggestedCities:
            return completerResults.count
        case .savedCities:
            return savedCities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Protocols

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            completerResults.removeAll()
            tableView.reloadData()
        } else {
            if completerResults.isEmpty {
                loadingIndicator.startAnimating()
            }
            searchCompleter.queryFragment = searchText
        }
    }
}

extension ListViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        // Overwrite the existing results, and then refresh the UI with the new results.
        completerResults = completer.results
        loadingIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle any errors returned from MKLocalSearchCompleter.
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
            loadingIndicator.stopAnimating()
            showAlert(title: R.string.localizable.alertError(), message: error.localizedDescription)
        }
    }
}
