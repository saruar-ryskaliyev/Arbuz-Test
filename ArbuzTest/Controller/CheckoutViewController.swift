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

        streetTextField.placeholder = "Street"
        streetTextField.borderStyle = .roundedRect
        streetTextField.translatesAutoresizingMaskIntoConstraints = false

        numberTextField.placeholder = "Number"
        numberTextField.keyboardType = .numberPad
        numberTextField.borderStyle = .roundedRect
        numberTextField.translatesAutoresizingMaskIntoConstraints = false

        floorTextField.placeholder = "Floor"
        floorTextField.keyboardType = .numberPad
        floorTextField.borderStyle = .roundedRect
        floorTextField.translatesAutoresizingMaskIntoConstraints = false

        flatNumberTextField.placeholder = "Flat"
        flatNumberTextField.keyboardType = .numberPad
        flatNumberTextField.borderStyle = .roundedRect
        flatNumberTextField.translatesAutoresizingMaskIntoConstraints = false

        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)

        timePicker.datePickerMode = .time
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker)

        frequencySegmentedControl.selectedSegmentIndex = 0
        frequencySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frequencySegmentedControl)

        checkOutButton.setTitle("Checkout", for: .normal)
        checkOutButton.backgroundColor = .systemGreen
        checkOutButton.layer.cornerRadius = 10
        checkOutButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        checkOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkOutButton)

        view.addSubview(phoneNumberTextField)
        view.addSubview(streetTextField)
        view.addSubview(numberTextField)
        view.addSubview(floorTextField)
        view.addSubview(flatNumberTextField)

        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
            make.width.equalTo(view.frame.width).offset(-100)
        }

        streetTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottomMargin).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
            make.width.equalTo(view.frame.width)
        }

        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottomMargin).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(40)
            make.width.equalTo((view.bounds.width - (4 * 10)) / 3)
        }

        floorTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottomMargin).offset(20)
            make.leading.equalTo(numberTextField.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.width.equalTo((view.bounds.width - (4 * 10)) / 3)
        }

        flatNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottomMargin).offset(20)
            make.leading.equalTo(floorTextField.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.trailing.equalTo(streetTextField.snp.trailing)
            make.width.equalTo((view.bounds.width - (4 * 10)) / 3)
        }

        checkOutButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottomMargin).offset(-100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        datePicker.snp.makeConstraints { make in
            make.leading.equalTo(phoneNumberTextField)
            make.top.equalTo(numberTextField.snp.bottomMargin).offset(20)
        }

        timePicker.snp.makeConstraints { make in
            make.leading.equalTo(datePicker.snp.trailingMargin).offset(10)
            make.top.equalTo(numberTextField.snp.bottomMargin).offset(20)
        }

        frequencySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottomMargin).offset(20)
            make.leading.equalTo(phoneNumberTextField)
        }
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
        
        orderedProductsList.append(selectedProducts)
        selectedProducts.removeAll()
        
        
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
