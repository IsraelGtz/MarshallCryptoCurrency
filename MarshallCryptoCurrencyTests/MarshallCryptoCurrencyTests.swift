//
//  MarshallCryptoCurrencyTests.swift
//  MarshallCryptoCurrencyTests
//
//  Created by Israel Gutiérrez Castillo.
//

@testable import MarshallCryptoCurrency
import CryptoCurrencyService
import Testing

@MainActor
struct MarshallCryptoCurrencyTests {
    
    /*
     Test MainViewModel resolves correctly the selection and ordering of exchange currencies
    */
    
    @Test func resolveRightOrderingOfCurrencies_success() async throws {
        // Given
        let viewModel = MainViewModel()
        let usdCur = ExchangeCurrency(id: Currency.USD, rate: 1.0)
        
        //When
        //viewModel will keep the result of the request inside itself
        await viewModel.getAllExchangeCurrencies(excluding: usdCur)
        
        //Then
        //check the data from the request is valid
        try #require(viewModel.areExchangeCurrenciesLoaded == true)
        try #require(viewModel.exchangeCurrenciesError == nil)
        try #require(viewModel.exchangeCurrencies.count > 1)
        //check the order is correct having first SEK currency
        try #require(viewModel.exchangeCurrencies.first?.id == .SEK)
        //request to resolve the order after selecting SEK currency
        let reorderCurrenciesRemovingSEK = viewModel.resolveExchangeCurrencies(excluding: ExchangeCurrency(id: .SEK, rate: 1.0))
        //check USD currency now is the first in the given ordered list
        try #require(reorderCurrenciesRemovingSEK.first?.id == .USD)
        //check SEK is not in the given list
        try #require(!reorderCurrenciesRemovingSEK.contains(where: { exCur in
            exCur == ExchangeCurrency(id: .SEK, rate: 1.0)
        }))
    }
}
