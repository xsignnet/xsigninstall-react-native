import { NativeModules } from 'react-native';

type XsigninstallReactNativeType = {
  multiply(a: number, b: number): Promise<number>;
  reportRegister():void;
  initWakeupHandler(block:(result:object)=>void):void;
  getInstallParams(block:(result:object)=>void):void;
};

const { XsigninstallReactNative } = NativeModules;

export default XsigninstallReactNative as XsigninstallReactNativeType;
