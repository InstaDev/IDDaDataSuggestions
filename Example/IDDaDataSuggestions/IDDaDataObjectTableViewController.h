//
//  IDDaDataObjectTableViewController.h
//  IDDaDataSuggestions
//
//  Created by CocoaPods on 19/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDDaDataObjectTableViewController : UITableViewController
{
    NSMutableArray *_objectKeys;
    NSMutableArray *_objectValues;
}

@property (nonatomic, retain) NSDictionary *object;

@end
