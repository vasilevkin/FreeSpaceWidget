//
//  ViewController.swift
//  freespacewidget
//
//  Created by Sergey Vasilevkin on 27/04/2019.
//  Copyright © 2019 Sergey Vasilevkin. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class ViewController: UIViewController {

    @IBOutlet private weak var availableLabel: UILabel!
    @IBOutlet private weak var usedLabel: UILabel!
    @IBOutlet private weak var totalStorageLabel: UILabel!

    @IBOutlet private weak var availableDescriptionLabel: UILabel!
    @IBOutlet private weak var usedDescriptionLabel: UILabel!
    @IBOutlet private weak var totalStorageDescriptionLabel: UILabel!
    @IBOutlet private weak var freeDescriptionLabel: UILabel!

    @IBOutlet private weak var aboutButton: UIButton!
    @IBOutlet private weak var howToUseButton: UIButton!

    @IBOutlet private weak var horizontalProgressView: UIProgressView!

    var viewModel: ViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.availableSpaceString.bind(to: availableLabel.rx.text).disposed(by: viewModelDisposeBag)
                viewModel.usedSpaceString.bind(to: usedLabel.rx.text).disposed(by: viewModelDisposeBag)
                viewModel.totalStorageString.bind(to: totalStorageLabel.rx.text).disposed(by: viewModelDisposeBag)
                viewModel.usedPercentage.bind(to: horizontalProgressView.rx.progress).disposed(by: viewModelDisposeBag)
            }
        }
    }

    private var viewModelDisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ViewModel()

        aboutButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.performSegue(withIdentifier: "AboutScreenSeque", sender: self)
            })
            .disposed(by: viewModelDisposeBag)

        howToUseButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.performSegue(withIdentifier: "HowToUseSeque", sender: self)
            })
            .disposed(by: viewModelDisposeBag)

        configureUI()
    }

    fileprivate func configureUI() {
        let constants = Constants()

        horizontalProgressView.progressTintColor = constants.colorProgressViewProgress
        horizontalProgressView.trackTintColor = constants.colorProgressViewEmptyLine
        horizontalProgressView.clipsToBounds = true
        horizontalProgressView.layer.cornerRadius = constants.sizeProgressViewCornerRadius

        availableDescriptionLabel.textColor = constants.colorProgressViewProgress
        usedDescriptionLabel.textColor = constants.colorProgressViewProgress
        totalStorageDescriptionLabel.textColor = constants.colorProgressViewProgress

        availableDescriptionLabel.font = UIFont(name: constants.nameWidgetCircularProgressValueFont,
                                                size: constants.sizeDescriptionLabelFont)
        usedDescriptionLabel.font = UIFont(name: constants.nameWidgetCircularProgressValueFont,
                                           size: constants.sizeDescriptionLabelFont)
        totalStorageDescriptionLabel.font = UIFont(name: constants.nameWidgetCircularProgressValueFont,
                                                   size: constants.sizeDescriptionLabelFont)
    }

}
