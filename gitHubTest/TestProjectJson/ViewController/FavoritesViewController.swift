//
//  FavoritesViewController.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 10/09/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var favorites = [FavoritesRepo]()
    var dataManager: CoreDataManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.textLabel?.text = favorites[indexPath.row].fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "infoRepoUID") as! InfoRepoViewController
        let item = SearchItem(id: Int(favorites[indexPath.row].id), fullName: favorites[indexPath.row].fullName ?? "", description: favorites[indexPath.row].descriptionRepo).self
        vc.item = item
        vc.dataManager = dataManager
        
        let transition = CATransition()
        
        transition.duration = 1.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func fetchData() {
        favorites = dataManager.fetchData(from: FavoritesRepo.self)
        if favorites.count > 0 {
            self.tableView.isHidden = false
        } else {
            self.tableView.isHidden = true
        }
    }

}
