//
//  NSMutableURLRequest+PAYTPV.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (PAYTPV)

- (void)ptpv_setJSONPayload:(NSDictionary *)jsonPayload;

@end
