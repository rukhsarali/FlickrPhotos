//
//  FavoritesVC.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import UIKit
import RealmSwift
class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var savedRealmData : Results<RealmData>?
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func uiSetup() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "PhotosCell", bundle: nil), forCellReuseIdentifier: "cell")
        //load realmData
        savedRealmData = realm.objects(RealmData.self)
    }

}
//tableView Delegate
extension FavoritesVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRealmData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PhotosCell
        cell.title.text = savedRealmData?[indexPath.row].title
        cell.ownerName.text = savedRealmData?[indexPath.row].ownerName
        cell.imageCell.sd_setImage(with: URL(string: savedRealmData?[indexPath.row].image ?? ""), placeholderImage:UIImage(named: "placholderImage") )
        cell.starButton.tag = indexPath.row
        cell.starButton.isSelected = true
        cell.starButton.addTarget(self, action: #selector(starButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    //click star button Action
    @objc func starButtonClicked(sender:UIButton) {
        SavedItems.selectedRows.remove(at: sender.tag)
        deleteRow(indexPath: sender.tag)
        tableView.reloadData()

    }
    //delete row
    func deleteRow(indexPath : Int) {
       
        if let deleteRow = savedRealmData?[indexPath]{
            
            do{
                try self.realm.write {
                    self.realm.delete(deleteRow)
                    print("deletdeddd")
                   // tableView.reloadData()
                }
            }catch{
                print("error delete category  \(error)")
            }
        }
    }
    
}
