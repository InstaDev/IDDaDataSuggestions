//
//  IDDaDataViewController.m
//  IDDaDataSuggestions
//
//  Created by CocoaPods on 10/18/2014.
//  Copyright (c) 2014 InstaDev. All rights reserved.
//

#import "IDDaDataTableViewController.h"
#import <IDDaDataSuggestions/IDDaDataSuggestions.h>
#import "IDDaDataObjectTableViewController.h"


@interface IDDaDataTableViewController ()

@end

@implementation IDDaDataTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _suggestions = [NSArray new];
    
    [[IDDaDataSuggestions sharedInstance] setBaseURL:@"https://dadata.ru/api/v2/" apiKey:@""];
    
    failedRequest = ^(NSError *error) {
        UIAlertView *errorAlert =[[UIAlertView alloc] initWithTitle:@"Ошибка" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
        [errorAlert show];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)moduleChanged:(id)sender
{
    _currentModule = [(UISegmentedControl *)sender selectedSegmentIndex];
}


#pragma mark - SearchDisplayController Delegate

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    switch (_currentModule) {
        case 0:
        {
           // NSArray *restrictions = @[@{@"region" : @"Санкт-Петербург"}];
            NSArray *restrictions = nil;
            [[IDDaDataSuggestions sharedInstance] getAddressSuggestionsForString:searchString
                                                                    restrictions:restrictions
                                                         hideRestrictionInResult:YES
                                                                         success:^(NSArray *suggestions) {
                                                                             _suggestions = suggestions;
                                                                             [controller.searchResultsTableView reloadData];
                                                                         } failure:failedRequest];
        }
            break;
        case 1:
        {
            // NSArray *restrictions = @[@{@"kladr_id" : @"77"}];
            NSArray *restrictions = nil;
            // NSArray *statuses = @[@"ACTIVE"];
            NSArray *statuses = nil;

            [[IDDaDataSuggestions sharedInstance] getPartySuggestionsForString:searchString
                                                                  restrictions:restrictions
                                                                      statuses:statuses
                                                                          type:daDataPartyTypeBoth
                                                                       success:^(NSArray *suggestions) {
                                                                                     _suggestions = suggestions;
                                                                                     [controller.searchResultsTableView reloadData];
                                                                                }
                                                                       failure:failedRequest];
        }
            break;
        case 2:
        {
            //NSArray *parts = @[@"NAME", @"PATRONYMIC"];
            NSArray *parts = nil;
            [[IDDaDataSuggestions sharedInstance] getFioSuggestionsForString:searchString
                                                                       parts:parts
                                                                     success:^(NSArray *suggestions) {
                                                                             _suggestions = suggestions;
                                                                             [controller.searchResultsTableView reloadData];
                                                                         }
                                                                     failure:failedRequest];
        }
            break;
        default:
            break;
    }

    return YES;
}

#pragma mark - View cycle managment

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showObject"])
    {
        IDDaDataObjectTableViewController * vc = segue.destinationViewController;
        vc.object = _selectedSuggestion;
    }
}

#pragma mark - UITableView Dekegate and DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _suggestions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"suggestionCell";
    
    UITableViewCell *cell = [sender dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _suggestions[indexPath.row][@"value"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedSuggestion = _suggestions[indexPath.row];
    [self performSegueWithIdentifier:@"showObject" sender:self];
}

@end
