//
//  ViewController.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/5/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import UIKit
import CoreData

class SimpsonsCharacterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "SimpsonCollectionViewCell"
    var simpsons = [Simpsons]()
    var selectionIndex = 0
    //let manager = PersistenceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        
        simpsons = PersistenceManager.loadSavedSimpsons()
        
        if simpsons == [] {
            self.downloadSimpsons()
        }
        
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        selectionIndex = sender.selectedSegmentIndex
        self.collectionView.reloadData()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        PersistenceManager.deleteAllSimpsons()
        
        //reload the view controller, which includes redownloading all of the data
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SimpsonsCharacterViewController")
        var viewControllers = self.navigationController!.viewControllers
        viewControllers.removeLast()
        viewControllers.append(vc)
        self.navigationController?.setViewControllers(viewControllers, animated: false)
    }
    
    
    func downloadSimpsons() {
        
        let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")!
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String:Any]
            
            let characters =  json["RelatedTopics"] as! [[String:Any]]
            
            for character in characters {
                let imageDict = character["Icon"] as! [String:String]
                let imageURL = imageDict["URL"]!
                let text = character["Text"] as! String
                //split text up into name and desc, respectively
                let separated = text.components(separatedBy: " - ")
                //print(separated[1])
                //let newSimpson = Simpson(separated[0], separated[1], imageURL)
                //self.simpsons.append(newSimpson)
                self.downloadImage(imageURL, completion: { (imageData) in
                    //send back to collectionView to show
                    DispatchQueue.main.async {
                        
                        let newSimpson = PersistenceManager.addSimpson(separated[0], separated[1], imageData)
                        //print(newSimpson.desc!)
                        self.simpsons.append(newSimpson)
                        self.collectionView.reloadData()
                    }
                })
            }
            }.resume()
        
    }
    
    func downloadImage(_ urlString: String,
                       completion: @escaping (Data)->()) {
        
        let filePath = Bundle.main.path(forResource: "doh", ofType: "png")
        let url = URL(string: urlString) ?? URL.init(fileURLWithPath: filePath!)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                //print("Did receive image data")
                completion(safeData)
            }
        }
        
        dataTask.resume()
        
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "SimpsonCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
        //self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension SimpsonsCharacterViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.simpsons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SimpsonCollectionViewCell
        
        let data = Data(referencing: self.simpsons[indexPath.row].image!)
        cell.imageView.image = UIImage(data: data)
        cell.nameLabel.text = self.simpsons[indexPath.row].name
        
        //changes table display depending on segmented control
        if selectionIndex == 1 {
            cell.imageView.isHidden = false
            cell.nameLabel.isHidden = true
        } else {
            cell.imageView.isHidden = true
            cell.nameLabel.isHidden = false
        }
        
        return cell
    }
    
}

extension SimpsonsCharacterViewController: UICollectionViewDelegate {
    
    //adds touch functionality to individual cells, need to configure for linking to character profile page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("did select cell: \(indexPath)")
        
        let selectedIndex = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        vc.simpson = self.simpsons[selectedIndex]
        self.navigationController!.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        
        //self.simpsons.remove(at: selectedIndex)
        //self.collectionView.reloadData()
    }
}

extension SimpsonsCharacterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.collectionView.frame.size.width
        // let screenHeight = self.collectionView.frame.size.height
        
        return CGSize(width: screenWidth/3.0,
                      height: screenWidth/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}


/* reference material
class PokedexViewController: UIViewController {
    
    let cellIdentifier = "cellBreak"
    
    @IBOutlet var collectionView: UICollectionView!
    
    var manager = ServiceManager()
    
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        
        self.downloadPokemon()
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
        //self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func downloadPokemon() {
        let completion = { [unowned self] (newMon: Pokemon) in
            // print("Did receive image data to show")
            DispatchQueue.main.async { [unowned self] in
                self.pokemon.append(newMon)
                self.collectionView.reloadData()
                //    print("did set image data")
            }
            // print("Dispatched work to the main thread")
        }
        
        self.manager.downloadPokemon("hitmontop",
                                     completion: completion)
        self.manager.downloadPokemon("ivysaur",
                                     completion: completion)
        self.manager.downloadPokemon("jigglypuff",
                                     completion: completion)
        self.manager.downloadPokemon("pikachu",
                                     completion: completion)
        self.manager.downloadPokemon("ditto",
                                     completion: completion)
        self.manager.downloadPokemon("bulbasaur",
                                     completion: completion)
        self.manager.downloadPokemon("mew",
                                     completion: completion)
        self.manager.downloadPokemon("squirtle",
                                     completion: completion)
        self.manager.downloadPokemon("honedge",
                                     completion: completion)
        self.manager.downloadPokemon("haunter",
                                     completion: completion)
    }
    
}

extension PokedexViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokemonCollectionViewCell
        
        let data = Data(referencing: self.pokemon[indexPath.row].shinyImage!)
        cell.imageView.image = UIImage(data: data)
        cell.nameLabel.text = self.pokemon[indexPath.row].name
        
        return cell
    }
 
}

extension PokedexViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select cell: \(indexPath)")
        
        let selectedPokemonIndex = indexPath.row
        let selectedMon = self.pokemon[selectedPokemonIndex]
        PersistenceManager.addPokemonToTrainer(selectedMon)
        
        self.pokemon.remove(at: selectedPokemonIndex)
        self.collectionView.reloadData()
    }
}


extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.collectionView.frame.size.width
        // let screenHeight = self.collectionView.frame.size.height
        
        return CGSize(width: screenWidth/3.0,
                      height: screenWidth/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}*/
