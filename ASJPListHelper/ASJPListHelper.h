//
//  ASJPListHelper.h
//  PList
//
//  Created by Sudeep Jaiswal on 12/08/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

@import Foundation;

@interface ASJPListHelper : NSObject

/**
 *  Will replace existing data in PList with provided data
 *
 *  @param data An array containing data to be replaced
 *  @param name Name of the PList file without extension
 *
 *  @return A bool indicating whether the operation was successful
 */
- (BOOL)checkIn:(NSArray *)data
inPListFileNamed:(NSString *)name;

/**
 *  Will append provided data to already existing data in the PList
 *
 *  @param data An array containing data to be added
 *  @param name Name of the PList file without extension
 *
 *  @return A bool indicating whether the operation was successful
 */
- (BOOL)updateExistingDataWith:(NSArray *)data
 inPListFileNamed:(NSString *)name;

/**
 *  Get contents of the provided PList file
 *
 *  @param name Name of the PList file without extension
 *
 *  @return An array of file contents
 */
- (NSArray *)contentsOfPlistFileNamed:(NSString *)name;

@end
