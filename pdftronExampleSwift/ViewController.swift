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
//        documentController.pdfViewCtrl.dele
        
        self.present(navigationController, animated: true) {
            self.enablePadding()
        }
        
    }
    
    @objc func zoomRect() {
        enablePadding()
        // if you uncomment the next line it behaves a little better but still now perfectly
//        documentController.pdfViewCtrl.contentScrollView.zoom(to: documentController.pdfViewCtrl.frame, animated: false)
        var pdfRect = PTPDFRect(x1: -266.91396, y1: 350.44244, x2: 352.46744, y2: 619.9053)!
        let cgRect = documentController.pdfViewCtrl.pdfRectPage2CGRectScreen(pdfRect, pageNumber: 1)
        documentController.pdfViewCtrl.contentScrollView.zoom(to: cgRect, animated: true)
    }
    
    private func enablePadding() {
        let horizontalPadding = 1000.0
        let verticalPadding = 800.0
        documentController.pdfViewCtrl.contentScrollView.contentInset = UIEdgeInsets(top: verticalPadding / 2, left: horizontalPadding / 2,
                                                                                     bottom: verticalPadding / 2, right: horizontalPadding / 2)
    }
    
    @objc func disablePadding() {
        documentController.pdfViewCtrl.contentScrollView.contentInset = .zero
    }
    
    
}
