import 'package:bdk_dart/bdk_dart.dart' as bdk_dart;
import 'package:flutter/material.dart';

const phrase = 'good wealth glad trouble dignity hundred '
    'desk laptop edge museum practice neither';

void main() async {
  await bdk_dart.BdkDart.init();
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
                  future: bdk_dart.mnemonicPhraseToSeed(
                    req: const bdk_dart.PhraseToSeedReq(
                      phrase: phrase,
                      password: '',
                    ),
                  ),
                  builder: (context, snapshot) => Text(
                    'Seed: ${snapshot.data ?? snapshot.error ?? '- - -'}',
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
