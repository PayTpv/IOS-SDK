//
//  Models.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "Models.h"

@implementation Card

#pragma mark - Inits

- (instancetype)initWithIdUser:(NSString *)idUser
                     tokenUser:(NSString *)tokenUser
                          name:(NSString *)name {
    self = [super init];
    if (self) {
        _idUser = idUser;
        _tokenUser = tokenUser;
        _name = name;
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithIdUser:[aDecoder decodeObjectForKey:@"id"]
                      tokenUser:[aDecoder decodeObjectForKey:@"token"]
                           name:[aDecoder decodeObjectForKey:@"name"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_idUser forKey:@"id"];
    [aCoder encodeObject:_tokenUser forKey:@"token"];
    [aCoder encodeObject:_name forKey:@"name"];
}

#pragma mark - Equatable

- (BOOL)isEqual:(id)object {
    return [_idUser isEqual:[object idUser]] &&
    [_tokenUser isEqual:[object tokenUser]] &&
    [_name isEqual:[object name]];
}

@end


@implementation Purchase

#pragma mark - Inits

- (instancetype)initWithOrder:(NSString *)order
                     authCode:(NSString *)authCode
                     currency:(PTPVCurrency *)currency
                         card:(Card *)card {
    self = [super init];
    if (self) {
        _order = order;
        _authCode = authCode;
        _currency = currency;
        _card = card;
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithOrder:[aDecoder decodeObjectForKey:@"order"]
                      authCode:[aDecoder decodeObjectForKey:@"authCode"]
                      currency:[aDecoder decodeObjectForKey:@"currency"]
                          card:[aDecoder decodeObjectForKey:@"card"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_order forKey:@"order"];
    [aCoder encodeObject:_authCode forKey:@"authCode"];
    [aCoder encodeObject:_currency forKey:@"currency"];
    [aCoder encodeObject:_card forKey:@"card"];
}

#pragma mark - Equatable

- (BOOL)isEqual:(id)object {
    return [_order isEqual:[object order]] &&
    [_authCode isEqual:[object authCode]] &&
    [_currency isEqual:[object currency]] &&
    [_card isEqual:[object card]];
}

@end


@implementation Product

#pragma mark - Inits

- (instancetype)initWithName:(NSString *)name
                       price:(NSNumber *)price
                    currency:(PTPVCurrency *)currency {
    self = [super init];
    if (self) {
        _name = name;
        _price = price;
        _currency = currency;
    }
    return self;
}

@end
