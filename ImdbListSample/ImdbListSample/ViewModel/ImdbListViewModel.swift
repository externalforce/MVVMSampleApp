//
//  ImdbListViewModel.swift
//  ImdbListSample
//
//  Created by Muhammet Gokhan Yavuz on 14.12.2021.
//

import Foundation

protocol ImdbListProtocol {
    func fetchItems()
    func changeLoading()

    var films: [Film] { get set }
    var imdbListService: ImdbListServiceProtocol { get }

    var imdbListOutPut: ImdbListOutPut? { get }

    func setDelegate(output: ImdbListOutPut)
}


final class ImdbListViewModel: ImdbListProtocol {
    var imdbListOutPut: ImdbListOutPut?
        
    func setDelegate(output: ImdbListOutPut) {
        imdbListOutPut = output
    }
    

    var films: [Film] = []
    private var isLoading = false
    let imdbListService: ImdbListServiceProtocol


    init() {
        imdbListService = ImdbListService()
    }

    func fetchItems() {
        changeLoading()
        imdbListService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.films = response ?? []
            self?.imdbListOutPut?.saveDatas(values: self?.films ?? [])
        }
    }

    func changeLoading() {
        isLoading = !isLoading
        imdbListOutPut?.changeLoading(isLoad: isLoading)
    }
}
