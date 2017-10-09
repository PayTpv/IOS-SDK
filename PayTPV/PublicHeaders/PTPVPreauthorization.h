//
//  PTPVPreauthorization.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/9/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVNSDictionaryEncodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a preauthorization request
 */
@interface PTPVPreauthorization : NSObject<PTPVNSDictionaryEncodable>

/**
 Creates a PTPVPreauthorization

 @param order Reference operation. Should be that identified the original preauthorization.
 @param amount Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...

 @return A PTPVPreauthorization instance populated with the provided values
 */
- (instancetype)initWithOrder:(NSString *)order
                       amount:(NSNumber *)amount;

/**
 Reference operation. Should be that identified the original preauthorization.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Amount of the operation in integer format. 1.00 EURO = 100, 4.50 EUROS = 450...
 */
@property (nonatomic, copy, nullable) NSNumber *amount;

@end

NS_ASSUME_NONNULL_END
