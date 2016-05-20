//
//  ViewController.m
//  ASJPlistHelperExample
//
//  Created by sudeep on 20/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJPlistHelper.h"

static NSString *const kPlistFileName = @"sample";

@interface ViewController () {
  IBOutlet UITextField *inputTextField;
  IBOutlet UITextView *plistContentsTextView;
}

@property (strong, nonatomic) ASJPlistHelper *plistHelper;
@property (readonly, nonatomic) BOOL isInputValid;
@property (readonly, copy, nonatomic) NSString *trimmedInput;

- (void)setup;
- (IBAction)addTapped:(id)sender;
- (IBAction)updateTapped:(id)sender;
- (IBAction)deleteTapped:(id)sender;
- (void)refreshTextView;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

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
  _plistHelper = [[ASJPlistHelper alloc] initWithPlistNamed:kPlistFileName];
  [self refreshTextView];
  
  NSLog(@"%@", _plistHelper.plistPath);
}

- (void)refreshTextView
{
  inputTextField.text = nil;
  plistContentsTextView.text = [_plistHelper.plistContents description];
}

#pragma mark - IBActions

- (IBAction)addTapped:(id)sender
{
  if (!self.isInputValid) {
    return;
  }
  
  BOOL success = [_plistHelper save:self.trimmedInput];
  if (!success)
  {
    [self showAlertWithTitle:@"Error" message:@"Couldn't add data to plist."];
    return;
  }
  [self refreshTextView];
}

- (IBAction)updateTapped:(id)sender
{
  if (!self.isInputValid) {
    return;
  }
  
  BOOL success = [_plistHelper update:self.trimmedInput];
  if (!success)
  {
    [self showAlertWithTitle:@"Error" message:@"Couldn't update data in plist."];
    return;
  }
  [self refreshTextView];
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

- (IBAction)deleteTapped:(id)sender
{
  NSError *error = nil;
  BOOL success = [_plistHelper deletePlistWithError:&error];
  [self refreshTextView];
  
  if (!success || error)  {
    [self showAlertWithTitle:@"Error" message:error.localizedFailureReason];
  }
}

#pragma mark - Helpers

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:ok];
  
  [self presentViewController:alert animated:YES completion:nil];
}

@end
