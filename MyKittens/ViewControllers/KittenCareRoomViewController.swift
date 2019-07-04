//
//  KittenCareRoomViewController.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 1.12.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit
import AVFoundation

extension KittenCareRoomViewController: KittenDataSourceDelegate {
    func kittenDetailLoaded(kittenDetail: Kitten) {
        DispatchQueue.main.async {
            self.kittenCareImage.image = UIImage(named: "\(kittenDetail.kittenId)")
            self.kittenCareHunger.text = "Hunger: \(self.hunger!)"
            self.kittenCareLove.text = "Love: \(self.love!)"
        }
    }
}

class KittenCareRoomViewController: UIViewController {
    @IBOutlet weak var kittenCareImage: UIImageView!
    @IBOutlet weak var kittenCareLove: UILabel!
    @IBOutlet weak var kittenCareHunger: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var kittenBottleImage: UIImageView!
    @IBOutlet weak var kittenFoodImage: UIImageView!
    
    var player: AVAudioPlayer?
    
    func playSound(sound: String) {

        guard let url = Bundle.main.url(forResource: "\(sound)", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var hunger : Int?
    var love : Int?
    var selectedKittenId : Int?
    var kittenDataSource = KittenDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        kittenDataSource.delegate = self
        
        heartImage.alpha = 0

        love = globalKittenNeed[selectedKittenId!][0]
        hunger = globalKittenNeed[selectedKittenId!][1]
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "careRoomBackground.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        Timer.schedule(repeatInterval: 2, handler: { timer in
            
            self.heartImage.alpha = 0
            if (self.love! <= 0){
                //nothing
                self.love = 0
                globalKittenNeed[self.selectedKittenId!][0] = self.love!
            }else {
                self.love! = self.love! - 1
               globalKittenNeed[self.selectedKittenId!][0] = self.love!
            }
            if (self.hunger! < 0){
                //nothing
                self.hunger = 0
               globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }else if (self.hunger! >= 100){
                //nothing
                self.hunger = 100
               globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }
            else {
                self.hunger = self.hunger! + 1
                globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }
            self.kittenCareLove.text = "Love: \(self.love!)"
            self.kittenCareHunger.text = "Hunger: \(self.hunger!)"
            globalKittenNeed[self.selectedKittenId!][0] = self.love!
            globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        kittenDataSource.loadKittenDetail(kittenId: selectedKittenId!)
    }
    @IBAction func kittenCareTap(_ sender: UITapGestureRecognizer) {
        playSound(sound: "catpurr")
        if (love! >= 100){
           //nothing
        }else {
            love=love!+1
            heartImage.alpha = 1.0
           globalKittenNeed[self.selectedKittenId!][0] = self.love!
        }
        self.kittenCareLove.text = "Love: \(self.love!)"
    }
    @IBAction func kittenCareSwipe(_ sender: UISwipeGestureRecognizer) {
        playSound(sound: "catpurr")
        if (love! >= 96){
            //nothing
        }else {
            love=love!+5
            globalKittenNeed[self.selectedKittenId!][0] = self.love!
            heartImage.alpha = 1.0
        }
        self.kittenCareLove.text = "Love: \(self.love!)"
    }
    
    @IBAction func kittenBottlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        kittenBottleImage.transform = kittenBottleImage.transform.translatedBy(x: translation.x, y: translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        print(self.kittenBottleImage.frame.origin.x)
        print(self.kittenBottleImage.frame.origin.y)
        print(self.kittenCareImage.frame.origin.x)
        print(self.kittenCareImage.frame.origin.y)

        if self.kittenBottleImage.frame.origin.x > self.kittenCareImage.frame.origin.x  &&
            self.kittenBottleImage.frame.origin.x < self.kittenCareImage.frame.origin.x + 70 &&
            self.kittenBottleImage.frame.origin.y < self.kittenCareImage.frame.origin.y + 70 &&
            self.kittenBottleImage.frame.origin.y > self.kittenCareImage.frame.origin.y  {
            if (hunger! <= 0){
                //nothing
                hunger = 0
                globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }else {
                hunger=hunger!-1
                globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }
            self.kittenCareHunger.text = "Hunger: \(self.hunger!)"
        }
    }
    
    @IBAction func kittenFoodPan(_ sender: UIPanGestureRecognizer) {
        playSound(sound: "catmeow")

        let translation = sender.translation(in: self.view)
        kittenFoodImage.transform = kittenFoodImage.transform.translatedBy(x: translation.x, y: translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        if self.kittenFoodImage.frame.origin.x > self.kittenCareImage.frame.origin.x  &&
            self.kittenFoodImage.frame.origin.x < self.kittenCareImage.frame.origin.x + 70 &&
            self.kittenFoodImage.frame.origin.y < self.kittenCareImage.frame.origin.y + 70 &&
            self.kittenFoodImage.frame.origin.y > self.kittenCareImage.frame.origin.y {
            if (hunger! <= 0){
                //nothing
                hunger = 0
                globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }else {
                hunger=hunger!-10
                kittenFoodImage.alpha = 0
                globalKittenNeed[self.selectedKittenId!][1] = self.hunger!
            }
            self.kittenCareHunger.text = "Hunger: \(self.hunger!)"
        }
    }
}
