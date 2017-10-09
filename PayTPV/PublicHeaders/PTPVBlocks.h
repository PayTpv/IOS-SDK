//
//  PTPVBlocks.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

@class PTPVResponse,
PTPVUser,
PTPVCard,
PTPVPurchase,
PTPVDCCDetails,
PTPVRefund,
PTPVSubscriptionDetails;

/**
 A callback that will be run with the error response from the API.

 @param error The error returned from the response
 */
typedef void (^PTPVErrorBlock)(NSError * __nullable error);

/**
 A callback that will be run with the user response from the API.

 @param user The user from the response
 @param error The error returned from the response
 */
typedef void (^PTPVAddUserCompletionBlock)(PTPVUser * __nullable user, NSError * __nullable error);

/**
 A callback that will be run with the user response from the API.

 @param user The user from the response
 @param error The error returned from the response
 */
typedef void (^PTPVAddUserTokenCompletionBlock)(PTPVUser * __nullable user, NSError * __nullable error);

/**
 A callback that will be run with the card response from the API.

 @param card The card from the response
 @param error The error returned from the response
 */
typedef void (^PTPVInfoUserCompletionBlock)(PTPVCard * __nullable card, NSError * __nullable error);

/**
 A callback that will be run with the response from the API.

 @param response The response
 @param error The error returned from the response
 */
typedef void (^PTPVRemoveUserCompletionBlock)(PTPVResponse * __nullable response, NSError * __nullable error);

/**
 A callback that will be run with the purchase response from the API.

 @param purchase The purchase from the response
 @param error The error returned from the response
 */
typedef void (^PTPVExecutePurchaseCompletionBlock)(PTPVPurchase * __nullable purchase, NSError * __nullable error);

/**
 A callback that will be run with the dcc details response from the API.

 @param response The dcc details from the response
 @param error The error returned from the response
 */
typedef void (^PTPVExecutePurchaseDCCCompletionBlock)(PTPVDCCDetails * __nullable response, NSError * __nullable error);

/**
 A callback that will be run with the purchase response from the API.

 @param purchase The purchase from the response
 @param error The error returned from the response
 */
typedef void (^PTPVConfirmPurchaseDCCCompletionBlock)(PTPVPurchase * __nullable purchase, NSError * __nullable error);

/**
 A callback that will be run with the refund response from the API.

 @param refund The refund details from the response
 @param error The error returned from the response
 */
typedef void (^PTPVExecuteRefundCompletionBlock)(PTPVRefund * __nullable refund, NSError * __nullable error);

/**
 A callback that will be run with the subscription response from the API.

 @param subscription The subscription details from the response
 @param error The error returned from the response
 */
typedef void (^PTPVCreateSubscriptionCompletionBlock)(PTPVSubscriptionDetails * __nullable subscription, NSError * __nullable error);

/**
 A callback that will be run with the subscription response from the API.

 @param subscription The subscription details from the response
 @param error The error returned from the response
 */
typedef void (^PTPVEditSubscriptionCompletionBlock)(PTPVSubscriptionDetails * __nullable subscription, NSError * __nullable error);

/**
 A callback that will be run with the response from the API.

 @param response The response
 @param error The error returned from the response
 */
typedef void (^PTPVRemoveSubscriptionCompletionBlock)(PTPVResponse * __nullable response, NSError * __nullable error);

/**
 A callback that will be run with the subscription response from the API.

 @param subscription The subscription details from the response
 @param error The error returned from the response
 */
typedef void (^PTPVCreateSubscriptionTokenCompletionBlock)(PTPVSubscriptionDetails * __nullable subscription, NSError * __nullable error);

/**
 A callback that will be run with the purchase response from the API.

 @param purchase The purchase from the response
 @param error The error returned from the response
 */
typedef void (^PTPVCreatePreauthorizationCompletionBlock)(PTPVPurchase * __nullable purchase, NSError * __nullable error);

/**
 A callback that will be run with the purchase response from the API.

 @param purchase The purchase from the response
 @param error The error returned from the response
 */
typedef void (^PTPVConfirmPreauthorizationCompletionBlock)(PTPVPurchase * __nullable purchase, NSError * __nullable error);

/**
 A callback that will be run with the purchase response from the API.

 @param purchase The purchase from the response
 @param error The error returned from the response
 */
typedef void (^PTPVCancelPreauthorizationCompletionBlock)(PTPVPurchase * __nullable purchase, NSError * __nullable error);
