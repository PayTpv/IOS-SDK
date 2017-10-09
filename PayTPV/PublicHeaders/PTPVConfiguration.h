//
//  PTPVConfiguration.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 7/28/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVNSDictionaryEncodable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the configuration of the contracted product.
 
 You provide a PTPVConfiguration instance to the PTPVAPIClient which will use it when making api calls to PAYTPV.

 In order to use the PAYTPV payment gateway in your business, you must have the necessary configuration parameters. These can be obtained through the PAYTPV customer management platform at https://secure.paytpv.com/cp_control/

 Once inside the platform, the configuration of the contracted product can be reviewed through the menu My products -> Configure product.

 After clicking the "Edit" button of the chosen product, a screen will appear with the basic information of the product under the section "Technical configuration of the WEB POS". Specifically, the information required during the integration process is:

 Password

 Terminal number

 Customer code
 */
@interface PTPVConfiguration : NSObject<NSCopying, PTPVNSDictionaryEncodable>

/**
 A shared singleton configuration
 */
+ (instancetype)sharedConfiguration;

/**
 Creates a PTPVConfiguration

 @param merchantCode Customer code
 @param terminal Terminal number
 @param password Password
 @param jetId Identifier for JET encryption

 @return A PTPVConfiguration instance populated with the provided values
 */
- (instancetype)initWithMerchantCode:(NSString *)merchantCode
                            terminal:(NSString *)terminal
                            password:(NSString *)password
                               jetId:(NSString *)jetId;

/**
 Customer code
 */
@property (nonatomic, copy, readwrite) NSString *merchantCode;

/**
 Terminal number

 */
@property (nonatomic, copy, readwrite) NSString *terminal;

/**
 Password
 */
@property (nonatomic, copy, readwrite) NSString *password;

/**
 Identifier for JET encryption
 */
@property (nonatomic, copy, readwrite) NSString *jetId;

@end

NS_ASSUME_NONNULL_END
