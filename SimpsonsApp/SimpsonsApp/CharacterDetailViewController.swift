//
//  CharacterDetailViewController.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/6/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    var simpson: Simpsons!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Character Details"
        
        self.nameLabel.text = simpson.name
        self.descTextView.text = simpson.desc
        self.imageView.image = UIImage(data: simpson.image as! Data)
        
    }
    
    
    
    
}

/* reference material
class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var movesLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(data: Data(referencing: self.pokemon.shinyImage!))
        self.idLabel.text = "\(pokemon.idNum)"
        self.nameLabel.text = pokemon.name!
        self.typeLabel.text = pokemon.type!
        //    self.movesLabel.text = pokemon.allMoves().map{ $0.name! }.joined(separator: "\n")
        
        self.typeLabel.numberOfLines = 0
        self.movesLabel.numberOfLines = 0
    }
    
    @IBAction func makeSteveAction(_ sender: Any) {
        self.pokemon.name = "Steve"
        PersistenceManager.savePokemon()
        self.nameLabel.text = pokemon.name!
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        PersistenceManager.deletePokemon(self.pokemon)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}*/
