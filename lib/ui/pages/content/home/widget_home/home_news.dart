import 'package:app_majpr_new/data/services_data/article_pool.dart';
import 'package:app_majpr_new/domain/models/article_model.dart';
import 'package:flutter/material.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticlePoolService service = ArticlePoolService();
    Future<List<ArticleModel>> futureArticles = service.fecthData();
    return FutureBuilder<List<ArticleModel>>(
      future: futureArticles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              ArticleModel article = items[index];
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      article.thumbnail,
                      width: 160,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Titulo: ${article.title}"),
                        Text(article.byline),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("abstract: ${article.abstract}"),
                        Text("tipo: ${article.itemType}"),
                        Text("sub-seccion: ${article.subsection}"),
                        Text(
                            "Fecha de publicacion: ${article.publishedDate.toString()}"),
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
