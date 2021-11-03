//
//  ViewControllerGame.swift
//  proyectoMayusculas
//
//  Created by Clarissa Velásquez Magaña on 12/10/21.
//

import UIKit

class ViewControllerGame: UIViewController {
    
    var gameMode : Int!
    var difficulty : Int!
    var ruta : String!
    var allQuestionList = [Pregunta]()
    var toUseQuestionList = [Pregunta]()
    var currQuestion = 0
    var score = 0
    var rulesToCheck : Set<Int> = []
    
    @IBOutlet weak var labelInstruction: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonMin: UIButton!
    @IBOutlet weak var buttonMayu: UIButton!
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var buttonOpc1: UIButton!
    @IBOutlet weak var buttonOpc2: UIButton!
    @IBOutlet weak var buttonOpc3: UIButton!
    @IBOutlet weak var buttonOpc4: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ruta = Bundle.main.path(forResource: "Property List", ofType: "plist")
        
        getAllQuestions()
        getRealQuestions()
        newQuestion()
        
        labelScore.text = "0/\(toUseQuestionList.count)"
    }
    
    
    func getAllQuestions() {
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: ruta))
           allQuestionList = try PropertyListDecoder().decode([Pregunta].self, from: data)
        }
            catch {
                print("ERROR al cargar el archivo")
            }
    }
    
    func getRealQuestions() {
        for q in allQuestionList {
            if q.dificultad == difficulty {
                toUseQuestionList.append(q)
            }
        }
    }
    
    func newQuestion() {
        if difficulty == 1 {
            labelInstruction.text = "Seleccione si la palabra debe iniciar con mayúscula o minúscula"
            buttonMin.setTitle("minúscula", for: .normal)
            buttonMayu.setTitle("mayúscula", for: .normal)
            
            desactivaBotones()
            
        }
        else if difficulty == 2 {
            labelInstruction.text = "Seleccione las palabras que deben de iniciar con mayúscula"
            
            desactivaBotones()
            
        }
        
        labelQuestion.text = toUseQuestionList[currQuestion].enunciado
    
    }
    
    func showResults() {
        let alert = UIAlertController(title: "Resultado", message: "Has obtenido \(score)/\(toUseQuestionList.count) aciertos", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: UIAlertAction.Style.default, handler: nil)
        
        let cancelAction = UIAlertAction(title: "Salir", style: .cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressedMin(_ sender: UIButton) {
        if toUseQuestionList[currQuestion].respuesta[0] == "min" {
            score += 1
            print("correct")
            labelScore.text = "\(score)/\(toUseQuestionList.count)"
        }
        else {
            rulesToCheck.formUnion(toUseQuestionList[currQuestion].normas)
        }
        
        currQuestion += 1
        if (currQuestion < toUseQuestionList.count) {
            newQuestion()
        }
        else {
            showResults()
        }
        
        
    }
    
    @IBAction func pressedMayu(_ sender: Any) {
        if toUseQuestionList[currQuestion].respuesta[0] == "mayu" {
            score += 1
            print("correct")
            labelScore.text = "\(score)/\(toUseQuestionList.count)"
        }
        else {
            rulesToCheck.formUnion(toUseQuestionList[currQuestion].normas)
        }
        currQuestion += 1
        if (currQuestion < toUseQuestionList.count) {
            newQuestion()
        }
        else {
            showResults()
        }
    }
    
    func desactivaBotones(){
        if difficulty == 1 {
            buttonOpc1.isEnabled = false
            buttonOpc2.isEnabled = false
            buttonOpc3.isEnabled = false
            buttonOpc4.isEnabled = false
            
            buttonMin.isEnabled = true
            buttonMayu.isEnabled = true
            
            buttonOpc1.backgroundColor = .white
            buttonOpc2.backgroundColor = .white
            buttonOpc3.backgroundColor = .white
            buttonOpc4.backgroundColor = .white
            
            buttonOpc1.setTitleColor(UIColor.white, for: UIControl.State.disabled)
            buttonOpc2.setTitleColor(UIColor.white, for: UIControl.State.disabled)
            buttonOpc3.setTitleColor(UIColor.white, for: UIControl.State.disabled)
            buttonOpc4.setTitleColor(UIColor.white, for: UIControl.State.disabled)
            
        }else if difficulty == 2 {
            buttonMin.isEnabled = false
            buttonMayu.isEnabled = false
            
            buttonOpc1.isEnabled = true
            buttonOpc2.isEnabled = true
            buttonOpc3.isEnabled = true
            buttonOpc4.isEnabled = true
            
            buttonMin.backgroundColor = .white
            buttonMayu.backgroundColor = .white
            
            buttonMin.setTitleColor(UIColor.white, for: UIControl.State.disabled)
            buttonMayu.setTitleColor(UIColor.white, for: UIControl.State.disabled)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
