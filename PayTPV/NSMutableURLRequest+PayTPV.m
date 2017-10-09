//
//  NSMutableURLRequest+PAYTPV.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "NSMutableURLRequest+PAYTPV.h"

@implementation NSMutableURLRequest (PAYTPV)

- (void)ptpv_setJSONPayload:(NSDictionary *)jsonPayload {
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonPayload options:0 error:nil];
    self.HTTPBody = data;
    [self setValue:[NSString stringWithFormat:@"%lu", (unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

@end
