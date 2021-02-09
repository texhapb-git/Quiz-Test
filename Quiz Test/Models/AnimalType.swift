//
//  AnimalType.swift
//  Quiz Test
//
//  Created by Максим Иванов on 08.02.2021.
//

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        
        switch self {
        case .dog:
            return "Вы мопс."
        case .cat:
            return "Жирная киса)"
        case .rabbit:
            return "Хватит размножаться!!!"
        case .turtle:
            return "Помедленнее, пожалуйста."
        }
        
    }
}
