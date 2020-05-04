import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:saca/settings.dart';

import 'package:saca/stores/app.store.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/repositories/category.repository.dart';
import 'package:saca/view-models/category.viewmodel.dart';

class HomeView extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _store = AppStore();

  FlutterTts flutterTts = new FlutterTts();
  bool isPlaying = false;

  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => isPlaying = true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => isPlaying = false);
  }

  void configTts() async {
    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setVoice('pt-br-x-afs-local');
    await flutterTts.setSharedInstance(true);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  @override
  void initState() {
    super.initState();
    configTts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: CategoryRepository.getAll(),
        builder: (ctx, snp) {
          if (snp.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (ctx, i) => _buildPanel(snp.data, _store),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPanel(List<Category> categories, AppStore store) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {},
      children: categories.map<ExpansionPanel>((Category category) {
        var categoryVM = CategoryViewModel.fromCategory(category);

        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(category.name),
            );
          },
          canTapOnHeader: true,
          isExpanded: categoryVM.isExpanded,
          body: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            spacing: 20,
            runSpacing: 20,
            children: category.images.map((image) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: GestureDetector(
                  onTap: () => _speak(image.name),
                  child: Column(
                    children: <Widget>[
                      Image.network('$CLOUDINARY_URL/${image.url}'),
                      Text('${image.name}')
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
