//
//  PTPVPurchaseRequest.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVCurrency.h"
#import "PTPVNSDictionaryEncodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the purchase request details
 */
@interface PTPVPurchaseRequest : NSObject<PTPVNSDictionaryEncodable>

/**
 Creates a PTPVPurchaseRequest. Used when executing a purchase.

 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 @param order Reference of the operation. Must be unique on every valid transaction
 @param currency Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 @param productDescription Optional. Description of the product
 @param owner Optional. Description of the transaction
 @param scoring Optional. Risk score of the transaction. Between 0 and 100

 @return A PTPVPurchaseRequest instance populated with the provided values
 */
- (instancetype)initWithAmount:(NSNumber *)amount
                         order:(NSString *)order
                      currency:(PTPVCurrency *)currency
            productDescription:(nullable NSString *)productDescription
                         owner:(nullable NSString *)owner
                       scoring:(nullable NSString *)scoring;

/**
 Creates a PTPVPurchaseRequest. Used when executing a Dynamic currency conversion purchase.

 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 @param order Reference of the operation. Must be unique on every valid transaction
 @param productDescription Optional. Description of the product
 @param owner Optional. Description of the transaction

 @return A PTPVPurchaseRequest instance populated with the provided values
 */
- (instancetype)initDCCWithAmount:(NSNumber *)amount
                            order:(NSString *)order
               productDescription:(nullable NSString *)productDescription
                            owner:(nullable NSString *)owner;

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

/**
 Reference of the operation. Must be unique on every valid transaction
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 */
@property (nonatomic, copy, nullable) PTPVCurrency *currency;

/**
 Description of the product
 */
@property (nonatomic, copy, nullable) NSString *productDescription;

/**
 Description of the transaction
 */
@property (nonatomic, copy, nullable) NSString *owner;

/**
 Risk score of the transaction. Between 0 and 100
 */
@property (nonatomic, copy, nullable) NSString *scoring;

@end

NS_ASSUME_NONNULL_END
