//
//  IDDaDataObjectTableViewController.m
//  IDDaDataSuggestions
//
//  Created by CocoaPods on 19/10/14.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import "IDDaDataObjectTableViewController.h"

@interface IDDaDataObjectTableViewController ()

@end

@implementation IDDaDataObjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _objectKeys = [NSMutableArray new];
    _objectValues = [NSMutableArray new];
    
    
    [(_object[@"data"]) ? _object[@"data"] : _object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj != [NSNull null])
        {
            [_objectKeys addObject:key];
            [_objectValues addObject:obj];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _objectKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if ([_objectValues[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *object = _objectValues[indexPath.row];
        if (![object objectForKey:@"value"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"objectCell" forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"objectData" forIndexPath:indexPath];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"objectData" forIndexPath:indexPath];
    }


    NSString *key = _objectKeys[indexPath.row];
    if ([_objectValues[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *object = _objectValues[indexPath.row];
        if ([object objectForKey:@"value"]) {
            cell.detailTextLabel.text = [object objectForKey:@"value"];
        }
    } else if ([_objectValues[indexPath.row] isKindOfClass:[NSNumber class]]) {
        cell.detailTextLabel.text = [(NSNumber *)_objectValues[indexPath.row] stringValue];
    } else {
        cell.detailTextLabel.text = _objectValues[indexPath.row];
    }
    cell.textLabel.text = key;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_objectValues[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *object = _objectValues[indexPath.row];
        if (![object objectForKey:@"value"]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
            IDDaDataObjectTableViewController *dest = [storyboard instantiateViewControllerWithIdentifier:@"objectController"];
            dest.object = object;
            [self.navigationController pushViewController:dest animated:YES];
        }
    }

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
