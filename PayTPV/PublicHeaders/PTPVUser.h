//
//  PTPVUser.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/8/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVNSDictionaryEncodable.h"
#import "PTPVAPIResponseDecodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the user registered in the system
 */
@interface PTPVUser : NSObject<PTPVNSDictionaryEncodable, PTPVAPIResponseDecodable>

/**
 Creates a PTPVUser

 @param idUser Unique identifier of the user registered in the system
 @param tokenUser Token code associated with the `DS_IDUSER`

 @return A PTPVUser instance populated with the provided values
 */
- (instancetype)initWithIdUser:(NSString *)idUser
                     tokenUser:(NSString *)tokenUser;

/**
 Unique identifier of the user registered in the system
 */
@property (nonatomic, copy, nullable) NSString *idUser;

/**
 Token code associated with the `DS_IDUSER`
 */
@property (nonatomic, copy, nullable) NSString *tokenUser;

@end

NS_ASSUME_NONNULL_END
