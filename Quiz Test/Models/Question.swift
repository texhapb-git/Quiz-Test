//
//  Question.swift
//  Quiz Test
//
//  Created by Максим Иванов on 08.02.2021.
//

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
    
    static let all: [Question] = [
        Question(text: "Какую еду вы предпочитаете?", type: .single, answers: [
            Answer(text: "Мясо", type: .dog),
            Answer(text: "Рыба", type: .cat),
            Answer(text: "Морковь", type: .rabbit),
            Answer(text: "Кукуруза", type: .turtle),
        ]),
        Question(text: "Что вы любите делать?", type: .multiple, answers: [
            Answer(text: "Обниматься", type: .rabbit),
            Answer(text: "Есть", type: .dog),
            Answer(text: "Спать", type: .turtle),
            Answer(text: "Плавать", type: .cat),
        ]),
        Question(text: "Любите ли вы поездки на машине?", type: .range, answers: [
            Answer(text: "Ненавижу", type: .cat),
            Answer(text: "Нервничаю", type: .rabbit),
            Answer(text: "Не замечаю", type: .turtle),
            Answer(text: "Обожаю", type: .dog),
        ]),
    ]
}
