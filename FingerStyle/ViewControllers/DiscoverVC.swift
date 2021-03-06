//
//  SavedVC.swift
//  FingerStyle
//
//  Created by Jonathan Kopp on 1/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit
import Firebase

class DiscoverVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UISearchBarDelegate{
    
    var tableView = UITableView()
    let theTabBar = TabBarVC()
    var songs = [SongObj]()
    var navView = UIView()
    var admin = true //If true view all songs that users have requested to be published.
    var searchBar = UISearchBar()
    var searchButton = UIButton()
    var searchToggle = Bool()
    var searchSongs = [SongObj]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: (self.view.bounds.height * 0.1)))
        navView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let label = UILabel(frame: CGRect(x:0, y: navView.bounds.height/2-10, width: navView.bounds.width, height: 50))
         searchButton = UIButton(frame: CGRect(x: self.view.bounds.width - 50, y: label.frame.minY + 12.5, width: 25, height: 25))
        searchButton.setImage(#imageLiteral(resourceName: "icons8-search-50 (1)"), for: .normal)
        searchButton.addTarget(self, action:#selector(self.searchPressed), for: .touchUpInside)
        navView.addSubview(searchButton)
        navView.addSubview(label)
        self.view.addSubview(navView)
        
        loadTempSongs()
        loadSongs()
        TabBarVC.currentSelected = "Discover"
        self.view.backgroundColor = .white
        tableView.register(savedCellTableViewCell.self, forCellReuseIdentifier: "savedCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: self.view.bounds.width * 0.2, y: navView.frame.maxY, width: self.view.bounds.width - self.view.bounds.width * 0.2, height: self.view.bounds.height - navView.frame.maxY)
        tableView.separatorStyle = .none
        
        searchBar.frame = CGRect(x: 0, y: navView.frame.height, width: self.view.bounds.width, height: 42)
        searchBar.delegate = self
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.tableView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.tableView.addGestureRecognizer(swipeLeft)
        
        self.view.backgroundColor = .white
        self.theTabBar.view.backgroundColor = .white
        
        
        
        theTabBar.view.gestureRecognizers?.removeAll()
        label.text = "Discover Songs"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        navView.addSubview(label)
       
        
        
        self.theTabBar.view.addSubview(navView)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //theTabBar.loadViewIfNeeded()
        self.addChild(theTabBar)
        
        self.view.addSubview(theTabBar.view)
        self.view.addSubview(tableView)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
            
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            return (tableView.indexPathForRow(at: location) == nil)
        }
        return true
    }
    
    @objc func searchPressed()
    {
        if(searchToggle){
            searchToggle = false
        }else{
            searchToggle = true
        }
        print(self.tableView.frame.minX)
        print("Search Pressed")
        if(searchToggle){
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.frame = CGRect(x: self.tableView.frame.minX, y: self.searchBar.frame.maxY, width: self.tableView.bounds.width, height: self.view.bounds.height - (self.searchBar.frame.maxY))
            self.view.addSubview(self.searchBar)
            self.searchButton.setImage(#imageLiteral(resourceName: "icons8-search-50 (1)").mask(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: .normal)
            })
        }else{
            UIView.animate(withDuration: 0.4, animations: {
                self.tableView.frame = CGRect(x: self.tableView.frame.minX, y: self.navView.frame.maxY, width: self.tableView.bounds.width, height: self.view.bounds.height - (self.navView.frame.maxY))
                self.searchBar.removeFromSuperview()
                self.searchButton.setImage(#imageLiteral(resourceName: "icons8-search-50 (1)"), for: .normal)
            })
            self.songs = self.searchSongs
            tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let theText = searchBar.text?.lowercased()
        {
            var newSongAr = [SongObj]()
            for song in searchSongs{
                if(song.nameOfArtist.lowercased().contains(theText) || song.nameOfSong.lowercased().contains(theText))
                {
                    newSongAr.append(song)
                }
            }
            
            songs = newSongAr
            if(theText == "")
            {
                songs = searchSongs
            }
            tableView.reloadData()
        }else{
            songs = searchSongs
            tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    @objc func swipeRight(_ sender: UISwipeGestureRecognizer)
    {
        //theTabBar.perform(#selector(theTabBar.swipeRight),with: nil, afterDelay: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = CGRect(x: self.view.bounds.width * 0.2, y: self.navView.frame.maxY, width: self.view.bounds.width - self.view.bounds.width * 0.2, height: self.view.bounds.height - self.navView.frame.maxY)
            
            //self.searchBar.frame = CGRect(x: self.view.bounds.width * 0.2, y: self.navView.frame.maxY, width: self.view.bounds.width - self.view.bounds.width * 0.2, height: 40)
        })
        if(tableView.cellForRow(at: (IndexPath(row: 0, section: 0))) != nil)
        {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    @objc func swipeLeft(_ sender: UISwipeGestureRecognizer)
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = CGRect(x: 0, y: self.navView.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - self.navView.frame.maxY)
            //self.searchBar.frame = CGRect(x: 0, y: self.navView.frame.maxY, width: self.view.bounds.width, height: 40)
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell") as! savedCellTableViewCell
        let cell = savedCellTableViewCell()
        cell.nameOfArtist.text = songs[indexPath.row].nameOfArtist
        cell.nameOfSong.text = ("\"" + (songs[indexPath.row].nameOfSong) + "\"")
        cell.difficulty.text = songs[indexPath.row].difficulty
//        if(songs[indexPath.row].link == true)
//        {
//            cell.link = true
//        }else{
//            cell.link = false
//        }
        if let type = songs[indexPath.row].theType
        {
            cell.type = type
        }
        cell.nameOfArtist.sizeToFit()
        cell.nameOfSong.sizeToFit()
        cell.difficulty.sizeToFit()
        
        cell.nameOfArtist.adjustsFontSizeToFitWidth = true
        cell.nameOfSong.adjustsFontSizeToFitWidth = true
        cell.difficulty.adjustsFontSizeToFitWidth = true
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.cellForRow(at: indexPath) != nil)
        {
            if(songs[indexPath.row].theType == "custom")
            {
                let controller = SongVC()
                controller.songName = ("\"" + (songs[indexPath.row].nameOfSong) + "\"")
                controller.artistName = (songs[indexPath.row].nameOfArtist)
                controller.difficulty = (songs[indexPath.row].difficulty)
                controller.theUid = (songs[indexPath.row].uid)
                controller.fullSong = (songs[indexPath.row].songTab)
                controller.theDescription = songs[indexPath.row].theDescription!
                controller.discover = true
                controller.admin = admin
                
                
                self.present(controller, animated: true, completion: nil)
            }else{
                let controller = SongLinkVC()
                controller.songName = ("\"" + (songs[indexPath.row].nameOfSong) + "\"")
                controller.artistName = (songs[indexPath.row].nameOfArtist)
                controller.difficulty = (songs[indexPath.row].difficulty)
                controller.theUid = (songs[indexPath.row].uid)
                controller.theDescription = songs[indexPath.row].theDescription!
                controller.discover = true
                controller.admin = admin
                controller.type = songs[indexPath.row].theType
                controller.theLink = songs[indexPath.row].theLink!
                
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func loadTempSongs()
    {
        
    }
    
    func loadSongs()
    {
        var ref = Database.database().reference().child("PublishedSongs")
        if(admin)
        {
            ref = Database.database().reference().child("Songs")
        }
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() {
                return }
            let test = snapshot.value as! [String : AnyObject]
            for(_, value) in test
            {
                let theValue = value as! [String : String]
                let song = SongObj()
                song.nameOfArtist = theValue["theArtist"]
                song.nameOfSong = theValue["theSongName"]
                song.difficulty = theValue["theDifficulty"]
                song.uid = theValue["theUid"]
                song.theType = "custom"
                song.songTab.e = theValue["e"]
                song.songTab.a = theValue["a"]
                song.songTab.d = theValue["d"]
                song.songTab.g = theValue["g"]
                song.songTab.b = theValue["b"]
                song.songTab.ee = theValue["ee"]
                
                if let desc = theValue["theDescription"]
                {
                    song.theDescription = desc
                }else
                {
                    song.theDescription = ""
                }
                
                self.songs.append(song)
                self.searchSongs.append(song)
            }
            self.tableView.reloadData()
        })
        loadLinks()
    }
    
    func loadLinks()
    {
        var ref = Database.database().reference().child("PublishedLinks")
        if(admin)
        {
            ref = Database.database().reference().child("Links")
        }
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() {
                return }
            let test = snapshot.value as! [String : AnyObject]
            for(_, value) in test
            {
                let theValue = value as! [String : String]
                let song = SongObj()
                song.nameOfArtist = theValue["theArtist"]
                song.nameOfSong = theValue["theSongName"]
                song.difficulty = theValue["theDifficulty"]
                song.uid = theValue["theUid"]
                song.link = true
                song.theLink = theValue["theLink"]
                
                if let desc = theValue["theDescription"]
                {
                    song.theDescription = desc
                }else
                {
                    song.theDescription = ""
                }
                
                if let type = theValue["theType"]
                {
                    song.theType = type
                }
                self.songs.append(song)
                self.searchSongs.append(song)
            }
            self.songs.sort(by: { $0.nameOfSong < $1.nameOfSong })
            self.searchSongs.sort(by: { $0.nameOfSong < $1.nameOfSong })
            self.tableView.reloadData()
        })
    }
    
}
