import Foundation
import UIKit

protocol ProgramViewControllerOutput {
    func viewControllerWillAppear()
    func dayChanged(day: Day)
    func didSelectEvent(with index: Int)
}

class ProgramViewController: MesanViewController {

    @IBOutlet weak var programView: ProgramView!
    @IBOutlet weak var eventScrollerView: EventScrollerView!

    var interactor: ProgramViewControllerOutput!
    var router: ProgramRouter!

    override func viewDidLoad() {
        super.viewDidLoad()

        programView.viewController = self
        ProgramConfigurator.sharedInstance.configure(viewController: self)

        router.showLoadingView(text: "Henter program") {
            self.interactor.viewControllerWillAppear()
        }
    }
}

extension ProgramViewController: ProgramViewDelegate {
    func dayChanged(day: Day) {
        interactor.dayChanged(day: day)
    }

    func didSelectEvent(with index: Int, from events: [Event], day: String) {
        router.goToEventsViewController(events: events, title: day, index: index)
    }
}

extension ProgramViewController: ProgramPresenterOutput {
    func updateViews(viewModel: ProgramViewModel) {
        if viewModel.selectedEventIndex != nil {
            eventScrollerView.allEvents = viewModel.eventsForSelectedDay
            eventScrollerView.showEventWithIndex(viewModel.selectedEventIndex!)
            eventScrollerView.isHidden = false
        } else {
            eventScrollerView.isHidden = true
        }

        router.hideLoadingView {
            self.programView.updateViews(viewModel: viewModel)
        }
    }

    func scrollToCurrentEvent() {
        programView.scrollToCurrentEvent()
    }
}
