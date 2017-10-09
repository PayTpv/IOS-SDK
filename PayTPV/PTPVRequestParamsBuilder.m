//
//  PTPVRequestParamsBuilder.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVRequestParamsBuilder.h"

#import "PTPVSigner.h"

@implementation PTPVRequestParamsBuilder

@end

#pragma mark - Users

@implementation PTPVRequestParamsBuilder (Users)

+ (NSDictionary *)addUser:(PTPVCard *)request
            remoteAddress:(NSString *)remoteAddress
            configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                request.pan,
                                                                                request.cvv,
                                                                                config.terminal,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)addUserWithJETToken:(NSString *)token
                        remoteAddress:(NSString *)remoteAddress
                        configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_JETTOKEN"] = token;
    params[@"DS_MERCHANT_JETID"] = config.jetId;

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                token,
                                                                                config.jetId,
                                                                                config.terminal,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)infoUser:(PTPVUser *)request
             remoteAddress:(NSString *)remoteAddress
             configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                request.idUser,
                                                                                request.tokenUser,
                                                                                config.terminal,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)removeUser:(PTPVUser *)request
               remoteAddress:(NSString *)remoteAddress
               configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                request.idUser,
                                                                                request.tokenUser,
                                                                                config.terminal,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

@end

#pragma mark - Purchase

@implementation PTPVRequestParamsBuilder (Purchase)

+ (NSDictionary *)executePurchase:(PTPVPurchaseRequest *)request
                          forUser:(PTPVUser *)user
                    remoteAddress:(NSString *)remoteAddress
                    configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                request.amount,
                                                                                request.order,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)executePurchaseDCC:(PTPVPurchaseRequest *)request
                             forUser:(PTPVUser *)user
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    [params removeObjectForKey:@"DS_MERCHANT_CURRENCY"];
    [params removeObjectForKey:@"DS_MERCHANT_SCORING"];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                request.amount,
                                                                                request.order,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)confirmPurchaseDCC:(PTPVDCCConfirmation *)request
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                config.terminal,
                                                                                request.order,
                                                                                request.currency,
                                                                                request.session,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)executeRefund:(PTPVRefund *)request
                        forUser:(PTPVUser *)user
                  remoteAddress:(NSString *)remoteAddress
                  configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                request.authCode,
                                                                                request.order,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

@end

#pragma mark - Subscription

@implementation PTPVRequestParamsBuilder (Subscription)

+ (NSDictionary *)createSubscription:(PTPVSubscription *)subscription
                            withCard:(PTPVCard *)card
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[subscription toDictionary]];
    [params addEntriesFromDictionary:[card toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                card.pan,
                                                                                card.cvv,
                                                                                config.terminal,
                                                                                subscription.amount,
                                                                                subscription.currency,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)createSubscription:(PTPVSubscription *)subscription
                            withUser:(PTPVUser *)user
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[subscription toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                subscription.amount,
                                                                                subscription.currency,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)editSubscription:(PTPVSubscription *)subscription
                           forUser:(PTPVUser *)user
                           execute:(BOOL)execute
                     remoteAddress:(NSString *)remoteAddress
                     configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[subscription toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];
    params[@"DS_EXECUTE"] = execute ? @YES : @NO;

    [params removeObjectForKey:@"DS_SUBSCRIPTION_ORDER"];
    [params removeObjectForKey:@"DS_SUBSCRIPTION_CURRENCY"];
    [params removeObjectForKey:@"DS_MERCHANT_SCORING"];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                subscription.amount,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)removeSubscription:(PTPVUser *)request
                       remoteAddress:(NSString *)remoteAddress
                       configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                request.idUser,
                                                                                request.tokenUser,
                                                                                config.terminal,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

@end

#pragma mark - Preauthorization

@implementation PTPVRequestParamsBuilder (Preauthorization)

+ (NSDictionary *)createPreauthorization:(PTPVPurchaseRequest *)request
                                 forUser:(PTPVUser *)user
                           remoteAddress:(NSString *)remoteAddress
                           configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[request toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                request.amount,
                                                                                request.order,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)confirmPreauthorization:(PTPVPreauthorization *)preauthorization
                                  forUser:(PTPVUser *)user
                            remoteAddress:(NSString *)remoteAddress
                            configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[preauthorization toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                preauthorization.order,
                                                                                preauthorization.amount,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)cancelPreauthorization:(PTPVPreauthorization *)preauthorization
                                 forUser:(PTPVUser *)user
                           remoteAddress:(NSString *)remoteAddress
                           configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[preauthorization toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                preauthorization.order,
                                                                                preauthorization.amount,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)confirmDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                          forUser:(PTPVUser *)user
                                    remoteAddress:(NSString *)remoteAddress
                                    configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[preauthorization toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                preauthorization.order,
                                                                                preauthorization.amount,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

+ (NSDictionary *)cancelDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                         forUser:(PTPVUser *)user
                                   remoteAddress:(NSString *)remoteAddress
                                   configuration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[preauthorization toDictionary]];
    [params addEntriesFromDictionary:[user toDictionary]];
    [params addEntriesFromDictionary:[config toDictionary]];

    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha1SignatureWithArray:@[
                                                                                config.merchantCode,
                                                                                user.idUser,
                                                                                user.tokenUser,
                                                                                config.terminal,
                                                                                preauthorization.order,
                                                                                preauthorization.amount,
                                                                                config.password,
                                                                                ]];
    params[@"DS_ORIGINAL_IP"] = remoteAddress;
    return params;
}

@end

#pragma mark - Other

@implementation PTPVRequestParamsBuilder (Other)

+ (NSDictionary *)remoteIPWithConfiguration:(PTPVConfiguration *)config {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:[config toDictionary]];

    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYYMMddHHmmss";
    NSString *timestamp = [df stringFromDate:[NSDate date]];

    params[@"DS_TIMESTAMP"] = timestamp;
    params[@"DS_MERCHANT_MERCHANTSIGNATURE"] = [PTPVSigner sha256SignatureWithArray:@[
                                                                                      config.merchantCode,
                                                                                      config.terminal,
                                                                                      timestamp,
                                                                                      config.password,
                                                                                      ]];
    return params;
}

@end
