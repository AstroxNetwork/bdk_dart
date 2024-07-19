import 'package:bdk_dart/bdk_dart.dart';
import 'package:flutter/material.dart';

const _testAddress =
    'bc1pkwq3mzjnfm6p5xmuz5g5v99cmarhxczruu0gd4fqw5fpj2x2p8lq3vau60';

void main() async {
  await BdkDart.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                FutureBuilder(
                  future: Address.create(address: _testAddress),
                  builder: (context, snapshot) => Text(
                    'Address: ${snapshot.data ?? snapshot.error ?? '- - -'}',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
