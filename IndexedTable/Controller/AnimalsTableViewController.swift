//
//  AnimalsTableViewController.swift
//  IndexedTable
//
//  Created by Chris Huang on 23/09/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class AnimalsTableViewController: UITableViewController {

	// MARK: Model
	let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu",
	               "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama",
	               "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear",
	               "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
	
	var animalsDictionary = [String: [String]]()
	var animalSectionTitles = [String]()
	
	private func createAnimalDictionary() {
		for animal in animals {
			let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
			let key = String(animal[..<firstLetterIndex])
			if var values = animalsDictionary[key] {
				values.append(animal)
				animalsDictionary[key] = values
			} else {
				animalsDictionary[key] = [animal]
			}
		}
		
		animalSectionTitles = [String](animalsDictionary.keys).sorted{ $0 < $1 }
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		createAnimalDictionary()
	}
	
	// MARK: UITableViewDataSource and UITableViewDelegate
	override func numberOfSections(in tableView: UITableView) -> Int { return animalSectionTitles.count }
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return animalSectionTitles[section]
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key = animalSectionTitles[section]
		return animalsDictionary[key]?.count ?? 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let key = animalSectionTitles[indexPath.section]
		let animalName = animalsDictionary[key]?[indexPath.row]
		cell.textLabel?.text = animalName
		if let imageName = animalName?.lowercased().replacingOccurrences(of: " ", with: "_") {
			cell.imageView?.image = UIImage(named: imageName)
		}
		return cell
	}
}
