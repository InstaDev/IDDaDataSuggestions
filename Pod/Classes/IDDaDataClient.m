//
//  IDDaDataClient.m
//  Taxi
//
//  Created by Nikolay Sotskiy on 18/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import "IDDaDataClient.h"
#import <objc/runtime.h>

static char kDaDataOperationDelegateObjectKey;

@implementation IDDaDataClient

- (id)init
{
    self = [super init];
    if (self) {
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

- (void) setBaseURL:(NSString *)url apiKey:(NSString *)apiKey
{
    _baseUrl = url;
    [_operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Token %@", apiKey] forHTTPHeaderField:@"Authorization"];
}

/** Makes request, maps list of operations to given delegate;
 *
 * @param path Relative url
 * @param delegate Delegate
 * @param parameters GET-params
 * @param success Completion block
 * @param failure Failure block
 */
- (void)getPath:(NSString *)path delegate:(id)delegate parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperation *operation = [_operationManager POST:[_baseUrl stringByAppendingString:path]
                                                    parameters:parameters
                                                       success:success
                                                       failure:failure];
    
    objc_setAssociatedObject(operation, &kDaDataOperationDelegateObjectKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

/** Cancels all operations associated with delegate
 *
 * @param delegate Delegate
 */
- (void)cancelAllOperationsForDelegate:(id)delegate
{
    for (NSOperation *operation in [_operationManager.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        BOOL match = (id)objc_getAssociatedObject(operation, &kDaDataOperationDelegateObjectKey) == delegate;
        
        if (match) {
            [operation cancel];
        }
    }
}

@end
