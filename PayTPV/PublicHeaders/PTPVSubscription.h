//
//  PTPVSubscription.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVCurrency.h"
#import "PTPVNSDictionaryEncodable.h"

#import "PTPVCard.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a subscription
 */
@interface PTPVSubscription : NSObject<PTPVNSDictionaryEncodable>

/**
 Creates a PTPVSubscription

 @param startDate Subscription start date. If the value is empty the date is the same day of registration. The format of the date is YYYY-MM-DD.
 @param endDate Subscription end date. It may not be later than the Subscription start date + 5 years. The format of the date is YYYY-MM-DD.
 @param order First characters of the reference of the operation.

 @b Important

 Do not include the characters “[“ or “]”, they will be used to recognize the user of the business.

 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 @param currency Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 @param periodicity Frequency of collection from the start date. The number expresses Days. It may not be greater than 365 days.
 @param scoring Optional. Risk score of the transaction. Between 0 and 100

 @return A PTPVSubscription instance populated with the provided values
 */
- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                            order:(NSString *)order
                           amount:(NSNumber *)amount
                         currency:(PTPVCurrency *)currency
                      periodicity:(NSString *)periodicity
                          scoring:(nullable NSString *)scoring;

/**
 Creates a PTPVSubscription

 @param startDate Subscription start date. If the value is empty the date is the same day of registration. The format of the date is YYYY-MM-DD.
 @param endDate Subscription end date. It may not be later than the Subscription start date + 5 years. The format of the date is YYYY-MM-DD.
 @param order First characters of the reference of the operation.

 @b Important

 Do not include the characters “[“ or “]”, they will be used to recognize the user of the business.

 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 @param currency Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 @param periodicity Frequency of collection from the start date. The number expresses Days. It may not be greater than 365 days.

 @return A PTPVSubscription instance populated with the provided values
 */
- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                            order:(NSString *)order
                           amount:(NSNumber *)amount
                         currency:(PTPVCurrency *)currency
                      periodicity:(NSString *)periodicity;

/**
 Creates a PTPVSubscription

 @param startDate Subscription start date. If the value is empty the date is the same day of registration. The format of the date is YYYY-MM-DD.
 @param endDate Subscription end date. It may not be later than the Subscription start date + 5 years. The format of the date is YYYY-MM-DD.
 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 @param periodicity Frequency of collection from the start date. The number expresses Days. It may not be greater than 365 days.

 @return A PTPVSubscription instance populated with the provided values
 */
- (instancetype)initWithStartDate:(NSString *)startDate
                          endDate:(NSString *)endDate
                           amount:(NSNumber *)amount
                      periodicity:(NSString *)periodicity;

/**
 Subscription start date. If the value is empty the date is the same day of registration. The format of the date is YYYY-MM-DD.
 */
@property (nonatomic, copy, nullable) NSString *startDate;

/**
 Subscription end date. It may not be later than the Subscription start date + 5 years. The format of the date is YYYY-MM-DD.
 */
@property (nonatomic, copy, nullable) NSString *endDate;

/**
 First characters of the reference of the operation.
 
 @b Important
 
 Do not include the characters “[“ or “]”, they will be used to recognize the user of the business.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Frequency of collection from the start date. The number expresses Days. It may not be greater than 365 days.
 */
@property (nonatomic, copy, nullable) NSString *periodicity;

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

/**
 Currency of the transaction. @see more details at http://developers.paytpv.com/en/documentacion/monedas . @see PTPVCurrency
 */
@property (nonatomic, copy, nullable) PTPVCurrency *currency;

/**
 Risk score of the transaction. Between 0 and 100
 */
@property (nonatomic, copy, nullable) NSString *scoring;

@end

NS_ASSUME_NONNULL_END
