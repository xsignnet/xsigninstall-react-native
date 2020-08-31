import * as React from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import XsigninstallReactNative from 'xsigninstall-react-native';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  React.useEffect(() => {
    XsigninstallReactNative.multiply(90, 9).then(setResult);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <Button title="reportRegister" 
      onPress={()=>XsigninstallReactNative.reportRegister()} 
      />
            <Button title="getWakeupParams" 
      onPress={()=>XsigninstallReactNative.initWakeupHandler((s)=>{console.log(s.abcWakeup)})} 
      />
            <Button title="getInstallParams" 
      onPress={()=>XsigninstallReactNative.getInstallParams((s)=>{console.log(JSON.stringify(s))})} 
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
