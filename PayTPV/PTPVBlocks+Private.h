//
//  PTPVBlocks+Private.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/11/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

@class PTPVRemoteIP;

/**
 A callback that will be run with the remote ip response from the API.

 @param response The remote ip from the response
 @param error The error returned from the response
 */
typedef void (^PTPVRemoteIPCompletionBlock)(PTPVRemoteIP * __nullable response, NSError * __nullable error);
