import UIKit
import Tools

class ViewController: UIViewController {
    
    private var padding = 0
    private let documentController = PTDocumentController()
    private var initialZoom = 0.0
    private var bottom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navigationController = UINavigationController(rootViewController: documentController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isTranslucent = false
        navigationController.toolbar.isTranslucent = false
        navigationController.navigationBar.topItem?.leftBarButtonItems = [UIBarButtonItem(title: "Zoom", style: .plain, target: self, action: #selector(test))]
        
//        let fileURL: URL = URL(string:"https://pdftron.s3.amazonaws.com/downloads/pdfref.pdf")!
        let fileURL = Bundle.main.url(forResource: "test2", withExtension: "pdf")
        documentController.openDocument(with: fileURL!)
        
        initialZoom = documentController.pdfViewCtrl.zoom
        
        self.present(navigationController, animated: true) {
            self.enablePadding()
        }
        
    }
    
    @objc func test() {
        var pdfRect: PTPDFRect!
        if bottom {
            pdfRect = PTPDFRect(x1: 0, y1: 0, x2: 224, y2: 233)
        } else {
            pdfRect = PTPDFRect(x1: 2800, y1: 3800, x2: 3024, y2: 4033)
        }
        let cgRect = documentController.pdfViewCtrl.pdfRectPage2CGRectScreen(pdfRect, pageNumber: 1)
        documentController.pdfViewCtrl.contentScrollView.zoom(to: cgRect, animated: true)
        bottom = !bottom
    }
    
    private func enablePadding() {
        let horizontalPadding = 1000.0
        let verticalPadding = 800.0
        documentController.pdfViewCtrl.contentScrollView.contentInset = UIEdgeInsets(top: verticalPadding / 2, left: horizontalPadding / 2,
                                                                                     bottom: verticalPadding / 2, right: horizontalPadding / 2)
        
    }
}
