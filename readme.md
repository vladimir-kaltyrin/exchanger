[![Build Status](https://www.bitrise.io/app/db9b8a614ca81158/status.svg?token=pnK66giJ4HQm8cRamwvSvQ&branch=develop)](https://www.bitrise.io/app/db9b8a614ca81158)

# Exchanger

The Exchanger is a simple iOS application demonstrating one of approaches to implement VIPER 💎 architecture in Objective-C.

# Table of contents

* [About](#about)
* [Setup](#setup)
* [Architecture ✘](#architecture)
* [Backend ✘](#architecture)
* [Testing ✘](#architecture)

<a name="about"/>

## About

The application is a fairly straightforward currency converter. It takes a reference rate from a European Central Bank by parsing its [public XML](http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml) and provides a feature to exchange any currency including EUR, USD and GBP in any combination.

When app starts there is a limited balance with 100 units of each currency.

<a name="setup"/>

## Setup

### Cocoapods

To install all project dependencies just use Cocoapods

```bash
pod install
```

### OCLint

If OCLint is not installed on your machine then run following commands in Terminal:

```bash
brew tap oclint/formulae
brew install oclint
```

### XCPretty

If XCPretty is not installed on your machine then run following commands in Terminal:

```bash
gem install xcpretty
```

<a name="architecture"/>

## Architecture
