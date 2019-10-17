//
//  SearchViewController.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 09/09/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = CoreDataManager(modelName: "TestProjectJson")
    
    var searchActive : Bool = false
    var infoGit: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        searchBar.delegate = self
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true
        if let searchText = searchBar.text {
            print(searchText)
            Model.shared.parseSearchJson(search: searchText) { res in
                    switch res {
                    case .none:
                        return
                    case .some(let result):
                        self.infoGit = result
                        self.tableView.reloadData()
                    }
                }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return infoGit?.items.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if (searchActive) {
            cell.textLabel?.text = infoGit?.items[indexPath.row].fullName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "infoRepoUID") as! InfoRepoViewController
        vc.item = infoGit?.items[indexPath.row]
        vc.dataManager = dataManager

        let transition = CATransition()

        transition.duration = 1.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func favoritesButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "favoritesRepoUID") as! FavoritesViewController
        vc.dataManager = dataManager
        
        let transition = CATransition()
        
        transition.duration = 1.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

class TableViewCell: UITableViewCell {
    
}

