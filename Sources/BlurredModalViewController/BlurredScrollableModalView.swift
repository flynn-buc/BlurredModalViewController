//
//  File.swift
//  
//
//  Created by Jonathan Hirsch on 8/31/20.
//

import UIKit

public protocol BlurredScrollableModalView {
    
    func canDismiss() ->Bool;
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView);
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool);
}
