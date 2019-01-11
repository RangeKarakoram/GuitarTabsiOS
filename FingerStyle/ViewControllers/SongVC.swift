//
//  SongVC.swift
//  FingerStyle
//
//  Created by Jonathan Kopp on 1/8/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit
import Firebase

class SongVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate{

    var songName = String()
    var artistName = String()
    var difficulty = String()
    var tableView = UITableView()
    var theSong = [SongTabObj]()
    var fullSong = SongTabObj()
    var theUid = String()
    
    var currentTab = IndexPath()
    var timerLine = UIView()
    var playButton = UIButton()
    var speedMultiplier = CGFloat()
    var playing = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(theUid)
        createTempSong()
        print((self.view.bounds.width / 20) / 2)
        
        print(songName)
        self.view.backgroundColor = .white
        print("Saved VC")
        tableView.register(songTableViewCell.self, forCellReuseIdentifier: "songCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height-150)
        tableView.allowsSelection = false
        
        
        self.view.backgroundColor = .white
        
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        navView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let label = UILabel(frame: CGRect(x:25, y: navView.bounds.height / 2, width: navView.bounds.width - 50, height: 50))
        var theColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        if(difficulty == "Intermediate")
        {
            theColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }else if(difficulty == "Expert")
        {
            theColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else{
            theColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        let song = NSMutableAttributedString(string: songName, attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNext-BoldItalic", size: 35)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
         let splitter = NSMutableAttributedString(string: " - ", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNext-Heavy", size: 32)!, NSAttributedString.Key.foregroundColor : theColor])
        let artist = NSMutableAttributedString(string: artistName, attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Book", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        song.append(splitter)
        song.append(artist)
        label.attributedText = song
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        let backbutton = UIButton(frame: CGRect(x: 0, y: label.frame.midY - 20, width: 25, height: 25))
        backbutton.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        backbutton.addTarget(self, action:#selector(self.backPressed), for: .touchUpInside)
        
        navView.addSubview(label)
        navView.addSubview(backbutton)
        self.view.addSubview(navView)
        self.view.addSubview(tableView)
        
        
        timerLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        timerLine.frame = CGRect(x: 10, y: 30, width: 0, height: 145)
        self.tableView.addSubview(timerLine)
        
        speedMultiplier = 1
        playing = false
        currentTab = IndexPath(row: 0, section: 0)
        
        let buttonView = UIView()
        buttonView.frame = CGRect(x: 0, y: self.view.bounds.height - 50, width: self.view.bounds.width, height: 50)
        buttonView.backgroundColor = .white
        
        playButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 25, y: -15, width: 50, height: 50))
        playButton.setImage(#imageLiteral(resourceName: "icons8-circled-play-50 (1)"), for: .normal)
        playButton.addTarget(self, action:#selector(self.playPressed), for: .touchUpInside)
        buttonView.addSubview(playButton)
        
        let slowDownButton = UIButton(frame: CGRect(x: playButton.frame.minX - 40, y: -5, width: 35, height: 35))
        slowDownButton.setImage(#imageLiteral(resourceName: "icons8-rewind-50"), for: .normal)
        slowDownButton.addTarget(self, action:#selector(self.slowDown), for: .touchUpInside)
        buttonView.addSubview(slowDownButton)
        
        let speedUpButton = UIButton(frame: CGRect(x: playButton.frame.maxX + 5, y: -5, width: 35, height: 35))
        speedUpButton.setImage(#imageLiteral(resourceName: "icons8-fast-forward-50"), for: .normal)
        speedUpButton.addTarget(self, action:#selector(self.speedUP), for: .touchUpInside)
        buttonView.addSubview(speedUpButton)
        
        self.view.addSubview(buttonView)
        
    }
    @objc func playPressed()
    {
        print("Play Pressed")
        if(playing == false)
        {
        scheduledTimerWithTimeInterval()
        playButton.setImage(#imageLiteral(resourceName: "icons8-pause-button-50 (1)"), for: .normal)
            playing = true
        }else{
            playButton.setImage(#imageLiteral(resourceName: "icons8-play-50"), for: .normal)
            playing = false
        }
        
    }
    @objc func slowDown()
    {
        if(speedMultiplier == 2)
        {
            speedMultiplier = 1
        }else{
        speedMultiplier = 0.5
        }
    }
    @objc func speedUP()
    {
        if(speedMultiplier == 0.5)
        {
            speedMultiplier = 1.0
        }else
        {
            speedMultiplier = 2
        }
    }
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "drawBack" with the interval of 1 seconds
        var timer = Timer()
        self.timerLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.8)
        timer = Timer.scheduledTimer(withTimeInterval: 0.009, repeats: true, block: {_ in
            if(self.playing)
            {
                self.drawTimer()
            }else
            {
                self.timerLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.2)
                timer.invalidate()
                return
            }
            if(self.currentTab.row>=self.tableView.numberOfRows(inSection: 0)){
                self.playing = false
                self.playButton.setImage(#imageLiteral(resourceName: "icons8-play-50"), for: .normal)
                self.currentTab = IndexPath(row: 0, section: 0)
                self.timerLine.removeFromSuperview()
                self.timerLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.2)
                self.timerLine.frame = CGRect(x: 10, y: 30, width: 0, height: 145)
                self.tableView.addSubview(self.timerLine)
                self.tableView.scrollToRow(at: self.currentTab, at: .top, animated: true)
                timer.invalidate()
                return
            }
            
        })
    }
    
    @objc func drawTimer()
    {
        //print("Boop")
        timerLine.removeFromSuperview()
        if(timerLine.frame.minX <= self.view.bounds.width - 20)
        {
        timerLine.frame = CGRect(x: timerLine.frame.minX + speedMultiplier, y: timerLine.frame.minY, width: 5, height: 145)
        }else{
            timerLine.frame = CGRect(x: 10, y: timerLine.frame.minY + 160, width: 5, height: 145)
            print("Current Tab", currentTab)
            currentTab = IndexPath(row: currentTab.row + 1, section: 0)
            if(currentTab.row < tableView.numberOfRows(inSection: 0))
            {
                tableView.scrollToRow(at: currentTab, at: .top, animated: true)
            }
            
        }
        tableView.addSubview(timerLine)
        
    }
    
    @objc func backPressed()
    {
        print("Back Pressed")
            self.dismiss(animated: true, completion: nil)
//            let controller = SavedVC()
//            self.present(controller, animated: false, completion: nil)
//            TabBarVC.currentSelected = "Saved"
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("Getting Called")
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            return (tableView.indexPathForRow(at: location) == nil)
        }
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAmountOfLines()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! songTableViewCell
        
        if(indexPath.row<theSong.count)
        {
            print(theSong[indexPath.row].theE)
            print(theSong[indexPath.row].e)
            
            cell.e.text = theSong[indexPath.row].e
            cell.a.text = theSong[indexPath.row].a
            cell.d.text = theSong[indexPath.row].d
            cell.g.text = theSong[indexPath.row].g
            cell.b.text = theSong[indexPath.row].b
            cell.ee.text = theSong[indexPath.row].ee
            
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at IndexPath: ", indexPath)
    }
    
    
    func calculateBPM()
    {
        //Should calculate how many notes per second
    }
    
    func getNotesPerLine() -> Int
    {
        //Should return how many notes before going to the next line.
        return Int((self.view.bounds.width / 20) / 2)
        
    }
    func getAmountOfLines() -> Int
    {
        //Calls NotesPerLine and BPM to return the amount of lines the table view should have
        let toReturn = Int(fullSong.theE.count / getNotesPerLine())
        return toReturn
    }
    
    func fillTableView()
    {
        //should get BPM and notesPerLine to figure out how/where to place all the notes
        //Divide the width / notesPerline to find out spacing between the notes.
        
    }
    func spacingBetweenNotes()->String
    {
        return "   "
    }
    
    
    func createTempSong()
    {
        
        //let theSong = SongTabObj()
//        theSong.e = "5 -5 -  -5 -5 -5 -5 -  -5 -  -5 -5 -  -5 -  -5 -5 -  -5 -5 "
//        theSong.a = "  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  "
//        theSong.d = "  -  -0 -  -  -  -  -0 -  -  -  -  -0 -  -  -  -  -0 -  - "
//        theSong.g = "5 -  -  -  -  -5 -  -  -  -  -5 -  -  -  -  -5 -  -  -  -5 "
//        theSong.b = "  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  "
//       theSong.ee = "  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  "
        
        
        //fullSong = theSong
        print("tEST" + fullSong.e)
        fullSong.theE = fullSong.e.components(separatedBy: "-")
        fullSong.theA = fullSong.a.components(separatedBy: "-")
        fullSong.theD = fullSong.d.components(separatedBy: "-")
        fullSong.theG = fullSong.g.components(separatedBy: "-")
        fullSong.theB = fullSong.b.components(separatedBy: "-")
        fullSong.theEE = fullSong.ee.components(separatedBy: "-")
        checkSizing()
        
    }
    
    func checkSizing()
    {
        var max = fullSong.theE.count
        if(max < fullSong.theA.count)
        {
            max = fullSong.theA.count
        }
        if(max < fullSong.theD.count)
        {
            max = fullSong.theD.count
        }
        if(max < fullSong.theG.count)
        {
            max = fullSong.theG.count
        }
        if(max < fullSong.theB.count)
        {
            max = fullSong.theB.count
        }
        if(max < fullSong.theEE.count)
        {
            max = fullSong.theEE.count
        }
        fixSizing(themax: max)
    }
    
    func fixSizing(themax: Int)
    {
        let numNotesPerLine = getNotesPerLine()
        var max = themax
        print(max % numNotesPerLine) //1 for 21 % 10
        if(max % numNotesPerLine != 0)
        {
            let toAdd = numNotesPerLine - (max % numNotesPerLine)
            max += toAdd
        }
        
        while(fullSong.theE.count < max)
        {
            fullSong.theE.append("  ")
        }
        while(fullSong.theA.count < max)
        {
            fullSong.theA.append("  ")
        }
        while(fullSong.theD.count < max)
        {
            fullSong.theD.append("  ")
        }
        while(fullSong.theG.count < max)
        {
            fullSong.theG.append("  ")
        }
        while(fullSong.theB.count < max)
        {
            fullSong.theB.append("  ")
        }
        while(fullSong.theEE.count < max)
        {
            fullSong.theEE.append("  ")
        }
        print(fullSong.theE.count)
        print(fullSong.theA.count)
        print(fullSong.theD.count)
        print(fullSong.theG.count)
        print(fullSong.theB.count)
        print(fullSong.theEE.count)
        seperateIntoArray()
    }
    
    func seperateIntoArray()
    {
        let numLines = getAmountOfLines()
        let numNotes = getNotesPerLine()
        
        var linectr = 0
        
        //Loops tab by tab
        while(linectr<numLines)
        {
            let first = linectr * numNotes
            let second = first + numNotes
            let newSongLine = SongTabObj()
            newSongLine.theE = Array(fullSong.theE[first..<second])
            newSongLine.e = ""
            newSongLine.theA = Array(fullSong.theA[first..<second])
            newSongLine.a = ""
            newSongLine.theD = Array(fullSong.theD[first..<second])
            newSongLine.d = ""
            newSongLine.theG = Array(fullSong.theG[first..<second])
            newSongLine.g = ""
            newSongLine.theB = Array(fullSong.theB[first..<second])
            newSongLine.b = ""
            newSongLine.theEE = Array(fullSong.theEE[first..<second])
            newSongLine.ee = ""
            
            theSong.append(newSongLine)
        
            linectr += 1
        }
        addSpacing()
        
        
    }
    
    func addSpacing()
    {
        //let spacing = spacingBetweenNotes()
        var spacing2 = spacingBetweenNotes()
        spacing2.removeLast()
        spacing2.removeLast()
        for i in theSong
        {
            for k in 0 ..< i.theE.count - 1
            {
                i.e = (i.e + i.theE[k] + spacing2)
                i.a = (i.a + i.theA[k] + spacing2)
                i.d = (i.d + i.theD[k] + spacing2)
                i.g = (i.g + i.theG[k] + spacing2)
                i.b = (i.b + i.theB[k] + spacing2)
                i.ee = (i.ee + i.theEE[k] + spacing2)
            }
            i.e = (i.e + i.theE[i.theE.count-1])
            i.a = (i.a + i.theA[i.theE.count-1])
            i.d = (i.d + i.theD[i.theE.count-1])
            i.g = (i.g + i.theG[i.theE.count-1])
            i.b = (i.b + i.theB[i.theE.count-1])
            i.ee = (i.ee + i.theEE[i.theE.count-1])
        }
    }
    
    
    
}
