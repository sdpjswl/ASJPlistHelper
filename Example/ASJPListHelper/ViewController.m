//
//  ViewController.m
//  ASJPListHelper
//
//  Created by sudeep on 03/05/15.
//  Copyright (c) 2015 Sudeep Jaiswal. All rights reserved.
//

#import "ViewController.h"
#import "ASJPListHelper.h"

NSString *const kPListFileName = @"InRainbows";

@interface ViewController ()

- (void)checkInData;
- (void)updateExistingData;
- (void)showData;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self checkInData];
  [self updateExistingData];
  [self showData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - PList

- (void)checkInData {
  
  NSArray *array = @[@"15 Step",
                     @"Bodysnatchers",
                     @"Nude",
                     @"Weird Fishes/Arpeggi",
                     @"All I Need",
                     @"Faust Arp",
                     @"Reckoner",
                     @"House of Cards",
                     @"Jigsaw Falling Into Place",
                     @"Videotape"];
  ASJPListHelper *plist = [[ASJPListHelper alloc] init];
  BOOL success = [plist save:array inPListFileNamed:kPListFileName];
  if (success) {
    [ViewController showAlertWithTitle:@"Success!" message:@"Data successfully saved in PList."];
  }
  else {
    [ViewController showAlertWithTitle:@"Error" message:@"Data could not be saved."];
  }
}

- (void)updateExistingData {
  NSArray *array = @[@"Radiohead"];
  ASJPListHelper *plist = [[ASJPListHelper alloc] init];
  BOOL success = [plist update:array inPListFileNamed:kPListFileName];
  if (success) {
    [ViewController showAlertWithTitle:@"Success!" message:@"Data successfully updated in PList."];
  }
  else {
    [ViewController showAlertWithTitle:@"Error" message:@"Data could not be updated."];
  }
}

- (void)showData {
  ASJPListHelper *plist = [[ASJPListHelper alloc] init];
  NSArray *contents = [plist contentsOfPlistFileNamed:kPListFileName];
  NSLog(@"%@", contents);
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

@end
