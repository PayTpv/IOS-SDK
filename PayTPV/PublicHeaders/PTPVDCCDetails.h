//
//  PTPVDCCDetails.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVResult.h"
#import "PTPVAPIResponseDecodable.h"

/**
 Represents the DCC purchase details
 */
@interface PTPVDCCDetails : NSObject<PTPVAPIResponseDecodable>

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

/**
 Reference of the operation.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Transaction currency. It will always be the same as the original product.
 */
@property (nonatomic, copy, nullable) NSString *currency;

/**
 Session var for later confirmation of the authorization. This value must be stored to confirm payment in the currency chosen by the end user.
 */
@property (nonatomic, copy, nullable) NSString *dccSession;

/**
 Native currency of the customer's card.
 */
@property (nonatomic, copy, nullable) NSString *dccCurrency;

/**
 Native currency of the customer's card in ISO3
 */
@property (nonatomic, copy, nullable) NSString *dccCurrencyISO3;

/**
 Literal currency in string. If the native currency is the same as the product PAYTPV, this field will come with value 0.
 */
@property (nonatomic, copy, nullable) NSString *dccCurrencyName;

/**
 Currency exchange rate. Return string but it will come in float format.
 */
@property (nonatomic, copy, nullable) NSString *dccExchange;

/**
 Amount of the operation in whole format. 1,00 EURO = 100, 4,50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *dccAmount;

/**
 Percentage value in float of DCC margin applied by the financial institution. For example: 0.03 will be 3%
 */
@property (nonatomic, copy, nullable) NSString *dccMarkup;

/**
 Country of the issuer of the card in ISO3 Code (ex.: 724 = Spain).
 */
@property (nonatomic, copy, nullable) NSString *dccCardCountry;

/**
 Result of operation. 0 or empty will be erroneous operation and 1 operation completed.
 */
@property (nonatomic) PTPVResult result;

@end
