//
//  ViewController.m
//  PListHelperDemo
//
//  Created by sudeep on 10/04/15.
//  Copyright (c) 2015 Sudeep Jaiswal. All rights reserved.
//

#import "ViewController.h"
#import "PListHelper.h"

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
    PListHelper *plist = [[PListHelper alloc] init];
    BOOL success = [plist checkIn:array inPListFileNamed:kPListFileName];
    if (success) {
        [ViewController showAlertWithTitle:@"Success!" message:@"Data successfully saved in PList."];
    }
    else {
        [ViewController showAlertWithTitle:@"Error" message:@"Data could not be saved."];
    }
}

- (void)updateExistingData {
    NSArray *array = @[@"Radiohead"];
    PListHelper *plist = [[PListHelper alloc] init];
    BOOL success = [plist updateExistingDataWith:array inPListFileNamed:kPListFileName];
    if (success) {
        [ViewController showAlertWithTitle:@"Success!" message:@"Data successfully updated in PList."];
    }
    else {
        [ViewController showAlertWithTitle:@"Error" message:@"Data could not be updated."];
    }
}

- (void)showData {
    PListHelper *plist = [[PListHelper alloc] init];
    NSArray *contents = [plist contentsOfPlistFileNamed:kPListFileName];
    NSLog(@"%@", contents);
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
