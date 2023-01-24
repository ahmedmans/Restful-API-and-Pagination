import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_example/pagination_normal_way/producte_screen.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_bloc.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_event.dart';
import 'package:pagination_example/pagination_with_bloc/repostory/post_repostory.dart';
import 'package:pagination_example/pagination_with_bloc/screen/posts_sacreen.dart';

void main() {
  runApp(const App());
}

/// This For Normal Pagination
/// Normal Pagination means Using StateFull Widget
/// If you need Test It You Can Stop BlocPagintaion by Comment THE App Class
/// and UnComment MyApp And add it inside main function at runApp(const MyApp())

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pagination',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ProductScreen(),
//     );
//   }
// }

/// This Pagination Using Bloc
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<PostRepository>(
        create: (context) => PostRepository(),
        child: BlocProvider<PostsBloc>(
          create: (context) =>
              PostsBloc(context.read<PostRepository>())..add(GetPostsEvent()),
          child: PostsScreen(),
        ),
      ),
    );
  }
}
