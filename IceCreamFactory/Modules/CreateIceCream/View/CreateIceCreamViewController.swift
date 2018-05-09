//
//  CreateIceCreamViewController.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

class CreateIceCreamViewController: UIViewController {
    
    var output: CreateIceCreamViewOutput?
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var weightField: UITextField!
    @IBOutlet private weak var colorField: UITextField!
    @IBOutlet private weak var flavorField: UITextField!
    @IBOutlet private weak var temperatureField: UITextField!
    
    // MARK: - View Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    // MARK: - Private
    
    private func getEditField(for textField: UITextField) -> CreateIceCreamViewField? {
        
        var fieldFactory: ((String?) -> CreateIceCreamViewField)? {
            switch textField {
            case nameField: return CreateIceCreamViewField.name
            case weightField: return CreateIceCreamViewField.weight
            case colorField: return CreateIceCreamViewField.color
            case flavorField: return CreateIceCreamViewField.flavor
            case temperatureField: return CreateIceCreamViewField.temp
            default: return nil
            }
        }
        
        return fieldFactory?(textField.text)
    }
    
    // MARK: - Actions
    
    @IBAction private func edit(_ textField: UITextField) {
        if let editField = getEditField(for: textField) {
            output?.didUpdate(editField)
        }
    }
    
    @IBAction func tapCreate(_ sender: UIButton) {
        output?.didTapCreate()
    }
    
}

extension CreateIceCreamViewController: CreateIceCreamViewInput {
    
    func set(_ field: CreateIceCreamViewField) {
        switch field {
        case .name(let name):
            nameField.text = name
        case .weight(let weight):
            weightField.text = weight
        case .color(let color):
            colorField.text = color
        case .flavor(let flavor):
            flavorField.text = flavor
        case .temp(let temp):
            temperatureField.text = temp
        }
    }
    
}
