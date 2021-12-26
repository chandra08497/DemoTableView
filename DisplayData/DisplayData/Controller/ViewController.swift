//
//  ViewController.swift
//  DisplayData
//
//  Created by FutureTeach on 22/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView:UITableView!
    
    // MARK: - Variables
    var userDetailsArray:[[String:Any]]?
    
    // MARK: - View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        callData()
    }

    // MARK: - Custom Methods
    private func setUpView(){
        tableView.register(UINib.init(nibName: CellId.userDetailsTableViewCell, bundle: nil), forCellReuseIdentifier: CellId.userDetailsTableViewCell)
    }
    
    // MARK: - GetRequest For UserData
    func callData(){
        guard let url = URL(string:"https://api.github.com/repos/Alamofire/Alamofire/issues")else{
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let data = data else {
                return
            }
            do{
                guard let jsondata = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] else {
                    return
                }
                self?.userDetailsArray = jsondata
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            } catch{
                
            }
            
        }.resume()
    }
}


// MARK: - TableView Delegate and Datasource
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellId.userDetailsTableViewCell) as? UserDetailsTableViewCell  {
            let index = userDetailsArray?[indexPath.row]
            let userNameObject = index?["user"] as? [String:Any]
            let userName = userNameObject?["login"] as? String
            
            let createdAt = index?["created_at"] as? String
            let title = index?["title"] as? String
            let avatarImg = userNameObject?["avatar_url"] as? String
            
            cell.createdAtLabel.text = convertDateFormat(strDate: createdAt ?? "")
            cell.nameLabel.text = userName
            cell.titleLabell.text = title
            cell.avatarImg.showImage(url: avatarImg ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
