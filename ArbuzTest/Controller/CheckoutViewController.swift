import UIKit

class CheckoutViewController: UIViewController {

    // MARK: - Properties

    private let phoneNumberTextField = UITextField()
    private let streetTextField = UITextField()
    private let numberTextField = UITextField()
    private let floorTextField = UITextField()
    private let flatNumberTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    private let frequencySegmentedControl = UISegmentedControl(items: ["1 week", "2 weeks", "1 month"])
    private let checkOutButton = UIButton()
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Checkout"

        phoneNumberTextField.placeholder = "Phone number"
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberTextField)
        
        
        
        
        checkOutButton.setTitle("Checkout", for: .normal)
        checkOutButton.backgroundColor = .systemGreen
        checkOutButton.layer.cornerRadius = 10
        checkOutButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        checkOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkOutButton)
        
        NSLayoutConstraint.activate([
            checkOutButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            checkOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkOutButton.widthAnchor.constraint(equalToConstant: 200),
            checkOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        

        streetTextField.placeholder = "Street"
        streetTextField.borderStyle = .roundedRect
        streetTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(streetTextField)
        
        NSLayoutConstraint.activate([
            streetTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            streetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            streetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            streetTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        

        numberTextField.placeholder = "Number"
        numberTextField.keyboardType = .numberPad
        numberTextField.borderStyle = .roundedRect
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberTextField)
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 20),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            numberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        floorTextField.placeholder = "Floor"
        floorTextField.keyboardType = .numberPad
        floorTextField.borderStyle = .roundedRect
        floorTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floorTextField)
        
        NSLayoutConstraint.activate([
            floorTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 20),
            floorTextField.leadingAnchor.constraint(equalTo: numberTextField.trailingAnchor, constant:20),
            floorTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            floorTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        flatNumberTextField.placeholder = "Flat number"
        flatNumberTextField.keyboardType = .numberPad
        flatNumberTextField.borderStyle = .roundedRect
        flatNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flatNumberTextField)
        
        NSLayoutConstraint.activate([
            flatNumberTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 20),
            flatNumberTextField.leadingAnchor.constraint(equalTo: floorTextField.trailingAnchor, constant: 20),
            flatNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            flatNumberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
     
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
        
  
        timePicker.datePickerMode = .time
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker)
        
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: -100),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
        
  
        frequencySegmentedControl.selectedSegmentIndex = 0
        frequencySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frequencySegmentedControl)
        
        NSLayoutConstraint.activate([
            frequencySegmentedControl.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: -50),
            frequencySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            frequencySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            frequencySegmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Validation Methods
    
    private func validatePhoneNumber() -> Bool {
        guard let phoneNumber = phoneNumberTextField.text else { return false }
        let phoneNumberRegex = "^\\d{11}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: phoneNumber)
    }
    
    private func validateAddress() -> Bool {
        guard let street = streetTextField.text, let number = numberTextField.text, let floor = floorTextField.text, let flatNumber = flatNumberTextField.text else { return false }
        return !street.isEmpty && !number.isEmpty && !floor.isEmpty && !flatNumber.isEmpty
    }
    
    // MARK: - Actions
    
    @objc private func placeOrder() {
        if !validatePhoneNumber() {
            
            let alert = UIAlertController(title: "Invalid phone number", message: "Please enter a valid 11-digit phone number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if !validateAddress() {
            
            let alert = UIAlertController(title: "Invalid address", message: "Please enter a valid address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        

        let selectedDate = datePicker.date
        let selectedTime = timePicker.date
        let selectedFrequencyIndex = frequencySegmentedControl.selectedSegmentIndex
        let selectedFrequency: String
        switch selectedFrequencyIndex {
        case 0:
            selectedFrequency = "1 week"
        case 1:
            selectedFrequency = "2 weeks"
        case 2:
            selectedFrequency = "1 month"
        default:
            selectedFrequency = ""
        }
    
        
        let alert = UIAlertController(title: "Success", message: "Your order has been placed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
