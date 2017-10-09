//
//  PTPVResponse.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/8/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVResult.h"
#import "PTPVAPIResponseDecodable.h"

/**
 Represents a generic response
 */
@interface PTPVResponse : NSObject<PTPVAPIResponseDecodable>

/**
 Result of operation. 0 or empty will be erroneous operation and 1 operation completed.
 */
@property (nonatomic) PTPVResult result;

@end
