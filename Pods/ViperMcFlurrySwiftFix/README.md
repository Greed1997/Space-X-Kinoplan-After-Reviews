# ViperMcFlurrySwiftFix

## Purpose
Contains fix enabling using of ViperMcFlurry (https://github.com/rambler-digital-
solutions/ViperMcFlurry) from Swift language ("moduleInput" problem) interacting with
modules written in Objective-C.

## Installation

### Cocoapods

Just add this to your *Podfile*

```
pod 'ViperMcFlurrySwiftFix'
```

And run:

```bash
pod install
```

## How it works

Demo application contains two viper modules **Root** and **Test**. Router of Root module opens Test module using ViperMcFlurry methods:

```swift
import ViperMcFlurry

class RootRouter: RootRouterInput {
    
    weak var transitionHandler: RamblerViperModuleTransitionHandlerProtocol!

    func showTest() {
        transitionHandler.openModule!(usingFactory: TestModuleConfigurator()) { (sourceModuleTransitionHandler, destinationModuleTransitionHandler) in
            
            let sourceViewController = sourceModuleTransitionHandler as! UIViewController
            let destinationViewController = destinationModuleTransitionHandler as! UIViewController
            
            sourceViewController.present(destinationViewController, animated: true, completion: nil)
            
            }.thenChain { (moduleInput) -> RamblerViperModuleOutput? in
                // This code without ViperMcFlurrySwiftFix will crash, because
                // moduleInput will check only Obj-C version of property and returns nil.
                // The fix checks both Obj-C and Swift properties.
                (moduleInput as! TestModuleInput).configure()  // FIX WORKS HERE!!!
                return nil
        }
    }
    
}
```

Without fix **moduleInput** property will not find value inside Obj-C runtime, because Swift properties do not
land there. So, first of all value is checked in normal Obj-C property, then in Swift properties using Swift reflection.
