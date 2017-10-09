//
//  PTPVRequestParamsBuilderTest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTPVTestConstants.h"
#import "PTPVRequestParamsBuilder.h"

#import "PTPVConfiguration.h"
#import "PTPVUser.h"
#import "PTPVPurchaseRequest.h"
#import "PTPVDCCConfirmation.h"
#import "PTPVRefund.h"
#import "PTPVSubscription.h"
#import "PTPVPreauthorization.h"

@interface PTPVRequestParamsBuilderTest : XCTestCase

@property (nonatomic, copy) PTPVConfiguration *config;
@property (nonatomic, copy, nullable) NSString *remoteAddress;

@end

@implementation PTPVRequestParamsBuilderTest

- (void)setUp {
    [super setUp];

    self.config = [PTPVConfiguration new];
    self.config.merchantCode = @"MERCHANT_CODE";
    self.config.terminal = @"1234";
    self.config.password = @"PASSWORD";
    self.config.jetId = @"JETID";

    self.remoteAddress = @"127.0.0.1";
}

#pragma mark - User

- (void)testBuildAddUserParams {
    PTPVCard *req = [[PTPVCard alloc] initWithPan:@"4111111111111111"
                                       expiryDate:@"0518"
                                              cvv:@"123"];

    NSDictionary *params = [PTPVRequestParamsBuilder addUser:req remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_MERCHANT_CVV2": @"123",
                                               @"DS_MERCHANT_EXPIRYDATE": @"0518",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"aea1fe7865714f667c283ac0cddc9ecc4e60cd17",
                                               @"DS_MERCHANT_PAN": @"4111111111111111",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildAddUserTokenParams {
    NSString *token = @"asdf";

    NSDictionary *params = [PTPVRequestParamsBuilder addUserWithJETToken:token remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_MERCHANT_JETTOKEN": @"asdf",
                                               @"DS_MERCHANT_JETID": @"JETID",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"d50e5ddeff5c9048b967fd6afc1de5b73e38078c",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildInfoUserParams {
    PTPVUser *req = [[PTPVUser alloc] initWithIdUser:@"123456"
                                           tokenUser:@"abcd"];

    NSDictionary *params = [PTPVRequestParamsBuilder infoUser:req remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"734372af70a0de0fd38de03f9e7c7191d3f1f6f5",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildRemoveUserParams {
    PTPVUser *req = [[PTPVUser alloc] initWithIdUser:@"123456"
                                           tokenUser:@"abcd"];

    NSDictionary *params = [PTPVRequestParamsBuilder removeUser:req remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"734372af70a0de0fd38de03f9e7c7191d3f1f6f5",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

#pragma mark - Purchase

- (void)testBuildExecutePurchaseParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];
    PTPVPurchaseRequest *req = [[PTPVPurchaseRequest alloc] initWithAmount:@699
                                                                     order:@"1338"
                                                                  currency:PTPVCurrencyEUR
                                                        productDescription:@"Some product"
                                                                     owner:@"Some company"
                                                                   scoring:@"2"];

    NSDictionary *params = [PTPVRequestParamsBuilder executePurchase:req forUser:user remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_CURRENCY": @"EUR",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"5cf3c220df47db84e413e3c23a903d10681c4570",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_OWNER": @"Some company",
                                               @"DS_MERCHANT_PRODUCTDESCRIPTION": @"Some product",
                                               @"DS_MERCHANT_SCORING": @"2",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildExecutePurchaseDCCParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];
    PTPVPurchaseRequest *req = [[PTPVPurchaseRequest alloc] initDCCWithAmount:@699
                                                                        order:@"1338"
                                                           productDescription:@"Some product"
                                                                        owner:@"Some company"];

    NSDictionary *params = [PTPVRequestParamsBuilder executePurchaseDCC:req forUser:user remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"5cf3c220df47db84e413e3c23a903d10681c4570",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_OWNER": @"Some company",
                                               @"DS_MERCHANT_PRODUCTDESCRIPTION": @"Some product",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildConfirmPurchaseDCCParams {
    PTPVDCCConfirmation *req = [[PTPVDCCConfirmation alloc] initWithOrder:@"1338"
                                                                 currency:PTPVCurrencyEUR
                                                                  session:@"4321"];

    NSDictionary *params = [PTPVRequestParamsBuilder confirmPurchaseDCC:req remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_MERCHANT_DCC_CURRENCY": @"EUR",
                                               @"DS_MERCHANT_DCC_SESSION": @"4321",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"5e8608b48018d28e080709955d2d5feca567a78a",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildExecuteRefundParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];
    PTPVRefund *req = [[PTPVRefund alloc] initWithAuthCode:@"907668/391190917589223600158531373672"
                                                     order:@"1338"
                                                  currency:PTPVCurrencyEUR
                                                    amount:@699];

    NSDictionary *params = [PTPVRequestParamsBuilder executeRefund:req forUser:user remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_AUTHCODE": @"907668/391190917589223600158531373672",
                                               @"DS_MERCHANT_CURRENCY": @"EUR",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"069b7143e0ce6309540522f32eee2fd877b04461",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

#pragma mark - Subscription

- (void)testBuildCreateSubscriptionParams {
    PTPVCard *card = [[PTPVCard alloc] initWithPan:@"4111111111111111"
                                       expiryDate:@"0518"
                                              cvv:@"123"];
    PTPVSubscription *subscription = [[PTPVSubscription alloc] initWithStartDate:@"2017-01-27"
                                                                         endDate:@"2018-01-27"
                                                                           order:@"1338"
                                                                          amount:@699
                                                                        currency:PTPVCurrencyEUR
                                                                     periodicity:@"365"
                                                                         scoring:@"2"];

    NSDictionary *params = [PTPVRequestParamsBuilder createSubscription:subscription withCard:card remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_MERCHANT_PAN": @"4111111111111111",
                                               @"DS_MERCHANT_EXPIRYDATE": @"0518",
                                               @"DS_MERCHANT_CVV2": @"123",
                                               @"DS_SUBSCRIPTION_STARTDATE": @"2017-01-27",
                                               @"DS_SUBSCRIPTION_ENDDATE": @"2018-01-27",
                                               @"DS_SUBSCRIPTION_ORDER": @"1338",
                                               @"DS_SUBSCRIPTION_AMOUNT": @699,
                                               @"DS_SUBSCRIPTION_CURRENCY": @"EUR",
                                               @"DS_SUBSCRIPTION_PERIODICITY": @"365",
                                               @"DS_MERCHANT_SCORING": @"2",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"9bf350eb6c9f85809670b8ae656f65af6efa8b6f",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildEditSubscriptionParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];
    PTPVSubscription *subscription = [[PTPVSubscription alloc] initWithStartDate:@"2017-01-27"
                                                                         endDate:@"2018-01-27"
                                                                          amount:@699
                                                                     periodicity:@"365"];

    NSDictionary *params = [PTPVRequestParamsBuilder editSubscription:subscription forUser:user execute:true remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_SUBSCRIPTION_STARTDATE": @"2017-01-27",
                                               @"DS_SUBSCRIPTION_ENDDATE": @"2018-01-27",
                                               @"DS_SUBSCRIPTION_AMOUNT": @699,
                                               @"DS_SUBSCRIPTION_PERIODICITY": @"365",
                                               @"DS_EXECUTE": @YES,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"368fddd786e25e8bff5e78ba39d4c57ac384aebb",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildRemoveSubscriptionParams {
    PTPVUser *req = [[PTPVUser alloc] initWithIdUser:@"123456"
                                           tokenUser:@"abcd"];

    NSDictionary *params = [PTPVRequestParamsBuilder removeSubscription:req remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"734372af70a0de0fd38de03f9e7c7191d3f1f6f5",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

#pragma mark - Preauthorization

- (void)testBuildCreatePreauthorizationParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];
    PTPVPurchaseRequest *req = [[PTPVPurchaseRequest alloc] initWithAmount:@699
                                                                     order:@"1338"
                                                                  currency:PTPVCurrencyEUR
                                                        productDescription:@"Some product"
                                                                     owner:@"Some company"
                                                                   scoring:@"2"];

    NSDictionary *params = [PTPVRequestParamsBuilder createPreauthorization:req forUser:user remoteAddress:self.remoteAddress configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_CURRENCY": @"EUR",
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"5cf3c220df47db84e413e3c23a903d10681c4570",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_OWNER": @"Some company",
                                               @"DS_MERCHANT_PRODUCTDESCRIPTION": @"Some product",
                                               @"DS_MERCHANT_SCORING": @"2",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildConfirmPreauthorizationParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];

    PTPVPreauthorization *req = [[PTPVPreauthorization alloc] initWithOrder:@"1338"
                                                                     amount:@699];

    NSDictionary *params = [PTPVRequestParamsBuilder confirmPreauthorization:req
                                                                     forUser:user
                                                               remoteAddress:self.remoteAddress
                                                               configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"6e6a5f28f6fbaf01a880c5b6bff8da85e6304677",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildCancelPreauthorizationParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];

    PTPVPreauthorization *req = [[PTPVPreauthorization alloc] initWithOrder:@"1338"
                                                                     amount:@699];

    NSDictionary *params = [PTPVRequestParamsBuilder cancelPreauthorization:req
                                                                    forUser:user
                                                              remoteAddress:self.remoteAddress
                                                              configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"6e6a5f28f6fbaf01a880c5b6bff8da85e6304677",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildConfirmDeferredPreauthorizationParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];

    PTPVPreauthorization *req = [[PTPVPreauthorization alloc] initWithOrder:@"1338"
                                                                     amount:@699];

    NSDictionary *params = [PTPVRequestParamsBuilder confirmDeferredPreauthorization:req
                                                                             forUser:user
                                                                       remoteAddress:self.remoteAddress
                                                                       configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"6e6a5f28f6fbaf01a880c5b6bff8da85e6304677",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

- (void)testBuildCancelDeferredPreauthorizationParams {
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@"123456" tokenUser:@"abcd"];

    PTPVPreauthorization *req = [[PTPVPreauthorization alloc] initWithOrder:@"1338"
                                                                     amount:@699];

    NSDictionary *params = [PTPVRequestParamsBuilder cancelDeferredPreauthorization:req
                                                                            forUser:user
                                                                      remoteAddress:self.remoteAddress
                                                                      configuration:self.config];

    BOOL equal = [params isEqualToDictionary:@{
                                               @"DS_IDUSER": @"123456",
                                               @"DS_MERCHANT_AMOUNT": @699,
                                               @"DS_MERCHANT_MERCHANTCODE": @"MERCHANT_CODE",
                                               @"DS_MERCHANT_MERCHANTSIGNATURE": @"6e6a5f28f6fbaf01a880c5b6bff8da85e6304677",
                                               @"DS_MERCHANT_ORDER": @"1338",
                                               @"DS_MERCHANT_TERMINAL": @"1234",
                                               @"DS_TOKEN_USER": @"abcd",
                                               @"DS_ORIGINAL_IP": [self remoteAddress],
                                               }];

    XCTAssertTrue(equal);
}

@end
