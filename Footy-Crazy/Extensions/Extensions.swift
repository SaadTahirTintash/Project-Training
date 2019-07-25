//
//  Extensions.swift
//  Footy-Crazy
//
//  Created by Tintash on 25/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

extension UITableView{
    func defaultCell()->UITableViewCell{
        guard let cell = self.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.defaultCell) else{
            return UITableViewCell(style: .default, reuseIdentifier: FCConstants.CELL_IDENTIFIERS.defaultCell)
        }
        return cell
    }
}
