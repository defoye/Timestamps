# TableauxUI

[![CI Status](https://img.shields.io/travis/defoye/TableauxUI.svg?style=flat)](https://travis-ci.org/defoye/TableauxUI)
[![Version](https://img.shields.io/cocoapods/v/TableauxUI.svg?style=flat)](https://cocoapods.org/pods/TableauxUI)
[![License](https://img.shields.io/cocoapods/l/TableauxUI.svg?style=flat)](https://cocoapods.org/pods/TableauxUI)
[![Platform](https://img.shields.io/cocoapods/p/TableauxUI.svg?style=flat)](https://cocoapods.org/pods/TableauxUI)

<!--ts-->
   * [Example](#example)
   * [Requirements](#requirements)
   * [Installation](#installation)
   * [Usage](#usage)
<!--te-->

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TableauxUI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TableauxUI'
```

## Usage

Build UITableViews by simply adding structs to a Tableau!

First, create a cell, and add an adapter to your model.

```swift
struct GreenModel {
    let name: String = "Green"
}

extension GreenModel: TableauDataAdapter {
    var identifier: String {
	return GreenTableauCell.reuseIdentifier
    }
}

class GreenTableauCell: TableauCell {
    func configure(data: Any?) {
    	self.backgroundColor = .green
    }
}
```

The TableauDataAdapter passes a unique identifier to your TableauxUIView so that views can be recycled. Here we pass a generated identifier by using an extension on the UIView:

```swift
public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UIView: ReusableView {}
```

Next, create a GreenViewAdapter and give it a tableau to paint your view:

```swift
enum Tableaux: Int, CaseIterable {
    case GreenTableau
}

class GreenViewAdapter {
    let tableau: Tableau(numberReservedTableaux: Tableaux.allCases.count)
}
```

```swift
extension GreenViewAdapter {
    func buildGreenTableau(index: Tableau, reload: @escaping (() -> Void)) {
    	let paintAdapter = tableau.paintAdapter()
        let tenGreenModels = Array.init(repeating: GreenModel(), count: 10)
        
        paintAdapter.paint(sectionModel: tenGreenModels, at: index.rawValue)
		
        reloadBlock()
    }
}
```

Connect to the paint adapter to create your painting.  Here, we append 10 Green models to the Tableau. 

And that's pretty much it.  Finally, connect your tableauxUIView to your GreenViewAdapter.

```swift
class GreenViewController: UIViewController {
    let viewAdapter: GreenViewAdapter
    let tableauxView: TableauxUIView
    let dataSource: DataSource
    
    init(viewAdapter: GreenViewAdapter) {
    	self.viewAdapter = viewAdapter
        self.tableauxView = TableauxUIView(frame: .zero, style: .plain)
	self.dataSource = DataSource(tableau: viewAdapter.tableau, tableauxUIView: tableauxView)
		
	super.init(nibName: nil, bundle: nil)
		
	self.tableauxView.registerCellTypes(types: [GreenTableauCell.self])
    }
    
    public override func viewDidLoad() {
	super.viewDidLoad()
        
	self.view = tableauxView
		
	greenViewAdapter.buildGreenTableau {
	    DispatchQueue.main.async {
		self.tableauxView.reloadData()
	    }
	}
    }
}
```

And of course, feel free to subclass a UITableView and/or a UITableViewCell instead. 

Enjoy!

## Author

Ernest DeFoy, erniedefoy3@gmail.com

## License

TableauxUI is available under the MIT license. See the LICENSE file for more info.
