//
//  GenreViewController.swift
//  Deezer-ApternStudy
//
//  Created by Muhammed Enes Kılıçlı on 13.05.2023.
//

import UIKit


class GenreViewController: UIViewController {
    
    var genreID: Int!
    var genreName: String!
    var artistList = [GenreArtist]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    ///Configure navigation, tableview, and others...
    private func configure(){
        
        // MARK: NavigationController
        title = genreName
        navigationController?.navigationBar.tintColor = UIColor.purple
        navigationController?.navigationBar.prefersLargeTitles = false
        
 
        // MARK: TableView register and delegate
        tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "artistTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // MARK: ActivityIndicator
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { /// wait 0.2 second to see activityIndicator
            self.getArtist()
        }
        
    }

    /// get artistList and reload tableview
    private func getArtist(){
        
        APICaller.shared.getGenreArtist(with: genreID) { data in
            switch(data)
            {
            case .success(let artist):
                DispatchQueue.main.async{
                    self.artistList = artist.data ?? [GenreArtist]()
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

//MARK: TableView Delegate
extension GenreViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc =  storyboard?.instantiateViewController(withIdentifier: "albumViewController") as? AlbumViewController{
            let artist = artistList[indexPath.row]
            vc.artistID = artist.id
            vc.artistName = artist.name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: TableView Datasource
extension GenreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistTableViewCell", for: indexPath) as! ArtistTableViewCell

        cell.label.text = self.artistList[indexPath.row].name
        cell.photoView.kf.setImage(with: URL(string: "\(self.artistList[indexPath.row].picture_xl ?? "")"),options: [.transition(.fade(0.7))])

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
}
