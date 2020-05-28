//
//  DoKitAlertUtil.swift
//  AFNetworking
//
//  Created by didi on 2020/5/26.
//

import Foundation

class DoKitAlertUtil {
    static func handleAlertAction(vc: UIViewController, title: String, text: String, ok: String, cancel: String, okBlock:@escaping ()->Void, cancelBlock:@escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .default) { (action: UIAlertAction) in
            okBlock()
        }
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { (action: UIAlertAction) in
            cancelBlock()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
