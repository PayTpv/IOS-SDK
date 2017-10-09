//
//  PTPVCard.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVNSDictionaryEncodable.h"
#import "PTPVAPIResponseDecodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the user's credit card details
 */
@interface PTPVCard : NSObject<PTPVNSDictionaryEncodable, PTPVAPIResponseDecodable>

/**
 Creates a PTPVCard

 @param pan Card number, without any spaces or dashes
 @param expiryDate Expiry date of the card, expressed as “mmyy” (two-digits for the month and two-digits for the year)
 @param cvv CVC2 Code of the card

 @return A PTPVCard instance populated with the provided values
 */
- (instancetype)initWithPan:(NSString *)pan
                 expiryDate:(NSString *)expiryDate
                        cvv:(NSString *)cvv;

/**
 Card number, without any spaces or dashes.
 When receiving the card details from PAYTPV, only the last four digits will be returned. The rest will be masked with X.
 */
@property (nonatomic, copy, nullable) NSString *pan;

/**
 Expiry date of the card, expressed as “mmyy” (two-digits for the month and two-digits for the year).
 When receiving the card details from PAYTPV, the expiry date is in the format YYYY/MM.
 */
@property (nonatomic, copy, nullable) NSString *expiryDate;

/**
 CVC2 Code of the card
 */
@property (nonatomic, copy, nullable) NSString *cvv;

/**
 Card brand (Visa, MasterCard, American Express, etc).
 */
@property (nonatomic, copy, nullable) NSString *brand;

/**
 Type of card (DEBIT, CREDIT, etc).
 */
@property (nonatomic, copy, nullable) NSString *type;

/**
 ISO3 Code the country of the issuer of the card.
 */
@property (nonatomic, copy, nullable) NSString *country;

@end

NS_ASSUME_NONNULL_END
