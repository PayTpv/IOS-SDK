# PAYTPV iOS SDK

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PAYTPV.svg)](https://img.shields.io/cocoapods/v/PAYTPV.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

The PAYTPV SDK provides easy to use methods for connecting to the PAYTPV API.

- [Requirements](#requirements)
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
- [Usage](#usage)
- [Examples](#examples)

## Requirements

The SDK is compatible with iOS apps supporting iOS 8.0 and later.

---

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate PAYTPV into your project, specify it in your `Podfile`:

```ruby
pod 'PAYTPV'
```

Example Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<TARGET_NAME>' do
  pod 'PAYTPV'
end
```

Then, run the following command:

```bash
$ pod install
```

Don't forget to use the `.xcworkspace` instead of the `.xcodeproj` from now on.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate PAYTPV into your project using Carthage, specify it in your `Cartfile`:

```ogdl
github "PayTpv/IOS-SDK" ~> 1.0
```

Then, run `carthage update` to build the framework and drag the built `PAYTPV.framework` into your Xcode project.

---

## Usage

After you're done installing the SDK, you need to create the configuration object with your terminal details:

Swift:

```swift
import PAYTPV

let config = PTPVConfiguration(merchantCode: "MERCHANT_CODE", terminal: "TERMINAL", password: "PASSWORD", jetId: "JETID")
PTPVAPIClient.shared().configuration = config
```

ObjC:

```objective-c
#import <PAYTPV/PAYTPV.h>

PTPVConfiguration *config = [[PTPVConfiguration alloc] initWithMerchantCode:@"MERCHANT_CODE"
                                                       terminal:@"TERMINAL"
                                                       password:@"PASSWORD" 
                                                       jetId:@"JETID"];
[[PTPVAPIClient sharedClient] setConfiguration:config];
```

After you created the configuration, you can start making requests:

Swift:

```swift
// get the user's card details
let card = PTPVCard(pan: "4111111111111111", expiryDate: "0518", cvv: "123")

// add the card
PTPVAPIClient.shared().addUser(card) { (user, error) in
    guard let user = user else {
        if let error = error {
            // handle error
        }
        return;
    }

    // define payment details
    let purchaseRequest = PTPVPurchaseRequest(amount: "199",
                                                order: "ios_1234",
                                                currency: PTPVCurrencyEUR,
                                                productDescription: nil,
                                                owner: nil,
                                                scoring: nil)

    // make the payment
    PTPVAPIClient.shared().executePurchase(purchaseRequest, for: user, completion: { (purchase, error) in
        guard let purchase = purchase else {
            if let error = error {
                // handle error
            }
            return;
        }

        // handle successful payment
    })
}
```

ObjC:

```objective-c
// get the user's card details
PTPVCard *card = [[PTPVCard alloc] initWithPan:@"4111111111111111"
                                    expiryDate:@"0518"
                                            cvv:@"123"];

// add the card
[[PTPVAPIClient sharedClient] addUser:card completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
    if (error != nil) {
        // handle error
        return;
    }

    // define payment details
    PTPVPurchaseRequest *purchaseRequest;
    purchaseRequest = [[PTPVPurchaseRequest alloc] initWithAmount:@"199"
                                                            order:@"ios_1234"
                                                            currency:PTPVCurrencyEUR
                                                productDescription:nil
                                                            owner:nil
                                                            scoring:nil];

    // make the payment
    [[PTPVAPIClient sharedClient] executePurchase:purchaseRequest forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            // handle error
            return;
        }

        // handle successful payment
    }];
}];
```

If you have several terminals, you can instantiate a separate client with the configuration instead of using the shared client:

Swift:

```swift
let client = PTPVAPIClient(configuration: config)
client.addUser(..., completion: ...)
```

Objc:

```objective-c
PTPVAPIClient *client = [[PTPVAPIClient alloc] initWithConfiguration:config];
[client addUser:... completion:...];
```

---

## Examples

There are Swift and Objective-C example applications included in the repository. They show how to use the SDK to: add a card, remove a card, make a payment, make a refund. Check the `Examples` folder.
