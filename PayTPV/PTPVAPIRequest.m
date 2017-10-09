//
//  PTPVAPIRequest.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVAPIRequest.h"

#import "NSMutableURLRequest+PAYTPV.h"
#import "PTPVDispatchFunctions.h"
#import "PTPVAPIClient.h"
#import "PTPVAPIClient+Private.h"
#import "PTPVAPIResponseDecodable.h"
#import "PTPVError.h"

@implementation PTPVAPIRequest

static NSString * const HTTPMethodPOST = @"POST";

#pragma mark - POST

+ (NSURLSessionDataTask *)postWithAPIClient:(PTPVAPIClient *)apiClient
                                   endpoint:(NSString *)endpoint
                                 parameters:(NSDictionary *)parameters
                               deserializer:(id<PTPVAPIResponseDecodable>)deserializer
                                 completion:(PTPVAPIResponseBlock)completion {
    // Build url
    NSURL *url = [apiClient.apiURL URLByAppendingPathComponent:endpoint];

    // Setup request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = HTTPMethodPOST;
    [request ptpv_setJSONPayload:parameters];

    // Perform request
    NSURLSessionDataTask *task = [apiClient.urlSession dataTaskWithRequest:request completionHandler:^(NSData *body, NSURLResponse *response, NSError *error) {
        [[self class] parseResponse:response body:body error:error deserializer:deserializer completion:completion];
    }];
    [task resume];

    return task;
}

#pragma mark -

+ (void)parseResponse:(NSURLResponse *)response
                 body:(NSData *)body
                error:(NSError *)error
         deserializer:(id<PTPVAPIResponseDecodable>)deserializer
           completion:(PTPVAPIResponseBlock)completion {
    // Derive HTTP URL response
    NSHTTPURLResponse *httpResponse = nil;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        httpResponse = (NSHTTPURLResponse *)response;
    }

    // Wrap completion block with main thread dispatch
    void (^safeCompletion)(id<PTPVAPIResponseDecodable>, NSError *) = ^(id<PTPVAPIResponseDecodable> responseObject, NSError *responseError) {
        dispatchToMainThreadIfNecessary(^{
            completion(responseObject, httpResponse, responseError);
        });
    };

    if (error) {
        // Forward NSURLSession error
        return safeCompletion(nil, error);
    }

    // Parse JSON response body
    NSDictionary *jsonDictionary = nil;
    if (body) {
        jsonDictionary = [NSJSONSerialization JSONObjectWithData:body options:(NSJSONReadingOptions)kNilOptions error:NULL];
    }

    // Check if we have an error
    NSError *parsedError = [NSError ptpv_errorFromPAYTPVResponse:jsonDictionary];
    if (parsedError != nil) {
        return safeCompletion(nil, parsedError);
    }

    // Generate response object
    id<PTPVAPIResponseDecodable> responseObject = [[deserializer class] decodedObjectFromAPIResponse:jsonDictionary];

    if (!responseObject) {
        // Use generic error
        return safeCompletion(nil, [NSError ptpv_failedToParseError]);
    }

    return safeCompletion(responseObject, nil);
}

@end
