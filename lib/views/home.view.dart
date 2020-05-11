import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:saca/controllers/categories.controller.dart';
import 'package:saca/services/tts.service.dart';
import 'package:saca/settings.dart';

import 'package:saca/stores/user.store.dart';
import 'package:saca/stores/category.store.dart';

import 'Images/create.view.dart';

class HomeView extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ttsService = TtsService();
  final categoriesController = CategoriesController();

  @override
  void initState() {
    super.initState();
    CategoriesController().getAllAsync(context);
  }

  @override
  Widget build(BuildContext context) {
    var _userStore = Provider.of<UserStore>(context, listen: false);
    var _categoryStore = Provider.of<CategoryStore>(context, listen: false);

    return Scaffold(
      body: Observer(builder: (_) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => categoriesController.getAllAsync(context),
            child: SingleChildScrollView(
              child: categoriesController.categories(context) == null
                  ? Center(child: CircularProgressIndicator())
                  : ExpansionPanelList(
                      expansionCallback: (index, isExpanded) {
                        categoriesController.toggleExpanded(
                            context, index, isExpanded);
                      },
                      children: _categoryStore.categories
                          .map<ExpansionPanel>(
                            (category) => ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(category.name),
                                );
                              },
                              canTapOnHeader: true,
                              isExpanded: category.isExpanded,
                              body: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: 20,
                                runSpacing: 20,
                                children: category.images.map((image) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: GestureDetector(
                                      onTap: () => ttsService.speak(image.name),
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                              '$CLOUDINARY_URL/${image.url}'),
                                          Text('${image.name}')
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        );
      }),
      floatingActionButton: _userStore.isAuthenticated
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CreateImage.routeName),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryTextTheme.title.color,
              ),
            )
          : null,
    );
  }
}
// child: FutureBuilder(
//   future: CategoryRepository.getAll(),
//   builder: (ctx, snp) {
//     if (snp.hasData) {
//       return ListView.builder(
//         itemCount: 1,
//         itemBuilder: (ctx, i) => _buildPanel(snp.data, _userStore),
//       );
//     } else {
//       return Container(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//   },
// ),
