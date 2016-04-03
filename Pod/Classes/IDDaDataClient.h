//
//  IDDaDataClient.h
//  IDDaDataSuggestions
//
//  Created by Nikolay Sotskiy on 18/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

@import Foundation;
#import <AFNetworking/AFNetworking.h>


@interface IDDaDataClient : NSObject
{
    AFHTTPRequestOperationManager *_operationManager;
    NSString *_baseUrl;
}

- (id)init;

- (void) setBaseURL:(NSString *)url apiKey:(NSString *)apiKey;

- (void)getPath:(NSString *)path delegate:(id)delegate parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

- (void)cancelAllOperationsForDelegate:(id)delegate;

@end
