//
//  PTPVRemoteIP.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/11/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVAPIResponseDecodable.h"

/**
 Represents the remote ip response
 */
@interface PTPVRemoteIP : NSObject<PTPVAPIResponseDecodable>

/**
 The remote ip of the client.
 */
@property (nonatomic, copy, nullable) NSString *remoteAddress;

@end
