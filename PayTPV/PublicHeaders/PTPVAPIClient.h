//
//  PTPVAPIClient.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 7/25/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTPVBlocks.h"

#import "PTPVConfiguration.h"
#import "PTPVUser.h"
#import "PTPVResponse.h"
#import "PTPVCard.h"
#import "PTPVPurchaseRequest.h"
#import "PTPVPurchase.h"
#import "PTPVDCCDetails.h"
#import "PTPVDCCConfirmation.h"
#import "PTPVRefund.h"
#import "PTPVSubscription.h"
#import "PTPVSubscriptionDetails.h"
#import "PTPVPreauthorization.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A client for making requests to the PAYTPV API.
 */
@interface PTPVAPIClient : NSObject

/**
 A shared singleton API client.
 */
+ (instancetype)sharedClient;

/**
 Creates an API client with the given configuration.

 @param configuration The configuration to use
 @return A PTPVAPIClient instance using the given configuration
 */
- (instancetype)initWithConfiguration:(PTPVConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 The client's configuration.
 */
@property (nonatomic, copy) PTPVConfiguration *configuration;

@end

#pragma mark - Users

/**
 Contains the user related APIs
 */
@interface PTPVAPIClient (Users)

/**
 Add a card to PAYTPV.

 @b Important

 This operation must be activated by PAYTPV. Contact us to register for the desired product.

 @param card A PTPVCard instance containing the credit card details. @see PTPVCard
 @param completion The callback to run with the returned PTPVUser object, or an error.
 */
- (void)addUser:(PTPVCard *)card
     completion:(PTPVAddUserCompletionBlock)completion;

/**
 Registers a user based on a token previously obtained trough the solution BankStore JET. @see http://developers.paytpv.com/en/documentacion/jet-bankstore

 @param token Token obtained from javascript
 @param completion The callback to run with the returned PTPVUser object, or an error.
 */
- (void)addUserWithJETToken:(NSString *)token
                 completion:(PTPVAddUserTokenCompletionBlock)completion;

/**
 Returns the user information for the registered user.
 
 This function will be used to confirm to the customers of the business which card will be used to make the payment. This step is optional but it is convenient to avoid mistrust.

 @param user A PTPVUser instance containing the user registration within the system. @see PTPVUser
 @param completion The callback to run with the returned PTPVCard object, or an error.
 */
- (void)infoUser:(PTPVUser *)user
      completion:(PTPVInfoUserCompletionBlock)completion;

/**
 Removes a user from the account of the business.

 @param user A PTPVUser instance containing the user registration within the system. @see PTPVUser
 @param completion The callback to run with the returned error if there is one.
 */
- (void)removeUser:(PTPVUser *)user
        completion:(PTPVErrorBlock)completion;

@end

#pragma mark - Purchase

/**
 Contains the purchase related APIs
 */
@interface PTPVAPIClient (Purchase)

/**
 Execute a payment with the user's details.
 
 Once the user is registered in the system, charges may be made to their account by sending their credentials and data of the operation.

 @param purchase A PTPVPurchaseRequest instance containing the purchase details. @see PTPVPurchaseRequest
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)executePurchase:(PTPVPurchaseRequest *)purchase
                forUser:(PTPVUser *)user
             completion:(PTPVExecutePurchaseCompletionBlock)completion;

/**
 Execute a Dynamic currency conversion purchase with the user's details.
 
 @b Important

 This operation must be activated by PAYTPV. Contact us to register for the desired product.

 Once the user is registered on the system, they can make payments with their account by sending their credentials and operation information. The DCC caseload requires that a payment process is carried out in two steps: execute_purchase_dcc, where the native currency of the card is received (in the case of the card having the same currency as the product associated with the transaction, the result will be a 1:1 conversion) and will be subsequently confirmed with the confirm_purchase_dcc method with the selected currency and the original session of the transaction.

 @param request A PTPVPurchaseRequest instance containing the purchase details. @see PTPVPurchaseRequest:initDCCWithUser
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVDCCDetails object, or an error.
 */
- (void)executePurchaseDCC:(PTPVPurchaseRequest *)request
                   forUser:(PTPVUser *)user
                completion:(PTPVExecutePurchaseDCCCompletionBlock)completion;

/**
 Confirms the currency for a dcc transaction.
 
 Once the DS_MERCHANT_DCC_SESSION parameter has been restored when a DCC purchase has been made, the state of the transaction will be “waiting” for the currency confirmation. The business must suggest to the client the currency in which they wish to pay (showing the conversion in real time) and when it is selected, the business must confirm the authorisation with the currency selected by the end user.

 @param request A PTPVDCCConfirmation instance containing the dcc details. @see PTPVDCCConfirmation
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)confirmPurchaseDCC:(PTPVDCCConfirmation *)request
                completion:(PTPVConfirmPurchaseDCCCompletionBlock)completion;

/**
 Refunds a purchase.

 @param refund A PTPVRefund instance containing the purchase details
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVRefund object, or an error.
 */
- (void)executeRefund:(PTPVRefund *)refund
              forUser:(PTPVUser *)user
           completion:(PTPVExecuteRefundCompletionBlock)completion;

@end

#pragma mark - Subscription

/**
 Contains the subscription related APIs
 */
@interface PTPVAPIClient (Subscription)

/**
 Creates a subscription to the account of the business with the given credit card.

 The registration of a subscription implies the registration of a user in the BankStore system of PAYTPV. This process is completely independent from the isolated charge to a customer of the business.

 If the execution of the first installment has an error for several reasons (balance, validity of the card, etc...), the subscription will be canceled having to create a new subscription.

 @param subscription A PTPVSubscription instance containing the subscription details. @see PTPVSubscription
 @param card A PTPVCard instance containing the credit card details. @see PTPVCard
 @param completion The callback to run with the returned PTPVSubscriptionDetails object, or an error.
 */
- (void)createSubscription:(PTPVSubscription *)subscription
                  withCard:(PTPVCard *)card
                completion:(PTPVCreateSubscriptionCompletionBlock)completion;

/**
 Creates a subscription to the account of the business for a user that was already registered in the system, without it being necessary in this case to send card data again

 @param subscription A PTPVSubscription instance containing the subscription details. @see PTPVSubscription
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVSubscriptionDetails object, or an error.
 */
- (void)createSubscription:(PTPVSubscription *)subscription
                  withUser:(PTPVUser *)user
                completion:(PTPVCreateSubscriptionTokenCompletionBlock)completion;

/**
 Updates an existing subscription.
 
 If a user renews their subscription or simply wants to increase the payment of the service we offer the service of editing a subscription. In this case it will not be possible to change the currency nor the bank details of the customer of the business. The modification of the subscription involves the prior registration of a user in subscription mode in the BankStore system of PAYTPV. This process is completely independent from the isolated charge to a customer of the business.

 @param subscription A PTPVSubscription instance containing the subscription details. @see PTPVSubscription
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param execute If the registration process involves the payment of the first installment the value of DS_EXECUTE must be `true`. If you only want the subscription registration without the payment of the first installment (it will be executed with the parameters sent) its value must be `false`.
 @param completion The callback to run with the returned PTPVSubscriptionDetails object, or an error.
 */
- (void)editSubscription:(PTPVSubscription *)subscription
                 forUser:(PTPVUser *)user
                 execute:(BOOL)execute
              completion:(PTPVEditSubscriptionCompletionBlock)completion;

/**
 Removes a subscription from the account of the business.

 @param request A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned error if there is one.
 */
- (void)removeSubscription:(PTPVUser *)request
                completion:(PTPVErrorBlock)completion;

@end

#pragma mark - Preauthorization

/**
 Contains the preauthorization related APIs
 */
@interface PTPVAPIClient (Preauthorization)

/**
 Creates a user preauthorization in the system.
 
 Once the user is registered in the system, preauthorization operations may be performed by sending their credentials and data of the operation.

 @param request A PTPVPurchaseRequest instance containing the purchase details. @see PTPVPurchaseRequest
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)createPreauthorization:(PTPVPurchaseRequest *)request
                       forUser:(PTPVUser *)user
                    completion:(PTPVCreatePreauthorizationCompletionBlock)completion;

/**
 Confirms a preauthorization.
 
 Once a preauthorization operation has been performed and authorized, it can be confirmed to make the cash payment within 7 days; after that date, preauthorizations become invalid. The amount of the preauthorization confirmation can be less than, equal to or greater than 15% of the original preauthorization.

 @param preauthorization A PTPVPreauthorization instance containing the preauthorization details. @see PTPVPreauthorization
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)confirmPreauthorization:(PTPVPreauthorization *)preauthorization
                        forUser:(PTPVUser *)user
                     completion:(PTPVConfirmPreauthorizationCompletionBlock)completion;

/**
 Cancels a preauthorization.

 Once a preauthorization has been performed, it can be canceled within 7 days.

 @param preauthorization A PTPVPreauthorization instance containing the preauthorization details. @see PTPVPreauthorization
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)cancelPreauthorization:(PTPVPreauthorization *)preauthorization
                       forUser:(PTPVUser *)user
                    completion:(PTPVCancelPreauthorizationCompletionBlock)completion;

/**
 Confirms a deferred preauthorization in the system.

 Once a deferred pre-authorisation operation has been carried out and authorised, it can be confirmed to carry out the effective payment within the following 72 hours; after this time, the deferred pre-authorisations lose their validity. The amount of the deferred pre-authorisation must be exactly equal to that of the original deferred pre-authorisation.

 @param preauthorization A PTPVPreauthorization instance containing the preauthorization details. @see PTPVPreauthorization
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)confirmDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                                forUser:(PTPVUser *)user
                             completion:(PTPVCancelPreauthorizationCompletionBlock)completion;

/**
 Cancels a deferred preauthorization in the system.

 Once a deferred pre-authorisation has been carried out, it can be cancelled within the following 72 hours.

 @param preauthorization A PTPVPreauthorization instance containing the preauthorization details. @see PTPVPreauthorization
 @param user A PTPVUser instance containing the user details. @see PTPVUser
 @param completion The callback to run with the returned PTPVPurchase object, or an error.
 */
- (void)cancelDeferredPreauthorization:(PTPVPreauthorization *)preauthorization
                               forUser:(PTPVUser *)user
                            completion:(PTPVCancelPreauthorizationCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
