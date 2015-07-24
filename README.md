ASJPListHelper
==============

Property lists are everywhere in Objective-C. This utility class attempts to simplify working with them. I have added the basic functionality needed to save and retreive data from them.

```
- (BOOL)checkIn:(NSArray *)data inPListFileNamed:(NSString *)name;
```

Saves data you provide in a a plist of the specified name. This method **will overwrite** any previous data present in the plist so be careful! Returns YES if saving is successful.

```
- (BOOL)updateExistingDataWith:(NSArray *)data inPListFileNamed:(NSString *)name;
```

Similar to `checkIn`, you have to provide the data and the name of you plist. This method **will not overwrite** previous data present in the file and append new data after it. Returns YES if saving is successful.

```
- (NSArray *)contentsOfPlistFileNamed:(NSString *)name;
```

Returns the data saved in the plist of the name specified.

# License

ASJPListHelper is available under the MIT license. See the LICENSE file for more info.
