//
//  IDDaDataViewController.h
//  IDDaDataSuggestions
//
//  Created by CocoaPods on 10/18/2014.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDDaDataTableViewController : UITableViewController
{
    NSArray *_suggestions;
    NSDictionary *_selectedSuggestion;
    
    NSInteger _currentModule;
    
    void(^failedRequest)(NSError *error);
}

@end
