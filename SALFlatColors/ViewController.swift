//
//  ViewController.swift
//  SALFlatColors
//
//  Created by Salvatore Petrazzuolo on 18/11/2018.
//  Copyright © 2018 A&S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    
    let COLLECTION_CELL_LEFT_PADDING: CGFloat        = 0
    let COLLECTION_CELL_RIGHT_PADDING: CGFloat       = 0
    let COLLECTION_CELL_INTER_ITEMS_PADDING: CGFloat = 0
    let COLLECTION_CELL_MIN_LINE_SPACING: CGFloat    = 0
    let COLLECTION_CELL_ASPECTRATIO: CGFloat         = 1
    
    
    let is4: Bool = {
        return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) < 568
    }()
    
    let isPadPro: Bool = {
        return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) >= 1366
    }()
    
    func isLandscape() -> Bool {
        return UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight
    }
    
    func numberOfItems() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if is4 {
                return isLandscape() ? 5 : 3
            } else {
                return isLandscape() ? 6 : 3
            }
        } else {
            if isPadPro {
                return isLandscape() ? 9 : 7
            } else {
                return isLandscape() ? 8 : 6
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomFlat = FlatColors.allCases.randomElement()?.uiColor
        view.backgroundColor = randomFlat
        collection.backgroundColor = randomFlat
        
        
        saveLiterals()
        saveAssets()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FlatColors.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.viewWithTag(11)?.backgroundColor = FlatColors.allCases[indexPath.row].uiColor
        (cell.viewWithTag(12) as! UILabel).text = String(describing: FlatColors.allCases[indexPath.row])
        (cell.viewWithTag(12) as! UILabel).textColor = FlatColors.allCases[indexPath.row].uiColor.readableColor()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.backgroundColor = FlatColors.allCases[indexPath.row].uiColor
        collection.backgroundColor = FlatColors.allCases[indexPath.row].uiColor
        
        print("""
            name: \(FlatColors.allCases[indexPath.row])
            red: \(view.backgroundColor!.redComponent)
            green: \(view.backgroundColor!.greenComponent)
            blue: \(view.backgroundColor!.blueComponent)
            alpha: \(view.backgroundColor!.alphaComponent)
            rgba: \(view.backgroundColor!.toRGBAComponents())
            """
        )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItem()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return COLLECTION_CELL_MIN_LINE_SPACING
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return COLLECTION_CELL_INTER_ITEMS_PADDING
    }
    
    
    func sizeForItem() -> CGSize {
        if isLandscape() {
            if let size = UserDefaults.standard.sizeFor(key: "settingLandscape") {
                return size
            } else {
                let viewWidth = (UIScreen.main.bounds.size.width - (COLLECTION_CELL_INTER_ITEMS_PADDING * (numberOfItems() - 1)) - (2 * COLLECTION_CELL_LEFT_PADDING)) / numberOfItems()
                UserDefaults.standard.setSize(CGSize(width: viewWidth, height: viewWidth * COLLECTION_CELL_ASPECTRATIO), forKey: "settingLandscape")
                return CGSize(width: viewWidth, height: viewWidth * COLLECTION_CELL_ASPECTRATIO)
            }
        } else {
            if let size = UserDefaults.standard.sizeFor(key: "settingPortrait") {
                return size
            } else {
                let viewWidth = (UIScreen.main.bounds.size.width - (COLLECTION_CELL_INTER_ITEMS_PADDING * (numberOfItems() - 1)) - (2 * COLLECTION_CELL_LEFT_PADDING)) / numberOfItems()
                UserDefaults.standard.setSize(CGSize(width: viewWidth, height: viewWidth * COLLECTION_CELL_ASPECTRATIO), forKey: "settingPortrait")
                return CGSize(width: viewWidth, height: viewWidth * COLLECTION_CELL_ASPECTRATIO)
            }
        }
    }
}

extension ViewController {
    func saveLiterals() {
        let outputListFile: String = "FlatLiterals.swift"
        var listFileContent: String = ""
        
        let rowStart = """
import UIKit
    
enum FlatLiterals: CaseIterable {

"""
        let rowEnd = """
}

"""
        let rowContent = "    static let %@ = #colorLiteral(red: %f, green: %f, blue: %f, alpha: %f)\n"
        
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let listUrl = documentsDirectoryURL.appendingPathComponent(outputListFile)
        print(listUrl)
        
        
        if FileManager.default.fileExists(atPath: listUrl.path) && FileManager.default.isDeletableFile(atPath: listUrl.path) {
            try! FileManager.default.removeItem(atPath: listUrl.path)
        }
        FileManager.default.createFile(atPath: listUrl.path, contents: nil, attributes: nil)
        
        listFileContent.append(rowStart)
        for color in FlatColors.allCases {
            let components = color.uiColor.toRGBAComponents()
            let currentRow =  String(format: rowContent, String(describing: color), components.r, components.g, components.b, components.a)
            listFileContent.append(currentRow)
        }
        listFileContent.append(rowEnd)
        
        try! listFileContent.write(to: listUrl, atomically: true, encoding: String.Encoding.utf8)
    }
    
    func saveAssets() {
        let fileContent = """
{
  "info" : {
    "version" : 1,
    "author" : "xcode"
  },
  "colors" : [
    {
      "idiom" : "universal",
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "red" : "%f",
          "green" : "%f",
          "blue" : "%f",
          "alpha" : "%f"
        }
      }
    }
  ]
}
"""
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let colorDirectoryURL =  documentsDirectoryURL.appendingPathComponent("/FlatColors.xcassets/%@.colorset/")
        let colorFileURL =  documentsDirectoryURL.appendingPathComponent("/FlatColors.xcassets/%@.colorset/Contents.json")
        
        print(documentsDirectoryURL)
        
        for color in FlatColors.allCases {
            let components = color.uiColor.toRGBAComponents()
            let currentColorDirectoryString = String(format: colorDirectoryURL.relativePath, String(describing: color))
            let currentColorFileString = String(format: colorFileURL.relativePath, String(describing: color))
            let colorFileContent = String(format: fileContent, components.r, components.g, components.b, components.a)
            
            if !FileManager.default.fileExists(atPath: currentColorDirectoryString) {
                try! FileManager.default.createDirectory(at: URL(fileURLWithPath: currentColorDirectoryString), withIntermediateDirectories: true, attributes: nil)
            }
            if !FileManager.default.fileExists(atPath: currentColorFileString) {
                FileManager.default.createFile(atPath: currentColorFileString, contents: nil, attributes: nil)
            }
            try! colorFileContent.write(to: URL(fileURLWithPath: currentColorFileString), atomically: true, encoding: String.Encoding.utf8)
            
        }
        
    }
}



