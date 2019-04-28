//
//  ViewModel.swift
//  freespacewidget
//
//  Created by Sergey Vasilevkin on 28/04/2019.
//  Copyright © 2019 Sergey Vasilevkin. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public class ViewModel {

    public var freePercentage = BehaviorRelay<CGFloat>(value: 0.0)
    public var availableSpaceString = BehaviorRelay<String>(value: "")
    public var usedSpaceString = BehaviorRelay<String>(value: "")
    public var totalStorageString = BehaviorRelay<String>(value: "")
    public var usedPercentage = BehaviorRelay<Float>(value: 0.0)

    let disposeBag = DisposeBag()

    public init() {
        let spaceUpdateSampler = Observable<Int>
            .interval(Constants.samplerUpdateInterval, scheduler: MainScheduler.instance)
            .startWith(0)

        spaceUpdateSampler
            .subscribe(onNext: { [weak self] _ in
                let model = CapacityMainModel()

                let freePercentage = model.freeSpace * 100 / model.totalSpace
                let usedProgressNumber = Float(1.0 - Double(freePercentage) / 100.0)   // 0.0 ... 1.0

                self?.usedPercentage.accept(usedProgressNumber)
                self?.freePercentage.accept(CGFloat(freePercentage))

                //      x.x Gb   ( x Mb )
                let freeSpaceGb = String(format: "%.1f", Double(model.freeSpace)/1000.0/1000.0/1000.0)
                let freeSpaceMegab = String(format: "%.0f", Double(model.freeSpace)/1000.0/1000.0)
                let freeSpaceString = freeSpaceGb + " Gb   ( " + freeSpaceMegab + " Mb )"
                self?.availableSpaceString.accept(freeSpaceString)

                //      x Gb   ( x Mb )
                let usedSpaceGb = String(format: "%.0f", Double(model.usedSpace)/1000.0/1000.0/1000.0)
                let usedSpaceMegab = String(format: "%.0f", Double(model.usedSpace)/1000.0/1000.0)
                let usedSpaceString = usedSpaceGb + " Gb   ( " + usedSpaceMegab + " Mb )"
                self?.usedSpaceString.accept(usedSpaceString)

                //      x Gb   ( x Mb )
                let totalSpaceGb = String(format: "%.0f", Double(model.totalSpace)/1000.0/1000.0/1000.0)
                let totalSpaceMegab = String(format: "%.0f", Double(model.totalSpace)/1000.0/1000.0)
                let totalSpaceString = totalSpaceGb + " Gb   ( " + totalSpaceMegab + " Mb )"
                self?.totalStorageString.accept(totalSpaceString)

                #if DEBUG
                print("  ** MainScreenViewModel.freeSpaceString = \(freeSpaceString)")
                print("  ** MainScreenViewModel.usedSpaceString = \(usedSpaceString)")
                print("  ** MainScreenViewModel.totalSpaceString = \(totalSpaceString)")
                #endif
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }

}
