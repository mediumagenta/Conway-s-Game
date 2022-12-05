//
//  GameManagementInterfaceView.swift
//  Conway's Game
//
//  Created by Michael on 12/4/22.
//

import UIKit

final class GameManagementInterfaceView: UIView {
    
    //MARK: - UI Elements
    //MARK: Кнопки
    let startOrStopGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запустить игру", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let addRandomLifeCellsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Задать точки рандомно", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    //MARK: Левые лейблы для слайдеров
    private let worldSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Размер поля"
        label.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let countOfRandomLifeCellsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество живых ячеек"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let animationSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Скорость анимации"
        label.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    //MARK: - Блоки слайдеров с информацией над ними
    //MARK: WorldSize
    let worldSizeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 10
        slider.maximumValue = 90
        slider.value = 50
        return slider
    }()
    
    private let leftWorldSizeSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    let centerWorldSizeSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50"
        label.textColor = .black
        return label
    }()
    
    private let rightWorldSizeSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "90"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    private lazy var labelsForWorldSizeSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftWorldSizeSliderLabel, centerWorldSizeSliderLabel, rightWorldSizeSliderLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalCentering
        return stack
    }()
    
    
    //MARK: CountOfRandomLifeCells
    let countRandomLifeCellsSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.1
        slider.maximumValue = 0.9
        slider.value = 0.5
        return slider
    }()
    
    private let leftCountRandomLifeCellsSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    private let rightCountRandomLifeCellsSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    private lazy var labelsForCountRandomLifeCellsSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftCountRandomLifeCellsSliderLabel, rightCountRandomLifeCellsSliderLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    
    //MARK: Animation Speed
    let animationSpeedSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.1
        slider.maximumValue = 0.9
        slider.value = 0.75
        return slider
    }()
    
    private let leftAnimationSpeedSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    
    private let rightAnimationSpeedSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max"
        label.textColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        return label
    }()
    
    private lazy var labelsForAnimationSpeedSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftAnimationSpeedSliderLabel, rightAnimationSpeedSliderLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    

    //MARK: - Sliders Stacks
    //MARK: Vertical
    private lazy var worldSizeSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelsForWorldSizeSliderStack, worldSizeSlider])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var countOfRandomLifeCellsSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelsForCountRandomLifeCellsSliderStack, countRandomLifeCellsSlider])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var animationSpeedSliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelsForAnimationSpeedSliderStack, animationSpeedSlider])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Horizontal
    private lazy var worldSizeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [worldSizeLabel, worldSizeSliderStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var countOfRandomLifeCellsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countOfRandomLifeCellsLabel, countOfRandomLifeCellsSliderStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var animationSpeedStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [animationSpeedLabel, animationSpeedSliderStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: All vertical elements
    lazy var settingsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [worldSizeStack, countOfRandomLifeCellsStack, animationSpeedStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        //stack.backgroundColor = .blue
        return stack
    }()
    
    private lazy var sliders = [worldSizeSlider, countRandomLifeCellsSlider, animationSpeedSlider]
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Logic of UI Elements
    
    func disableElements() {
        startOrStopGameButton.setTitle("Остановить игру", for: .normal)
        addRandomLifeCellsButton.isEnabled = false
        worldSizeSlider.isEnabled = false
        countRandomLifeCellsSlider.isEnabled = false
        animationSpeedSlider.isEnabled = false
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.addRandomLifeCellsButton.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
            self.settingsStack.alpha = 0.3
            self.sliders.forEach {$0.minimumTrackTintColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)}
        }
    }
    
    func enableElements() {
        startOrStopGameButton.setTitle("Запустить игру", for: .normal)
        addRandomLifeCellsButton.isEnabled = true
        worldSizeSlider.isEnabled = true
        countRandomLifeCellsSlider.isEnabled = true
        animationSpeedSlider.isEnabled = true
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.addRandomLifeCellsButton.backgroundColor = .blue
            self.settingsStack.alpha = 1
            self.sliders.forEach {$0.minimumTrackTintColor = .systemBlue}
        }
    }
    
    
    //MARK: - Setting UI Elements
    private func addViews() {
        addSubview(startOrStopGameButton)
        addSubview(addRandomLifeCellsButton)
        addSubview(settingsStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startOrStopGameButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            startOrStopGameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            startOrStopGameButton.widthAnchor.constraint(equalToConstant: startOrStopGameButton.intrinsicContentSize.width + 40),
            startOrStopGameButton.heightAnchor.constraint(equalToConstant: 40),
            
            addRandomLifeCellsButton.topAnchor.constraint(equalTo: startOrStopGameButton.topAnchor),
            addRandomLifeCellsButton.leadingAnchor.constraint(equalTo: startOrStopGameButton.trailingAnchor, constant: 12),
            addRandomLifeCellsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            addRandomLifeCellsButton.heightAnchor.constraint(equalTo: startOrStopGameButton.heightAnchor),
            
            settingsStack.topAnchor.constraint(equalTo: addRandomLifeCellsButton.bottomAnchor, constant: 20),
            settingsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            settingsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            settingsStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
            //settingsStack.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 0)
        ])
    }
}
