import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBAction func buttonListener(_ sender: Any) {
        self.view.makeToast("Show Toast")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

