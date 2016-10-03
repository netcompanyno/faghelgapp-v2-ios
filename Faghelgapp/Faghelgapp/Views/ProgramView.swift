//
//  ProgramView.swift
//  Faghelgapp
//
//  Created by Anders Ullnæss on 27/09/16.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import Foundation
import UIKit

protocol ProgramViewDelegate: class {
    func dayChanged(day: Day)
}

class ProgramView: NibLoadingView {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var selectedDayLine: UIView!
    
    let programEntryCellIdentifier = "ProgramEntryCell"
    
    var viewController: ProgramViewDelegate?
    
    var viewModel = ProgramViewModel()
    
    override func awakeFromNib() {
        tableView.register(ProgramEntryCell.self, forCellReuseIdentifier: programEntryCellIdentifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    func updateViews(viewModel: ProgramViewModel) {
        self.viewModel = viewModel
        updateButtonColors()
        moveSelectedDayLine()
        tableView.reloadData()
        scrollToTopOfList()
    }
    
    @IBAction func dayButtonClicked(_ sender: UIButton) {
        let selectedDay = Day(rawValue: sender.title(for: .normal)!)!
        viewController?.dayChanged(day: selectedDay)
    }
    
    private func updateButtonColors() {
        thursdayButton.setTitleColor(Constants.Colours.mesanGrey, for: .normal)
        fridayButton.setTitleColor(Constants.Colours.mesanGrey, for: .normal)
        saturdayButton.setTitleColor(Constants.Colours.mesanGrey, for: .normal)
        
        switch viewModel.selectedDay {
        case .thursday:
            thursdayButton.setTitleColor(Constants.Colours.mesanBlue, for: .normal)
            break;
        case .friday:
            fridayButton.setTitleColor(Constants.Colours.mesanBlue, for: .normal)
            break;
        case .saturday:
            saturdayButton.setTitleColor(Constants.Colours.mesanBlue, for: .normal)
            break;
        }
    }
    
    private func moveSelectedDayLine() {
        let distanceToMove = getDistanceToMoveSelectedDayLine()
        UIView.animate(withDuration: 0.2) { () in
            self.selectedDayLine.transform = CGAffineTransform(translationX: distanceToMove, y: 0)
        }
    }
    
    private func getDistanceToMoveSelectedDayLine() -> CGFloat {
        let width = selectedDayLine.frame.width
        
        switch viewModel.selectedDay {
        case .friday:
            return width
        case .saturday:
            return 2 * width
        default:
            return 0
        }
    }
    
    private func scrollToTopOfList() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
    }
}

extension ProgramView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventsForSelectedDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: programEntryCellIdentifier)! as! ProgramEntryCell
        cell.populate(event: viewModel.eventsForSelectedDay[indexPath.row])
        
        return cell;
    }
}
