//
//  CreateVC.swift
//  FingerStyle
//
//  Created by Jonathan Kopp on 1/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class CreateVC: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    var ArtistTextField = UITextField()
    var artistLabel = UILabel()
    var SongTextField = UITextField()
    var songLabel = UILabel()
    var difficulty = String()
    var errorMSG = UILabel()

    var begButton = UIButton()
    var intButton = UIButton()
    var expButton = UIButton()
    var doneButton = UIButton()
    var desctextView = UITextView()
    var descField = UITextField()
    var descLabel = UILabel()
    var guitar = UIImageView()
    var guitarCover = UIImageView()
    var slider = UISlider()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: self.view.bounds.height * 0.1))
        navView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navView.isOpaque = true
        
        let label = UILabel(frame: CGRect(x:0, y: navView.bounds.height/2-10, width: navView.bounds.width, height: 50))
        label.text = "Create Tab"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        let backbutton = UIButton(frame: CGRect(x: 10, y: label.frame.minY + 12.5, width: 25, height: 25))
        backbutton.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        backbutton.addTarget(self, action:#selector(self.backPressed), for: .touchUpInside)
        navView.addSubview(backbutton)
        navView.addSubview(label)
        self.view.addSubview(navView)
        
        let label2 = UILabel(frame: CGRect(x:10, y: navView.bounds.height, width: navView.bounds.width-20, height: 20))
        label2.text = "Enter song's name & artist's name. Then select the difficulty."
        label2.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label2.font = UIFont(name: "Avenir-Book", size: 20.0)
        label2.textAlignment = .center
        label2.adjustsFontSizeToFitWidth = true
        self.view.addSubview(label2)
        SongTextField.frame = CGRect(x: 50, y: navView.frame.maxY + 30, width: view.bounds.width - 100, height: 50)
        SongTextField.isEnabled = true
        //SongTextField.placeholder = "Song name."
        SongTextField.attributedPlaceholder = NSAttributedString(string: "Song's name.",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        SongTextField.font = UIFont(name: "Avenir-Book", size: 25)
        SongTextField.autocorrectionType = UITextAutocorrectionType.yes
        SongTextField.keyboardType = UIKeyboardType.default
        SongTextField.returnKeyType = UIReturnKeyType.done
        SongTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        SongTextField.contentVerticalAlignment = .center
        SongTextField.delegate = self
        SongTextField.backgroundColor = .clear
        //SongTextField.layer.cornerRadius = 25
        //SongTextField.layer.borderWidth = 2
        //SongTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        SongTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        SongTextField.textAlignment = .center
        SongTextField.adjustsFontSizeToFitWidth = true
        
        let songLine = UIView()
        songLine.frame = CGRect(x: 0, y: SongTextField.frame.height - 12, width: SongTextField.frame.width, height: 2)
        songLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        songLabel.frame = CGRect(x: SongTextField.frame.maxX + 5, y: SongTextField.frame.midY - 12.5, width: 40, height: 25)
        songLabel.text = "0/30"
        songLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        songLabel.font = UIFont(name: "Avenir", size: 12)
        self.view.addSubview(songLabel)
        SongTextField.addSubview(songLine)
        self.view.addSubview(SongTextField)
        
        
        ArtistTextField.frame = CGRect(x: 50, y: SongTextField.frame.maxY + 10, width: view.bounds.width - 100, height: 50)
        ArtistTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ArtistTextField.isEnabled = true
        //ArtistTextField.placeholder = "Artist name."
        ArtistTextField.attributedPlaceholder = NSAttributedString(string: "Artist's name.",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        ArtistTextField.font = UIFont(name: "Avenir-Book", size: 25)
        ArtistTextField.autocorrectionType = UITextAutocorrectionType.yes
        ArtistTextField.keyboardType = UIKeyboardType.default
        ArtistTextField.returnKeyType = UIReturnKeyType.done
        ArtistTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        ArtistTextField.contentVerticalAlignment = .center
        ArtistTextField.delegate = self
        ArtistTextField.backgroundColor = .clear
        //ArtistTextField.layer.cornerRadius = 25
        //ArtistTextField.layer.borderWidth = 2
        //ArtistTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        ArtistTextField.textAlignment = .center
        ArtistTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ArtistTextField.adjustsFontSizeToFitWidth = true
        
        let aLine = UIView()
        aLine.frame = CGRect(x: 0, y: ArtistTextField.frame.height - 12, width: ArtistTextField.frame.width, height: 2)
        aLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
        artistLabel.frame = CGRect(x: ArtistTextField.frame.maxX + 5, y: ArtistTextField.frame.midY - 12.5, width: 40, height: 25)
        artistLabel.text = "0/30"
        artistLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        artistLabel.font = UIFont(name: "Avenir", size: 12)
        self.view.addSubview(artistLabel)
        ArtistTextField.addSubview(aLine)
        self.view.addSubview(ArtistTextField)
        
        doneButton = UIButton(frame: CGRect(x: 100, y: self.view.bounds.height - 70, width: view.bounds.width - 200, height: 50))
        doneButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        doneButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20.0)
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        doneButton.addTarget(self, action:#selector(self.donePressed), for: .touchUpInside)
        doneButton.layer.cornerRadius = 20
        doneButton.layer.borderWidth = 2
        doneButton.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.view.addSubview(doneButton)
        
        descField.frame = CGRect(x: 50, y: doneButton.frame.minY - 55, width: view.bounds.width - 100, height: 50)
        descField.adjustsFontSizeToFitWidth = true
        descField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        descField.isEnabled = true
        //ArtistTextField.placeholder = "Artist name."
        descField.attributedPlaceholder = NSAttributedString(string: "Additional song information.",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        descField.font = UIFont(name: "Avenir-Book", size: 15)
        descField.autocorrectionType = UITextAutocorrectionType.yes
        descField.keyboardType = UIKeyboardType.default
        descField.returnKeyType = UIReturnKeyType.done
        descField.clearButtonMode = UITextField.ViewMode.whileEditing;
        descField.contentVerticalAlignment = .center
        descField.delegate = self
        descField.backgroundColor = .clear
//        descField.layer.cornerRadius = 25
//        descField.layer.borderWidth = 2
//        descField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        descField.textAlignment = .center
        descField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        let dLine = UIView()
        dLine.frame = CGRect(x: 0, y: descField.frame.height - 12, width: ArtistTextField.frame.width, height: 2)
        dLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
        descLabel.frame = CGRect(x: descField.frame.maxX + 5, y: descField.frame.midY - 12.5, width: 40, height: 25)
        descLabel.text = "0/50"
        descLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        descLabel.font = UIFont(name: "Avenir", size: 12)
        self.view.addSubview(descLabel)
        descField.addSubview(dLine)
        self.view.addSubview(descField)
        
        
        
        begButton = UIButton(frame: CGRect(x: 10, y: ArtistTextField.frame.maxY + 10, width: view.bounds.width * 0.3, height: 50))
        begButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        begButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20.0)
        begButton.titleLabel?.adjustsFontSizeToFitWidth = true
        begButton.setTitle("Beginner", for: .normal)
        begButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        begButton.addTarget(self, action:#selector(self.begPressed), for: .touchUpInside)
        begButton.layer.cornerRadius = 25
        begButton.layer.borderWidth = 2
        begButton.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        self.view.addSubview(begButton)
        
        intButton = UIButton(frame: CGRect(x: begButton.frame.maxX + 10, y: ArtistTextField.frame.maxY + 10, width: view.bounds.width * 0.3, height: 50))
        intButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        intButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20.0)
        intButton.titleLabel?.adjustsFontSizeToFitWidth = true
        intButton.setTitle("Intermediate", for: .normal)
        intButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        intButton.addTarget(self, action:#selector(self.intPressed), for: .touchUpInside)
        intButton.layer.cornerRadius = 25
        intButton.layer.borderWidth = 2
        intButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        self.view.addSubview(intButton)
        
        expButton = UIButton(frame: CGRect(x: intButton.frame.maxX + 10, y: ArtistTextField.frame.maxY + 10, width: view.bounds.width * 0.3, height: 50))
        expButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        expButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20.0)
        expButton.titleLabel?.adjustsFontSizeToFitWidth = true
        expButton.setTitle("Expert", for: .normal)
        expButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        expButton.addTarget(self, action:#selector(self.expPressed), for: .touchUpInside)
        expButton.layer.cornerRadius = 25
        expButton.layer.borderWidth = 2
        expButton.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        self.view.addSubview(expButton)
        
    
        errorMSG.frame = CGRect(x: 10, y: intButton.frame.maxY, width: self.view.bounds.width - 20, height: 30)
        
        drawGuitar()
    }
    
    

    @objc func backPressed()
    {
            //let controller = SavedVC()
            self.dismiss(animated: false, completion: nil)
            //self.present(controller, animated: true, completion: nil)
    }
    @objc func begPressed()
    {
        difficulty = "Beginner"
        begButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        expButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        intButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        guitarCover.frame = guitar.frame
        guitarCover.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
        guitarCover.contentMode = .scaleAspectFit
        guitarCover.alpha = 0
        self.view.addSubview(guitarCover)
        UIView.animate(withDuration: 0.4, animations: {
            self.guitarCover.alpha = 1
            
        }, completion: { (finished: Bool) in
            self.guitar.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
            self.guitarCover.removeFromSuperview()
        })
        
    }
    @objc func intPressed()
    {
        difficulty = "Intermediate"
        
        begButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        expButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        intButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        guitarCover.frame = guitar.frame
        guitarCover.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
        guitarCover.contentMode = .scaleAspectFit
        guitarCover.alpha = 0
        self.view.addSubview(guitarCover)
        UIView.animate(withDuration: 0.4, animations: {
            self.guitarCover.alpha = 1
            
        }, completion: { (finished: Bool) in
            self.guitar.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
            self.guitarCover.removeFromSuperview()
        })
        
    }
    @objc func expPressed()
    {
        difficulty = "Expert"
        begButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        intButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        expButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        guitarCover.frame = guitar.frame
        guitarCover.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        guitarCover.contentMode = .scaleAspectFit
        guitarCover.alpha = 0
        self.view.addSubview(guitarCover)
        UIView.animate(withDuration: 0.4, animations: {
            self.guitarCover.alpha = 1
            
        }, completion: { (finished: Bool) in
            self.guitar.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            self.guitarCover.removeFromSuperview()
        })
    }
    
    @objc func donePressed()
    {
        errorMSG.removeFromSuperview()
        if(SongTextField.text == "")
        {
            errorMSG.text = "Song must have a name."
        }
        else if(ArtistTextField.text == "")
        {
            errorMSG.text = "Song must have an artist."
        }
        else if(difficulty == "")
        {
            errorMSG.text = "Select difficulty."
        }else{
            let controller = CreateWebCustom()
            controller.artistName = ArtistTextField.text!
            controller.songName = SongTextField.text!
            controller.difficulty = difficulty
            if(descField.text == "Additional song information.")
            {
                descField.text = ""
            }
            controller.theDescription = descField.text!
            self.present(controller, animated: false, completion: nil)
        }
        errorMSG.frame = CGRect(x: 10, y: intButton.frame.maxY, width: self.view.bounds.width - 20, height: 30)
        errorMSG.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        errorMSG.font = UIFont(name: "AvenirNext-Bold", size: 15)
        errorMSG.textAlignment = .center
        //errorMSG.sizeToFit()
        errorMSG.adjustsFontSizeToFitWidth = true
        self.view.addSubview(errorMSG)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        super.touchesBegan(touches,  with: event)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        checkMaxLength(textField: textField)
        let newLength = (textField.text!.count) + (string.count) - range.length
        if(textField == SongTextField)
        {
            songLabel.text = "\(String(newLength))/30"
        }else if(textField == ArtistTextField)
        {
            artistLabel.text = "\(String(newLength))/30"
        }else
        {
            descLabel.text = "\(String(newLength))/50"
        }
        return true
    }

    func checkMaxLength(textField: UITextField!) {
        if(textField == descField)
        {
        if (textField.text!.count >= 50) {
            textField.deleteBackward()
        }
        }else{
            if (textField.text!.count >= 30) {
                textField.deleteBackward()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == descField)
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.descField.frame = CGRect(x: 50, y: self.intButton.frame.maxY + 2.5, width: self.view.bounds.width - 100, height: 50)
                self.descLabel.frame = CGRect(x: self.descField.frame.maxX + 5, y: (self.intButton.frame.maxY) + 7.5, width: 40, height: 25)
                
                
                })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == descField)
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.descField.frame = CGRect(x: 50, y: self.doneButton.frame.minY - 55, width: self.view.bounds.width - 100, height: 50)
                self.descLabel.frame = CGRect(x: self.descField.frame.maxX + 5, y: self.descField.frame.midY - 12.5, width: 40, height: 25)
                
                
            })
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func drawGuitar()
    {
        let gwidth = self.view.bounds.width
        
        let gy = self.view.bounds.height - (errorMSG.frame.maxY + (self.doneButton.frame.height) + 10)
        let gheight = gy
        guitar.contentMode = .scaleAspectFit
        guitar.image = #imageLiteral(resourceName: "onlyLogo").mask(with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        guitar.frame = CGRect(x: self.view.bounds.width/2 - gwidth/2, y: doneButton.frame.minY - gy, width: gwidth, height: gheight)
        self.view.addSubview(guitar)
    }

}


