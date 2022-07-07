import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var allGamesRedUnderline: UIView!
    @IBOutlet weak var popularRedUnderline: UIView!
    
    
    @IBOutlet weak var firstGameView: UIView!
    @IBOutlet weak var allGamesLabel: UILabel!
    @IBOutlet weak var popularGamesLabel: UILabel!
    
    
    @IBOutlet weak var gamesView: UIView!
    @IBOutlet weak var secondGameView: UIView!
    @IBOutlet weak var thirdGameView: UIView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    

    
    var balance = 0
    private let games = Games.self
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        
        balance = setBalance()
        configuringInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)

    }
 
    
        private func configuringInterface(){
        
        balanceLabel.text = String(balance)
        balanceLabel.textColor = .white
        balanceLabel.font = UIFont(name: "Roboto-Bold", size: 18)
        
            
        gamesView.layer.cornerRadius = 20
        
            
        popularGamesLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        popularRedUnderline.layer.cornerRadius = 4
        
        allGamesLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        allGamesRedUnderline.layer.cornerRadius = 4
        allGamesRedUnderline.isHidden = true

        firstGameView.layer.cornerRadius = 10
            
        secondGameView.isHidden = true
        secondGameView.layer.cornerRadius = 10

            
        thirdGameView.layer.cornerRadius = 10
        thirdGameView.isHidden = true

        
    }
    
   private func setBalance() -> Int {
        
        let userDefaults = UserDefaults.standard

        if userDefaults.keyExists(key: "Balance") {
            return userDefaults.integer(forKey: "Balance")
        } else {
            return 1000
        }
    }
    
    @IBAction func popuralGamesButtonPressed(_ sender: Any) {
           Model.instance.play(sound: Constant.spin_sound)
           allGamesRedUnderline.isHidden = true
           popularRedUnderline.isHidden = false
           secondGameView.isHidden = true
           thirdGameView.isHidden = true
       }
       
       
       @IBAction func allGamesButtonPressed(_ sender: Any) {
           Model.instance.play(sound: Constant.spin_sound)
           popularRedUnderline.isHidden = true
           allGamesRedUnderline.isHidden = false
           secondGameView.isHidden = false
           thirdGameView.isHidden = false
       }
    
    @IBAction func firstGameButtonPressed(_ sender: Any) {
        if let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            newViewController.slotsImages = games.firstGameImageSet
            
            newViewController.modalTransitionStyle = .crossDissolve
            newViewController.modalPresentationStyle = .overCurrentContext
            newViewController.balance = balance
            
            self.present(newViewController, animated: true)
        }
    }
    
    
    @IBAction func secondGameButtonPressed(_ sender: Any) {
        if let GameViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            GameViewController.slotsImages = games.secondGameImageSet

            GameViewController.modalTransitionStyle = .crossDissolve
            GameViewController.modalPresentationStyle = .overCurrentContext
            GameViewController.balance = balance
            
            self.present(GameViewController, animated: true)
        }
    }
    
    
    @IBAction func thirdGameButtonPressed(_ sender: Any) {
        if let GameViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            GameViewController.slotsImages = games.thirdGameImageSet

            GameViewController.modalTransitionStyle = .crossDissolve
            GameViewController.modalPresentationStyle = .overCurrentContext
            GameViewController.balance = balance
            
            self.present(GameViewController, animated: true)
        }
    }
    
    
   
}


extension UserDefaults {
    
    func keyExists(key: String) -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: key) else { return false }
        return true
    }
}

