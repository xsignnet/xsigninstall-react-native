import { NativeModules } from 'react-native';

type XsigninstallReactNativeType = {
  multiply(a: number, b: number): Promise<number>;
};

const { XsigninstallReactNative } = NativeModules;

export default XsigninstallReactNative as XsigninstallReactNativeType;
