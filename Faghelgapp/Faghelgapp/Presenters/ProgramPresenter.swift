//
//  ProgramPresenter.swift
//  Faghelgapp
//
//  Created by Anders Ullnæss on 27/09/16.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import Foundation

protocol ProgramPresenterOutput {
    func updateViews(viewModel: ProgramViewModel)
}

class ProgramPresenter {
    let viewModel = ProgramViewModel()
    
    var viewController: ProgramPresenterOutput!
}

extension ProgramPresenter: ProgramInteractorOutput {
    func dayChanged(day: Day) {
        viewModel.selectedDay = day
        if let program = viewModel.program {
            viewModel.eventsForSelectedDay = program.getEventsForDay(day: day)
        }
        
        updateViewsFromMainThread()
    }
    
    func fetchedProgram(_ program: Program) {
        viewModel.program = program
        viewModel.eventsForSelectedDay = program.getEventsForDay(day: viewModel.selectedDay)
        updateViewsFromMainThread()
    }
    
    func fetchProgramFailed() {
        // TODO
    }
    
    private func updateViewsFromMainThread() {
        DispatchQueue.main.async {
            self.viewController.updateViews(viewModel: self.viewModel)
        }
    }
}