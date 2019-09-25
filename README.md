
## Project

[![Build Status](https://travis-ci.org/miguelpimentel/desafio-ios.svg?branch=master)](https://travis-ci.org/miguelpimentel/desafio-ios)
[![codecov](https://codecov.io/gh/miguelpimentel/desafio-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/miguelpimentel/desafio-ios)
![SWIFT Version](https://img.shields.io/badge/swift-5.0-orange)
![LICENSE](https://img.shields.io/badge/License-MIT-blue)

## Architecture

The movie app was develop based on VIP architecture. However, it was necessary to make adjustments in order to adopt customization of components, local storage and a proper API consumption layer.

The architecture used was based in VIP, so it is based on scenes (Entity; View; Interactor, Presenter, Router and Work ). I create three scenes (Home; Search; Movie Detail). 

There is also a network layer, that make it easy to apply http requests and create endpoint with its parameters. It was made with UrlSession

There is a Manager for realm, local storage (cache), that is based on protocols and uses the adapter design pattern. 

In this scenario, there is a folder with extension of native components such as helpers( designable and inspectable - see observation)

The general architecture could be present as:

[![Untitled-Diagram.jpg](https://i.postimg.cc/VL2XJYdh/Untitled-Diagram.jpg)](https://postimg.cc/fJjVFQ77)

For more informations about VIP (https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf)

## Unit test 

The CI runs a specific stage for unit test, the reports are based on codecov tool.

## Extra Features

#### 1. Preview a movie detail using force touch 

#### 2. Share an image poster in movie details

## Observations 

* Forcing wrapping almost ever should be avoided, but in some points could avoid an overhead since an object can not be null, for example UIFont.
* Designable and inspectable must be used only with a low amount of views. E.g movie collection view cell and card for movie genre. So, be careful.
* Using a VIP architecture in such small mobile app makes non sense (over Engineer), MVP or MVVM fits better for this scenario. However, in real world, architecture makes the difference, so spent time on it can bring a more maintenable and stable code.
* Lately, I'm avoiding to use pods and carthage. In my opinion, the apple's framework are so powerfull and many external frameworks are descontinuated. __It's important be free of third part frameworks__. 
* There is a log related to web view, see this topic in stackoverflow. It's an xcode configuration.
https://stackoverflow.com/questions/12411208/app-rejected-for-using-libsqlite3-dylib

### NOTE: I was in war room this week, so i did not have much time to make it, ignore the ! force wrap, e/g realm in interactor. 

### Issue

Feel free to open up an issue about a problem or desired feature.

### About me 

Found in Software Engineering an area to explore and develop his skills. A professional passionate about learning and applying knowledge as a way to improve the software development workflow. Great interest in areas such as: Mobile development; Backend Development; NoSQL; Big data; Data Science; Agile Methodology; Software Architecture; DevOps; CI; CD and Project Management.

[![qrcode.png](https://i.postimg.cc/GtDTY5gC/qrcode.png)](https://postimg.cc/gLY0bNPS)
