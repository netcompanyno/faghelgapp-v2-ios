//
//  PeopleEntryCell.swift
//  Faghelgapp
//
//  Created by Tore Brandtzæg on 03.10.2016.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import UIKit
import NibDesignable

class PeopleEntryCell: NibDesignableTableViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortNameLabel: UILabel!
    
    func populate(person: Person) {
        self.nameLabel.text = person.fullName
        self.shortNameLabel.text = "@\(person.shortName)"
        // TODO: person image
    }
}
