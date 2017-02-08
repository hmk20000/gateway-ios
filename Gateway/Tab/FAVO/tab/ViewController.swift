

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    var destinationViewController:UIViewController!
    var oldViewController:UIViewController!
    var _viewControllersByIdentifier:NSMutableDictionary!
    var destinationIdentifier:NSString!

    @IBOutlet weak var sliderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.sliderView.layer.cornerRadius = 20
        
        
        _viewControllersByIdentifier = NSMutableDictionary()
        
        if(self.childViewControllers.count < 1){
            self.performSegue(withIdentifier: "FavoSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTabChangedClicked(_ sender: AnyObject) {
        let button = sender as! UIButton
        UIView.animate(withDuration: 0.5, animations: {
            self.sliderView.center = button.center
        })
        
        switch button.tag {
        case 1:
            self.performSegue(withIdentifier: "FavoSegue", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "HistorySegue", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "DownSegue", sender: nil)
        default:
            self.performSegue(withIdentifier: "FavoSegue", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.oldViewController = self.destinationViewController;
        
        
        if((_viewControllersByIdentifier.object(forKey: segue.identifier!)) == nil){
            _viewControllersByIdentifier.setObject(segue.destination, forKey: segue.identifier! as NSCopying)
        }
        
        
        
        self.destinationIdentifier = segue.identifier as NSString!;
        self.destinationViewController = _viewControllersByIdentifier.object(forKey: self.destinationIdentifier) as! UIViewController;
        
    }
}

