import UIKit
import Tools

class ViewController: UIViewController {
    
    private var padding = 0
    private let documentController = PTDocumentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navigationController = UINavigationController(rootViewController: documentController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isTranslucent = false
        navigationController.toolbar.isTranslucent = false
        navigationController.navigationBar.topItem?.leftBarButtonItems = [
            UIBarButtonItem(title: "Zoom Rect", style: .plain, target: self, action: #selector(zoomRect)),
            UIBarButtonItem(title: "Disable padding", style: .plain, target: self, action: #selector(disablePadding)),
        ]
        
        let fileURL = Bundle.main.url(forResource: "test2", withExtension: "pdf")
        documentController.openDocument(with: fileURL!)
        
        self.present(navigationController, animated: true)
    }
    
    @objc func zoomRect() {
        enablePadding()
        var pdfRect = PTPDFRect(x1: -266.91396, y1: 350.44244, x2: 352.46744, y2: 619.9053)!
        documentController.pdfViewCtrl.showRect(1, rect: pdfRect)
    }
    
    private func enablePadding() {
        let horizontalPadding = 1000.0
        let verticalPadding = 800.0
        documentController.pdfViewCtrl.setPageSpacing(0, vert_col_space: 0,
                                                      horiz_pad: Int32(horizontalPadding) / 2,
                                                      vert_pad: Int32(verticalPadding) / 2)
    }
    
    @objc func disablePadding() {
        documentController.pdfViewCtrl.setPageSpacing(0, vert_col_space: 0, horiz_pad: 0, vert_pad: 0)
    }
}
