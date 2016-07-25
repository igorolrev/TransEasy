//
//  UIViewController+TransEasy.swift
//  TransEasy
//
//  Created by Mohammad Porooshani on 7/21/16.
//  Copyright © 2016 Porooshani. All rights reserved.
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Mohammad Poroushani
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

private let toSecondViewSegueID = "toSecondViewSegue"

class FirstViewController: UIViewController, TransEasyDestinationViewControllerProtocol {
  
  @IBOutlet weak var qrButton: UIButton!
  @IBOutlet weak var qrLabel: UILabel!
  @IBOutlet weak var presentationStyleButton: UIBarButtonItem!
  
    var isModal = false
  var easyPresentAnimationComtroller = EasyPresentAnimationController()
  var easyDismissAnimationComtroller = EasyDismissAnimationController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
    return true
  }
  override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    print("unwindng in First Controller")
  }
  override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
    print("unwindng override in First Controller")
    return nil
  }
  @IBAction func qrButtonClicked(sender: AnyObject) {
    
    if isModal {
        guard let destinationViewController = storyboard?.instantiateViewControllerWithIdentifier("secondVC") else {
            return
        }
        // This method adds easy trans to the SecondViewController using the provided options for present and dismiss.
        setupEasyTransition(on: destinationViewController, presentOptions: TransEasyPresentOptions(duration: 0.4, sourceView: qrButton, blurStyle: UIBlurEffectStyle.Dark), dismissOptions: TransEasyDismissOptions(duration: 0.4, destinationView: qrButton))
        presentViewController(destinationViewController, animated: true, completion: nil)
    } else {
        performSegueWithIdentifier(toSecondViewSegueID, sender: sender)
    }
    
  }
  @IBAction func getBack(segue: UIStoryboardSegue) {
    guard let seg = segue as? TransEasySegue else {
      return
    }
    
//    seg.sourceView = qrImage
  }
  func transEasyDestinationView() -> UIView {
    return qrButton
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    guard let segueID = segue.identifier else {
      print("Could not verify the segue's identity")
      return
    }
    
    switch segueID {
    case toSecondViewSegueID:
      if let easySeg = segue as? TransEasySegue {
        easySeg.sourceView = qrButton
        return
      }
    default:
      print("Unknown segue!")
    }
    
  }
    @IBAction func modalButtonClicked(sender: AnyObject) {
        
        isModal = !isModal
        presentationStyleButton.title = "Style: " + (isModal ? "Modal" : "Push")
    }
  
}
