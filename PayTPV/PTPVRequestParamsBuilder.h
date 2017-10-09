//
//  PTPVRequestParamsBuilder.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVUser.h"
#import "PTPVCard.h"
#import "PTPVPurchaseRequest.h"
#import "PTPVDCCConfirmation.h"
#import "PTPVRefund.h"
#import "PTPVSubscription.h"
#import "PTPVConfiguration.h"
#import "PTPVPreauthorization.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTPVRequestParamsBuilder : NSObject

@end

#pragma mark - Users

@interface PTPVRequestParamsBuilder (Users)

+ (NSDictionary *)addUser:(PTPVCard *)request
            remoteAddress:(NSString *)remoteAddress
            configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)addUserWithJETToken:(NSString *)token
                        remoteAddress:(NSString *)remoteAddress
                        configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)infoUser:(PTPVUser *)request
             remoteAddress:(NSString *)remoteAddress
             configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)removeUser:(PTPVUser *)request
               remoteAddress:(NSString *)remoteAddress
               configuration:(PTPVConfiguration *)config;

@end

#pragma mark - Purchase

@interface PTPVRequestParamsBuilder (Purchase)

+ (NSDictionary *)executePurchase:(PTPVPurchaseRequest *)request
                          forUser:(PTPVUser *)user
                    remoteAddress:(NSString *)remoteAddress
                    configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)executePurchaseDCC:(PTPVPurchaseRequest *)request
                             forUser:(PTPVUser *)user
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)confirmPurchaseDCC:(PTPVDCCConfirmation *)request
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)executeRefund:(PTPVRefund *)request
                        forUser:(PTPVUser *)user
                  remoteAddress:(NSString *)remoteAddress
                  configuration:(PTPVConfiguration *)config;

@end

#pragma mark - Subscription

@interface PTPVRequestParamsBuilder (Subscription)

+ (NSDictionary *)createSubscription:(PTPVSubscription *)subscription
                            withCard:(PTPVCard *)card
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)createSubscription:(PTPVSubscription *)subscription
                            withUser:(PTPVUser *)user
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)editSubscription:(PTPVSubscription *)subscription
                           forUser:(PTPVUser *)user
                           execute:(BOOL)execute
                     remoteAddress:(NSString *)remoteAddress
                     configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)removeSubscription:(PTPVUser *)request
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config;

@end

#pragma mark - Preauthorization

@interface PTPVRequestParamsBuilder (Preauthorization)

+ (NSDictionary *)createPreauthorization:(PTPVPurchaseRequest *)request
                                 forUser:(PTPVUser *)user
                           remoteAddress:(NSString *)remoteAddress
                           configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)confirmPreauthorization:(PTPVPreauthorization *)preauthorization
                                  forUser:(PTPVUser *)user
                            remoteAddress:(NSString *)remoteAddress
                            configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)cancelPreauthorization:(PTPVPreauthorization *)preauthorization
                                 forUser:(PTPVUser *)user
                           remoteAddress:(NSString *)remoteAddress
                           configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)confirmDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                          forUser:(PTPVUser *)user
                                    remoteAddress:(NSString *)remoteAddress
                                    configuration:(PTPVConfiguration *)config;

+ (NSDictionary *)cancelDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                         forUser:(PTPVUser *)user
                                   remoteAddress:(NSString *)remoteAddress
                                   configuration:(PTPVConfiguration *)config;

@end

#pragma mark - Other

@interface PTPVRequestParamsBuilder (Other)

+ (NSDictionary *)remoteIPWithConfiguration:(PTPVConfiguration *)config;

@end

NS_ASSUME_NONNULL_END
