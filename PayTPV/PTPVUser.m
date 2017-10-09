//
//  PTPVUser.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/8/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVUser.h"

@interface PTPVUser()
@property (nonatomic, readwrite, nonnull, copy) NSDictionary *originalResponse;
@end

@implementation PTPVUser

- (instancetype)initWithIdUser:(NSString *)idUser
                     tokenUser:(NSString *)tokenUser {
    self = [super init];
    if (self) {
        _idUser = idUser;
        _tokenUser = tokenUser;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description {
    NSArray *props = @[
                       [NSString stringWithFormat:@"%@: %p", NSStringFromClass([self class]), self],
                       [NSString stringWithFormat:@"idUser = %@", self.idUser],
                       [NSString stringWithFormat:@"tokenUser = %@", self.tokenUser],
                       ];

    return [NSString stringWithFormat:@"<%@>", [props componentsJoinedByString:@"; "]];
}

#pragma mark - PTPVNSDictionaryEncodable

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"DS_IDUSER"] = self.idUser;
    dict[@"DS_TOKEN_USER"] = self.tokenUser;
    return dict;
}

#pragma mark - PTPVAPIResponseDecodable

+ (instancetype)decodedObjectFromAPIResponse:(NSDictionary *)response {
    PTPVUser *res = [self new];
    res.idUser = [response[@"DS_IDUSER"] stringValue];
    res.tokenUser = [response[@"DS_TOKEN_USER"] stringValue];

    res.originalResponse = response;

    return res;
}

@end
