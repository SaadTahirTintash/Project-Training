//
//  Extensions.swift
//  Footy-Crazy
//
//  Created by Tintash on 25/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Creates a table view cell with default id for the first time and then dequeues it with the same id
    func defaultCell()-> UITableViewCell {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.defaultTableCell) else {
            return UITableViewCell(style: .default, reuseIdentifier: FCConstants.CELL_IDENTIFIERS.defaultTableCell)
        }
        return cell
    }
}
