//
//  PTPVAPIClient.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 7/25/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVAPIClient.h"
#import "PTPVAPIClient+Private.h"
#import "PTPVRequestParamsBuilder.h"

#import "PTPVAPIRequest.h"

#import "PTPVBlocks.h"

static NSString * const APIBaseURL = @"https://secure.paytpv.com/gateway/json-bankstore";
static NSString * const APIEndpointAddUser = @"add_user";
static NSString * const APIEndpointAddUserToken = @"add_user_token";
static NSString * const APIEndpointInfoUser = @"info_user";
static NSString * const APIEndpointRemoveUser = @"remove_user";
static NSString * const APIEndpointExecutePurchase = @"execute_purchase";
static NSString * const APIEndpointExecutePurchaseDCC = @"execute_purchase_dcc";
static NSString * const APIEndpointConfirmPurchaseDCC = @"confirm_purchase_dcc";
static NSString * const APIEndpointExecuteRefund = @"execute_refund";
static NSString * const APIEndpointCreateSubscription = @"create_subscription";
static NSString * const APIEndpointEditSubscription = @"edit_subscription";
static NSString * const APIEndpointRemoveSubscription = @"remove_subscription";
static NSString * const APIEndpointCreateSubscriptionToken = @"create_subscription_token";
static NSString * const APIEndpointCreatePreauthorization = @"create_preauthorization";
static NSString * const APIEndpointConfirmPreauthorization = @"preauthorization_confirm";
static NSString * const APIEndpointCancelPreauthorization = @"preauthorization_cancel";
static NSString * const APIEndpointConfirmDeferredPreauthorization = @"deferred_preauthorization_confirm";
static NSString * const APIEndpointCancelDeferredPreauthorization = @"deferred_preauthorization_cancel";
static NSString * const APIEndpointRemoteIP = @"json-remote-ip";

@implementation PTPVAPIClient

+ (instancetype)sharedClient {
    static id sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedClient = [[self alloc] init]; });
    return sharedClient;
}

- (instancetype)init {
    return [self initWithConfiguration:[PTPVConfiguration sharedConfiguration]];
}

- (instancetype)initWithConfiguration:(PTPVConfiguration *)configuration {
    self = [super init];
    if (self) {
        _apiURL = [NSURL URLWithString:APIBaseURL];
        _urlSession = [NSURLSession sessionWithConfiguration:[self sessionConfiguration]];
        _configuration = configuration;
    }
    return self;
}

- (NSURLSessionConfiguration *)sessionConfiguration {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return sessionConfiguration;
}

@end

#pragma mark - Users

@implementation PTPVAPIClient (Users)

- (void)addUser:(PTPVCard *)card
     completion:(PTPVAddUserCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVUser *> postWithAPIClient:self
                                             endpoint:APIEndpointAddUser
                                           parameters:[PTPVRequestParamsBuilder addUser:card
                                                                          remoteAddress:response.remoteAddress
                                                                          configuration:self.configuration]
                                         deserializer:[PTPVUser new]
                                           completion:^(PTPVUser *object, NSHTTPURLResponse *response, NSError *error) {
                                               completion(object, error);
                                           }];
    }];
}

- (void)addUserWithJETToken:(NSString *)token
                 completion:(PTPVAddUserTokenCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVUser *> postWithAPIClient:self
                                             endpoint:APIEndpointAddUserToken
                                           parameters:[PTPVRequestParamsBuilder addUserWithJETToken:token
                                                                                      remoteAddress:response.remoteAddress
                                                                                      configuration:self.configuration]
                                         deserializer:[PTPVUser new]
                                           completion:^(PTPVUser *object, NSHTTPURLResponse *response, NSError *error) {
                                               completion(object, error);
                                           }];
    }];
}

- (void)infoUser:(PTPVUser *)user
      completion:(PTPVInfoUserCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVCard *> postWithAPIClient:self
                                             endpoint:APIEndpointInfoUser
                                           parameters:[PTPVRequestParamsBuilder infoUser:user
                                                                           remoteAddress:response.remoteAddress
                                                                           configuration:self.configuration]
                                         deserializer:[PTPVCard new]
                                           completion:^(PTPVCard *object, NSHTTPURLResponse *response, NSError *error) {
                                               completion(object, error);
                                           }];
    }];
}

- (void)removeUser:(PTPVUser *)user
        completion:(PTPVErrorBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVResponse *> postWithAPIClient:self
                                                 endpoint:APIEndpointRemoveUser
                                               parameters:[PTPVRequestParamsBuilder removeUser:user
                                                                                 remoteAddress:response.remoteAddress
                                                                                 configuration:self.configuration]
                                             deserializer:[PTPVResponse new]
                                               completion:^(PTPVResponse *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(error);
                                               }];
    }];
}

@end

#pragma mark - Purchase

@implementation PTPVAPIClient (Purchase)

- (void)executePurchase:(PTPVPurchaseRequest *)request
                forUser:(PTPVUser *)user
             completion:(PTPVExecutePurchaseCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointExecutePurchase
                                               parameters:[PTPVRequestParamsBuilder executePurchase:request
                                                                                            forUser:user
                                                                                      remoteAddress:response.remoteAddress
                                                                                      configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)executePurchaseDCC:(PTPVPurchaseRequest *)request
                   forUser:(PTPVUser *)user
                completion:(PTPVExecutePurchaseDCCCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVDCCDetails *> postWithAPIClient:self
                                                   endpoint:APIEndpointExecutePurchaseDCC
                                                 parameters:[PTPVRequestParamsBuilder executePurchaseDCC:request
                                                                                                 forUser:user
                                                                                           remoteAddress:response.remoteAddress
                                                                                           configuration:self.configuration]
                                               deserializer:[PTPVDCCDetails new]
                                                 completion:^(PTPVDCCDetails *object, NSHTTPURLResponse *response, NSError *error) {
                                                     completion(object, error);
                                                 }];
    }];
}

- (void)confirmPurchaseDCC:(PTPVDCCConfirmation *)request
                completion:(PTPVConfirmPurchaseDCCCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointConfirmPurchaseDCC
                                               parameters:[PTPVRequestParamsBuilder confirmPurchaseDCC:request
                                                                                         remoteAddress:response.remoteAddress
                                                                                         configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)executeRefund:(PTPVRefund *)request
              forUser:(PTPVUser *)user
           completion:(PTPVExecuteRefundCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVRefund *> postWithAPIClient:self
                                               endpoint:APIEndpointExecuteRefund
                                             parameters:[PTPVRequestParamsBuilder executeRefund:request
                                                                                        forUser:user
                                                                                  remoteAddress:response.remoteAddress
                                                                                  configuration:self.configuration]
                                           deserializer:[PTPVRefund new]
                                             completion:^(PTPVRefund *object, NSHTTPURLResponse *response, NSError *error) {
                                                 completion(object, error);
                                             }];
    }];
}

@end

#pragma mark - Purchase

@implementation PTPVAPIClient (Subscription)

- (void)createSubscription:(PTPVSubscription *)subscription
                  withCard:(PTPVCard *)card
                completion:(PTPVCreateSubscriptionCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVSubscriptionDetails *> postWithAPIClient:self
                                                            endpoint:APIEndpointCreateSubscription
                                                          parameters:[PTPVRequestParamsBuilder createSubscription:subscription
                                                                                                         withCard:card
                                                                                                    remoteAddress:response.remoteAddress
                                                                                                    configuration:self.configuration]
                                                        deserializer:[PTPVSubscriptionDetails new]
                                                          completion:^(PTPVSubscriptionDetails *object, NSHTTPURLResponse *response, NSError *error) {
                                                              completion(object, error);
                                                          }];
    }];
}

- (void)createSubscription:(PTPVSubscription *)subscription
                  withUser:(PTPVUser *)user
                completion:(PTPVCreateSubscriptionTokenCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVSubscriptionDetails *> postWithAPIClient:self
                                                            endpoint:APIEndpointCreateSubscriptionToken
                                                          parameters:[PTPVRequestParamsBuilder createSubscription:subscription
                                                                                                         withUser:user
                                                                                                    remoteAddress:response.remoteAddress
                                                                                                    configuration:self.configuration]
                                                        deserializer:[PTPVSubscriptionDetails new]
                                                          completion:^(PTPVSubscriptionDetails *object, NSHTTPURLResponse *response, NSError *error) {
                                                              completion(object, error);
                                                          }];
    }];
}

- (void)editSubscription:(PTPVSubscription *)subscription
                 forUser:(PTPVUser *)user
                 execute:(BOOL)execute
              completion:(PTPVEditSubscriptionCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVSubscriptionDetails *> postWithAPIClient:self
                                                            endpoint:APIEndpointEditSubscription
                                                          parameters:[PTPVRequestParamsBuilder editSubscription:subscription
                                                                                                        forUser:user
                                                                                                        execute:execute
                                                                                                  remoteAddress:response.remoteAddress
                                                                                                  configuration:self.configuration]
                                                        deserializer:[PTPVSubscriptionDetails new]
                                                          completion:^(PTPVSubscriptionDetails *object, NSHTTPURLResponse *response, NSError *error) {
                                                              completion(object, error);
                                                          }];
    }];
}

- (void)removeSubscription:(PTPVUser *)request
                completion:(PTPVErrorBlock)completion{
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVResponse *> postWithAPIClient:self
                                                 endpoint:APIEndpointRemoveSubscription
                                               parameters:[PTPVRequestParamsBuilder removeSubscription:request
                                                                                         remoteAddress:response.remoteAddress
                                                                                         configuration:self.configuration]
                                             deserializer:[PTPVResponse new]
                                               completion:^(PTPVResponse *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(error);
                                               }];
    }];
}

@end

#pragma mark - Preauthorization

@implementation PTPVAPIClient (Preauthorization)

- (void)createPreauthorization:(PTPVPurchaseRequest *)request
                       forUser:(PTPVUser *)user
                    completion:(PTPVCreatePreauthorizationCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointCreatePreauthorization
                                               parameters:[PTPVRequestParamsBuilder createPreauthorization:request
                                                                                                   forUser:user
                                                                                             remoteAddress:response.remoteAddress
                                                                                             configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)confirmPreauthorization:(PTPVPreauthorization *)preauthorization
                        forUser:(PTPVUser *)user
                     completion:(PTPVConfirmPreauthorizationCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointConfirmPreauthorization
                                               parameters:[PTPVRequestParamsBuilder confirmPreauthorization:preauthorization
                                                                                                    forUser:user
                                                                                              remoteAddress:response.remoteAddress
                                                                                              configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)cancelPreauthorization:(PTPVPreauthorization *)preauthorization
                       forUser:(PTPVUser *)user
                    completion:(PTPVCancelPreauthorizationCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointCancelPreauthorization
                                               parameters:[PTPVRequestParamsBuilder cancelPreauthorization:preauthorization
                                                                                                   forUser:user
                                                                                             remoteAddress:response.remoteAddress
                                                                                             configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)confirmDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                forUser:(PTPVUser *)user
                             completion:(PTPVCancelPreauthorizationCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointConfirmDeferredPreauthorization
                                               parameters:[PTPVRequestParamsBuilder confirmDeferredPreauthorization:preauthorization
                                                                                                            forUser:user
                                                                                                      remoteAddress:response.remoteAddress
                                                                                                      configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

- (void)cancelDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                               forUser:(PTPVUser *)user
                            completion:(PTPVCancelPreauthorizationCompletionBlock)completion {
    [self remoteIPWithCompletion:^(PTPVRemoteIP * _Nullable response, NSError * _Nullable error) {
        [PTPVAPIRequest<PTPVPurchase *> postWithAPIClient:self
                                                 endpoint:APIEndpointCancelDeferredPreauthorization
                                               parameters:[PTPVRequestParamsBuilder cancelDeferredPreauthorization:preauthorization
                                                                                                           forUser:user
                                                                                                     remoteAddress:response.remoteAddress
                                                                                                     configuration:self.configuration]
                                             deserializer:[PTPVPurchase new]
                                               completion:^(PTPVPurchase *object, NSHTTPURLResponse *response, NSError *error) {
                                                   completion(object, error);
                                               }];
    }];
}

@end

#pragma mark - Other

@implementation PTPVAPIClient (Other)

NSString *const kRemoteAddressCacheDateKey = @"ptpv_kCacheDateKey";
NSString *const kRemoteAddressCacheAddressKey = @"ptpv_kCacheAddressKey";
NSTimeInterval const kRemoteAddressCacheInterval = 60; // we cache the ip for 60 seconds

- (void)remoteIPWithCompletion:(PTPVRemoteIPCompletionBlock)completion {
    NSDate *cacheDate = [[NSUserDefaults standardUserDefaults] objectForKey:kRemoteAddressCacheDateKey];
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:kRemoteAddressCacheAddressKey];
    if (cacheDate != nil && address != nil) {
        if ([[NSDate date] timeIntervalSinceDate:cacheDate] < kRemoteAddressCacheInterval) {
                PTPVRemoteIP *res = [PTPVRemoteIP new];
                res.remoteAddress = address;

                return completion(res, nil);
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRemoteAddressCacheDateKey];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRemoteAddressCacheAddressKey];
        }
    }

    [PTPVAPIRequest<PTPVRemoteIP *> postWithAPIClient:self
                                             endpoint:APIEndpointRemoteIP
                                           parameters:[PTPVRequestParamsBuilder remoteIPWithConfiguration:self.configuration]
                                         deserializer:[PTPVRemoteIP new]
                                           completion:^(PTPVRemoteIP *object, NSHTTPURLResponse *response, NSError *error) {
                                               [[NSUserDefaults standardUserDefaults] setObject:object.remoteAddress forKey:kRemoteAddressCacheAddressKey];
                                               [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kRemoteAddressCacheDateKey];
                                               completion(object, error);
                                           }];
}

@end
