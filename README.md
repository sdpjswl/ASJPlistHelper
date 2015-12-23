# ASJPListHelper

Property lists are everywhere in Objective-C. This utility class attempts to simplify working with them. I have added the basic functionality needed to save and retreive data from them.

# Installation (Coming soon)

Cocoapods is the preferred way to install this library. Add this command to your `Podfile`:

```
pod 'ASJPListHelper'
```

# Usage

```
- (BOOL)save:(NSArray *)data inPListFileNamed:(NSString *)name;
```

Saves data you provide in a a plist of the specified name. This method **will overwrite** any previous data present in the plist so be careful! Returns YES if saving is successful.

```
- (BOOL)update:(NSArray *)data inPListFileNamed:(NSString *)name;
```

Similar to `save`, you have to provide the data and the name of you plist. This method **will not overwrite** previous data present in the file and append new data after it. Returns YES if saving is successful.

```
- (NSArray *)contentsOfPlistFileNamed:(NSString *)name;
```

Returns the data saved in the plist of the name specified.

### To-do

- Add UI to example project
- Refactor code and make it podworthy
- Look up NSPropertyListSerialization
- Allow `id` to be sent to save/update

# License

ASJPListHelper is available under the MIT license. See the LICENSE file for more info.
