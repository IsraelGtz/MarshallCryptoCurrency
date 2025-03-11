# Marshall Cryptos

Code assigment from Marshall to develop an app that shows a list of cryptos. 


## Description of my proposed app

* Modularized in three different "layers" for a better abstraction and maintenance

    * MCNetworkService: manages the creation and execution of web requests to different enpoints, basically the "network layer".
    
    * CryptoCurrencyService: intermediary service between UI and network which provides the main models used in the app. These models are used to decode the data recieved from the network service.
    
    * MarshallCryptoCurreny: manages the user inputs to request the needed data to fulfill the requirements of the app.
    
* Access three different API's

    * Used to request the list of cryptos:
    
            https://api.coincap.io/v2/assets

    * Used to request the historical data of a given crypto: 
    
            https://api.coincap.io/v2/assets/(CRYPTO_ID)/history?interval=(INTERVAL_TIME)

    * Used to request a list of currency exchanges based always on USD: 
    
            https://api.frankfurter.dev/v1/latest?base=USD
    
* Main navigation is based in three main "screens"

    * Main view with the list of cryptos
    
    * Detail view showing the info of each crypto
    
    * Web view showing the webpage of each crypto
    
## Installation

To successfully compile and run the app you will need to:

* Install Xcode 16 or higher, as the app was developed using Swift 6.0 and the minimum deployment is iOS 18

* Download MCNetworkService, CryptoCurrencyService and MarshallCryptoCurrency into the same directory

* You will probably need to change the developer team inside Xcode for the signing process

* When you open "MarshallCryptoCurreny" remember to close the other two services as having dependencies open may cause weird behaviour in Xcode 16

