//
//  PTPVSignerTest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTPVSigner.h"

@interface PTPVSignerTest : XCTestCase

@end

@implementation PTPVSignerTest

- (void)testSHA1Signature {
    NSDictionary *tests = @{
                            @[@"a", @"b", @"c"]: @"a9993e364706816aba3e25717850c26c9cd0d89d",
                            @[@"abc", @"def", @"ghi"]: @"c63b19f1e4c8b5f76b25c49b8b87f57d8e4872a1",
                            };

    [tests enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *signature = [PTPVSigner sha1SignatureWithArray:key];
        XCTAssertEqualObjects(obj, signature);
    }];
}

- (void)testSHA256Signature {
    NSDictionary *tests = @{
                            @[@"a", @"b", @"c"]: @"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
                            @[@"abc", @"def", @"ghi"]: @"19cc02f26df43cc571bc9ed7b0c4d29224a3ec229529221725ef76d021c8326f",
                            };

    [tests enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *signature = [PTPVSigner sha256SignatureWithArray:key];
        XCTAssertEqualObjects(obj, signature);
    }];
}

@end
