///////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015 Matteo Pacini                                              //
//                                                                               //
// Permission is hereby granted, free of charge, to any person obtaining a copy  //
// of this software and associated documentation files (the "Software"), to deal //
// in the Software without restriction, including without limitation the rights  //
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     //
// copies of the Software, and to permit persons to whom the Software is         //
// furnished to do so, subject to the following conditions:                      //
//                                                                               //
// The above copyright notice and this permission notice shall be included in    //
// all copies or substantial portions of the Software.                           //
//                                                                               //
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    //
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      //
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   //
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        //
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, //
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     //
// THE SOFTWARE.                                                                 //
///////////////////////////////////////////////////////////////////////////////////

import UIKit


class ViewController : UICollectionViewController {

    //MARK: Properties 
    
    //Cell class name, without Swift module
    fileprivate let cellIdentifier =
        NSStringFromSwiftClass(CollectionViewCell.self)!
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //This is necessary for the layout to honor "itemsPerRow"
        self.collectionViewLayout.invalidateLayout()
        
    }
        
    //MARK: Setup
    
    fileprivate func setup() {
        
        //Background color (as per screenshot)
        self.collectionView!.backgroundColor =
            UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        //Title (random)
        
        self.navigationItem.title = "Whatever"
        
        //Register cell nib
        
        let nib = UINib(nibName: "CollectionViewCell",
            bundle: Bundle.main)
        
        self.collectionView!.register(nib,
            forCellWithReuseIdentifier: cellIdentifier)
        
        //If we're on the normal layout, we add a bar button item,
        //whose action pushes a copy of this view controller with the expanded
        //layout.
        if let _ = self.collectionViewLayout as? CollectionViewFlowLayout {
            
            let bbi = UIBarButtonItem(title: "Change Layout",
                style: UIBarButtonItemStyle.plain,
                target: self,
                action: #selector(ViewController.changeLayout))
            
            self.navigationItem.setLeftBarButton(bbi, animated: false)
            
        }
        
    }
    
    //MARK: UICollectionViewDataSource
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        
            return 27 //Random
            
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: self.cellIdentifier,
                for: indexPath) as! CollectionViewCell
            
            return cell
            
    }
        
    //MARK: Change Layout
    
    func changeLayout() {
        
        let nextVC =
        ViewController(collectionViewLayout : CollectionViewExpandedFlowLayout())
        
        //This performs some kind of witchcraft underneath.
        nextVC.useLayoutToLayoutNavigationTransitions = true

        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}

