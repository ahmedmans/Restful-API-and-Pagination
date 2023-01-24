abstract class PostsState {
  final posts;

  PostsState(this.posts);
}

class InitState extends PostsState {
  InitState(super.posts);
}

class PostsLoadingState extends PostsState {
  PostsLoadingState(super.posts);
}

class PotsLoadedSuccessState extends PostsState {
  PotsLoadedSuccessState({required posts}) : super(posts);
}
