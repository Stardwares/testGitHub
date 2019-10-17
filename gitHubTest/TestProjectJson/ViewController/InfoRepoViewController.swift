//
//  InfoRepoViewController.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 09/09/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import UIKit

class InfoRepoViewController: UIViewController {
    
    @IBOutlet weak var nameRepoLabel: UILabel!
    @IBOutlet weak var descriptionRepo: UILabel!
    @IBOutlet weak var userNameRepo: UILabel!
    @IBOutlet weak var mailUserRepo: UILabel!
    
    var dataManager: CoreDataManager!
    private var favorites = [FavoritesRepo]()
    
    var item: SearchItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
            nameRepoLabel.text = item.fullName
            descriptionRepo.text = item.description
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddFavorites(_ sender: Any) {
        saveName(save: item)
    }
    
    func showAlertController(title: String?, message: String?) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        present(viewController,animated: true, completion: nil)
    }
    
    func saveName(save: SearchItem) {
        let context = dataManager.getContext()
        
        fetchData()
        
        if !(favorites.contains(where: {$0.id == Int32(save.id)})) {
            let item = dataManager.createObject(from: FavoritesRepo.self)
            item.id = Int32(save.id)
            item.fullName = save.fullName
            item.descriptionRepo = save.description
           dataManager.save(context: context)
            showAlertController(title: "Выполнено", message: "Данный репозиторий добавлен в избранное")
        } else {
            showAlertController(title: "Выполнено", message: "Данный репозиторий уже находится в избранном")
        }
        
       
    }
    
    private func fetchData() {
       favorites = dataManager.fetchData(from: FavoritesRepo.self)
    }

}


