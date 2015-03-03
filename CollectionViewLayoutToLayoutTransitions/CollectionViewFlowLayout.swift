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

//Normal layout
//
//3 items per row on iPads, and just one for iPhones.
class CollectionViewFlowLayout : UICollectionViewFlowLayout {
    
    private var itemsPerRow : Int {
        get {
            let idiom = UIDevice.currentDevice().userInterfaceIdiom
            if (idiom == UIUserInterfaceIdiom.Pad) {
                //3 items on iPads
                return 3
            } else {
                //One item on iPhones 
                return 1
            }
        }
    }
    
    //MARK: UICollectionViewFlowLayout
    
    override func prepareLayout() {
        
        self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        
        let collectionViewWidth =
            self.collectionView?.bounds.size.width
    
        let leftRightSpacing =
        self.sectionInset.left + self.sectionInset.right
        
        let totalInterItemSpacing : CGFloat
            
        switch self.itemsPerRow {
            case 1:
                totalInterItemSpacing = CGFloat(0)
            default:
                totalInterItemSpacing =
                    CGFloat(self.itemsPerRow-1) * self.minimumInteritemSpacing
        }
        
        let itemWidth : CGFloat
            
        switch self.itemsPerRow {
            case 1:
                itemWidth = collectionViewWidth! - leftRightSpacing
            default:
                itemWidth = floor(
                    (collectionViewWidth! - totalInterItemSpacing - leftRightSpacing) / CGFloat(self.itemsPerRow)
                )
        }
        
        self.itemSize = CGSizeMake(itemWidth, itemWidth * 1.15)
        
    }
    
}
