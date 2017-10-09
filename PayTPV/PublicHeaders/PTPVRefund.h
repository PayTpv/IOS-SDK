//
//  PTPVRefund.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVCurrency.h"
#import "PTPVNSDictionaryEncodable.h"
#import "PTPVAPIResponseDecodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a purchase refund request
 */
@interface PTPVRefund : NSObject<PTPVNSDictionaryEncodable, PTPVAPIResponseDecodable>

/**
 Creates a PTPVRefund.

 @param authCode Original bank code of the authorization of the transaction
 @param order Original reference of the operation.
 @param currency Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 @param amount Optional. For partial refunds. Amount to be refunded in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...

 @return A PTPVRefund instance populated with the provided values
 */
- (instancetype)initWithAuthCode:(NSString *)authCode
                           order:(NSString *)order
                        currency:(PTPVCurrency *)currency
                          amount:(nullable NSNumber *)amount;

/**
 Creates a PTPVRefund.

 @param authCode Original bank code of the authorization of the transaction
 @param order Original reference of the operation.
 @param currency Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency

 @return A PTPVRefund instance populated with the provided values
 */
- (instancetype)initWithAuthCode:(NSString *)authCode
                           order:(NSString *)order
                        currency:(PTPVCurrency *)currency;

/**
 Original bank code of the authorization of the transaction
 */
@property (nonatomic, copy, nullable) NSString *authCode;

/**
 Original reference of the operation.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 */
@property (nonatomic, copy, nullable) PTPVCurrency *currency;

/**
 For partial refunds. Amount to be refunded in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

@end

NS_ASSUME_NONNULL_END
