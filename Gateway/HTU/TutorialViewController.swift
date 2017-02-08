//
//  TutorialViewController.swift
//  4points
//
//  Created by ming on 2016. 8. 10..
//  Copyright © 2016년 C4TK. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController{
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var page:Int?
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
            tutorialPageViewController?.page = self.page
        }
    }
    @IBAction func closeTutorial(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch page {
        case 0?:
            pageControl.numberOfPages = 5
            containerView.backgroundColor = UIColor.init(red: 213, green: 213, blue: 213, alpha: 213)
            
        case 1?:
            pageControl.numberOfPages = 23
        default:
            pageControl.numberOfPages = 3
        }
        
        let tutorialChecker = firstTimeChecker()
        if !tutorialChecker.isFirstTime(){
            tutorialChecker.save()
        }
        //pageControl.addTarget(self, action: #selector(TutorialViewController.didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        if pageControl.currentPage < pageControl.numberOfPages{
            tutorialPageViewController?.scrollToNextViewController()
        }
    }
    
    @IBAction func didTapPreButton(_ sender: UIButton) {
        if pageControl.currentPage > 0{
            tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage-1)
        }
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        switch page {
        case 0?:
            return UIInterfaceOrientationMask.all
        case 1?:
            return UIInterfaceOrientationMask.landscape
        default:
            return UIInterfaceOrientationMask.all
        }
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
