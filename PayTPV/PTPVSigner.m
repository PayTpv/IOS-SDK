//
//  PTPVSigner.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "PTPVSigner.h"

@implementation PTPVSigner

+ (NSString *)sha1SignatureWithArray:(NSArray *)strings {
    if (!strings.count) return @"";

    NSString *unionString = [strings componentsJoinedByString:@""];
    NSData *data = [unionString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

+ (NSString *)sha256SignatureWithArray:(NSArray *)strings {
    if (!strings.count) return @"";

    NSString *unionString = [strings componentsJoinedByString:@""];
    NSData *data = [unionString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

@end
