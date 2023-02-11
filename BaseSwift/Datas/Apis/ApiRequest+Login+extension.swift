//
//  ApiRequest+Login+extension.swift
//  gurume_go_ios
//
//  Created by daovu on 19/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

extension ApiRequest {
//    static func getShopDetail(id: Int) -> Observable<Response<ShopData>> {
//        return ApiRequest.request(ApiInput.init(method: .get,
//                                                url: ApiRouter.init(api: API.GET_SHOP_INFO(id: id))))
//    }
//    
//    static func getCommons() -> Observable<Response<CommonModel>> {
//        return ApiRequest.request(.init(method: .get, url: .init(api: .GET_COMMONS)), shouldAuthorize: false, returnError: true)
//    }
//    
//    static func register(request: InitRequest) -> Observable<Response<Register>> {
//        return ApiRequest.request(.init(method: .post, url: .init(api: .INIT), params: request.dictionary), shouldAuthorize: false, returnError: true)
//    }
//    
//    static func getShopMenu(id: Int, request: PageLimitRequest) -> Observable<Response<ShopMenuData>> {
//        return ApiRequest.request(.init(method: .get,
//                                        url: .init(api: .GET_SHOP_MENU(id: id)),
//                                        params: request.dictionary))
//    }
//    
//    static func getShopPhoto(id: Int, request: PageLimitRequest) -> Observable<Response<ShopPhotoData>> {
//        return ApiRequest.request(.init(method: .get,
//                                        url: .init(api: .GET_SHOP_PHOTO(id: id)),
//                                        params: request.dictionary))
//    }
//    static func changeCharacterColor(request: ChangeCharacterColorRequest) -> Observable<Response<BaseResponse>> {
//        return ApiRequest.request(.init(method: .post, url: .init(api: .CHANGE_CHARACTER_COLOR), params: request.dictionary), shouldAuthorize: true, returnError: true)
//    }
//    static func getMe() -> Observable<Response<MeResult>> {
//        return ApiRequest.request(.init(method: .get, url: .init(api: .ME)), shouldHandleRetry: true, shouldAuthorize: true, returnError: true)
//    }
//    static func dailyGiftHistory(id: Int) -> Observable<Response<BaseResponse>> {
//        return ApiRequest.request(.init(method: .post, url: .init(api: .DAILY_GIFT_HISTORY(id: id))), shouldAuthorize: true, returnError: true)
//    }
//    
//   static func getRankList(request: PageLimitRequest) -> Observable<Response<RankData>> {
//        return ApiRequest.request(.init(method: .get, url: .init(api: .GET_RANK), params: request.dictionary), returnError: true)
//    }
//    static func getOwnedCharacter(request: OwnedCharacterRequest) -> Observable<Response<OwnedCharacterResponse>> {
//        return ApiRequest.request(.init(method: .get, url: .init(api: .OWNED_CHARACTER), params: request.dictionary), shouldAuthorize: true, returnError: true)
//    }
//    static func changeCharacter(request: ChangeCharacterRequest) -> Observable<Response<BaseResponse>> {
//        return ApiRequest.request(.init(method: .post, url: .init(api: .CHANGE_CHARACTER_COLOR), params: request.dictionary), shouldAuthorize: true, returnError: true)
//    }
//    static func bookingShop(idShop: Int,request: BookingRequest) -> Observable<Response<BaseResponse>> {
//        return ApiRequest.request(.init(method: .post, url: .init(api: .BOOKING(id: idShop)), params: request.dictionary), shouldAuthorize: true, returnError: true)
//    }
}
