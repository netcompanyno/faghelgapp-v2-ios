//
//  FeedView.swift
//  Faghelgapp
//
//  Created by Anders Ullnæss on 18/10/16.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import Foundation

class FeedView: NibLoadingView {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textMessageCellIdentifier = "TextMessageCell"
    let imageMessageCellIdentifier = "ImageMessageCell"
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    override func awakeFromNib() {
        initTableView()
    }
    
    func updateFeed(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    private func initTableView() {
        tableView.register(ImageMessageCell.self, forCellReuseIdentifier: imageMessageCellIdentifier)
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = false;
    }
}

extension FeedView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: imageMessageCellIdentifier, for: indexPath) as! ImageMessageCell
        
        cell.populate(message: message)
        return cell
    }
}
