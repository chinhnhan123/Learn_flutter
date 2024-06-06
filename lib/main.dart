import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        home: RandomWords(),
        theme: ThemeData(primaryColor: Colors.red));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _words = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            return const Divider();
          }
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index]);
        }),
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 18.0),
        ),
        trailing: Icon(
          alreadySaved ? Icons.add_a_photo : Icons.add_a_photo_outlined,
          color: alreadySaved ? Colors.tealAccent : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: const TextStyle(fontSize: 16.0),
            ),
          );
        });

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved WordPairs'),
          ),
          body: ListView(children: tiles.toList()),
        );
      }),
    );
  }
}
