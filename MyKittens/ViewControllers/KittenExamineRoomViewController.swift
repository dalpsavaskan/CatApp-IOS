//
//  KittenExamineRoomViewController.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 1.12.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit

extension KittenExamineRoomViewController: KittenDataSourceDelegate {
    func kittenDetailLoaded(kittenDetail: Kitten) {
        DispatchQueue.main.async {
            self.kittenNameLabel.text = "Name: \(kittenDetail.kittenName)"
            self.kittenColorLabel.text = "Color: \(kittenDetail.kittenColor)"
            self.kittenSexLabel.text = "Sex: \(kittenDetail.kittenSex)"
            self.kittenAgeLabel.text = "Age: \(kittenDetail.kittenAge)"
            self.kittenLovelinessLabel.text = "Loveliness: \(kittenDetail.kittenLoveliness)"
            self.kittenWildnessLabel.text = "Wildness: \(kittenDetail.kittenWildness)"
            self.kittemExamineImage.image = UIImage(named: "\(kittenDetail.kittenId)")
        }
    }
}

class KittenExamineRoomViewController: UIViewController {
    
    @IBOutlet weak var kittemExamineImage: UIImageView!
    @IBOutlet weak var kittenNameLabel: UILabel!
    @IBOutlet weak var kittenColorLabel: UILabel!
    @IBOutlet weak var kittenSexLabel: UILabel!
    @IBOutlet weak var kittenAgeLabel: UILabel!
    @IBOutlet weak var kittenLovelinessLabel: UILabel!
    @IBOutlet weak var kittenWildnessLabel: UILabel!
    
    var food = 0
    var love = 100
    
    var selectedKittenId : Int?
    let kittenDataSource = KittenDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kittenDataSource.delegate = self
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "examineRoomBackground.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        kittenDataSource.loadKittenDetail(kittenId: selectedKittenId!)
    }
}
