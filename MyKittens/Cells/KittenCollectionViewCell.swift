//
//  KittenCollectionViewCell.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 1.12.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit

class KittenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var kittenNameLabel: UILabel!
    @IBOutlet weak var kittenExamineButton: CustomButton!
    @IBOutlet var kittenCareButton: CustomButton!
    @IBOutlet weak var kittenCollectionImage: UIImageView!
    
}

