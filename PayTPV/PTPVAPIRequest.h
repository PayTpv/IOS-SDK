//
//  PTPVAPIRequest.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVAPIResponseDecodable.h"

@class PTPVAPIClient;

@interface PTPVAPIRequest<__covariant ResponseType:id<PTPVAPIResponseDecodable>> : NSObject

typedef void(^PTPVAPIResponseBlock)(ResponseType object, NSHTTPURLResponse *response, NSError *error);

+ (NSURLSessionDataTask *)postWithAPIClient:(PTPVAPIClient *)apiClient
endpoint:(NSString *)endpoint
parameters:(NSDictionary *)parameters
deserializer:(id<PTPVAPIResponseDecodable>)deserializer
completion:(PTPVAPIResponseBlock)completion;

@end
