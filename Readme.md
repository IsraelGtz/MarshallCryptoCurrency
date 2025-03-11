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

* Download/clone MarshallCryptoCurrency from here: 

         https://github.com/IsraelGtz/MarshallCryptoCurrency.git
            
* Open 'MarshallCryptoCurrency.xcodeproj'. After that go to 'File -> Add Package Dependencies...' in the new window search for "https://github.com/IsraelGtz/CryptoCurrencyService.git". After found it press "Add Package". Automatically should add 'CryptoCurrencyService' and 'MCNetworkService' packages into the project.

* You will probably need to change the developer team inside Xcode for the signing process

* If you plan to check the packages in Xcode remember to open one by one as Xcode has sometimes weird behaviour when a project and its dependencies are open at the same time.

## Extra information

* The link for 'MCNetworkService' repository is:

         https://github.com/IsraelGtz/MCNetworkService.git

* The link for 'CryptoCurrencyService' repository is:

         https://github.com/IsraelGtz/CryptoCurrencyService.git



Thanks for giving me the opportunity to work on this code assigment. It was really fun!

