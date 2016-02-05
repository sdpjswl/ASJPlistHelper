//
//  ViewController.m
//  ASJPListHelper
//
//  Created by sudeep on 03/05/15.
//  Copyright (c) 2015 Sudeep Jaiswal. All rights reserved.
//

#import "ViewController.h"
#import "ASJPListHelper.h"

static NSString *const kPListFileName = @"sample";
static NSString *const kCellIdentifier = @"cell";

@interface ViewController () <UITableViewDataSource> {
  IBOutlet UITextField *inputTextField;
  IBOutlet UITableView *plistTableView;
}

@property (strong, nonatomic) ASJPListHelper *plistHelper;
@property (copy, nonatomic) id plistContents;
@property (readonly, nonatomic) BOOL isInputValid;
@property (readonly, copy, nonatomic) NSString *trimmedInput;

- (void)setup;
- (IBAction)addTapped:(id)sender;
- (IBAction)updateTapped:(id)sender;
- (void)reloadTable;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setup];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup
{
  _plistHelper = [[ASJPListHelper alloc] initWithPListFileNamed:kPListFileName];
  _plistContents = _plistHelper.pListContents;
  NSLog(@"%@", _plistHelper.pListPath);
  
  Class cellClass = [UITableViewCell class];
  [plistTableView registerClass:cellClass forCellReuseIdentifier:kCellIdentifier];
}

- (void)reloadTable
{
  [[NSOperationQueue mainQueue] addOperationWithBlock:^
  {
    _plistContents = _plistHelper.pListContents;
    [plistTableView reloadData];
  }];
}

#pragma mark - IBActions

- (IBAction)addTapped:(id)sender
{
  if (!self.isInputValid) {
    return;
  }
  [_plistHelper save:self.trimmedInput];
  [self reloadTable];
}

- (IBAction)updateTapped:(id)sender
{
  if (!self.isInputValid) {
    return;
  }
  [_plistHelper update:self.trimmedInput];
  [self reloadTable];
}

- (BOOL)isInputValid
{
  if (self.trimmedInput.length) {
    return YES;
  }
  return NO;
}

- (NSString *)trimmedInput
{
  NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  return [inputTextField.text stringByTrimmingCharactersInSet:characterSet];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_plistHelper.pListContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  
  id object = nil;
  if ([_plistContents isKindOfClass:[NSArray class]])
  {
    object = [_plistContents objectAtIndex:indexPath.row];
  }
  else
  {
    NSArray *keys = [object allKeys];
    object = [_plistContents objectForKey:keys[indexPath.row]];
  }
  
  cell.textLabel.text = object;
  return cell;
}

#pragma mark - Helpers

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

@end
