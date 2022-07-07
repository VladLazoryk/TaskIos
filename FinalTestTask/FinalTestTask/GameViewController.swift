import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var minusLabel: UILabel!
    
    @IBOutlet weak var plusButtonView: UIView!
    @IBOutlet weak var minusButtonView: UIView!
    
    @IBOutlet weak var backgroundSpinView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var spinPriceLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    
    @IBOutlet weak var spinPriceView: UIView!
    @IBOutlet weak var spinButton: UIButton!
   
    


    private var slotsDataArray = [[Int](), [Int](), [Int](), [Int](), [Int]()]
    public var slotsImages: [UIImage] = [UIImage]()
    public var balance: Int = 0
    private var spinPrice: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
                    
        pickerView.delegate   = self
        pickerView.dataSource = self
        
        loadData()
        setupUI()
        spinSlots()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)

        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)

    }
    
    
    
   private func loadData() {
        for i in 0...4 {
            for _ in 0...100 {
                slotsDataArray[i].append(Int.random(in: 0...slotsImages.count - 1))
            }
        }
    }
    
    private func setupUI() {
        
        pickerView.isUserInteractionEnabled = false
        
        backgroundSpinView.alpha = 0.5
        backgroundSpinView.layer.cornerRadius = 50
        
        resultsLabel.alpha = 0
        
        
        plusLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        plusLabel.font = UIFont(name: "Roboto-Bold", size: 22)
        
        balanceLabel.text = String(balance)
        balanceLabel.textColor = UIColor(red: 0.169, green: 0.157, blue: 0.212, alpha: 1)
        balanceLabel.font = UIFont(name: "Roboto-Bold", size: 22)

        
        
        plusButtonView.layer.backgroundColor = UIColor(red: 0.169, green: 0.157, blue: 0.212, alpha: 1).cgColor
        plusButtonView.layer.cornerRadius = 3
        plusButtonView.layer.borderWidth = 1
        plusButtonView.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
        
        
        
        minusLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        minusLabel.font = UIFont(name: "Roboto-Bold", size: 22)
        
        spinPriceLabel.text = String(spinPrice)
        spinPriceLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        spinPriceLabel.font = UIFont(name: "Roboto-Bold", size: 22)
        
        minusButtonView.layer.backgroundColor = UIColor(red: 0.169, green: 0.157, blue: 0.212, alpha: 1).cgColor
        minusButtonView.layer.cornerRadius = 3
        minusButtonView.layer.borderWidth = 1
        minusButtonView.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
        
        
        spinPriceView.layer.backgroundColor = UIColor(red: 0.169, green: 0.157, blue: 0.212, alpha: 1).cgColor
        spinPriceView.layer.cornerRadius = 3
        spinPriceView.layer.borderWidth = 1
        spinPriceView.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
        
       
    }

    private func spinSlots() {
        for i in 0...4 {
            pickerView.selectRow(Int.random(in: 5...97), inComponent: i, animated: true)
        }
    }
    
    private func checkWinOrLose() {
        let firstSlot = pickerView.selectedRow(inComponent: 0)
        let secondSlot = pickerView.selectedRow(inComponent: 1)
        let thirdSlot = pickerView.selectedRow(inComponent: 2)
        let fourthSlot = pickerView.selectedRow(inComponent: 3)
        let fifthSlot = pickerView.selectedRow(inComponent: 4)
        Model.instance.play(sound: Constant.win_sound)
        
        
        let slots = [slotsDataArray[0][firstSlot], slotsDataArray[1][secondSlot], slotsDataArray[2][thirdSlot], slotsDataArray[3][fourthSlot], slotsDataArray[4][fifthSlot]]
        
        let results = slots.sorted()
        
        if (results[0] == results[1] && results[0] == results[2] && results[0] == results[3]) || (results[1] == results[2] && results[1] == results[3] && results[1] == results[3]) {
            
            let prize = spinPrice * 100
            balance = balance + prize
            resultsLabel.text = "WIN: \(String(prize))"
        } else if (results[0] == results[1] && results[0] == results[2]) && (results[3] == results[4]) || (results[0] == results[1] && results[2] == results[3] && results[2] == results[4]) {
            let prize = spinPrice * 50
            balance = balance + prize
            resultsLabel.text = "WIN: \(String(prize))"

        } else if (results[0] == results[1] && results[2] == results[3]) || (results[0] == results[1] && results[3] == results[4]) || (results[1] == results[2] && results[3] == results[4]) {
            let prize = spinPrice * 10
            balance = balance + prize
            resultsLabel.text = "WIN: \(String(prize))"

        } else if (results[0] == results[1] && results[0] == results[2]) || (results[1] == results[2] && results[1] == results[3]) || (results[2] == results[3] && results[3] == results[4]) {
            let prize = spinPrice * 5
            balance = balance + prize
            resultsLabel.text = "WIN: \(String(prize))"

        } else if Set(results).count == 4 {
            let prize = spinPrice * 2
            balance = balance + prize
            resultsLabel.text = "WIN: \(String(prize))"

        } else if Set(results).count == 5 {
            resultsLabel.text = "Try again"
        }
        
        resultsLabel.alpha = 1
        balanceLabel.text = String(balance)
    
        let userDefaults = UserDefaults.standard

        DispatchQueue.main.async {
            userDefaults.set(self.balance, forKey: "Balance")
        }
    }
    
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        spinPrice = spinPrice + 1
        spinPriceLabel.text = String(spinPrice)

    }
    
    
   @IBAction func minusButtonPressed(_ sender: Any) {
       
       if spinPrice != 1 {
           spinPrice = spinPrice - 1
       }
       
       spinPriceLabel.text = String(spinPrice)
       
   }
   
    
    @IBAction func spinButtonPressed(_ sender: AnyObject) {
        
        spinSlots()
        checkWinOrLose()
        balance = balance - spinPrice
        self.balanceLabel.text = String(balance)
        
        let userDefaults = UserDefaults.standard

        DispatchQueue.main.async {
            userDefaults.set(self.balance, forKey: "Balance")
        }
        
    }
    
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
            
           
           if let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
               newViewController.modalTransitionStyle = .crossDissolve
               newViewController.modalPresentationStyle = .overCurrentContext
               
               newViewController.balance = balance
               
               self.present(newViewController, animated: true)
           }
       }
}



extension GameViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
}


extension GameViewController: UIPickerViewDataSource {
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerImage = UIImageView()
        
        switch component {
        case 0 : pickerImage.image = slotsImages[(Int)(slotsDataArray[0][row])]
        case 1 : pickerImage.image = slotsImages[(Int)(slotsDataArray[1][row])]
        case 2 : pickerImage.image = slotsImages[(Int)(slotsDataArray[2][row])]
        case 3 : pickerImage.image = slotsImages[(Int)(slotsDataArray[3][row])]
        case 4 : pickerImage.image = slotsImages[(Int)(slotsDataArray[4][row])]
        default : print("done")
        }
        
        pickerImage.contentMode = .scaleAspectFit
        return pickerImage
    }
}
