//
//  KittenCollectionViewController.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 1.12.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit

extension KittenCollectionViewController: KittenDataSourceDelegate {
    func kittenListLoaded(kittenList: [Kitten]) {
        self.kittenList = kittenList
        DispatchQueue.main.async {
            self.kittenCollectionView.reloadData()
        }
    }
}

extension KittenCollectionViewController: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kittenList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let kittenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kittenCell", for: indexPath) as! KittenCollectionViewCell
        let kitten = kittenList[indexPath.row]
        kittenCell.kittenNameLabel.text = "\(kitten.kittenName)"
        kittenCell.kittenCollectionImage.image = UIImage(named: "\(kitten.kittenId)")
        kittenCell.kittenCareButton.myValue = kitten.kittenId
        kittenCell.kittenExamineButton.myValue = kitten.kittenId
        return kittenCell
    }
}

var globalKittenNeed: [[Int]] = [[100,0],[100,0],[100,0],[100,0],[100,0],[100,0]]

class KittenCollectionViewController: UIViewController {

    var kittenDataSource = KittenDataSource()
    var kittenList: [Kitten] = []
    
    @IBOutlet weak var kittenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kittenDataSource.delegate = self
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "collectionBackground.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        Timer.schedule(repeatInterval: 2, handler: { timer in
            for i in 0...globalKittenNeed.count-1 {
                if (globalKittenNeed[i][0] <= 0){
                    //nothing
                    globalKittenNeed[i][0] = 0
                }else {
                    globalKittenNeed[i][0] = globalKittenNeed[i][0] - 1
                }
                if (globalKittenNeed[i][1] < 0){
                    //nothing
                    globalKittenNeed[i][1] = 0
                }else if (globalKittenNeed[i][1] >= 100){
                    //nothing
                    globalKittenNeed[i][1] = 100
                }
                else {
                    globalKittenNeed[i][1] = globalKittenNeed[i][1] + 1
                }
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        kittenDataSource.loadKittenList()
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
}
