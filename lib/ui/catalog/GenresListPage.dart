import 'package:flutter/material.dart';
import 'BooksListGenresPage.dart';

class GenresListPage extends StatefulWidget {
  const GenresListPage({super.key});

  @override
  State<GenresListPage> createState() => _MyGenresListPage();
}

class _MyGenresListPage extends State<GenresListPage> {

  final List<String> listofGenres = [
    "Children's Fiction",
    "Children's Non-fiction",
    "Action & Adventure Fiction",
    "Classics (Greek & Latin Antiquity)",
    "Crime & Mystery Fiction",
    "Dramatic Readings",
    "Epistolary Fiction",
    "Erotica",
    "Travel Fiction",
    "Family Life",
    "Fantastic Fiction",
    "Fictional Biographies & Memoirs",
    "General Fiction",
    "Historical Fiction",
    "Humorous Fiction",
    "Literary Fiction",
    "Nature & Animal Fiction",
    "Nautical & Marine Fiction",
    "Plays",
    "Poetry",
    "Religious Fiction",
    "Romance",
    "Sagas",
    "Satire",
    "Short Stories",
    "Sports Fiction",
    "Suspense, Espionage, Political & Thrillers",
    "War & Military Fiction",
    "Westerns",
    "*Non-fiction"
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Genres", textAlign: TextAlign.center,),
        leading: GestureDetector(
            child: const BackButton(),
            onTap: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: ListView.builder(
            itemCount: listofGenres.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                            builder: (context) => BooksListGenresPage(bookGenre: listofGenres[index])
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const ContinuousRectangleBorder(),
                    //backgroundColor: Colors.grey.shade50,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(listofGenres[index]),
                ),
              );
            }
        ),
      ),
    );
  }
}