//
//  PeopleView.swift
//  Faghelgapp
//
//  Created by Anders Ullnæss on 27/09/16.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import Foundation
import UIKit

protocol PeopleViewDelegate: class {
    func didSelectPerson(person: Person)
}

class PeopleView: NibLoadingView {

    @IBOutlet weak var peopleTableView: UITableView!

    let peopleEntryCellIdentifier = "PeopleEntryCell"

    var viewController: PeopleViewDelegate?

    var viewModel = PeopleViewModel()

    override func awakeFromNib() {
        peopleTableView.register(PeopleEntryCell.self, forCellReuseIdentifier: peopleEntryCellIdentifier)
        peopleTableView.estimatedRowHeight = 50
        peopleTableView.rowHeight = UITableViewAutomaticDimension
        peopleTableView.tableFooterView = UIView()

        let header = PeopleHeaderCell()
        header.frame.size = CGSize(width: header.frame.size.width, height: 180)
        peopleTableView.tableHeaderView = header

        header.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(tapGestureRecognizer:)))
        header.addGestureRecognizer(tapGestureRecognizer)
    }

    func getLoggedInPerson() -> Person? {
        if let token = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.token) {
            let currentUser = TokenUtil.getUsernameFromToken(token: token)
            return self.viewModel.people.filter { $0.shortName == currentUser }.first
        }

        return nil
    }

    func updateViews(viewModel: PeopleViewModel) {
        self.viewModel = viewModel

        if let currentPerson = getLoggedInPerson() {
            (peopleTableView.tableHeaderView as! PeopleHeaderCell).populate(person: currentPerson)
        }

        peopleTableView.reloadData()
        peopleTableView.layoutIfNeeded()
    }

    @objc func headerTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let currentPerson = getLoggedInPerson() {
            viewController?.didSelectPerson(person: currentPerson)
        }
    }
}

extension PeopleView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: peopleEntryCellIdentifier)! as! PeopleEntryCell
        cell.populate(person: self.viewModel.people[indexPath.row])
        return cell
    }
}

extension PeopleView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.viewModel.people[indexPath.row]
        viewController?.didSelectPerson(person: person)
    }
}
