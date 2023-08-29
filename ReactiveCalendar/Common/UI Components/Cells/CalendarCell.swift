//
//  CalendarCell.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import UIKit
import SnapKit

class CalendarCell: UICollectionViewCell, CollectionViewReusableCell {
    
    struct ViewModel {
        let date: Date
        let calendar = Calendar.current
        var dayNumber: Int {
            let dayNumber = calendar.component(.day, from: date)
            return dayNumber
        }
        let isCurrentMonth: Bool
    }
    
    // MARK: Properties
    
    private lazy var mainView: UIView = {
        let view = UIView(backgroundColor: .quaternaryColor)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var calendarView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dayLabel, spacer])
        view.axis = .vertical
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    private lazy var spacer = UIView(backgroundColor: .clear)
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .openSansSemiBold16
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Implementation
    
    func configure(with viewModel: ViewModel) {
        dayLabel.text = "\(viewModel.dayNumber)"
        mainView.backgroundColor = viewModel.isCurrentMonth ? .quaternaryColor : .lightGray
    }
    
    // MARK: Private Implementation
    
    private func layoutViews() {
        backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(calendarView)
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
