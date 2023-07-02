import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: ((context, AsyncSnapshot snapshot) {
          // snapshot ; notify state of future
          // snapshot.data ; result of future
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // ListView needs a height (if not, infinite)
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  // ListView ; when having many items & wants to optimize loading, creation, etc
  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    // runs itembuilder, builds when it is "needed"
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // have access on item with index
        var webtoon = snapshot.data[index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // seperates items
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
