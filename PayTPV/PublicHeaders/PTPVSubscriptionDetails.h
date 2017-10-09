//
//  PTPVSubscriptionDetails.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVCurrency.h"
#import "PTPVAPIResponseDecodable.h"

#import "PTPVUser.h"

/**
 Represents the subscription details
 */
@interface PTPVSubscriptionDetails : NSObject<PTPVAPIResponseDecodable>

/**
 Unique identifier of the user registered in the system. It will come back empty in the case of error.
 */
@property (nonatomic, copy, nullable) NSString *idUser;

/**
 Token code associated with the DS_IDUSER.
 */
@property (nonatomic, copy, nullable) NSString *tokenUser;

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

/**
 Original reference of the operation + [DS_IDUSER] + date of the transaction in format YYYYMMDD.
 
 Example:

 DS_SUBSCRIPTION_ORDER = Luis_3268314

 The charge of the subscription to DS_IDUSER 32 on December 23, 2030 the system will return it as DS_SUBSCRIPTION_ORDER:

 DS_SUBSCRIPTION_ORDER = Luis_3268314[23]20301223
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 */
@property (nonatomic, copy, nullable) PTPVCurrency *currency;

/**
 Authentication bank code of the transaction.
 */
@property (nonatomic, copy, nullable) NSString *authCode;

/**
 Country of the issuer of the card in ISO3 Code (ex.: 724 = Spain). May be left empty.
 */
@property (nonatomic, copy, nullable) NSString *cardCountry;

/**
 Returns a user with the details in the subscription

 @return The PTPVUser associated with the subscriptio
 */
- (nonnull PTPVUser *)user;

@end
