//
//  File.swift
//  
//
//  Created by Jonathan Hirsch on 8/31/20.
//

import UIKit

public protocol BlurredScrollableModalView {
    
    func canDismiss()->Bool;
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView);
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool);
}
