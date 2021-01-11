//
//  ViewController.swift
//  MyToDo
//
//  Created by Assem on 1/9/21.
//  Copyright © 2021 Assem. All rights reserved.
//

import SnapKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let localStorage = CoreDataStorage()
    private var items: [ToDo] = []
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonDidPressed), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 30
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return button
    }()
    
    let ToDoTitleLabel: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 30)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "Set your theme"
        return textField
    }()
    
    let ToDoSubtitleLabel: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 30)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.placeholder = "Set your task"
        return textField
    }()
    
    let dueDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.accessibilityElementsHidden = true
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    var popUpView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.sizeToFit()
        return view
    }()
    
    let addInPopUpViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(addToDoButtonPressed), for: .touchUpInside)
        return button
    }()
           
    let cancelInPopUpViewButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    let editInPopUpViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(editToDoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        popUpView.isHidden = true
        configureTableView()
        configureAddButton()
        items = localStorage.fetchToDoItems()
        reloadTableView()
    }
    
    
    @objc private func addButtonDidPressed(sender: UIButton!) {
        showAddPopUpView()
    }
    
    private func showAddPopUpView() {
        popUpView.isHidden = false
        tableView.isHidden = true
        configureAddPopUpView()
        configureAddPopUpViewButtons()
        configureToDoTitleLabel()
        configureToDoSubtitleLabel()
        configureDatePicker()
    }
    
    @objc private func addToDoButtonPressed() {
        popUpView.isHidden = true
        tableView.isHidden = false
        let title = ToDoTitleLabel.text ?? ""
        let subtitle = ToDoSubtitleLabel.text ?? ""
        self.localStorage.save(title: title, subtitle: subtitle, date: dueDatePicker.date)
        reloadTableView()
    }

    @objc private func editToDoButtonPressed() {
        showEditPopUpView()
        popUpView.isHidden = true
        tableView.isHidden = false
        let title = ToDoTitleLabel.text ?? ""
        let subtitle = ToDoSubtitleLabel.text ?? ""
        let date = dueDatePicker.date
        self.localStorage.update()
        reloadTableView()
    }
    
    private func reloadTableView() {
           items = localStorage.fetchToDoItems()
           tableView.reloadData()
    }
    
    private func showEditPopUpView() {
        popUpView.isHidden = false
        tableView.isHidden = true
        configureAddPopUpView()
        configureEditPopUpViewButtons()
        configureToDoTitleLabel()
        configureToDoSubtitleLabel()
        configureDatePicker()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoCell.self, forCellReuseIdentifier: String(describing: ToDoCell.self))
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().offset(-10)
            $0.size.equalTo(60)
        }
    }
    
    private func configureAddPopUpView() {
        view.addSubview(popUpView)
        popUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    private func configureToDoTitleLabel() {
        popUpView.addSubview(ToDoTitleLabel)
        ToDoTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(30)
        }
    }
    
    private func configureToDoSubtitleLabel() {
        popUpView.addSubview(ToDoSubtitleLabel)
        ToDoSubtitleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(ToDoTitleLabel.snp.bottom).offset(10)
        }
    }
    private func configureDatePicker() {
        popUpView.addSubview(dueDatePicker)
        dueDatePicker.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureAddPopUpViewButtons() {
        popUpView.addSubview(addInPopUpViewButton)
        popUpView.addSubview(cancelInPopUpViewButton)
        addInPopUpViewButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.bottom.equalToSuperview()
        }
        cancelInPopUpViewButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureEditPopUpViewButtons() {
        popUpView.addSubview(editInPopUpViewButton)
        popUpView.addSubview(cancelInPopUpViewButton)
        editInPopUpViewButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.bottom.equalToSuperview()
        }
        cancelInPopUpViewButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ToDoCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ToDoCell
        cell.titleLabel.text = self.items[indexPath.row].title
        cell.subtitleLabel.text = self.items[indexPath.row].subtitle
        let date = self.items[indexPath.row].dueDate?.description
        cell.dueDate.text = date
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.localStorage.delete(item: self.items[indexPath.row])
            self.reloadTableView()
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            guard let self = self else { return }
            let item = self.items[indexPath.row]
            self.showEditPopUpView()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

