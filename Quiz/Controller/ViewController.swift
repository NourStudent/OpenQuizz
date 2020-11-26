//
//  ViewController.swift
//  Quiz
//
//  Created by user172836 on 6/19/20.
//  Copyright © 2020 user172836. All rights reserved.
//

import UIKit
var game = Game()


 class ViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var activityIndicator:
           UIActivityIndicatorView!
    @IBOutlet weak var scoreLabel: UILabel!
        /*{
        didSet{
            if scoreLabel != oldValue{
                TextView.text = "\(game.currentQuestion.title)\nVotre reponse est correcte"
                
            }
            else{
                TextView.text = "\(game.currentQuestion.title)\nVotre reponse est incorrecte"
                
            }
        }
    }*/
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var TextView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationObserved = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name:notificationObserved, object: nil)
        
        startNewGame()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self , action: #selector(dragQuestionView(_:)))
        questionView.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    
    
 @IBAction func didTapNewGameButton() {
        startNewGame()
    }
    
    private func startNewGame(){
        
        //activityIndicator.isHidden = false
       // newGameButton.isHidden = true
        questionView.title = "loading..."
        questionView.style = .standard
        scoreLabel.text = "0 / 10"
        TextView.text = " "
        
        game.refresh()
        
    }
    
    
     @objc func questionsLoaded(notification:Notification){
           
           print ("selecteur appele \(notification.name)")
        
          //activityIndicator.isHidden = true
           //newGameButton.isHidden = false
           
           questionView.title = game.currentQuestion.title
           
         
           
       }
       
     @objc func dragQuestionView(_ sender: UIPanGestureRecognizer) {
    if game.state == .ongoing {
        switch sender.state {
        case .began, .changed:
            transformQuestionViewWith(gesture: sender)
        case .ended, .cancelled:
            answerQuestion()
        default:
            break
        }
    }
}
    
     private func transformQuestionViewWith(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation (in: questionView)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        let screenWidth = UIScreen.main.bounds.width
        let translationPercent = translation.x/(screenWidth / 2)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        let rotationTransform = CGAffineTransform (rotationAngle: rotationAngle)
        let transform = translationTransform.concatenating(rotationTransform)
        questionView.transform = transform
        
        if translation.x > 0 {
        questionView.style = .correct
        } else {
       questionView.style = .incorrect
       }
    }

     private func answerQuestion() {
        
          switch questionView.style {
    case .correct:
        game.answerCurrentQuestion(with: true)
        
        TextView.text = "\(game.currentQuestion.title)\nVotre reponse est :True"
    case .incorrect:
        game.answerCurrentQuestion(with: false)
      TextView.text = "\(game.currentQuestion.title) \nVotre reponse est :False "
    case .standard:
        break
            
    }
        scoreLabel.text = " \(game.score) /10"
                
            
            let screenWidth = UIScreen.main.bounds.width
            var translationTransform : CGAffineTransform
            if questionView.style == .correct {
                
                translationTransform = CGAffineTransform (translationX: screenWidth, y: 0)
            }else {
                translationTransform = CGAffineTransform (translationX: -screenWidth, y: 0)
                
                
            }
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.questionView.transform = translationTransform
                
            }) {  (succes) in
                if succes {
                    self.showQuestionView()
                    }
        }
        }
   
        
        
        private func showQuestionView() {
            questionView.transform = .identity
            questionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
             questionView.style = .standard
            
             switch game.state {
             case .ongoing:
                  questionView.title = game.currentQuestion.title
             case .over:
                 questionView.title = "Game Over "
                
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.questionView.transform = .identity
            }, completion: nil)
            
      
            
              func appearView() {
              self.newGameButton.alpha = 0
              self.newGameButton.isHidden = false

              UIView.animate(withDuration: 0.9, animations: {
              self.newGameButton.alpha = 1
              }, completion: {
              finished in
              self.newGameButton.isHidden = false
                
              })
                
}
            
            
    }
}
