# CarFax - Coding Assigment
## _Display Cars_

The current project is reponsible for dowloading cars using CarFax REST api and display them on a homepage. 

## Implementation Plan

- Download and display all cars on the home screen.
- When clicked on the dealer phone number. The app should be able to make a call.

###### Note : Supports iOS 14.1 or above.

## Installation

Pod install to download the libraries.

```sh
cd to /path/project
pod install
```

## Libraries

 - [SDWebImage](https://github.com/SDWebImage/SDWebImage) For loading the images asynchronously and for better caching.

## References
- [Formatting Number](https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift) Formats the given phone number string to (XXX) XXX-XXXX
- [Convert numbers to small number format](https://gist.github.com/gbitaudeau/daa4d6dc46517b450965e9c7e13706a3)
- [Convert number to current locale format](https://medium.com/@mariannM/currency-converter-in-swift-4-2-97384a56da41)