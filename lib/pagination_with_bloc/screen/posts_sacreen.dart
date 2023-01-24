import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_bloc.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_state.dart';
import 'package:shimmer/shimmer.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PotsLoadedSuccessState) {
            List posts = state.posts;
            return ListView.builder(
              controller: context.read<PostsBloc>().scrollController,
              itemCount: context.read<PostsBloc>().isLoadingMoor
                  ? posts.length + 1
                  : posts.length,
              itemBuilder: (context, index) {
                if (index >= posts.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var data = posts[index];
                  return Container(
                    margin: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data['jetpack_featured_media_url'],
                            fit: BoxFit.fill,
                            placeholderFadeInDuration:
                                Duration(milliseconds: 300),
                            placeholder: (context, url) => Shimmer(
                                child: SizedBox(),
                                gradient: LinearGradient(colors: [
                                  Colors.grey,
                                  Colors.white,
                                ])),
                          ),
                        ),
                        Text(data['title']['rendered']),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
