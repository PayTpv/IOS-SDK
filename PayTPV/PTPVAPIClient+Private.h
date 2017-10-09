//
//  PTPVAPIClient+Private.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVBlocks+Private.h"

#import "PTPVRemoteIP.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTPVAPIClient ()

@property (nonatomic, strong, readwrite) NSURL *apiURL;
@property (nonatomic, strong, readwrite) NSURLSession *urlSession;

@end

@interface PTPVAPIClient (Other)

- (void)remoteIPWithCompletion:(PTPVRemoteIPCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
