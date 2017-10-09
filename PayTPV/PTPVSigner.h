//
//  PTPVSigner.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTPVSigner : NSObject

+ (NSString *)sha1SignatureWithArray:(NSArray *)strings;
+ (NSString *)sha256SignatureWithArray:(NSArray *)strings;

@end

NS_ASSUME_NONNULL_END
