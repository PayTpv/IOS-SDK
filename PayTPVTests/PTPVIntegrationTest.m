//
//  PTPVIntegrationTest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTPVTestConstants.h"
#import "PTPVTestUtils.h"

#import "PAYTPV.h"

@interface PTPVIntegrationTest : XCTestCase

@end

@implementation PTPVIntegrationTest

#pragma mark - Setup

- (void)setUp {
    [super setUp];

    [self testCredentialsNotEmpty];

    PTPVConfiguration *config = [[PTPVConfiguration alloc] initWithMerchantCode:TestMerchantCode
                                                                       terminal:TestTerminal
                                                                       password:TestPassword
                                                                          jetId:TestJetId];
    [PTPVAPIClient sharedClient].configuration = config;
}

- (void)testCredentialsNotEmpty {
    PTPVAssertStringNotEmpty(TestMerchantCode);
    PTPVAssertStringNotEmpty(TestTerminal);
    PTPVAssertStringNotEmpty(TestPassword);
//    PTPVAssertStringNotEmpty(TestJetId);
    PTPVAssertStringNotEmpty(TestCardPan);
    PTPVAssertStringNotEmpty(TestCardExpiryDate);
    PTPVAssertStringNotEmpty(TestCardCvv);
}

#pragma mark - Helpers

- (PTPVCard *)generateTestCard {
    return [[PTPVCard alloc] initWithPan:TestCardPan
                              expiryDate:TestCardExpiryDate
                                     cvv:TestCardCvv];
}

- (void)validateAddUser:(PTPVUser *)response
                  error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertStringNotEmpty(response.idUser);
    PTPVAssertStringNotEmpty(response.tokenUser);
}

- (void)validateInfoUser:(PTPVCard *)response
                   error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertStringNotEmpty(response.pan);
    PTPVAssertStringNotEmpty(response.brand);
    PTPVAssertStringNotEmpty(response.type);
    PTPVAssertStringNotEmpty(response.country);
    PTPVAssertStringNotEmpty(response.expiryDate);
}

- (void)validateRemoveUserWithError:(NSError *)error {
    XCTAssertNil(error);
}

- (void)validateExecutePurchase:(PTPVPurchase *)response
                          error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertNumberNotEmpty(response.amount);
    PTPVAssertStringNotEmpty(response.authCode);
    PTPVAssertStringNotEmpty(response.cardCountry);
    PTPVAssertStringNotEmpty(response.currency);
    PTPVAssertStringNotEmpty(response.order);
    XCTAssertTrue(response.result == PTPVResultOK);
}

- (void)validateExecutePurchaseDCC:(PTPVDCCDetails *)response
                             error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertNumberNotEmpty(response.amount);
    PTPVAssertStringNotEmpty(response.currency);
    PTPVAssertStringNotEmpty(response.order);
    PTPVAssertStringNotEmpty(response.dccSession);
    PTPVAssertStringNotEmpty(response.dccCurrency);
    PTPVAssertStringNotEmpty(response.dccCurrencyISO3);
    PTPVAssertStringNotEmpty(response.dccCurrencyName);
    PTPVAssertStringNotEmpty(response.dccExchange);
    XCTAssertNotNil(response.dccAmount);
//    PTPVAssertNumberNotEmpty(response.dccAmount);
    PTPVAssertStringNotEmpty(response.dccMarkup);
    PTPVAssertStringNotEmpty(response.dccCardCountry);
    XCTAssertTrue(response.result == PTPVResultOK);
}

- (void)validateConfirmPurchaseDCC:(PTPVPurchase *)response
                             error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertNumberNotEmpty(response.amount);
    PTPVAssertStringNotEmpty(response.authCode);
    PTPVAssertStringNotEmpty(response.cardCountry);
    PTPVAssertStringNotEmpty(response.currency);
    PTPVAssertStringNotEmpty(response.order);
    XCTAssertTrue(response.result == PTPVResultOK);
}

- (void)validateExecuteRefund:(PTPVRefund *)response
                        error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertStringNotEmpty(response.order);
    PTPVAssertStringNotEmpty(response.currency);
    PTPVAssertStringNotEmpty(response.authCode);
}

- (void)validateSubscription:(PTPVSubscriptionDetails *)response
                       error:(NSError *)error {
    XCTAssertNotNil(response);
    XCTAssertNil(error);
    PTPVAssertStringNotEmpty(response.idUser);
    PTPVAssertStringNotEmpty(response.tokenUser);
    PTPVAssertNumberNotEmpty(response.amount);
    PTPVAssertStringNotEmpty(response.order);
    PTPVAssertStringNotEmpty(response.currency);
    PTPVAssertStringNotEmpty(response.authCode);
    PTPVAssertStringNotEmpty(response.cardCountry);
}

- (void)validateRemoveSubscriptionWithError:(NSError *)error {
    XCTAssertNil(error);
}

#pragma mark - User

- (void)testUser {
    XCTestExpectation *expectation = [self expectationWithDescription:@"add_user/info_user/remove_user"];

    // add_user
    PTPVCard *params = [self generateTestCard];
    [[PTPVAPIClient sharedClient] addUser:params completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [self validateAddUser:user error:error];

        // info_user
        [[PTPVAPIClient sharedClient] infoUser:user completion:^(PTPVCard * _Nullable card, NSError * _Nullable error) {
            [self validateInfoUser:card error:error];

            // clean up
            PTPVUser *params = [[PTPVUser alloc] initWithIdUser:user.idUser tokenUser:user.tokenUser];
            [[PTPVAPIClient sharedClient] removeUser:params completion:^(NSError * _Nullable error) {
                [self validateRemoveUserWithError:error];
                [expectation fulfill];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

/**
 Disabled since it requires the javascript api in order to create a jet token.
 */
//- (void)testAddUserToken {
//    XCTestExpectation *expectation = [self expectationWithDescription:@"add_user_token"];
//
//    NSURL *url = [[NSURL alloc] initWithString:@"https://secure.paytpv.com/gateway/jet_request.php"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    request.HTTPMethod = @"POST";
//    NSString *data = @"";
//    NSData *formData = [data dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = formData;
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)formData.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *body, NSURLResponse *response, NSError *error) {
//        XCTAssertNil(error);
//        XCTAssertNotNil(body);
//
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:body options:kNilOptions error:&error];
//        XCTAssertNil(error);
//
//        NSString *token = json[@"paytpvToken"];
//
//        [[PTPVAPIClient sharedClient] addUserWithJETToken:token completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
//            [self validateAddUser:user error:error];
//
//            [expectation fulfill];
//        }];
//    }];
//    [task resume];
//
//    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
//        if(error) {
//            XCTFail(@"Expectation failed with error: %@", error);
//        }
//    }];
//}

#pragma mark - Purchase

- (void)testExecutePurchase {
    XCTestExpectation *expectation = [self expectationWithDescription:@"execute_purchase/execute_refund"];

    // add_user
    PTPVCard *params = [self generateTestCard];
    [[PTPVAPIClient sharedClient] addUser:params completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [self validateAddUser:user error:error];

        NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

        // execute_purchase
        PTPVPurchaseRequest *params = [[PTPVPurchaseRequest alloc] initWithAmount:@199
                                                                            order:order
                                                                         currency:PTPVCurrencyEUR
                                                               productDescription:@"Some product"
                                                                            owner:@"Some owner"
                                                                          scoring:@"2"];
        [[PTPVAPIClient sharedClient] executePurchase:params forUser:user completion:^(PTPVPurchase * _Nullable executePurchase, NSError * _Nullable error) {
            [self validateExecutePurchase:executePurchase error:error];

            // execute_refund
            PTPVRefund *params = [[PTPVRefund alloc] initWithAuthCode:executePurchase.authCode
                                                                order:executePurchase.order
                                                             currency:PTPVCurrencyEUR
                                                               amount:@99];
            [[PTPVAPIClient sharedClient] executeRefund:params forUser:user completion:^(PTPVRefund * _Nullable response, NSError * _Nullable error) {
                [self validateExecuteRefund:response error:error];

                // clean up
                PTPVUser *params = [[PTPVUser alloc] initWithIdUser:user.idUser tokenUser:user.tokenUser];
                [[PTPVAPIClient sharedClient] removeUser:params completion:^(NSError * _Nullable error) {
                    [self validateRemoveUserWithError:error];
                    [expectation fulfill];
                }];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

- (void)testExecutePurchaseDCC {
    XCTestExpectation *expectation = [self expectationWithDescription:@"execute_purchase_dcc/confirm_purchase_dcc"];

    // add_user
    PTPVCard *params = [self generateTestCard];
    [[PTPVAPIClient sharedClient] addUser:params completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [self validateAddUser:user error:error];

        NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

        // execute_purchase_dcc
        PTPVPurchaseRequest *params = [[PTPVPurchaseRequest alloc] initDCCWithAmount:@199
                                                                               order:order
                                                                  productDescription:@"Some product"
                                                                               owner:@"Some owner"];
        [[PTPVAPIClient sharedClient] executePurchaseDCC:params forUser:user completion:^(PTPVDCCDetails * _Nullable response, NSError * _Nullable error) {
            [self validateExecutePurchaseDCC:response error:error];

            // disabled since the execute_order_dcc returns the dcc fields empty
            // confirm_purchase_dcc
//            PTPVDCCConfirmation *params = [[PTPVDCCConfirmation alloc] initWithDCCDetails:response
//                                                                                 currency:response.dccCurrency];
//            [[PTPVAPIClient sharedClient] confirmPurchaseDCC:params completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
//                [self validateConfirmPurchaseDCC:response error:error];

                // clean up
                PTPVUser *params = [[PTPVUser alloc] initWithIdUser:user.idUser tokenUser:user.tokenUser];
                [[PTPVAPIClient sharedClient] removeUser:params completion:^(NSError * _Nullable error) {
                    [self validateRemoveUserWithError:error];
                    [expectation fulfill];
                }];
//            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

#pragma mark - Subscription

- (void)testCreateSubscription {
    XCTestExpectation *expectation = [self expectationWithDescription:@"create_subscription/edit_subscription/remove_subscription"];

    NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd";

    // create_subscription
    PTPVCard *card = [self generateTestCard];
    PTPVSubscription *subscription = [[PTPVSubscription alloc] initWithStartDate:[df stringFromDate:[NSDate date]]
                                                                         endDate:@"2018-12-25"
                                                                           order:order
                                                                          amount:@199
                                                                        currency:PTPVCurrencyEUR
                                                                     periodicity:@"30"
                                                                         scoring:@"2"];
    [[PTPVAPIClient sharedClient] createSubscription:subscription withCard:card completion:^(PTPVSubscriptionDetails * _Nullable response, NSError * _Nullable error) {
        [self validateSubscription:response error:error];

        // edit_subscription
        subscription.endDate = @"2018-11-25";
        subscription.periodicity = @"60";
        subscription.amount = @299;
        [[PTPVAPIClient sharedClient] editSubscription:subscription forUser:[response user] execute:false completion:^(PTPVSubscriptionDetails * _Nullable response, NSError * _Nullable error) {
            [self validateSubscription:response error:error];

            // remove_subscription
            PTPVUser *params = [[PTPVUser alloc] initWithIdUser:response.idUser
                                                      tokenUser:response.tokenUser];
            [[PTPVAPIClient sharedClient] removeSubscription:params completion:^(NSError * _Nullable error) {
                [self validateRemoveSubscriptionWithError:error];

                [expectation fulfill];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

- (void)testCreateSubscriptionToken {
    XCTestExpectation *expectation = [self expectationWithDescription:@"add_user/create_subscription_token/remove_subscription"];

    NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd";

    // add_user
    PTPVCard *params = [self generateTestCard];
    [[PTPVAPIClient sharedClient] addUser:params completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [self validateAddUser:user error:error];

        // create_subscription_token
        PTPVSubscription *subscription = [[PTPVSubscription alloc] initWithStartDate:[df stringFromDate:[NSDate date]]
                                                                             endDate:@"2018-12-25"
                                                                               order:order
                                                                              amount:@199
                                                                            currency:PTPVCurrencyEUR
                                                                         periodicity:@"30"
                                                                             scoring:@"2"];
        [[PTPVAPIClient sharedClient] createSubscription:subscription withUser:user completion:^(PTPVSubscriptionDetails * _Nullable response, NSError * _Nullable error) {
            [self validateSubscription:response error:error];

            // clean up
            // remove_subscription
            [[PTPVAPIClient sharedClient] removeSubscription:[response user] completion:^(NSError * _Nullable error) {
                [self validateRemoveSubscriptionWithError:error];

                // remove_user
//                [[PTPVAPIClient sharedClient] removeUser:user completion:^(PTPVResponse * _Nullable response, NSError * _Nullable error) {
//                    [self validateRemoveUser:response error:error];
                    [expectation fulfill];
//                }];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

#pragma mark - Preauthorization

- (void)testPreauthorization {
    XCTestExpectation *expectation = [self expectationWithDescription:@"create_preauthorization/preauthorization_confirm/preauthorization_cancel"];

    // add_user
    PTPVCard *params = [self generateTestCard];
    [[PTPVAPIClient sharedClient] addUser:params completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [self validateAddUser:user error:error];

        NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

        // create_preauthorization
        PTPVPurchaseRequest *preauthRequest = [[PTPVPurchaseRequest alloc] initWithAmount:@199
                                                                                    order:order
                                                                                 currency:PTPVCurrencyEUR
                                                                       productDescription:@"Some product"
                                                                                    owner:@"Some owner"
                                                                                  scoring:@"2"];
        [[PTPVAPIClient sharedClient] createPreauthorization:preauthRequest forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
            [self validateExecutePurchase:response error:error];

            // preauthorization_confirm
            PTPVPreauthorization *confirmation = [[PTPVPreauthorization alloc] initWithOrder:response.order
                                                                                            amount:response.amount];
            [[PTPVAPIClient sharedClient] confirmPreauthorization:confirmation forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
                [self validateExecutePurchase:response error:error];

                // create another preauthorization
                NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];
                preauthRequest.order = order;
                [[PTPVAPIClient sharedClient] createPreauthorization:preauthRequest forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
                    [self validateExecutePurchase:response error:error];

                    // preauthorization_cancel
                    PTPVPreauthorization *confirmation = [[PTPVPreauthorization alloc] initWithOrder:response.order
                                                                                                    amount:response.amount];
                    [[PTPVAPIClient sharedClient] cancelPreauthorization:confirmation forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
                        [self validateExecutePurchase:response error:error];

                        // clean up
                        PTPVUser *params = [[PTPVUser alloc] initWithIdUser:user.idUser tokenUser:user.tokenUser];
                        [[PTPVAPIClient sharedClient] removeUser:params completion:^(NSError * _Nullable error) {
                            [self validateRemoveUserWithError:error];
                            [expectation fulfill];
                        }];
                    }];
                }];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

/**
 Disabled since it requires using the iframe api to create a deferred preauthorization and listening on the notification url for the user id and user token, and there is no clear way to automate it.
 */
//- (void)testDeferredPreauthorization {
//
//    XCTestExpectation *expectation = [self expectationWithDescription:@"create_preauthorization/deferred_preauthorization_confirm"];
//
//    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:@""
//                                            tokenUser:@""];
//
//    // deferred_preauthorization_confirm
//    PTPVPreauthorization *confirmation = [[PTPVPreauthorization alloc] initWithOrder:@"ios_3124"
//                                                                              amount:@199];
//    [[PTPVAPIClient sharedClient] confirmDeferredPreauthorization:confirmation forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
//        [self validateExecutePurchase:response error:error];
//
//        [expectation fulfill];
//    }];
//
//    // deferred_preauthorization_cancel
//    [[PTPVAPIClient sharedClient] cancelDeferredPreauthorization:confirmation forUser:user completion:^(PTPVPurchase * _Nullable response, NSError * _Nullable error) {
//        [self validateExecutePurchase:response error:error];
//
//        [expectation fulfill];
//    }];
//
//    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
//        if(error) {
//            XCTFail(@"Expectation failed with error: %@", error);
//        }
//    }];
//}

@end
