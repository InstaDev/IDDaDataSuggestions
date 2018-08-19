//
//  IDDaDataSuggest.h
//  IDDaDataSuggestions
//
//  Created by Nikolay Sotskiy on 18/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

@import Foundation;
#import <AFNetworking/AFNetworking.h>
#import "IDDaDataClient.h"

enum daDataSuggestionType
{
    daDataSuggestionTypeAddress,
    daDataSuggestionTypeParty,
    daDataSuggestionTypeFio
};

enum daDataPartyType
{
    daDataPartyTypeBoth,
    daDataPartyTypeLegal,
    daDataPartyTypeIndividual
};

@interface IDDaDataSuggestions : NSObject

+ (id) sharedInstance;

- (void) setBaseURL:(NSString *)url apiKey:(NSString *)apiKey;

- (void) getAddressSuggestionsForString: (NSString *) searchString
                                success: (void (^)(NSArray * suggestions)) successBlock
                                failure: (void (^)(NSError* error)) failureBlock;

- (void) getAddressSuggestionsForString: (NSString *) searchString
                           restrictions: (NSArray *) restrictions
                hideRestrictionInResult: (BOOL) restrict_value
                                  count: (NSUInteger)count
                                success: (void (^)(NSArray * suggestions)) successBlock
                                failure: (void (^)(NSError* error)) failureBlock;

- (void) getAddressSuggestionsForString: (NSString *) searchString
                           restrictions: (NSArray *) restrictions
                hideRestrictionInResult: (BOOL) restrict_value
                                  count: (NSUInteger)count
                                  owner: (id) owner
                                success: (void (^)(NSArray * suggestions)) successBlock
                                failure: (void (^)(NSError* error)) failureBlock;

- (void) getPartySuggestionsForString: (NSString *) searchString
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock;

- (void) getPartySuggestionsForString: (NSString *) searchString
                         restrictions: (NSArray *) restrictions
                             statuses: (NSArray *) statuses
                                 type: (enum daDataPartyType) partyType
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock;

- (void) getPartySuggestionsForString: (NSString *) searchString
                         restrictions: (NSArray *) restrictions
                             statuses: (NSArray *) statuses
                                 type: (enum daDataPartyType) partyType
                                owner: (id) owner
                              success: (void (^)(NSArray * suggestions)) successBlock
                              failure: (void (^)(NSError* error)) failureBlock;

- (void) getFioSuggestionsForString: (NSString *) searchString
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock;

- (void) getFioSuggestionsForString: (NSString *) searchString
                              parts: (NSArray *) parts
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock;

- (void) getFioSuggestionsForString: (NSString *) searchString
                              parts: (NSArray *) parts
                              owner: (id) owner
                            success: (void (^)(NSArray * suggestions)) successBlock
                            failure: (void (^)(NSError* error)) failureBlock;

@end
