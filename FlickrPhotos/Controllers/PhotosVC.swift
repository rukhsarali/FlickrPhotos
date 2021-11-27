//
//  PhotosVC.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import UIKit
import Foundation
import SDWebImage
import RealmSwift
class PhotosVC: UIViewController {
    let realm = try! Realm()
    var savedRealmData : Results<RealmData>?
    var getPhotos = [Photo]()
    @IBOutlet weak var tableView: UITableView!
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
        getData()
        //load realmData
        savedRealmData = realm.objects(RealmData.self)
    }
}
//tableView Delegate
extension PhotosVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PhotosCell
        let data = getPhotos[indexPath.row]
        cell.title.text = data.title
        cell.ownerName.text = data.ownername
        cell.imageCell.sd_setImage(with: URL(string: data.url_m ?? "" ), placeholderImage:UIImage(named: "placholderImage") )
        if SavedItems.selectedRows.contains(indexPath.row){
             cell.starButton.setImage(UIImage(named:"selectedStar"), for: .normal)
           }
           else{
             cell.starButton.setImage(UIImage(named:"deselectStar"), for: .normal)
           }
           cell.starButton.tag = indexPath.row
           cell.starButton.addTarget(self, action: #selector(starButtonClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    //click star button Action
    @objc func starButtonClicked(_ sender:UIButton){
        let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
        if SavedItems.selectedRows.contains(selectedIndexPath.row){
            SavedItems.selectedRows.remove(at: SavedItems.selectedRows.firstIndex(of: selectedIndexPath.row)!)
            let result = realm.objects(RealmData.self).filter("indexPath == \(selectedIndexPath.row)")
            deleteRow(indexPath: result[0].selfIndexPath)
            
        }else{
            SavedItems.selectedRows.append(selectedIndexPath.row)
            saveToRealm(img: getPhotos[sender.tag].url_m ?? "", title: getPhotos[sender.tag].title ?? "", ownerName: getPhotos[sender.tag].ownername ?? "", index: selectedIndexPath.row)
        }
        self.tableView.reloadData()
    }
}
//get data from Api
extension PhotosVC{
    func getData() {
        let photosURL = "https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=56e779b053994c656ecbef2b4ecc9266&user_id=65789667%40N06&extras=url_m%2Cowner_name&format=json&nojsoncallback=1"
        let params = [
            "":""
        ] as [String : Any]
        HTTPManager.shared.get(photosURL, withparams: params, controller: self) { (response: FlickrPhotosModel) in
            if response.photos?.photo?.count != 0 {
                self.getPhotos = response.photos?.photo ?? []
                self.tableView.reloadData()
            }else{
                Alerts.showAlert(on: self, title: "Error", message: "there is no data found!")
            }
        }
    }
}
//save and delete in realm
extension PhotosVC {
    func saveToRealm(img: String , title: String , ownerName: String, index: Int) {
        let data = RealmData()
        data.title = title
        data.ownerName = ownerName
        data.image = img
        data.indexPath = index
        data.selfIndexPath = savedRealmData?.endIndex ?? 0
        SavedItems.realmRows.append(savedRealmData?.endIndex ?? 0)
        
        do {
            try realm.write{
                realm.add(data)
            }
        }catch{
            print(error)
        }
    }
    
    //delete row
    func deleteRow(indexPath : Int) {
       
        if let deleteRow = savedRealmData?[indexPath]{
            
            do{
                try self.realm.write {
                    self.realm.delete(deleteRow)
                   // tableView.reloadData()
                }
            }catch{
                print("error delete category  \(error)")
            }
        }
    }
    
}
