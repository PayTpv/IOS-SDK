//
//  PTPVPurchase.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVResult.h"
#import "PTPVAPIResponseDecodable.h"

/**
 Represents the purchase details
 */
@interface PTPVPurchase : NSObject<PTPVAPIResponseDecodable>

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

/**
 Reference of the operation.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 */
@property (nonatomic, copy, nullable) NSString *currency;

/**
 Authorization bank code of the transaction (required to execute a return).
 */
@property (nonatomic, copy, nullable) NSString *authCode;

/**
 Country of the issuer of the card in ISO3 Code (ex.: 724 = Spain). May be left empty.
 */
@property (nonatomic, copy, nullable) NSString *cardCountry;

/**
 Result of operation. 0 or empty will be erroneous operation and 1 operation completed.
 */
@property (nonatomic) PTPVResult result;

@end
