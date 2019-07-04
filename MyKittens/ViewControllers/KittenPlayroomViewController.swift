//
//  KittenPlayerViewController.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 30.11.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit
import AVFoundation

extension KittenPlayroomViewController: KittenDataSourceDelegate {
    func kittenListLoaded(kittenList: [Kitten]) {
        self.kittenList = kittenList
    }
}

extension Timer {
    static public func schedule(delay: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    static func schedule(repeatInterval interval: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
}

class KittenPlayroomViewController: UIViewController {
    
    @IBOutlet weak var kittenOne: UIImageView!
    @IBOutlet weak var kittenTwo: UIImageView!
    @IBOutlet weak var kittenThree: UIImageView!
    @IBOutlet weak var kittenFour: UIImageView!
    @IBOutlet weak var kittenFive: UIImageView!
    @IBOutlet weak var kittenSix: UIImageView!
    @IBOutlet weak var kittenOneButton: CustomButton!
    @IBOutlet weak var kittenTwoButton: CustomButton!
    @IBOutlet weak var kittenThreeButton: CustomButton!
    @IBOutlet weak var kittenFourButton: CustomButton!
    @IBOutlet weak var kittenFiveButton: CustomButton!
    @IBOutlet weak var kittenSixButton: CustomButton!
    
    var kittenDataSource = KittenDataSource()
    var kittenList: [Kitten] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        kittenDataSource.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "playroomBackground.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        kittenOneButton.myValue = 0
        kittenTwoButton.myValue = 1
        kittenThreeButton.myValue = 2
        kittenFourButton.myValue = 3
        kittenFiveButton.myValue = 4
        kittenSixButton.myValue = 5

        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 0
    }
    
    var player: AVAudioPlayer?
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "catmeow", withExtension: "mp3") else { return }
        
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
    
    @IBOutlet var kittenOneTapGesture: UITapGestureRecognizer!
    @IBOutlet var kittenTwoTapGesture: UITapGestureRecognizer!
    @IBOutlet var kittenThreeTapGesture: UITapGestureRecognizer!
    @IBOutlet var kittenFourTapGesture: UITapGestureRecognizer!
    @IBOutlet var kittenFiveTapGesture: UITapGestureRecognizer!
    @IBOutlet var kittenSixTapGesture: UITapGestureRecognizer!
    
    @IBAction func kittenOneTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 1
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 0
        playSound()
    }
    @IBAction func kittenTwoTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 1
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 0
        playSound()
    }
    @IBAction func kittenThreeTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 1
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 0
        playSound()
    }
    @IBAction func kittenFourTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 1
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 0
        playSound()
    }
    @IBAction func kittenFiveTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 1
        kittenSixButton.alpha = 0
        playSound()
    }
    @IBAction func kittenSixTap(_ sender: UITapGestureRecognizer) {
        kittenOneButton.alpha = 0
        kittenTwoButton.alpha = 0
        kittenThreeButton.alpha = 0
        kittenFourButton.alpha = 0
        kittenFiveButton.alpha = 0
        kittenSixButton.alpha = 1
        playSound()
    }
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! CustomButton
        
        let kitten = kittenList[button.myValue]
        if (segue.destination is KittenExamineRoomViewController){
            let detailViewController = segue.destination as! KittenExamineRoomViewController
            detailViewController.selectedKittenId = kitten.kittenId
        }else if (segue.destination is KittenCareRoomViewController){
            let detailViewController = segue.destination as! KittenCareRoomViewController
            detailViewController.selectedKittenId = kitten.kittenId
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        kittenDataSource.loadKittenList()
        
        Timer.schedule(repeatInterval: 3.0, handler: { _ in 

            if self.kittenOne.frame.origin.x < 20 {
                UIView.animate(withDuration: 2, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenOne.transform = self.kittenOne.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenOneButton.transform = self.kittenOneButton.transform.translatedBy(x: CGFloat(self.kittenOne.frame.origin.x-self.kittenOneButton.frame.origin.x), y: CGFloat(self.kittenOne.frame.origin.y-self.kittenOneButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenOne.frame.origin.x > UIScreen.main.bounds.width-20 { //320
                UIView.animate(withDuration: 2, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenOne.transform = self.kittenOne.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenOneButton.transform = self.kittenOneButton.transform.translatedBy(x: CGFloat(self.kittenOne.frame.origin.x-self.kittenOneButton.frame.origin.x), y: CGFloat(self.kittenOne.frame.origin.y-self.kittenOneButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenOne.frame.origin.y < UIScreen.main.bounds.height/3 { //345
                UIView.animate(withDuration: 2, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenOne.transform = self.kittenOne.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 100)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenOneButton.transform = self.kittenOneButton.transform.translatedBy(x: CGFloat(self.kittenOne.frame.origin.x-self.kittenOneButton.frame.origin.x), y: CGFloat(self.kittenOne.frame.origin.y-self.kittenOneButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenOne.frame.origin.y > UIScreen.main.bounds.height { //600
                UIView.animate(withDuration: 2, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenOne.transform = self.kittenOne.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 100)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenOneButton.transform = self.kittenOneButton.transform.translatedBy(x: CGFloat(self.kittenOne.frame.origin.x-self.kittenOneButton.frame.origin.x), y: CGFloat(self.kittenOne.frame.origin.y-self.kittenOneButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 2, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenOne.transform = self.kittenOne.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenOneButton.transform = self.kittenOneButton.transform.translatedBy(x: CGFloat(self.kittenOne.frame.origin.x-self.kittenOneButton.frame.origin.x), y: CGFloat(self.kittenOne.frame.origin.y-self.kittenOneButton.frame.origin.y))
                    })
                })
            }
            if self.kittenTwo.frame.origin.x < 20 { //20
                UIView.animate(withDuration: 1.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenTwo.transform = self.kittenTwo.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenTwoButton.transform = self.kittenTwoButton.transform.translatedBy(x: CGFloat(self.kittenTwo.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenTwo.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenTwo.frame.origin.x > UIScreen.main.bounds.width-20 {
                UIView.animate(withDuration: 1.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenTwo.transform = self.kittenTwo.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenTwoButton.transform = self.kittenTwoButton.transform.translatedBy(x: CGFloat(self.kittenTwo.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenTwo.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenTwo.frame.origin.y < UIScreen.main.bounds.height/3  {
                UIView.animate(withDuration: 1.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenTwo.transform = self.kittenTwo.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenTwoButton.transform = self.kittenTwoButton.transform.translatedBy(x: CGFloat(self.kittenTwo.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenTwo.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenTwo.frame.origin.y > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 1.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenTwo.transform = self.kittenTwo.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenTwoButton.transform = self.kittenTwoButton.transform.translatedBy(x: CGFloat(self.kittenTwo.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenTwo.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 1.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenTwo.transform = self.kittenTwo.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenTwoButton.transform = self.kittenTwoButton.transform.translatedBy(x: CGFloat(self.kittenTwo.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenTwo.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            if self.kittenThree.frame.origin.x < 20 {
                UIView.animate(withDuration: 1, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenThree.transform = self.kittenThree.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenThreeButton.transform = self.kittenThreeButton.transform.translatedBy(x: CGFloat(self.kittenThree.frame.origin.x-self.kittenTwoButton.frame.origin.x), y: CGFloat(self.kittenThree.frame.origin.y-self.kittenTwoButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenThree.frame.origin.x > UIScreen.main.bounds.width-20 {
                UIView.animate(withDuration: 1, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenThree.transform = self.kittenThree.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenThreeButton.transform = self.kittenThreeButton.transform.translatedBy(x: CGFloat(self.kittenThree.frame.origin.x-self.kittenThreeButton.frame.origin.x), y: CGFloat(self.kittenThree.frame.origin.y-self.kittenThreeButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenThree.frame.origin.y < UIScreen.main.bounds.height/3  {
                UIView.animate(withDuration: 1, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenThree.transform = self.kittenThree.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenThreeButton.transform = self.kittenThreeButton.transform.translatedBy(x: CGFloat(self.kittenThree.frame.origin.x-self.kittenThreeButton.frame.origin.x), y: CGFloat(self.kittenThree.frame.origin.y-self.kittenThreeButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenThree.frame.origin.y > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 1, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenThree.transform = self.kittenThree.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenThreeButton.transform = self.kittenThreeButton.transform.translatedBy(x: CGFloat(self.kittenThree.frame.origin.x-self.kittenThreeButton.frame.origin.x), y: CGFloat(self.kittenThree.frame.origin.y-self.kittenThreeButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 1, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenThree.transform = self.kittenThree.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenThreeButton.transform = self.kittenThreeButton.transform.translatedBy(x: CGFloat(self.kittenThree.frame.origin.x-self.kittenThreeButton.frame.origin.x), y: CGFloat(self.kittenThree.frame.origin.y-self.kittenThreeButton.frame.origin.y))
                    })
                })
            }
            if self.kittenFour.frame.origin.x < 20 {
                UIView.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFour.transform = self.kittenFour.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFourButton.transform = self.kittenFourButton.transform.translatedBy(x: CGFloat(self.kittenFour.frame.origin.x-self.kittenFourButton.frame.origin.x), y: CGFloat(self.kittenFour.frame.origin.y-self.kittenFourButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFour.frame.origin.x > UIScreen.main.bounds.width-20 {
                UIView.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFour.transform = self.kittenFour.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFourButton.transform = self.kittenFourButton.transform.translatedBy(x: CGFloat(self.kittenFour.frame.origin.x-self.kittenFourButton.frame.origin.x), y: CGFloat(self.kittenFour.frame.origin.y-self.kittenFourButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFour.frame.origin.y < UIScreen.main.bounds.height/3  {
                UIView.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFour.transform = self.kittenFour.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFourButton.transform = self.kittenFourButton.transform.translatedBy(x: CGFloat(self.kittenFour.frame.origin.x-self.kittenFourButton.frame.origin.x), y: CGFloat(self.kittenFour.frame.origin.y-self.kittenFourButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFour.frame.origin.y > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFour.transform = self.kittenFour.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFourButton.transform = self.kittenFourButton.transform.translatedBy(x: CGFloat(self.kittenFour.frame.origin.x-self.kittenFourButton.frame.origin.x), y: CGFloat(self.kittenFour.frame.origin.y-self.kittenFourButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFour.transform = self.kittenFour.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFourButton.transform = self.kittenFourButton.transform.translatedBy(x: CGFloat(self.kittenFour.frame.origin.x-self.kittenFourButton.frame.origin.x), y: CGFloat(self.kittenFour.frame.origin.y-self.kittenFourButton.frame.origin.y))
                    })
                })
            }
            if self.kittenFive.frame.origin.x < 20 {
                UIView.animate(withDuration: 2.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFive.transform = self.kittenFive.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFiveButton.transform = self.kittenFiveButton.transform.translatedBy(x: CGFloat(self.kittenFive.frame.origin.x-self.kittenFiveButton.frame.origin.x), y: CGFloat(self.kittenFive.frame.origin.y-self.kittenFiveButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFive.frame.origin.x > UIScreen.main.bounds.width-20 {
                UIView.animate(withDuration: 2.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFive.transform = self.kittenFive.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFiveButton.transform = self.kittenFiveButton.transform.translatedBy(x: CGFloat(self.kittenFive.frame.origin.x-self.kittenFiveButton.frame.origin.x), y: CGFloat(self.kittenFive.frame.origin.y-self.kittenFiveButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFive.frame.origin.y < UIScreen.main.bounds.height/3  {
                UIView.animate(withDuration: 2.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFive.transform = self.kittenFive.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFiveButton.transform = self.kittenFiveButton.transform.translatedBy(x: CGFloat(self.kittenFive.frame.origin.x-self.kittenFiveButton.frame.origin.x), y: CGFloat(self.kittenFive.frame.origin.y-self.kittenFiveButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenFive.frame.origin.y > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 2.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFive.transform = self.kittenFive.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFiveButton.transform = self.kittenFiveButton.transform.translatedBy(x: CGFloat(self.kittenFive.frame.origin.x-self.kittenFiveButton.frame.origin.x), y: CGFloat(self.kittenFive.frame.origin.y-self.kittenFiveButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 2.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenFive.transform = self.kittenFive.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenFiveButton.transform = self.kittenFiveButton.transform.translatedBy(x: CGFloat(self.kittenFive.frame.origin.x-self.kittenFiveButton.frame.origin.x), y: CGFloat(self.kittenFive.frame.origin.y-self.kittenFiveButton.frame.origin.y))
                    })
                })
            }
            if self.kittenSix.frame.origin.x < 20 {
                UIView.animate(withDuration: 1.7, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenSix.transform = self.kittenSix.transform.translatedBy(x: CGFloat(80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenSixButton.transform = self.kittenSixButton.transform.translatedBy(x: CGFloat(self.kittenSix.frame.origin.x-self.kittenSixButton.frame.origin.x), y: CGFloat(self.kittenSix.frame.origin.y-self.kittenSixButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenSix.frame.origin.x > UIScreen.main.bounds.width-20 {
                UIView.animate(withDuration: 3.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenSix.transform = self.kittenSix.transform.translatedBy(x: CGFloat(-80), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenSixButton.transform = self.kittenSixButton.transform.translatedBy(x: CGFloat(self.kittenSix.frame.origin.x-self.kittenSixButton.frame.origin.x), y: CGFloat(self.kittenSix.frame.origin.y-self.kittenSixButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenSix.frame.origin.y < UIScreen.main.bounds.height/3  {
                UIView.animate(withDuration: 3.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenSix.transform = self.kittenSix.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenSixButton.transform = self.kittenSixButton.transform.translatedBy(x: CGFloat(self.kittenSix.frame.origin.x-self.kittenSixButton.frame.origin.x), y: CGFloat(self.kittenSix.frame.origin.y-self.kittenSixButton.frame.origin.y))
                    })
                })
            }
            else if self.kittenSix.frame.origin.y > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 3.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenSix.transform = self.kittenSix.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(-80))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenSixButton.transform = self.kittenSixButton.transform.translatedBy(x: CGFloat(self.kittenSix.frame.origin.x-self.kittenSixButton.frame.origin.x), y: CGFloat(self.kittenSix.frame.origin.y-self.kittenSixButton.frame.origin.y))
                    })
                })
            }
            else {
                UIView.animate(withDuration: 3.5, delay:1, options:[.allowUserInteraction], animations: {
                    self.kittenSix.transform = self.kittenSix.transform.translatedBy(x: CGFloat(self.randRange(lower: -30, upper: 30)), y: CGFloat(self.randRange(lower: -30, upper: 30)))
                }, completion:{(true) in
                    CustomButton.animate(withDuration: 3, delay:1, options:[.allowUserInteraction], animations: {
                        self.kittenSixButton.transform = self.kittenSixButton.transform.translatedBy(x: CGFloat(self.kittenSix.frame.origin.x-self.kittenSixButton.frame.origin.x), y: CGFloat(self.kittenSix.frame.origin.y-self.kittenSixButton.frame.origin.y))
                    })
                })
            }
        })
    }
}
