
# react-native-iterable

## Getting started

`$ npm install react-native-iterable --save`

### Mostly automatic installation

`$ react-native link react-native-iterable`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-iterable` and add `RNIterable.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNIterable.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.krazylabs.RNIterablePackage;` to the imports at the top of the file
  - Add `new RNIterablePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-iterable'
  	project(':react-native-iterable').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-iterable/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-iterable')
  	```


## Usage
```javascript
import RNIterable from 'react-native-iterable';

// TODO: What to do with the module?
RNIterable;
```
  