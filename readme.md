[![Build Status](https://www.bitrise.io/app/db9b8a614ca81158/status.svg?token=pnK66giJ4HQm8cRamwvSvQ&branch=develop)](https://www.bitrise.io/app/db9b8a614ca81158)

![Exchanger](https://github.com/vkaltyrin/exchanger/blob/develop/exchanger.png)

# Exchanger

The Exchanger is a simple iOS application demonstrating one of approaches to implement VIPER 💎 architecture in modern Objective-C.

# Table of contents

* [About](#about)
* [Setup](#setup)
    * [CocoaPods](#cocoapods)
    * [OCLint](#oclint)
    * [XCPretty](#xcpretty)
* [Notes on implementation](#notes)
    * [Architecture](#architecture)
    * [VIPER](#viper)
    * [Type Inference](#typeinference)
    * [Blocks](#blocks)
    * [CarouselView](#carouselview)
    * [Persistance](#persistance)
    * [Tests](#tests)

<a name="about"/>

## About

The application is a fairly straightforward currency converter. It takes a reference rate from a European Central Bank by parsing its [public XML](http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml) and provides a feature to exchange any currency including EUR, USD and GBP in any combination. The exchange rate is automatically updated each 30 seconds.

When app starts there is a limited balance with 100 units of each currency.
There are two text inputs on the screen, both are cyclic carousel views for choosing currency to exchange.

YouTube video of how it works:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=SdipG8ApWWc
" target="_blank"><img src="http://img.youtube.com/vi/SdipG8ApWWc/0.jpg"
alt="Exchanger app video" width="480" height="360" border="10" /></a>

The app core is carefully designed with love ❤️ to SOLID in pure Objective-C using VIPER architecture combined with SOA. Meanwhile, unit tests are written in Swift.

If you have any questions just [email me](mailto:vkasci@gmail.com). Feel free to open issues 😀

<a name="setup"/>

## Setup

<a name="cocoapods"/>

### Cocoapods

To install all project dependencies just use Cocoapods:

```bash
pod install
```

<a name="oclint"/>

### OCLint

If OCLint is not installed on your machine then run following commands in Terminal:

```bash
brew tap oclint/formulae
brew install oclint
```

<a name="xcpretty"/>

### XCPretty

If XCPretty is not installed on your machine then run following commands in Terminal:

```bash
gem install xcpretty
```

<a name="notes"/>

## Notes on implementation

### Architecture

<a name="architecture"/>

The app is intended to implement the clean architecture.

![Clean architecture](https://github.com/vkaltyrin/exchanger/blob/develop/architecture.png)

<a name="viper"/>

### VIPER

Each screen is represented as VIPER module. In this implementation of VIPER there is a Router
class for navigation between screens and functional callbacks to interact with module, for example:

```objective-c

@protocol ExchangeMoneyModule <NSObject>
@property (nonatomic, strong) void(^onFinish)();

- (void)dismissModule;

@end

```

<a name="typeinference"/>

### Type Inference

Type Inference is a common feature in Swift, but Objective-C by default doesn't provide it. It's easy to avoid this
issue by using C macroses, as it's provided below:

```objective-c
#define let __auto_type const
#define var __auto_type
```

Without using __auto_type:
```objective-c
NSArray<Currency *> *currencies = data.currencies;
```

With using using __auto_type:
```objective-c
let currencies = data.currencies;
```

<a name="blocks"/>

### Blocks

There is a common pattern in Objective-C to call a block:

```objective-c
if (block != nil) {
    block();
}
```

With optionals and closures syntax introduced in Swift this syntax looks especially overweighted.
There is a C macros to deal with that:

```objective-c
#define safeBlock(block, ...) if (block != nil) { block(__VA_ARGS__); }
```

<a name="carouselview"/>

### CarouselView

CarouselView implementation uses dummy UITextField in order to keep some first responder on the screen.
It that way the keyboard is always on the screen which is a nice UX.

<a name="persistance"/>

### Persistance

App saves the state using simple Core Data storage.

<a name="Tests"/>

### Tests

Unit tests are provided for service layer and core layer including formatters. Some folks prefer to write unit tests for Presenter and Interactor. In practice it may be a case of accidental complexity. When business logic is located mainly in services, then unit tests for service layer are appropriate. Interactor just passes values from presenter to services. Presenter's code is often changing and it makes more sense to write UI tests. In this way unit tests for Interactor and Presenter are recommended but there is no strict need to write tests for them meanwhile code keeps to be testable and maintable.
