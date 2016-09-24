//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var billButton: UIButton!
    
    var facts: [String : [String]] = [:]
    var currentPerson: String = ""
    var currentFact: String = ""
    var correctGuesses: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFacts()
        showFact()
    }
    
    func createFacts() {
        let billFacts = ["He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.","He scored 1590 (out of 1600) on his SATs.","His foundation spends more on global health each year than the United Nation's World Health Organization.","The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.","In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
        let steveFacts = ["He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.","Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.","He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.","He was a pescetarian, meaning he ate no meat except for fish."]
        
        facts["Bill Gates"] = billFacts
        facts["Steve Jobs"] = steveFacts
    }
    func showFact() {
        
        if let steveFacts = facts["Steve Jobs"], let billFacts = facts["Bill Gates"] {
            if steveFacts.isEmpty && billFacts.isEmpty {
                print("Game Over")
                steveButton.isUserInteractionEnabled = false
                billButton.isUserInteractionEnabled = false
                // the game is over
            } else {
                if !steveFacts.isEmpty && !billFacts.isEmpty {
                    let person = randomPerson()
                    let response = getFactForPerson(person: person)
                    newFactToDisplay(name: response.name, fact: response.fact)
                } else {
                    if steveFacts.isEmpty && !billFacts.isEmpty {
                            let response = getFactForPerson(person: "Bill Gates")
                            newFactToDisplay(name: response.name, fact: response.fact)
                        }
                    }
                    if billFacts.isEmpty && !steveFacts.isEmpty {
                            let response = getFactForPerson(person: "Steve Jobs")
                            newFactToDisplay(name: response.name, fact: response.fact)
                }
            }
        }
    }

    func randomIndex(fromArray array: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(array.count)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    func getFactForPerson(person: String) -> (name: String, fact: String) {
        let person = randomPerson()
        if var factsForPerson = facts[person] {
            print(person)
            print(factsForPerson.count)
            let fact = factsForPerson[randomIndex(fromArray: factsForPerson)]
            factsForPerson.remove(at: randomIndex(fromArray: factsForPerson))
            facts[person] = factsForPerson
            return (person,fact)
        }
        return ("No Person", "No Fact")
    }

    func newFactToDisplay(name: String, fact: String) {
        let person = randomPerson()
        let response = getFactForPerson(person: person)
        let name = response.name
        let fact = response.fact
        
        currentPerson = name
        currentFact = fact
        
        factLabel.text = currentFact
    }
    
    
    @IBAction func billButtonAction(_ sender: AnyObject) {
        if "Bill Gates" == currentPerson {
            correctGuesses += 1
            score.text = String(correctGuesses)
        }
        showFact()
    }
    @IBAction func steveButtonAction(_ sender: AnyObject) {
        if "Steve Jobs" == currentPerson {
            correctGuesses += 1
            score.text = String(correctGuesses)
        }
        showFact()
    }
}
