//
//  IDDaDataSuggest.m
//  Taxi
//
//  Created by Nikolay Sotskiy on 18/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import "IDDaDataSuggestions.h"



@interface IDDaDataSuggestions ()

@property(readonly, strong) IDDaDataClient* client;

@end

@implementation IDDaDataSuggestions

@synthesize client = _client;

/** Singleton
 *
 * @return id
 */
+ (id) sharedInstance
{
    static IDDaDataSuggestions* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(
                  &onceToken, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
    return sharedInstance;
}

- (id) init
{
    if (self = [super init])
    {
        _client = [[IDDaDataClient alloc] init];
    }
    return self;
}

- (void) setBaseURL:(NSString *)url apiKey:(NSString *)apiKey
{
    [_client setBaseURL:url apiKey:apiKey];
}

- (void) getAddressSuggestionsForString: (NSString *) searchString
                         success: (void (^)(NSArray * suggestions)) successBlock
                         failure: (void (^)(NSError* error)) failureBlock
{
    [self getAddressSuggestionsForString:searchString restrictions:nil hideRestrictionInResult:NO owner:nil success:successBlock failure:failureBlock];
}

- (void) getAddressSuggestionsForString: (NSString *) searchString
                    restrictions: (NSArray *) restrictions
         hideRestrictionInResult: (BOOL) restrict_value
                         success: (void (^)(NSArray * suggestions)) successBlock
                         failure: (void (^)(NSError* error)) failureBlock
{
    [self getAddressSuggestionsForString:searchString restrictions:restrictions hideRestrictionInResult:restrict_value owner:nil success:successBlock failure:failureBlock];
}

- (void) getAddressSuggestionsForString: (NSString *) searchString
                    restrictions: (NSArray *) restrictions
         hideRestrictionInResult: (BOOL) restrict_value
                           owner: (id) owner
                         success: (void (^)(NSArray * suggestions)) successBlock
                         failure: (void (^)(NSError* error)) failureBlock
{
    NSMutableDictionary* params = [@{@"query" : searchString} mutableCopy];
    
    if (restrictions) {
        [params setObject:restrictions forKey:@"locations"];
        [params setObject:restrict_value ? @"true" : @"false" forKey:@"restrict_value"];
    }
    
    [[IDDaDataSuggestions sharedInstance] makeSuggestionRequestType:daDataSuggestionTypeAddress params:params success:^(AFHTTPRequestOperation *operation, id responseObject, NSArray *suggestions) {
        successBlock(suggestions);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    } owner:owner];
}

- (void) getPartySuggestionsForString: (NSString *) searchString
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock
{
    [self getPartySuggestionsForString:searchString restrictions:nil statuses:nil type:daDataPartyTypeBoth success:successBlock failure:failureBlock];
}

- (void) getPartySuggestionsForString: (NSString *) searchString
                         restrictions: (NSArray *) restrictions
                             statuses: (NSArray *) statuses
                                 type: (enum daDataPartyType) partyType
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock
{
    [self getPartySuggestionsForString:searchString restrictions:restrictions statuses:statuses type:partyType owner:nil success:successBlock failure:failureBlock];
}

- (void) getPartySuggestionsForString: (NSString *) searchString
                         restrictions: (NSArray *) restrictions
                             statuses: (NSArray *) statuses
                                 type: (enum daDataPartyType) partyType
                                owner: (id) owner
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock
{
    NSMutableDictionary* params = [@{@"query" : searchString} mutableCopy];
    
    if (restrictions) {
        [params setObject:restrictions forKey:@"locations"];
    }
    
    if (statuses) {
        [params setObject:statuses forKey:@"status"];
    }
    
    switch (partyType) {
        case daDataPartyTypeLegal:
            [params setObject:@"LEGAL" forKey:@"type"];
            break;
        case daDataPartyTypeIndividual:
            [params setObject:@"INDIVIDUAL" forKey:@"type"];
            break;
        default:
            break;
    }
    
    [[IDDaDataSuggestions sharedInstance] makeSuggestionRequestType:daDataSuggestionTypeParty params:params success:^(AFHTTPRequestOperation *operation, id responseObject, NSArray *suggestions) {
        successBlock(suggestions);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    } owner:owner];
}

- (void) getFioSuggestionsForString: (NSString *) searchString
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock
{
    [self getFioSuggestionsForString:searchString parts:nil owner:nil success:successBlock failure:failureBlock];
}

- (void) getFioSuggestionsForString: (NSString *) searchString
                              parts: (NSArray *) parts
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock
{
    [self getFioSuggestionsForString:searchString parts:parts owner:nil success:successBlock failure:failureBlock];
}

- (void) getFioSuggestionsForString: (NSString *) searchString
                              parts: (NSArray *) parts
                              owner: (id) owner
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock
{
    NSMutableDictionary* params = [@{@"query" : searchString} mutableCopy];
    
    if (parts) {
        [params setObject:parts forKey:@"parts"];
    }
    
    [[IDDaDataSuggestions sharedInstance] makeSuggestionRequestType:daDataSuggestionTypeFio params:params success:^(AFHTTPRequestOperation *operation, id responseObject, NSArray *suggestions) {
        successBlock(suggestions);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    } owner:owner];
}

#pragma mark - Helpers

- (void) makeSuggestionRequestType: (enum daDataSuggestionType) requestType
                            params: (NSMutableDictionary*) params
                           success: (void (^)(AFHTTPRequestOperation* operation, id responseObject, NSArray* suggestions)) success
                           failure: (void (^)(AFHTTPRequestOperation* operation, NSError* error)) failure
                             owner: (id) owner
{
    NSString *apiPath = @"";
    switch (requestType) {
        case daDataSuggestionTypeAddress:
            apiPath = @"suggest/address";
            break;
        case daDataSuggestionTypeParty:
            apiPath = @"suggest/party";
            break;
        case daDataSuggestionTypeFio:
            apiPath = @"suggest/fio";
            break;
    }
    
    [self.client getPath: apiPath delegate: owner parameters: params
                 success: ^(AFHTTPRequestOperation* operation, id responseObject)
     {
         NSArray* suggestions = responseObject[@"suggestions"];
         if (suggestions.count > 0)
         {
             success(operation, responseObject, suggestions);
         }
         else
         {
             failure(operation, [NSError errorWithDomain: @"com.dadata.suggestions" code: 404
                                                userInfo: @{@"error" : @"Can't find suggestions"}]);
         }
     } failure: ^(AFHTTPRequestOperation* operation, NSError* error)
     {
         failure(operation, error);
     }];
}
                    
/** Cancels all requests associated with given delegate
 *
 */
- (void) cancelAllRequestsForDelegate: (id) delegate
{
    [self.client cancelAllOperationsForDelegate: delegate];
}


@end
