import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_event.dart';
import 'package:pagination_example/pagination_with_bloc/bloc/post_state.dart';
import 'package:pagination_example/pagination_with_bloc/repostory/post_repostory.dart';

class PostsBloc extends Bloc<PostEvent, PostsState> {
  PostRepository postRepository;

  int page = 1;

  ScrollController scrollController = ScrollController();

  bool isLoadingMoor = false;

  PostsBloc(this.postRepository) : super(InitState(null)) {
    scrollController.addListener(() {
      add(LoadMoorEvent());
    });

    on<GetPostsEvent>((event, emit) async {
      emit(PostsLoadingState(null));
      var posts = await postRepository.getPosts(page);
      emit(PotsLoadedSuccessState(posts: posts));
    });

    on<LoadMoorEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadingMoor = true;
        page++;
        var posts = await postRepository.getPosts(page);
        emit(PotsLoadedSuccessState(posts: [...state.posts, ...posts]));
      }
    });
  }
}
