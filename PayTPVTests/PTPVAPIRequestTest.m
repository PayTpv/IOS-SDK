//
//  PTPVAPIRequestTest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTPVTestUtils.h"
#import "PTPVAPIRequest.h"

#import "PTPVUser.h"
#import "PTPVCard.h"
#import "PTPVResponse.h"
#import "PTPVPurchase.h"
#import "PTPVDCCDetails.h"
#import "PTPVRefund.h"
#import "PTPVSubscriptionDetails.h"

@interface PTPVAPIRequest ()

+ (void)parseResponse:(NSURLResponse *)response
                 body:(NSData *)body
                error:(NSError *)error
         deserializer:(id<PTPVAPIResponseDecodable>)deserializer
           completion:(PTPVAPIResponseBlock)completion;

@end

@interface PTPVAPIRequestTest : XCTestCase

@end

@implementation PTPVAPIRequestTest

#pragma mark - User

- (void)testParseAddUserResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_IDUSER": @"7156914",
                           @"DS_TOKEN_USER": @"WVRZNmFrdGVlMG8",
                           @"DS_ERROR_ID": @"0",
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVUser new]
                       completion:^(PTPVUser *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertStringNotEmpty(object.idUser);
                           PTPVAssertStringNotEmpty(object.tokenUser);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseInfoUserResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_PAN": @"544528-XX-XXXX-0883",
                           @"DS_ERROR_ID": @0,
                           @"DS_CARD_BRAND": @"MASTERCARD",
                           @"DS_CARD_TYPE": @"CREDIT",
                           @"DS_CARD_I_COUNTRY_ISO3": @"USA",
                           @"DS_EXPIRYDATE": @"2018/05"
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVCard new]
                       completion:^(PTPVCard *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertStringNotEmpty(object.pan);
                           PTPVAssertStringNotEmpty(object.brand);
                           PTPVAssertStringNotEmpty(object.type);
                           PTPVAssertStringNotEmpty(object.country);
                           PTPVAssertStringNotEmpty(object.expiryDate);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseRemoveUserResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVResponse new]
                       completion:^(PTPVResponse *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

#pragma mark - Purchase

- (void)testParseExecutePurchaseResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseExecutePurchaseDCCResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_ORDER": @"1234",
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_DCC_SESSION": @"0",
                           @"DS_MERCHANT_DCC_CURRENCY": @"0",
                           @"DS_MERCHANT_DCC_CURRENCYISO3": @"0",
                           @"DS_MERCHANT_DCC_CURRENCYNAME": @"0",
                           @"DS_MERCHANT_DCC_EXCHANGE": @"0",
                           @"DS_MERCHANT_DCC_AMOUNT": @"0",
                           @"DS_MERCHANT_DCC_MARKUP": @"0",
                           @"DS_MERCHANT_DCC_CARDCOUNTRY": @"0",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVDCCDetails new]
                       completion:^(PTPVDCCDetails *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.order);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.dccSession);
                           PTPVAssertStringNotEmpty(object.dccCurrency);
                           PTPVAssertStringNotEmpty(object.dccCurrencyISO3);
                           PTPVAssertStringNotEmpty(object.dccCurrencyName);
                           PTPVAssertStringNotEmpty(object.dccExchange);
                           XCTAssertNotNil(object.dccAmount);
//                           PTPVAssertNumberNotEmpty(object.dccAmount);
                           PTPVAssertStringNotEmpty(object.dccMarkup);
                           PTPVAssertStringNotEmpty(object.dccCardCountry);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseConfirmPurchaseDCCResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseExecuteRefundResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVRefund new]
                       completion:^(PTPVRefund *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertStringNotEmpty(object.order);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.authCode);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

#pragma mark - Subscription

- (void)testParseCreateSubscriptionResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_IDUSER": @1234,
                           @"DS_TOKEN_USER": @"asdf",
                           @"DS_SUBSCRIPTION_AMOUNT": @"699",
                           @"DS_SUBSCRIPTION_ORDER": @"1338[1234]20170807",
                           @"DS_SUBSCRIPTION_CURRENCY": @"EUR",
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVSubscriptionDetails new]
                       completion:^(PTPVSubscriptionDetails *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertStringNotEmpty(object.idUser);
                           PTPVAssertStringNotEmpty(object.tokenUser);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.order);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseEditSubscriptionResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_IDUSER": @1234,
                           @"DS_TOKEN_USER": @"asdf",
                           @"DS_SUBSCRIPTION_AMOUNT": @"699",
                           @"DS_SUBSCRIPTION_ORDER": @"1338[1234]20170807",
                           @"DS_SUBSCRIPTION_CURRENCY": @"EUR",
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVSubscriptionDetails new]
                       completion:^(PTPVSubscriptionDetails *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertStringNotEmpty(object.idUser);
                           PTPVAssertStringNotEmpty(object.tokenUser);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.order);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseRemoveSubscriptionResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVResponse new]
                       completion:^(PTPVResponse *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

#pragma mark - Preauthorization

- (void)testParseCreatePreauthorizationResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseConfirmPreauthorizationResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseCancelPreauthorizationResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseConfirmDeferredPreauthorizationResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testParseCancelDeferredPreauthorizationResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"parseResponse"];

    NSDictionary *json = @{
                           @"DS_MERCHANT_AMOUNT": @699,
                           @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                           @"DS_MERCHANT_CARDCOUNTRY": @840,
                           @"DS_MERCHANT_CURRENCY": @"EUR",
                           @"DS_MERCHANT_ORDER": @"1337",
                           @"DS_RESPONSE": @1,
                           @"DS_ERROR_ID": @0,
                           };
    NSData *body = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSError *error;

    [PTPVAPIRequest parseResponse:nil
                             body:body
                            error:error
                     deserializer:[PTPVPurchase new]
                       completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                           XCTAssertNotNil(object);
                           XCTAssertNil(error);
                           PTPVAssertNumberNotEmpty(object.amount);
                           PTPVAssertStringNotEmpty(object.authCode);
                           PTPVAssertStringNotEmpty(object.cardCountry);
                           PTPVAssertStringNotEmpty(object.currency);
                           PTPVAssertStringNotEmpty(object.order);
                           XCTAssertTrue(object.result == PTPVResultOK);
                           [expectation fulfill];
                       }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
