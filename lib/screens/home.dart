import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saca/models/Category.dart';
import 'package:saca/repositories/categoriesRepository.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = true;

  final GlobalKey<_HomeScreenState> expansionTile = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: CategoryRepository.getAll(),
        builder: (ctx, snp) {
          if (snp.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (ctx, i) => _buildPanel(snp.data),
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

  Widget _buildPanel(categories) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: categories.map<ExpansionPanel>((Category category) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(category.name),
              );
            },
            canTapOnHeader: true,
            isExpanded: _isExpanded,
            body: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: category.cards
                      .map((card) => Image.memory(base64Decode(card.base64)))
                      .toList(),
                      ),
            )
            // body: GridView.builder(
            //   padding: const EdgeInsets.all(10),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 3 / 2,
            //     mainAxisSpacing: 10,
            //     crossAxisSpacing: 10,
            //   ),
            //   itemCount: item.cards.length,
            //   itemBuilder: (ctx, i) {
            //     return Text(item.cards[i].name);
            //   },
            // )
            );
      }).toList(),
    );
  }
}
