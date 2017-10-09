//
//  PTPVAPIResponseDecodable.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Protocol for decoding an NSDictionary to a concrete object
 */
@protocol PTPVAPIResponseDecodable <NSObject>

/**
 Decodes the given NSDictionary to a concrete object

 @param response An NSDictionary containing the response from the API
 @return A concrete object built from the response
 */
+ (nullable instancetype)decodedObjectFromAPIResponse:(nullable NSDictionary *)response;

/**
 Contains all the parameters received from the API
 */
@property(nonatomic, readonly, nonnull, copy)NSDictionary *originalResponse;

@end
