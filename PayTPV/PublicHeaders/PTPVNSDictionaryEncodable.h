//
//  PTPVNSDictionaryEncodable.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Protocol for encoding an object to NSDictionary
 */
@protocol PTPVNSDictionaryEncodable <NSObject>

/**
 * Encodes the object as an `NSDictionary`.
 */
- (nonnull NSDictionary *)toDictionary;

@end
