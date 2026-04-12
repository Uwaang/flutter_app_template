<SYSTEM>This is the full developer documentation for Flutter 배우기</SYSTEM>

# Flutter 앱 개발 가이드

> 모바일 및 태블릿 앱을 만들며 겪었던 문제를 공유합니다.

## Next steps

[Section titled “Next steps”](#next-steps)

Update content

Edit `src/content/docs/index.mdx` to see this page change.

Add new content

Add Markdown or MDX files to `src/content/docs` to create new pages.

Configure your site

Edit your `sidebar` and other config in `astro.config.mjs`.

Read the docs

Learn more in [the Starlight Docs](https://starlight.astro.build/).

# 코드 템플릿

개발 시간을 단축하고 일관된 코드 스타일을 유지하기 위해 코드 템플릿을 활용하는 것은 매우 유용합니다. 이 페이지에서는 Flutter 개발에 도움이 되는 다양한 코드 템플릿과 예제를 제공합니다.

## 프로젝트 구조 템플릿

[Section titled “프로젝트 구조 템플릿”](#프로젝트-구조-템플릿)

### 기능별 폴더 구조

[Section titled “기능별 폴더 구조”](#기능별-폴더-구조)

```plaintext
1
lib/
2
├── core/
3
│   ├── constants/
4
│   ├── exceptions/
5
│   ├── extensions/
6
│   ├── routes/
7
│   ├── services/
8
│   ├── theme/
9
│   └── utils/
10
├── data/
11
│   ├── datasources/
12
│   ├── models/
13
│   └── repositories/
14
├── domain/
15
│   ├── entities/
16
│   ├── repositories/ (interfaces)
17
│   └── usecases/
18
├── presentation/
19
│   ├── pages/
20
│   ├── providers/
21
│   ├── viewmodels/
22
│   └── widgets/
23
├── main.dart
24
└── app.dart
```

### 간소화된 구조 (소규모 프로젝트)

[Section titled “간소화된 구조 (소규모 프로젝트)”](#간소화된-구조-소규모-프로젝트)

```plaintext
1
lib/
2
├── common/
3
│   ├── constants.dart
4
│   ├── theme.dart
5
│   └── utils.dart
6
├── data/
7
│   ├── models/
8
│   └── repositories/
9
├── providers/
10
├── screens/
11
│   ├── home/
12
│   ├── details/
13
│   └── settings/
14
├── widgets/
15
│   ├── common/
16
│   └── specialized/
17
├── main.dart
18
└── app.dart
```

## 클래스 및 위젯 템플릿

[Section titled “클래스 및 위젯 템플릿”](#클래스-및-위젯-템플릿)

### StatelessWidget 템플릿

[Section titled “StatelessWidget 템플릿”](#statelesswidget-템플릿)

```dart
1
class CustomWidget extends StatelessWidget {
2
  final String title;
3
  final VoidCallback onTap;
4


5
  const CustomWidget({
6
    super.key,
7
    required this.title,
8
    required this.onTap,
9
  });
10


11
  @override
12
  Widget build(BuildContext context) {
13
    return GestureDetector(
14
      onTap: onTap,
15
      child: Container(
16
        padding: const EdgeInsets.all(16.0),
17
        decoration: BoxDecoration(
18
          color: Theme.of(context).primaryColor,
19
          borderRadius: BorderRadius.circular(8.0),
20
        ),
21
        child: Text(
22
          title,
23
          style: const TextStyle(
24
            color: Colors.white,
25
            fontWeight: FontWeight.bold,
26
          ),
27
        ),
28
      ),
29
    );
30
  }
31
}
```

### StatefulWidget 템플릿

[Section titled “StatefulWidget 템플릿”](#statefulwidget-템플릿)

```dart
1
class CounterWidget extends StatefulWidget {
2
  final int initialValue;
3
  final ValueChanged<int>? onChanged;
4


5
  const CounterWidget({
6
    super.key,
7
    this.initialValue = 0,
8
    this.onChanged,
9
  });
10


11
  @override
12
  State<CounterWidget> createState() => _CounterWidgetState();
13
}
14


15
class _CounterWidgetState extends State<CounterWidget> {
16
  late int _counter;
17


18
  @override
19
  void initState() {
20
    super.initState();
21
    _counter = widget.initialValue;
22
  }
23


24
  void _increment() {
25
    setState(() {
26
      _counter++;
27
      widget.onChanged?.call(_counter);
28
    });
29
  }
30


31
  @override
32
  Widget build(BuildContext context) {
33
    return Column(
34
      mainAxisSize: MainAxisSize.min,
35
      children: [
36
        Text('카운터: $_counter'),
37
        ElevatedButton(
38
          onPressed: _increment,
39
          child: const Text('증가'),
40
        ),
41
      ],
42
    );
43
  }
44
}
```

### HookWidget 템플릿 (flutter\_hooks)

[Section titled “HookWidget 템플릿 (flutter\_hooks)”](#hookwidget-템플릿-flutter_hooks)

```dart
1
class HookCounter extends HookWidget {
2
  final ValueChanged<int>? onChanged;
3


4
  const HookCounter({
5
    super.key,
6
    this.onChanged,
7
  });
8


9
  @override
10
  Widget build(BuildContext context) {
11
    final counter = useState(0);
12


13
    void increment() {
14
      counter.value++;
15
      onChanged?.call(counter.value);
16
    }
17


18
    return Column(
19
      mainAxisSize: MainAxisSize.min,
20
      children: [
21
        Text('카운터: ${counter.value}'),
22
        ElevatedButton(
23
          onPressed: increment,
24
          child: const Text('증가'),
25
        ),
26
      ],
27
    );
28
  }
29
}
```

### ConsumerWidget 템플릿 (Riverpod)

[Section titled “ConsumerWidget 템플릿 (Riverpod)”](#consumerwidget-템플릿-riverpod)

```dart
1
// 프로바이더 정의
2
@riverpod
3
class Counter extends _$Counter {
4
  @override
5
  int build() => 0;
6


7
  void increment() => state++;
8
}
9


10
// 위젯 구현
11
class CounterView extends ConsumerWidget {
12
  const CounterView({super.key});
13


14
  @override
15
  Widget build(BuildContext context, WidgetRef ref) {
16
    final counter = ref.watch(counterProvider);
17


18
    return Column(
19
      mainAxisSize: MainAxisSize.min,
20
      children: [
21
        Text('카운터: $counter'),
22
        ElevatedButton(
23
          onPressed: () => ref.read(counterProvider.notifier).increment(),
24
          child: const Text('증가'),
25
        ),
26
      ],
27
    );
28
  }
29
}
```

### HookConsumerWidget 템플릿 (hooks\_riverpod)

[Section titled “HookConsumerWidget 템플릿 (hooks\_riverpod)”](#hookconsumerwidget-템플릿-hooks_riverpod)

```dart
1
class HookConsumerCounter extends HookConsumerWidget {
2
  const HookConsumerCounter({super.key});
3


4
  @override
5
  Widget build(BuildContext context, WidgetRef ref) {
6
    final counter = ref.watch(counterProvider);
7
    final isActive = useState(true);
8


9
    return Column(
10
      mainAxisSize: MainAxisSize.min,
11
      children: [
12
        Switch(
13
          value: isActive.value,
14
          onChanged: (value) => isActive.value = value,
15
        ),
16
        Text('카운터: $counter'),
17
        ElevatedButton(
18
          onPressed: isActive.value
19
            ? () => ref.read(counterProvider.notifier).increment()
20
            : null,
21
          child: const Text('증가'),
22
        ),
23
      ],
24
    );
25
  }
26
}
```

## 데이터 모델 템플릿

[Section titled “데이터 모델 템플릿”](#데이터-모델-템플릿)

### Freezed 모델 템플릿

[Section titled “Freezed 모델 템플릿”](#freezed-모델-템플릿)

user.dart

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
part 'user.freezed.dart';
5
part 'user.g.dart';
6


7
@freezed
8
class User with _$User {
9
  const factory User({
10
    required String id,
11
    required String name,
12
    @JsonKey(name: 'email_address') required String email,
13
    String? profileUrl,
14
    @Default(false) bool isPremium,
15
  }) = _User;
16


17
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
18
}
```

### 상태를 가진 Freezed 모델 (AsyncValue 활용)

[Section titled “상태를 가진 Freezed 모델 (AsyncValue 활용)”](#상태를-가진-freezed-모델-asyncvalue-활용)

user\_state.dart

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:flutter_riverpod/flutter_riverpod.dart';
3
import 'user.dart';
4


5
part 'user_state.freezed.dart';
6


7
@freezed
8
class UserState with _$UserState {
9
  const factory UserState({
10
    required AsyncValue<User> user,
11
    @Default(false) bool isEditing,
12
  }) = _UserState;
13


14
  const UserState._();
15


16
  factory UserState.initial() => UserState(
17
    user: const AsyncValue.loading(),
18
  );
19


20
  bool get isLoading => user.isLoading;
21
  bool get hasError => user.hasError;
22


23
  UserState copyWithUser(User? newUser) {
24
    return copyWith(
25
      user: newUser != null
26
        ? AsyncValue.data(newUser)
27
        : const AsyncValue.loading(),
28
    );
29
  }
30
}
```

## Riverpod 프로바이더 템플릿

[Section titled “Riverpod 프로바이더 템플릿”](#riverpod-프로바이더-템플릿)

### 기본 Provider

[Section titled “기본 Provider”](#기본-provider)

```dart
1
final configProvider = Provider<AppConfig>((ref) {
2
  return AppConfig(
3
    apiUrl: 'https://api.example.com',
4
    timeout: const Duration(seconds: 30),
5
  );
6
});
```

### StateNotifierProvider

[Section titled “StateNotifierProvider”](#statenotifierprovider)

counter\_notifier.dart

```dart
1
class CounterNotifier extends StateNotifier<int> {
2
  CounterNotifier() : super(0);
3


4
  void increment() => state++;
5
  void decrement() {
6
    if (state > 0) state--;
7
  }
8
  void reset() => state = 0;
9
}
10


11
// counter_provider.dart
12
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
13
  return CounterNotifier();
14
});
```

### AsyncNotifierProvider

[Section titled “AsyncNotifierProvider”](#asyncnotifierprovider)

users\_notifier.dart

```dart
1
@riverpod
2
class UsersNotifier extends _$UsersNotifier {
3
  @override
4
  FutureOr<List<User>> build() async {
5
    return _fetchUsers();
6
  }
7


8
  Future<List<User>> _fetchUsers() async {
9
    final apiService = ref.read(apiServiceProvider);
10
    return await apiService.getUsers();
11
  }
12


13
  Future<void> refresh() async {
14
    state = const AsyncValue.loading();
15
    state = await AsyncValue.guard(_fetchUsers);
16
  }
17


18
  Future<void> addUser(User user) async {
19
    state = const AsyncValue.loading();
20
    final apiService = ref.read(apiServiceProvider);
21
    await apiService.addUser(user);
22


23
    state = await AsyncValue.guard(_fetchUsers);
24
  }
25
}
```

### FutureProvider 및 Stream 프로바이더

[Section titled “FutureProvider 및 Stream 프로바이더”](#futureprovider-및-stream-프로바이더)

```dart
1
// 단순 FutureProvider
2
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
3
  final apiService = ref.read(apiServiceProvider);
4
  return await apiService.getUserById(userId);
5
});
6


7
// 스트림 프로바이더
8
final messagesProvider = StreamProvider<List<Message>>((ref) {
9
  final chatService = ref.read(chatServiceProvider);
10
  return chatService.getMessagesStream();
11
});
```

## 화면 레이아웃 템플릿

[Section titled “화면 레이아웃 템플릿”](#화면-레이아웃-템플릿)

### 기본 화면 구조

[Section titled “기본 화면 구조”](#기본-화면-구조)

```dart
1
class ProfileScreen extends StatelessWidget {
2
  final String userId;
3


4
  const ProfileScreen({
5
    super.key,
6
    required this.userId,
7
  });
8


9
  @override
10
  Widget build(BuildContext context) {
11
    return Scaffold(
12
      appBar: AppBar(
13
        title: const Text('프로필'),
14
        actions: [
15
          IconButton(
16
            icon: const Icon(Icons.settings),
17
            onPressed: () {
18
              // 설정 화면으로 이동
19
            },
20
          ),
21
        ],
22
      ),
23
      body: SafeArea(
24
        child: Padding(
25
          padding: const EdgeInsets.all(16.0),
26
          child: Column(
27
            crossAxisAlignment: CrossAxisAlignment.start,
28
            children: [
29
              // 프로필 헤더
30
              const ProfileHeader(),
31


32
              const SizedBox(height: 16),
33


34
              // 탭 컨트롤
35
              const ProfileTabBar(),
36


37
              // 탭 콘텐츠
38
              Expanded(
39
                child: ProfileTabView(userId: userId),
40
              ),
41
            ],
42
          ),
43
        ),
44
      ),
45
      floatingActionButton: FloatingActionButton(
46
        onPressed: () {
47
          // 작업 수행
48
        },
49
        child: const Icon(Icons.add),
50
      ),
51
      bottomNavigationBar: BottomNavigationBar(
52
        items: const [
53
          BottomNavigationBarItem(
54
            icon: Icon(Icons.home),
55
            label: '홈',
56
          ),
57
          BottomNavigationBarItem(
58
            icon: Icon(Icons.person),
59
            label: '프로필',
60
          ),
61
          BottomNavigationBarItem(
62
            icon: Icon(Icons.settings),
63
            label: '설정',
64
          ),
65
        ],
66
        currentIndex: 1,
67
        onTap: (index) {
68
          // 탭 변경 처리
69
        },
70
      ),
71
    );
72
  }
73
}
```

### 반응형 레이아웃

[Section titled “반응형 레이아웃”](#반응형-레이아웃)

```dart
1
class ResponsiveLayout extends StatelessWidget {
2
  final Widget mobile;
3
  final Widget? tablet;
4
  final Widget? desktop;
5


6
  const ResponsiveLayout({
7
    super.key,
8
    required this.mobile,
9
    this.tablet,
10
    this.desktop,
11
  });
12


13
  static bool isMobile(BuildContext context) =>
14
      MediaQuery.of(context).size.width < 650;
15


16
  static bool isTablet(BuildContext context) =>
17
      MediaQuery.of(context).size.width >= 650 &&
18
      MediaQuery.of(context).size.width < 1100;
19


20
  static bool isDesktop(BuildContext context) =>
21
      MediaQuery.of(context).size.width >= 1100;
22


23
  @override
24
  Widget build(BuildContext context) {
25
    final Size size = MediaQuery.of(context).size;
26


27
    if (size.width >= 1100 && desktop != null) {
28
      return desktop!;
29
    }
30


31
    if (size.width >= 650 && tablet != null) {
32
      return tablet!;
33
    }
34


35
    return mobile;
36
  }
37
}
38


39
// 사용 예시
40
class MyResponsiveScreen extends StatelessWidget {
41
  const MyResponsiveScreen({super.key});
42


43
  @override
44
  Widget build(BuildContext context) {
45
    return Scaffold(
46
      appBar: AppBar(title: const Text('반응형 예제')),
47
      body: const ResponsiveLayout(
48
        mobile: MobileLayout(),
49
        tablet: TabletLayout(),
50
        desktop: DesktopLayout(),
51
      ),
52
    );
53
  }
54
}
```

## 네트워크 요청 템플릿

[Section titled “네트워크 요청 템플릿”](#네트워크-요청-템플릿)

### Dio를 활용한

[Section titled “Dio를 활용한”](#dio를-활용한)

REST API 클라이언트

```dart
1
class ApiClient {
2
  final Dio _dio;
3


4
  ApiClient() : _dio = Dio() {
5
    _dio.options.baseUrl = 'https://api.example.com';
6
    _dio.options.connectTimeout = const Duration(seconds: 5);
7
    _dio.options.receiveTimeout = const Duration(seconds: 3);
8


9
    _dio.interceptors.add(LogInterceptor(
10
      requestBody: true,
11
      responseBody: true,
12
    ));
13
  }
14


15
  Future<T> get<T>(
16
    String path, {
17
    Map<String, dynamic>? queryParameters,
18
    required T Function(dynamic data) fromJson,
19
  }) async {
20
    try {
21
      final response = await _dio.get(
22
        path,
23
        queryParameters: queryParameters,
24
      );
25
      return fromJson(response.data);
26
    } on DioException catch (e) {
27
      throw _handleError(e);
28
    }
29
  }
30


31
  Future<T> post<T>(
32
    String path, {
33
    required dynamic data,
34
    required T Function(dynamic data) fromJson,
35
  }) async {
36
    try {
37
      final response = await _dio.post(
38
        path,
39
        data: data,
40
      );
41
      return fromJson(response.data);
42
    } on DioException catch (e) {
43
      throw _handleError(e);
44
    }
45
  }
46


47
  Exception _handleError(DioException e) {
48
    switch (e.type) {
49
      case DioExceptionType.connectionTimeout:
50
      case DioExceptionType.receiveTimeout:
51
        return TimeoutException('연결 시간이 초과되었습니다');
52
      case DioExceptionType.badResponse:
53
        final statusCode = e.response?.statusCode;
54
        if (statusCode == 401) {
55
          return UnauthorizedException('인증이 필요합니다');
56
        } else if (statusCode == 404) {
57
          return NotFoundException('요청한 리소스를 찾을 수 없습니다');
58
        }
59
        return ServerException('서버 오류가 발생했습니다: $statusCode');
60
      default:
61
        return Exception('네트워크 오류가 발생했습니다: ${e.message}');
62
    }
63
  }
64
}
```

### GraphQL 요청 템플릿

[Section titled “GraphQL 요청 템플릿”](#graphql-요청-템플릿)

```dart
1
class GraphQLClient {
2
  final HttpLink _httpLink;
3
  late final graphql.GraphQLClient _client;
4


5
  GraphQLClient() : _httpLink = HttpLink('https://api.example.com/graphql') {
6
    final AuthLink authLink = AuthLink(
7
      getToken: () async => 'Bearer $token',
8
    );
9


10
    final Link link = authLink.concat(_httpLink);
11


12
    _client = graphql.GraphQLClient(
13
      link: link,
14
      cache: GraphQLCache(),
15
    );
16
  }
17


18
  Future<T> query<T>({
19
    required String queryDocument,
20
    Map<String, dynamic>? variables,
21
    required T Function(Map<String, dynamic> data) fromJson,
22
  }) async {
23
    final QueryOptions options = QueryOptions(
24
      document: gql.gql(queryDocument),
25
      variables: variables ?? {},
26
    );
27


28
    final QueryResult result = await _client.query(options);
29


30
    if (result.hasException) {
31
      throw _handleException(result.exception!);
32
    }
33


34
    return fromJson(result.data!);
35
  }
36


37
  Future<T> mutate<T>({
38
    required String mutationDocument,
39
    Map<String, dynamic>? variables,
40
    required T Function(Map<String, dynamic> data) fromJson,
41
  }) async {
42
    final MutationOptions options = MutationOptions(
43
      document: gql.gql(mutationDocument),
44
      variables: variables ?? {},
45
    );
46


47
    final QueryResult result = await _client.mutate(options);
48


49
    if (result.hasException) {
50
      throw _handleException(result.exception!);
51
    }
52


53
    return fromJson(result.data!);
54
  }
55


56
  Exception _handleException(OperationException exception) {
57
    if (exception.linkException != null) {
58
      return NetworkException('네트워크 오류가 발생했습니다');
59
    }
60


61
    if (exception.graphqlErrors.isNotEmpty) {
62
      final firstError = exception.graphqlErrors.first;
63
      return GraphQLException(firstError.message);
64
    }
65


66
    return Exception('알 수 없는 오류가 발생했습니다');
67
  }
68
}
```

## 상태 관리 템플릿

[Section titled “상태 관리 템플릿”](#상태-관리-템플릿)

### Riverpod + Freezed를 활용한 상태 관리

[Section titled “Riverpod + Freezed를 활용한 상태 관리”](#riverpod--freezed를-활용한-상태-관리)

todo\_state.dart

```dart
1
@freezed
2
class TodoState with _$TodoState {
3
  const factory TodoState({
4
    required AsyncValue<List<Todo>> todos,
5
    @Default('') String newTodoText,
6
    Todo? editingTodo,
7
  }) = _TodoState;
8


9
  factory TodoState.initial() => TodoState(
10
    todos: const AsyncValue.loading(),
11
  );
12
}
13


14
// todo_notifier.dart
15
@riverpod
16
class TodoNotifier extends _$TodoNotifier {
17
  @override
18
  TodoState build() {
19
    _loadTodos();
20
    return TodoState.initial();
21
  }
22


23
  Future<void> _loadTodos() async {
24
    state = state.copyWith(todos: const AsyncValue.loading());
25


26
    try {
27
      final todoRepository = ref.read(todoRepositoryProvider);
28
      final todos = await todoRepository.getTodos();
29
      state = state.copyWith(todos: AsyncValue.data(todos));
30
    } catch (error, stackTrace) {
31
      state = state.copyWith(todos: AsyncValue.error(error, stackTrace));
32
    }
33
  }
34


35
  void setNewTodoText(String text) {
36
    state = state.copyWith(newTodoText: text);
37
  }
38


39
  Future<void> addTodo() async {
40
    if (state.newTodoText.trim().isEmpty) return;
41


42
    final todo = Todo(
43
      id: const Uuid().v4(),
44
      title: state.newTodoText,
45
      completed: false,
46
    );
47


48
    final currentTodos = state.todos.valueOrNull ?? [];
49


50
    // 낙관적 업데이트
51
    state = state.copyWith(
52
      todos: AsyncValue.data([...currentTodos, todo]),
53
      newTodoText: '',
54
    );
55


56
    try {
57
      final todoRepository = ref.read(todoRepositoryProvider);
58
      await todoRepository.addTodo(todo);
59
    } catch (error) {
60
      // 실패 시 롤백
61
      state = state.copyWith(
62
        todos: AsyncValue.data(currentTodos),
63
      );
64
      // 오류 메시지 표시
65
    }
66
  }
67
}
```

## 페이지 라우팅 템플릿

[Section titled “페이지 라우팅 템플릿”](#페이지-라우팅-템플릿)

### GoRouter 설정

[Section titled “GoRouter 설정”](#gorouter-설정)

router.dart

```dart
1
final GlobalKey<NavigatorState> rootNavigatorKey =
2
    GlobalKey<NavigatorState>(debugLabel: 'root');
3


4
final GlobalKey<NavigatorState> shellNavigatorKey =
5
    GlobalKey<NavigatorState>(debugLabel: 'shell');
6


7
final routerProvider = Provider<GoRouter>((ref) {
8
  final authState = ref.watch(authStateProvider);
9


10
  return GoRouter(
11
    navigatorKey: rootNavigatorKey,
12
    initialLocation: '/',
13
    debugLogDiagnostics: true,
14
    redirect: (context, state) {
15
      final isLoggedIn = authState.valueOrNull?.user != null;
16
      final isLoggingIn = state.matchedLocation == '/login';
17


18
      if (!isLoggedIn && !isLoggingIn) return '/login';
19
      if (isLoggedIn && isLoggingIn) return '/';
20


21
      return null;
22
    },
23
    routes: [
24
      // 로그인 화면
25
      GoRoute(
26
        path: '/login',
27
        builder: (context, state) => const LoginScreen(),
28
      ),
29


30
      // 쉘 라우트 (하단 탐색바)
31
      ShellRoute(
32
        navigatorKey: shellNavigatorKey,
33
        builder: (context, state, child) => ShellScreen(child: child),
34
        routes: [
35
          // 홈 화면
36
          GoRoute(
37
            path: '/',
38
            builder: (context, state) => const HomeScreen(),
39
            routes: [
40
              // 상세 화면
41
              GoRoute(
42
                path: 'details/:id',
43
                builder: (context, state) {
44
                  final id = state.params['id']!;
45
                  return DetailsScreen(id: id);
46
                },
47
              ),
48
            ],
49
          ),
50


51
          // 프로필 화면
52
          GoRoute(
53
            path: '/profile',
54
            builder: (context, state) => const ProfileScreen(),
55
          ),
56


57
          // 설정 화면
58
          GoRoute(
59
            path: '/settings',
60
            builder: (context, state) => const SettingsScreen(),
61
          ),
62
        ],
63
      ),
64
    ],
65
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
66
  );
67
});
```

## 단위 테스트 템플릿

[Section titled “단위 테스트 템플릿”](#단위-테스트-템플릿)

### 일반 클래스 테스트

[Section titled “일반 클래스 테스트”](#일반-클래스-테스트)

```dart
1
void main() {
2
  group('Calculator 테스트', () {
3
    late Calculator calculator;
4


5
    setUp(() {
6
      calculator = Calculator();
7
    });
8


9
    test('더하기 테스트', () {
10
      expect(calculator.add(1, 2), 3);
11
      expect(calculator.add(-1, 1), 0);
12
      expect(calculator.add(0, 0), 0);
13
    });
14


15
    test('나누기 테스트', () {
16
      expect(calculator.divide(6, 2), 3);
17
      expect(calculator.divide(5, 2), 2.5);
18


19
      expect(
20
        () => calculator.divide(1, 0),
21
        throwsA(isA<DivisionByZeroException>()),
22
      );
23
    });
24
  });
25
}
```

### Riverpod 테스트

[Section titled “Riverpod 테스트”](#riverpod-테스트)

counter\_test.dart

```dart
1
void main() {
2
  group('CounterNotifier 테스트', () {
3
    late ProviderContainer container;
4


5
    setUp(() {
6
      container = ProviderContainer();
7
    });
8


9
    tearDown(() {
10
      container.dispose();
11
    });
12


13
    test('초기 상태는 0이다', () {
14
      expect(container.read(counterProvider), 0);
15
    });
16


17
    test('increment 메서드는 상태를 1 증가시킨다', () {
18
      container.read(counterProvider.notifier).increment();
19
      expect(container.read(counterProvider), 1);
20


21
      container.read(counterProvider.notifier).increment();
22
      expect(container.read(counterProvider), 2);
23
    });
24


25
    test('decrement 메서드는 상태를 1 감소시킨다', () {
26
      container.read(counterProvider.notifier).increment();
27
      container.read(counterProvider.notifier).increment();
28
      expect(container.read(counterProvider), 2);
29


30
      container.read(counterProvider.notifier).decrement();
31
      expect(container.read(counterProvider), 1);
32
    });
33


34
    test('decrement 메서드는 상태가 0일 때 감소시키지 않는다', () {
35
      expect(container.read(counterProvider), 0);
36


37
      container.read(counterProvider.notifier).decrement();
38
      expect(container.read(counterProvider), 0);
39
    });
40
  });
41
}
```

## 위젯 테스트 템플릿

[Section titled “위젯 테스트 템플릿”](#위젯-테스트-템플릿)

```dart
1
void main() {
2
  group('Counter 위젯 테스트', () {
3
    testWidgets('초기 카운터 값이 올바르게 표시된다', (WidgetTester tester) async {
4
      await tester.pumpWidget(
5
        const MaterialApp(
6
          home: Scaffold(
7
            body: CounterWidget(initialValue: 5),
8
          ),
9
        ),
10
      );
11


12
      expect(find.text('카운터: 5'), findsOneWidget);
13
      expect(find.text('증가'), findsOneWidget);
14
    });
15


16
    testWidgets('버튼 클릭 시 카운터가 증가한다', (WidgetTester tester) async {
17
      await tester.pumpWidget(
18
        const MaterialApp(
19
          home: Scaffold(
20
            body: CounterWidget(),
21
          ),
22
        ),
23
      );
24


25
      expect(find.text('카운터: 0'), findsOneWidget);
26


27
      await tester.tap(find.text('증가'));
28
      await tester.pump();
29


30
      expect(find.text('카운터: 1'), findsOneWidget);
31
    });
32


33
    testWidgets('onChanged 콜백이 호출된다', (WidgetTester tester) async {
34
      int? newValue;
35


36
      await tester.pumpWidget(
37
        MaterialApp(
38
          home: Scaffold(
39
            body: CounterWidget(
40
              onChanged: (value) {
41
                newValue = value;
42
              },
43
            ),
44
          ),
45
        ),
46
      );
47


48
      await tester.tap(find.text('증가'));
49
      await tester.pump();
50


51
      expect(newValue, 1);
52
    });
53
  });
54
}
```

## 예제 모음 링크

[Section titled “예제 모음 링크”](#예제-모음-링크)

다음은 더 많은 코드 예제를 찾을 수 있는 유용한 리소스 모음입니다:

### 공식 예제

[Section titled “공식 예제”](#공식-예제)

* [Flutter Gallery](https://github.com/flutter/gallery) - 공식 Flutter 위젯 및 기능 갤러리
* [Flutter Samples](https://github.com/flutter/samples) - 공식 Flutter 샘플 모음
* [Flutter 쿡북](https://docs.flutter.dev/cookbook) - 공식 Flutter 쿡북 레시피

### 커뮤니티 예제

[Section titled “커뮤니티 예제”](#커뮤니티-예제)

* [Flutter Awesome](https://flutterawesome.com/) - 커뮤니티가 제작한 Flutter 앱 예제 모음
* [Flutter Example Apps](https://github.com/iampawan/FlutterExampleApps) - 다양한 Flutter 앱 예제
* [Flutter Clean Architecture](https://github.com/ResoCoder/flutter-clean-architecture-course) - 클린 아키텍처 예제
* [The Flutter Way](https://github.com/abuanwar072) - UI 중심 Flutter 예제 모음
* [Riverpod Architecture](https://github.com/lucavenir/riverpod_architecture) - Riverpod 기반 아키텍처 예제

### 디자인 별 예제

[Section titled “디자인 별 예제”](#디자인-별-예제)

* [FlutterFolio](https://github.com/gskinnerTeam/flutterfolio) - 반응형 웹 포트폴리오 예제
* [Flutter UI Challenges](https://github.com/lohanidamodar/flutter_ui_challenges) - 다양한 UI 구현 예제
* [Flutter Movies](https://github.com/ibhavikmakwana/flutter_movies) - 영화 앱 UI 예제
* [Flutter Food Delivery](https://github.com/JideGuru/FlutterFoodybite) - 음식 배달 앱 UI

### 특정 기능 구현 예제

[Section titled “특정 기능 구현 예제”](#특정-기능-구현-예제)

* [Local Auth](https://github.com/flutter/packages/tree/main/packages/local_auth/local_auth/example) - 생체 인증 예제
* [Provider Shopper](https://github.com/flutter/samples/tree/main/provider_shopper) - Provider를 활용한 쇼핑 앱
* [Infinite List](https://github.com/felangel/bloc_examples/tree/master/flutter_infinite_list) - 무한 스크롤 구현
* [Firebase Chat](https://github.com/duytq94/flutter-chat-demo) - Firebase 기반 채팅 앱

### 아키텍처 예제

[Section titled “아키텍처 예제”](#아키텍처-예제)

* [Flutter TDD Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course) - 테스트 주도 개발 + 클린 아키텍처
* [Flutter BLoC Pattern](https://github.com/felangel/bloc) - BLoC 패턴 예제
* [Flutter Riverpod Architecture](https://github.com/rrousselGit/riverpod/tree/master/examples) - Riverpod 아키텍처 예제

이 리소스들은 다양한 Flutter 프로젝트와 코드 예제를 제공하여 개발자가 더 빠르게 학습하고 개발할 수 있도록 도와줍니다.

# Flutter 오류 대응법 가이드

Flutter 앱을 개발하면서 다양한 오류에 직면할 수 있습니다. 이 문서에서는 자주 발생하는 Flutter 오류들과 그 해결 방법을 소개합니다.

## 개발 환경 오류

[Section titled “개발 환경 오류”](#개발-환경-오류)

### Flutter Doctor 오류

[Section titled “Flutter Doctor 오류”](#flutter-doctor-오류)

Flutter SDK를 설치한 후에는 항상 `flutter doctor` 명령어를 실행하여 개발 환경을 확인하는 것이 좋습니다.

| 오류 메시지                          | 원인                                    | 해결 방법                                                    |
| ------------------------------- | ------------------------------------- | -------------------------------------------------------- |
| `Flutter requires Android SDK`  | Android SDK가 설치되지 않았거나 경로가 설정되지 않음    | Android Studio를 설치하거나, Android SDK 경로를 Flutter 환경 변수에 추가 |
| `Android licenses not accepted` | Android 라이선스 동의가 필요함                  | `flutter doctor --android-licenses` 실행 후 동의              |
| `Xcode not installed`           | iOS 개발을 위한 Xcode가 설치되지 않음 (macOS만 해당) | App Store에서 Xcode 설치                                     |
| `CocoaPods not installed`       | iOS 종속성 관리 도구가 설치되지 않음                | `sudo gem install cocoapods` 명령어로 설치                     |

### pubspec.yaml 관련 오류

[Section titled “pubspec.yaml 관련 오류”](#pubspecyaml-관련-오류)

```plaintext
1
Because every version of flutter_package from sdk depends on intl ^0.17.0 and app depends on intl ^0.18.0, flutter_package from sdk is forbidden.
```

**원인**: 패키지 간 의존성 충돌 **해결 방법**: 패키지 버전을 호환되는 범위로 조정하고 `flutter pub upgrade --major-versions` 실행

## 빌드 오류

[Section titled “빌드 오류”](#빌드-오류)

### Gradle 관련 오류

[Section titled “Gradle 관련 오류”](#gradle-관련-오류)

```plaintext
1
Gradle task assembleDebug failed with exit code 1
```

**원인**: 다양한 Gradle 구성 문제 발생 가능 **해결 방법**:

1. 안드로이드 폴더에서 `./gradlew clean` 실행
2. `flutter clean` 실행 후 다시 빌드
3. Gradle 버전 확인 및 업데이트

### iOS 빌드 오류

[Section titled “iOS 빌드 오류”](#ios-빌드-오류)

```plaintext
1
[!] CocoaPods could not find compatible versions for pod "Firebase/Core"
```

**원인**: CocoaPods 의존성 충돌 **해결 방법**:

1. iOS 폴더에서 `pod repo update` 실행
2. `pod install --repo-update` 실행
3. `Podfile.lock` 삭제 후 `pod install` 다시 실행

### 코드 서명 오류

[Section titled “코드 서명 오류”](#코드-서명-오류)

```plaintext
1
No provisioning profile matches the specified entitlements
```

**원인**: iOS 앱 서명 설정 문제 **해결 방법**:

1. Xcode를 열고 팀 설정 확인
2. 프로비저닝 프로필 업데이트
3. 앱 ID와 번들 ID가 일치하는지 확인

## 런타임 오류

[Section titled “런타임 오류”](#런타임-오류)

### 위젯 빌드 오류

[Section titled “위젯 빌드 오류”](#위젯-빌드-오류)

#### setState() 오류

[Section titled “setState() 오류”](#setstate-오류)

```plaintext
1
setState() called after dispose(): _MyWidgetState#a7c89(lifecycle state: defunct, not mounted)
```

**원인**: 위젯이 제거된 후 setState 호출 **해결 방법**:

```dart
1
// 수정 전
2
void fetchData() async {
3
  final data = await apiService.getData();
4
  setState(() {
5
    this.data = data;
6
  });
7
}
8


9
// 수정 후
10
void fetchData() async {
11
  final data = await apiService.getData();
12
  if (mounted) {
13
    setState(() {
14
      this.data = data;
15
    });
16
  }
17
}
```

#### RenderFlex 오버플로우

[Section titled “RenderFlex 오버플로우”](#renderflex-오버플로우)

```plaintext
1
A RenderFlex overflowed by 20 pixels on the bottom
```

**원인**: 자식 위젯이 부모 위젯의 제약 조건을 초과 **해결 방법**:

1. `Expanded` 또는 `Flexible` 위젯 사용
2. `SingleChildScrollView`로 스크롤 가능하게 만들기
3. `ConstrainedBox`를 사용하여 최대 크기 제한

```dart
1
// 오류 발생 코드
2
Column(
3
  children: [
4
    LargeWidget(),
5
    AnotherLargeWidget(),
6
  ],
7
)
8


9
// 해결 방법 (스크롤 적용)
10
SingleChildScrollView(
11
  child: Column(
12
    children: [
13
      LargeWidget(),
14
      AnotherLargeWidget(),
15
    ],
16
  ),
17
)
18


19
// 또는 Expanded 사용 (부모가 Row/Column일 경우)
20
Column(
21
  children: [
22
    Expanded(child: LargeWidget()),
23
    AnotherWidget(),
24
  ],
25
)
```

### 상태 관리 오류

[Section titled “상태 관리 오류”](#상태-관리-오류)

#### Provider 관련 오류

[Section titled “Provider 관련 오류”](#provider-관련-오류)

```plaintext
1
Error: Could not find the correct Provider<MyModel> above this Consumer Widget
```

**원인**: Provider가 위젯 트리의 상위에 없음 **해결 방법**: 적절한 위치에 Provider 배치

```dart
1
// 수정 전 (문제가 되는 구조)
2
Widget build(BuildContext context) {
3
  return Consumer<MyModel>(
4
    builder: (context, model, child) {
5
      return Text(model.data);
6
    },
7
  );
8
}
9


10
// 수정 후 (올바른 구조)
11
Widget build(BuildContext context) {
12
  return ChangeNotifierProvider(
13
    create: (_) => MyModel(),
14
    child: Consumer<MyModel>(
15
      builder: (context, model, child) {
16
        return Text(model.data);
17
      },
18
    ),
19
  );
20
}
```

#### Riverpod 관련 오류

[Section titled “Riverpod 관련 오류”](#riverpod-관련-오류)

```plaintext
1
ProviderNotFoundException: No provider found for providerHash:xxx
```

**원인**: ProviderScope 범위 밖에서 provider에 접근 시도 **해결 방법**: 앱 루트에 ProviderScope 추가

```dart
1
void main() {
2
  runApp(
3
    ProviderScope(
4
      child: MyApp(),
5
    ),
6
  );
7
}
```

### 네트워크 관련 오류

[Section titled “네트워크 관련 오류”](#네트워크-관련-오류)

#### CORS 오류 (웹)

[Section titled “CORS 오류 (웹)”](#cors-오류-웹)

```plaintext
1
Access to XMLHttpRequest has been blocked by CORS policy
```

**원인**: 웹 버전에서 CORS 정책 위반 **해결 방법**:

1. 서버 측에서 적절한 CORS 헤더 설정
2. 개발 시에는 Chrome을 `--disable-web-security` 옵션으로 실행
3. 프록시 서버 사용

#### 인증서 오류

[Section titled “인증서 오류”](#인증서-오류)

```plaintext
1
HandshakeException: Handshake error in client
```

**원인**: SSL 인증서 문제 **해결 방법**:

```dart
1
// 주의: 프로덕션 앱에서는 사용하지 않는 것이 좋습니다
2
HttpClient client = HttpClient()
3
  ..badCertificateCallback =
4
      (X509Certificate cert, String host, int port) => true;
```

### 비동기 처리 오류

[Section titled “비동기 처리 오류”](#비동기-처리-오류)

#### FutureBuilder 에러

[Section titled “FutureBuilder 에러”](#futurebuilder-에러)

```plaintext
1
type 'Future<dynamic>' is not a subtype of type 'Future<List<String>>'
```

**원인**: Future의 타입 불일치 **해결 방법**: 명시적 타입 지정

```dart
1
// 수정 전
2
Future fetchData() async {
3
  // ...
4
  return data;
5
}
6


7
// 수정 후
8
Future<List<String>> fetchData() async {
9
  // ...
10
  return data;
11
}
```

#### 스트림 오류

[Section titled “스트림 오류”](#스트림-오류)

```plaintext
1
Bad state: Stream has already been listened to
```

**원인**: 단일 구독 스트림에 여러 번 구독 시도 **해결 방법**: `Stream.asBroadcastStream()` 사용 또는 `StreamController`에서 `broadcast: true` 설정

## 플랫폼별 오류

[Section titled “플랫폼별 오류”](#플랫폼별-오류)

### Android 특정 오류

[Section titled “Android 특정 오류”](#android-특정-오류)

#### 다중 DEX 문제

[Section titled “다중 DEX 문제”](#다중-dex-문제)

```plaintext
1
Execution failed for task ':app:mergeDebugResources'. > java.lang.OutOfMemoryError
```

**원인**: 메서드 수가 DEX 제한을 초과 **해결 방법**: `android/app/build.gradle`에 멀티덱스 활성화

```txt
1
android {
2
  defaultConfig {
3
    multiDexEnabled true
4
  }
5
}
6


7
dependencies {
8
  implementation 'androidx.multidex:multidex:2.0.1'
9
}
```

#### 권한 관련 오류

[Section titled “권한 관련 오류”](#권한-관련-오류)

```plaintext
1
PlatformException: Permission denied
```

**원인**: 필요한 권한이 설정되지 않음 **해결 방법**: `AndroidManifest.xml`에 필요한 권한 추가 및 런타임 권한 요청 구현

```xml
1
<manifest>
2
  <uses-permission android:name="android.permission.INTERNET" />
3
  <uses-permission android:name="android.permission.CAMERA" />
4
  <!-- 필요한 권한 추가 -->
5
</manifest>
```

### iOS 특정 오류

[Section titled “iOS 특정 오류”](#ios-특정-오류)

#### Info.plist 관련 오류

[Section titled “Info.plist 관련 오류”](#infoplist-관련-오류)

```plaintext
1
This app has crashed because it attempted to access privacy-sensitive data without a usage description.
```

**원인**: 필요한 권한 설명이 Info.plist에 없음 **해결 방법**: `ios/Runner/Info.plist`에 관련 설명 추가

```xml
1
<key>NSCameraUsageDescription</key>
2
<string>이 앱은 프로필 사진 등록을 위해 카메라에 접근합니다.</string>
3
<key>NSPhotoLibraryUsageDescription</key>
4
<string>이 앱은 사진 업로드를 위해 갤러리에 접근합니다.</string>
```

#### 미니멈 iOS 버전 오류

[Section titled “미니멈 iOS 버전 오류”](#미니멈-ios-버전-오류)

```plaintext
1
The iOS deployment target is set to 8.0, but the range of supported deployment target versions is 9.0 to 14.0.
```

**원인**: 지원되지 않는 iOS 최소 버전 설정 **해결 방법**: `ios/Podfile` 및 Xcode 프로젝트 설정에서 최소 버전 업데이트

```ruby
1
# Podfile
2
platform :ios, '12.0'
```

## Web 특정 오류

[Section titled “Web 특정 오류”](#web-특정-오류)

### 자바스크립트 오류

[Section titled “자바스크립트 오류”](#자바스크립트-오류)

```plaintext
1
TypeError: Cannot read property 'X' of undefined
```

**원인**: 웹용 플러그인이 올바르게 초기화되지 않음 **해결 방법**: 플랫폼 조건부 코드 사용

```dart
1
import 'package:flutter/foundation.dart' show kIsWeb;
2


3
if (kIsWeb) {
4
  // 웹 전용 코드
5
} else {
6
  // 모바일 전용 코드
7
}
```

### 웹 리소스 로딩 오류

[Section titled “웹 리소스 로딩 오류”](#웹-리소스-로딩-오류)

```plaintext
1
Failed to load resource: net::ERR_BLOCKED_BY_CLIENT
```

**원인**: 광고 차단기가 리소스 로딩 차단 **해결 방법**: 리소스 URL 패턴 변경 또는 필수 리소스임을 사용자에게 알림

## 내부적인 패키지 오류

[Section titled “내부적인 패키지 오류”](#내부적인-패키지-오류)

### 플러그인 호환성 문제

[Section titled “플러그인 호환성 문제”](#플러그인-호환성-문제)

```plaintext
1
MissingPluginException(No implementation found for method X on channel Y)
```

**원인**: 플러그인 초기화 문제 또는 플랫폼 지원 부재 **해결 방법**:

1. 앱 재시작
2. `flutter clean` 실행 후 다시 빌드
3. 플러그인 호환성 확인 및 조건부 코드 작성

### 패키지 버전 충돌

[Section titled “패키지 버전 충돌”](#패키지-버전-충돌)

```plaintext
1
Undefined name 'X'. (The name X isn't a type and can't be used in a declaration)
```

**원인**: API 변경으로 인한 코드 호환성 문제 **해결 방법**:

1. 패키지 버전 확인 및 호환되는 버전 사용
2. 최신 API에 맞게 코드 업데이트
3. 코드 마이그레이션 가이드 참조

## 메모리 관련 오류

[Section titled “메모리 관련 오류”](#메모리-관련-오류)

### 메모리 누수

[Section titled “메모리 누수”](#메모리-누수)

#### 컨트롤러 누수

[Section titled “컨트롤러 누수”](#컨트롤러-누수)

```plaintext
1
A Timer still exists even after the widget tree was disposed.
```

**원인**: dispose 메서드에서 타이머, 컨트롤러 등을 해제하지 않음 **해결 방법**:

```dart
1
class _MyWidgetState extends State<MyWidget> {
2
  AnimationController _controller;
3
  Timer _timer;
4


5
  @override
6
  void initState() {
7
    super.initState();
8
    _controller = AnimationController(vsync: this);
9
    _timer = Timer.periodic(Duration(seconds: 1), (_) => update());
10
  }
11


12
  @override
13
  void dispose() {
14
    _controller.dispose(); // 컨트롤러 해제
15
    _timer.cancel(); // 타이머 취소
16
    super.dispose();
17
  }
18
}
```

#### 대용량 이미지 메모리 문제

[Section titled “대용량 이미지 메모리 문제”](#대용량-이미지-메모리-문제)

```plaintext
1
Out of memory: Bytes allocation failed
```

**원인**: 과도한 메모리 사용 **해결 방법**:

1. 이미지 캐싱 라이브러리 사용 (cached\_network\_image)
2. 적절한 크기의 이미지 로드 (ResizeImage 또는 서버 측 리사이징)
3. 메모리에 저장하는 데이터 제한

## 코드 품질 오류

[Section titled “코드 품질 오류”](#코드-품질-오류)

### 린트 오류

[Section titled “린트 오류”](#린트-오류)

```plaintext
1
The parameter 'onPressed' is required
```

**원인**: 필수 매개변수 누락 **해결 방법**: 코드 분석 도구가 지적한 문제 해결

### 성능 이슈

[Section titled “성능 이슈”](#성능-이슈)

#### 과도한 빌드 호출

[Section titled “과도한 빌드 호출”](#과도한-빌드-호출)

**원인**: 불필요한 위젯 리빌드로 인한 성능 저하 **해결 방법**:

1. `const` 생성자 사용
2. 상태 변경을 더 작은 위젯으로 분리
3. `RepaintBoundary`를 사용하여 리페인트 영역 제한

```dart
1
// 개선 전
2
ListView.builder(
3
  itemBuilder: (context, index) {
4
    return MyListItem(data: items[index]);
5
  }
6
)
7


8
// 개선 후
9
ListView.builder(
10
  itemBuilder: (context, index) {
11
    return RepaintBoundary(
12
      child: const MyListItem(data: items[index]),
13
    );
14
  }
15
)
```

## 디버깅 도구

[Section titled “디버깅 도구”](#디버깅-도구)

### Flutter DevTools

[Section titled “Flutter DevTools”](#flutter-devtools)

Flutter DevTools는 Flutter 앱 개발 시 강력한 디버깅 도구입니다. 다음과 같은 기능을 제공합니다:

1. **Inspector**: 위젯 트리 분석 및 레이아웃 디버깅
2. **Performance**: 프레임 드롭 분석
3. **Memory**: 메모리 사용량 및 누수 확인
4. **Network**: 네트워크 요청 모니터링
5. **Logging**: 로그 확인 및 필터링

### 효과적인 로깅 전략

[Section titled “효과적인 로깅 전략”](#효과적인-로깅-전략)

효과적인 로깅은 문제를 빠르게 파악하는 데 도움이 됩니다:

1. **로깅 레벨 구분**:

   ```dart
   1
   import 'package:logger/logger.dart';
   2


   3
   final logger = Logger(
   4
     printer: PrettyPrinter(),
   5
   );
   6


   7
   // 다양한 로깅 레벨 사용
   8
   logger.v("Verbose log");
   9
   logger.d("Debug log");
   10
   logger.i("Info log");
   11
   logger.w("Warning log");
   12
   logger.e("Error log");
   ```

2. **예외 처리**:

   ```dart
   1
   try {
   2
     // 위험한 작업
   3
   } catch (e, stackTrace) {
   4
     logger.e("오류 발생", error: e, stackTrace: stackTrace);
   5
   }
   ```

## 결론

[Section titled “결론”](#결론)

Flutter 앱 개발 중 발생하는 대부분의 오류는 체계적인 접근 방식으로 해결할 수 있습니다. 문제를 정확히 이해하고, 검색 엔진이나 Stack Overflow 같은 자료를 활용하며, 필요하다면 Flutter 이슈 트래커나 커뮤니티에 도움을 요청하세요.

오류 메시지를 무시하지 말고, 로그를 주의 깊게 읽고 분석하는 습관을 들이면 문제 해결 능력이 크게 향상됩니다. 또한 정기적으로 Flutter와 종속성을 최신 상태로 유지하는 것도 많은 문제를 예방할 수 있는 좋은 방법입니다.

# 자주 묻는 질문 (FAQ)

이 페이지에서는 Flutter 개발 과정에서 가장 자주 묻는 질문들과 그에 대한 답변을 제공합니다.

## 환경 설정

[Section titled “환경 설정”](#환경-설정)

### Q: Flutter SDK 업데이트는 어떻게 하나요?

[Section titled “Q: Flutter SDK 업데이트는 어떻게 하나요?”](#q-flutter-sdk-업데이트는-어떻게-하나요)

다음 명령어를 사용하여 Flutter SDK를 최신 버전으로 업데이트할 수 있습니다:

```bash
1
flutter upgrade
```

특정 채널(stable, beta, dev)로 전환하려면:

```bash
1
flutter channel stable
2
flutter upgrade
```

### Q: Flutter와 Dart의 버전 호환성은 어떻게 확인하나요?

[Section titled “Q: Flutter와 Dart의 버전 호환성은 어떻게 확인하나요?”](#q-flutter와-dart의-버전-호환성은-어떻게-확인하나요)

Flutter SDK 버전마다 지원하는 Dart 버전이 다릅니다. 현재 설치된 Flutter와 Dart 버전을 확인하려면:

```bash
1
flutter --version
```

공식 [Flutter 릴리스 페이지](https://docs.flutter.dev/release/archive)에서 각 Flutter 버전이 사용하는 Dart 버전을 확인할 수 있습니다.

### Q: MacOS에서 iOS 시뮬레이터를 실행하는 방법은?

[Section titled “Q: MacOS에서 iOS 시뮬레이터를 실행하는 방법은?”](#q-macos에서-ios-시뮬레이터를-실행하는-방법은)

```bash
1
# 사용 가능한 시뮬레이터 목록 확인
2
xcrun simctl list devices
3


4
# 시뮬레이터 실행
5
open -a Simulator
```

또는 VS Code의 상태바에서 디바이스 선택 옵션을 통해 iOS 시뮬레이터를 선택할 수 있습니다.

## 패키지 및 의존성

[Section titled “패키지 및 의존성”](#패키지-및-의존성)

### Q: pub.dev에서 패키지를 설치하는 가장 좋은 방법은 무엇인가요?

[Section titled “Q: pub.dev에서 패키지를 설치하는 가장 좋은 방법은 무엇인가요?”](#q-pubdev에서-패키지를-설치하는-가장-좋은-방법은-무엇인가요)

패키지를 설치하는 방법은 두 가지가 있습니다:

1. 명령줄에서 설치:

```bash
1
flutter pub add package_name
```

2. `pubspec.yaml` 파일을 직접 수정한 후:

```bash
1
flutter pub get
```

### Q: 패키지 버전 충돌을 해결하려면 어떻게 해야 하나요?

[Section titled “Q: 패키지 버전 충돌을 해결하려면 어떻게 해야 하나요?”](#q-패키지-버전-충돌을-해결하려면-어떻게-해야-하나요)

패키지 버전 충돌은 일반적으로 다음과 같은 방법으로 해결할 수 있습니다:

1. 종속성 트리를 확인하여 충돌 원인 파악:

```bash
1
flutter pub deps
```

2. 충돌하는 패키지 버전 범위 조정:

```yaml
1
dependencies:
2
  package_a: ^2.0.0 # 버전 범위 조정
```

3. 호환되는 버전으로 업데이트:

```bash
1
flutter pub upgrade --major-versions
```

### Q: 패키지 개발 시 로컬 패키지를 연결하는 방법은?

[Section titled “Q: 패키지 개발 시 로컬 패키지를 연결하는 방법은?”](#q-패키지-개발-시-로컬-패키지를-연결하는-방법은)

`pubspec.yaml`에 로컬 경로를 지정할 수 있습니다:

```yaml
1
dependencies:
2
  my_package:
3
    path: ../my_package
```

## 상태 관리

[Section titled “상태 관리”](#상태-관리)

### Q: 어떤 상태 관리 솔루션을 선택해야 할까요?

[Section titled “Q: 어떤 상태 관리 솔루션을 선택해야 할까요?”](#q-어떤-상태-관리-솔루션을-선택해야-할까요)

상태 관리 솔루션은 프로젝트 규모와 요구사항에 따라 다릅니다:

* **작은 프로젝트**: `setState`, `ValueNotifier`, `InheritedWidget`
* **중간 규모 프로젝트**: `Provider`, `Riverpod`
* **대규모 프로젝트**: `Riverpod`, `Bloc`, `Redux`

Riverpod는 다양한 규모의 프로젝트에 모두 적합하며, 최근에는 보일러플레이트 코드를 크게 줄인 코드 생성 기능을 제공하여 많은 개발자들이 선호합니다.

### Q: Riverpod와 Provider의 차이점은 무엇인가요?

[Section titled “Q: Riverpod와 Provider의 차이점은 무엇인가요?”](#q-riverpod와-provider의-차이점은-무엇인가요)

* **Provider**:

  * Context에 의존적
  * 위젯 트리 내에서만 동작
  * 단순하고 학습 곡선이 낮음

* **Riverpod**:

  * Context에 의존하지 않음
  * 컴파일 타임 안전성
  * 프로바이더 참조가 가능
  * 자동 캐싱 및 종속성 추적
  * 코드 생성을 통한 보일러플레이트 감소

### Q: StatefulWidget 대신 Hooks를 사용해야 하는 이유는 무엇인가요?

[Section titled “Q: StatefulWidget 대신 Hooks를 사용해야 하는 이유는 무엇인가요?”](#q-statefulwidget-대신-hooks를-사용해야-하는-이유는-무엇인가요)

Flutter Hooks는 React의 Hooks에서 영감을 받은 패턴으로, 다음과 같은 장점이 있습니다:

1. 상태 로직 재사용 용이
2. 코드 중복 감소
3. `initState`, `dispose` 등의 라이프사이클 메서드를 명시적으로 처리할 필요 없음
4. 더 간결하고 가독성 있는 코드

예를 들어, StatefulWidget을 사용하면:

```dart
1
class CounterWidget extends StatefulWidget {
2
  @override
3
  _CounterWidgetState createState() => _CounterWidgetState();
4
}
5


6
class _CounterWidgetState extends State<CounterWidget> {
7
  int count = 0;
8


9
  void increment() {
10
    setState(() {
11
      count++;
12
    });
13
  }
14


15
  @override
16
  Widget build(BuildContext context) {
17
    return /* 위젯 빌드 */;
18
  }
19
}
```

Hooks를 사용하면:

```dart
1
class CounterWidget extends HookWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    final count = useState(0);
5


6
    return /* 위젯 빌드 */;
7
  }
8
}
```

## UI 및 레이아웃

[Section titled “UI 및 레이아웃”](#ui-및-레이아웃)

### Q: 반응형 UI를 구현하는 가장 좋은 방법은 무엇인가요?

[Section titled “Q: 반응형 UI를 구현하는 가장 좋은 방법은 무엇인가요?”](#q-반응형-ui를-구현하는-가장-좋은-방법은-무엇인가요)

Flutter에서 반응형 UI를 구현하는 여러 방법이 있습니다:

1. **MediaQuery 사용**:

```dart
1
final width = MediaQuery.of(context).size.width;
2
if (width > 600) {
3
  // 태블릿/데스크톱 레이아웃
4
} else {
5
  // 모바일 레이아웃
6
}
```

2. **LayoutBuilder 사용**:

```dart
1
LayoutBuilder(
2
  builder: (context, constraints) {
3
    if (constraints.maxWidth > 600) {
4
      return WideLayout();
5
    } else {
6
      return NarrowLayout();
7
    }
8
  },
9
)
```

3. **flutter\_screenutil** 같은 라이브러리 사용:

```dart
1
Container(
2
  width: 100.w, // 화면 너비의 100%
3
  height: 50.h, // 화면 높이의 50%
4
)
```

### Q: ListView의 성능을 최적화하는 방법은?

[Section titled “Q: ListView의 성능을 최적화하는 방법은?”](#q-listview의-성능을-최적화하는-방법은)

ListView 성능 최적화를 위한 팁:

1. `ListView.builder` 사용하여 필요한 항목만 렌더링
2. `const` 위젯 활용
3. `RepaintBoundary`로 리페인트 영역 제한
4. 복잡한 항목에 `cacheExtent` 조정
5. 이미지에 `cached_network_image` 패키지 사용
6. 큰 목록은 `ListView.builder` 대신 `Sliver` 위젯 고려

```dart
1
ListView.builder(
2
  // 크기 지정으로 불필요한 레이아웃 계산 방지
3
  itemCount: items.length,
4
  // 더 많은 항목을 미리 로드하여 스크롤 시 부드럽게
5
  cacheExtent: 100,
6
  itemBuilder: (context, index) {
7
    return RepaintBoundary(
8
      child: MyListItem(
9
        key: ValueKey(items[index].id),
10
        item: items[index],
11
      ),
12
    );
13
  },
14
)
```

### Q: 스크롤 시 앱바가 사라지는 효과를 구현하려면 어떻게 해야 하나요?

[Section titled “Q: 스크롤 시 앱바가 사라지는 효과를 구현하려면 어떻게 해야 하나요?”](#q-스크롤-시-앱바가-사라지는-효과를-구현하려면-어떻게-해야-하나요)

`CustomScrollView`와 `SliverAppBar`를 사용하여 구현할 수 있습니다:

```dart
1
CustomScrollView(
2
  slivers: [
3
    SliverAppBar(
4
      floating: true, // 살짝 스크롤업 하면 보임
5
      pinned: false,  // 스크롤해도 상단에 고정되지 않음
6
      snap: true,     // 스크롤업 시 완전히 표시됨
7
      title: Text('타이틀'),
8
      expandedHeight: 200.0,
9
      flexibleSpace: FlexibleSpaceBar(
10
        background: Image.asset(
11
          'assets/header.jpg',
12
          fit: BoxFit.cover,
13
        ),
14
      ),
15
    ),
16
    // 나머지 콘텐츠
17
    SliverList(
18
      delegate: SliverChildBuilderDelegate(
19
        (context, index) => ListTile(title: Text('항목 $index')),
20
        childCount: 50,
21
      ),
22
    ),
23
  ],
24
)
```

## 네트워킹 및 API

[Section titled “네트워킹 및 API”](#네트워킹-및-api)

### Q: API 호출 시 최적의 에러 처리 방법은 무엇인가요?

[Section titled “Q: API 호출 시 최적의 에러 처리 방법은 무엇인가요?”](#q-api-호출-시-최적의-에러-처리-방법은-무엇인가요)

API 호출 시 에러 처리를 위한 권장사항:

1. 명확한 예외 계층 정의:

```dart
1
abstract class AppException implements Exception {
2
  final String message;
3
  AppException(this.message);
4
}
5


6
class NetworkException extends AppException {
7
  NetworkException(String message) : super(message);
8
}
9


10
class ServerException extends AppException {
11
  final int statusCode;
12
  ServerException(String message, this.statusCode) : super(message);
13
}
```

2. API 응답을 Result 패턴으로 래핑:

```dart
1
class Result<T> {
2
  final T? data;
3
  final AppException? error;
4


5
  Result.success(this.data) : error = null;
6
  Result.failure(this.error) : data = null;
7


8
  bool get isSuccess => error == null;
9
  bool get isFailure => error != null;
10
}
```

3. 비동기 호출 처리:

```dart
1
Future<Result<UserData>> fetchUserData(String userId) async {
2
  try {
3
    final response = await dio.get('/users/$userId');
4
    return Result.success(UserData.fromJson(response.data));
5
  } on DioException catch (e) {
6
    return Result.failure(
7
      ServerException(
8
        e.message ?? 'Unknown error',
9
        e.response?.statusCode ?? 500,
10
      ),
11
    );
12
  } on Exception catch (e) {
13
    return Result.failure(NetworkException(e.toString()));
14
  }
15
}
```

4. UI에서 사용:

```dart
1
FutureBuilder<Result<UserData>>(
2
  future: fetchUserData('123'),
3
  builder: (context, snapshot) {
4
    if (snapshot.connectionState == ConnectionState.waiting) {
5
      return CircularProgressIndicator();
6
    }
7


8
    if (snapshot.hasData) {
9
      final result = snapshot.data!;
10


11
      if (result.isSuccess) {
12
        return UserInfoWidget(user: result.data!);
13
      } else {
14
        // 에러 타입에 따른 처리
15
        if (result.error is NetworkException) {
16
          return NetworkErrorWidget(
17
            onRetry: () => setState(() {}),
18
          );
19
        } else if (result.error is ServerException) {
20
          final error = result.error as ServerException;
21
          return ServerErrorWidget(
22
            statusCode: error.statusCode,
23
            message: error.message,
24
          );
25
        }
26
      }
27
    }
28


29
    return ErrorWidget('알 수 없는 오류가 발생했습니다.');
30
  },
31
)
```

### Q: Dio vs http 패키지 중 어떤 것을 사용해야 할까요?

[Section titled “Q: Dio vs http 패키지 중 어떤 것을 사용해야 할까요?”](#q-dio-vs-http-패키지-중-어떤-것을-사용해야-할까요)

두 패키지 모두 API 통신에 사용되지만 다음과 같은 차이가 있습니다:

* **http 패키지**:

  * 플러터 팀이 관리하는 공식 패키지
  * 간단한 HTTP 요청에 적합
  * 기본적인 기능만 제공

* **Dio 패키지**:

  * 더 많은 기능을 제공
  * 인터셉터, 취소 토큰, 폼 데이터, 글로벌 구성 등 고급 기능
  * 타임아웃, 응답 변환, 에러 핸들링 등의 설정이 쉬움
  * 파일 다운로드/업로드 지원이 더 나음

일반적으로 복잡한 API 통신이 필요한 프로젝트에는 Dio를 권장합니다.

## 성능 최적화

[Section titled “성능 최적화”](#성능-최적화)

### Q: Flutter 앱의 성능을 분석하는 방법은?

[Section titled “Q: Flutter 앱의 성능을 분석하는 방법은?”](#q-flutter-앱의-성능을-분석하는-방법은)

Flutter 앱의 성능을 분석하는 여러 도구가 있습니다:

1. **Flutter DevTools**:

   * 위젯 트리 검사
   * 성능 오버레이 (`flutter run --profile` 모드에서 ‘P’ 키)
   * 메모리 프로파일링
   * 네트워크 트래픽 모니터링

2. **Flutter Performance 위젯**:

```dart
1
import 'package:flutter/rendering.dart';
2


3
void main() {
4
  debugPaintSizeEnabled = true; // 레이아웃 디버깅
5
  debugPaintLayerBordersEnabled = true; // 레이어 경계 표시
6
  debugPaintPointersEnabled = true; // 터치 포인터 표시
7
  runApp(MyApp());
8
}
```

3. **애널리틱스 도구**:

   * Firebase Performance Monitoring
   * Sentry 성능 모니터링

### Q: 이미지 로딩 성능을 최적화하는 방법은?

[Section titled “Q: 이미지 로딩 성능을 최적화하는 방법은?”](#q-이미지-로딩-성능을-최적화하는-방법은)

이미지 로딩 성능 최적화를 위한 팁:

1. `cached_network_image` 패키지 사용:

```dart
1
CachedNetworkImage(
2
  imageUrl: "http://example.com/image.jpg",
3
  placeholder: (context, url) => CircularProgressIndicator(),
4
  errorWidget: (context, url, error) => Icon(Icons.error),
5
)
```

2. 적절한 크기의 이미지 로드:

```dart
1
// 서버에서 이미지 크기 조정 (쿼리 파라미터 활용)
2
Image.network('https://example.com/image.jpg?width=300&height=300')
3


4
// 또는 Flutter에서 이미지 크기 제한
5
Image.network(
6
  'https://example.com/large-image.jpg',
7
  cacheWidth: 300, // 메모리에 캐시되는 이미지 크기 제한
8
  cacheHeight: 300,
9
)
```

3. 여러 해상도 지원:

```dart
1
// 2x, 3x 해상도 이미지 제공
2
AssetImage('assets/image.png')
```

4. 이미지 포맷 최적화:

   * JPEG: 사진에 적합
   * PNG: 투명도가 필요한 이미지에 적합
   * WebP: 더 나은 압축률 (작은 파일 크기)

## 앱 배포

[Section titled “앱 배포”](#앱-배포)

### Q: 앱 출시 전 체크리스트에는 어떤 것들이 있나요?

[Section titled “Q: 앱 출시 전 체크리스트에는 어떤 것들이 있나요?”](#q-앱-출시-전-체크리스트에는-어떤-것들이-있나요)

앱 출시 전 체크리스트:

1. **앱 성능 및 UI 검토**

   * 다양한 기기에서 테스트
   * 화면 회전 및 다양한 화면 크기 대응
   * 다크 모드 지원 확인

2. **리소스 최적화**

   * 이미지 최적화
   * 앱 크기 최소화
   * 불필요한 의존성 제거

3. **Error handling**

   * 모든 에러 시나리오 테스트
   * 충돌 리포팅 도구 통합 (Firebase Crashlytics, Sentry 등)

4. **권한 및 개인정보 처리**

   * 최소 필요 권한만 요청
   * 개인정보 처리방침 준비
   * GDPR/CCPA 준수 확인

5. **접근성**

   * 화면 낭독기 지원
   * 충분한 색상 대비
   * 확대/축소 지원

6. **앱 메타데이터**

   * 스크린샷 및 아이콘 준비
   * 앱 설명 및 키워드 최적화
   * 프로모션 자료 준비

### Q: Android와 iOS 모두 지원할 때 주의할 점은?

[Section titled “Q: Android와 iOS 모두 지원할 때 주의할 점은?”](#q-android와-ios-모두-지원할-때-주의할-점은)

Android와 iOS 모두 지원 시 고려사항:

1. **플랫폼별 UI 가이드라인**

   * Material Design (Android)
   * Cupertino (iOS)
   * `flutter/material.dart`와 `flutter/cupertino.dart` 적절히 사용

2. **플랫폼별 동작 차이**

   * 뒤로 가기 제스처 (iOS의 스와이프)
   * 알림 권한 처리 방식
   * 앱 라이프사이클 이벤트 처리

3. **플랫폼 감지**

```dart
1
import 'dart:io' show Platform;
2


3
if (Platform.isIOS) {
4
  // iOS 전용 코드
5
} else if (Platform.isAndroid) {
6
  // Android 전용 코드
7
}
```

4. **플랫폼별 설정 파일**

   * AndroidManifest.xml
   * Info.plist
   * 각 플랫폼에 맞는 권한 설명 추가

5. **플러그인 호환성**

   * 사용하는 모든 플러그인이 양쪽 플랫폼을 지원하는지 확인
   * 플랫폼별 구현이 필요한 경우 조건부 코드 작성

## 디버깅 및 테스팅

[Section titled “디버깅 및 테스팅”](#디버깅-및-테스팅)

### Q: Flutter 앱을 효과적으로 디버깅하는 방법은?

[Section titled “Q: Flutter 앱을 효과적으로 디버깅하는 방법은?”](#q-flutter-앱을-효과적으로-디버깅하는-방법은)

Flutter 앱 디버깅을 위한 팁:

1. **print vs debugPrint**:

   * `print`보다 `debugPrint` 사용 권장
   * 릴리스 모드에서 자동으로 비활성화됨
   * 출력 속도 제한으로 로그 손실 방지

2. **개발자 도구 활용**:

   * `flutter run` 시 가능한 커맨드 (q, r, p 등) 숙지
   * `flutter run --profile` 또는 `--release`로 성능 테스트

3. **IDE 디버깅 도구**:

   * 중단점(breakpoint) 설정
   * 변수 조사
   * 호출 스택 추적

4. **로깅 라이브러리 활용**:

```dart
1
import 'package:logger/logger.dart';
2


3
final logger = Logger(
4
  printer: PrettyPrinter(
5
    methodCount: 2, // 호출 스택 표시 수
6
    errorMethodCount: 8, // 오류 발생 시 호출 스택 표시 수
7
    lineLength: 120, // 출력 줄 길이
8
    colors: true, // 색상 활성화
9
    printEmojis: true, // 이모지 표시
10
    printTime: true, // 시간 표시
11
  ),
12
);
13


14
// 사용
15
logger.d("디버그 메시지");
16
logger.i("정보 메시지");
17
logger.w("경고 메시지");
18
logger.e("오류 메시지", error: e, stackTrace: s);
```

### Q: 위젯 테스트와 통합 테스트의 차이점은 무엇인가요?

[Section titled “Q: 위젯 테스트와 통합 테스트의 차이점은 무엇인가요?”](#q-위젯-테스트와-통합-테스트의-차이점은-무엇인가요)

* **단위 테스트**:

  * 개별 함수, 클래스, 메서드 테스트
  * 외부 의존성 없이 빠르게 실행
  * 예: 유틸리티 함수, 비즈니스 로직

* **위젯 테스트**:

  * 개별 위젯 또는 위젯 그룹 테스트
  * 실제 기기/에뮬레이터 없이 가상 환경에서 실행
  * UI 상호작용 및 렌더링 테스트
  * 예: 폼 제출, 리스트 스크롤, 상태 변경 확인

* **통합 테스트**:

  * 실제 기기/에뮬레이터에서 실행
  * 전체 앱 흐름 및 여러 위젯 간 상호작용 테스트
  * 외부 서비스 및 플랫폼 API와 통합 테스트
  * 예: 로그인 프로세스, 데이터 저장/검색, 플러그인 동작

## 기타 질문

[Section titled “기타 질문”](#기타-질문)

### Q: Flutter 웹 개발 시 주의할 점은?

[Section titled “Q: Flutter 웹 개발 시 주의할 점은?”](#q-flutter-웹-개발-시-주의할-점은)

Flutter 웹 개발 시 고려사항:

1. **성능 최적화**:

   * 초기 로딩 시간 최적화 (앱 크기 최소화)
   * 이미지 최적화 및 지연 로딩
   * `flutter build web --web-renderer canvaskit` vs `--web-renderer html` 선택

2. **브라우저 호환성**:

   * 다양한 브라우저에서 테스트
   * 모바일 브라우저 지원 확인
   * 폴백 메커니즘 구현

3. **SEO 고려**:

   * Flutter 웹은 기본적으로 SEO에 취약
   * 서버 사이드 렌더링 또는 정적 HTML 생성 고려
   * 메타데이터 및 robots.txt 관리

4. **플랫폼 감지**:

```dart
1
import 'package:flutter/foundation.dart' show kIsWeb;
2


3
if (kIsWeb) {
4
  // 웹 전용 코드
5
} else {
6
  // 모바일 전용 코드
7
}
```

### Q: Flutter로 게임을 개발할 수 있나요?

[Section titled “Q: Flutter로 게임을 개발할 수 있나요?”](#q-flutter로-게임을-개발할-수-있나요)

Flutter로 간단한 2D 게임을 개발할 수 있습니다. 복잡한 게임은 Unity나 전용 게임 엔진이 더 적합합니다.

Flutter 게임 개발을 위한 옵션:

1. **Flutter 자체 기능 활용**:

   * `CustomPainter`로 2D 그래픽 그리기
   * 애니메이션, 제스처 인식기로 인터랙션 구현
   * `StatefulWidget`과 `Ticker`로 게임 루프 구현

2. **라이브러리 활용**:

   * `flame`: Flutter용 게임 엔진 ([링크](https://flame-engine.org/))
   * `flutter_joystick`: 가상 조이스틱 구현
   * `audioplayers`: 게임 오디오 재생

3. **한계점**:

   * 복잡한 3D 게임에는 적합하지 않음
   * 높은 프레임 레이트 요구사항에 제약
   * 배터리 소모가 클 수 있음

### Q: Flutter Desktop 앱 개발 상태는 어떤가요?

[Section titled “Q: Flutter Desktop 앱 개발 상태는 어떤가요?”](#q-flutter-desktop-앱-개발-상태는-어떤가요)

Flutter Desktop은 macOS, Windows, Linux를 지원하며 안정적인 버전이 출시되었습니다:

1. **현재 상태**:

   * macOS: 안정 버전 출시
   * Windows: 안정 버전 출시
   * Linux: 안정 버전 출시

2. **시작하기**:

```bash
1
flutter config --enable-windows-desktop
2
flutter config --enable-macos-desktop
3
flutter config --enable-linux-desktop
4
flutter create --platforms=windows,macos,linux my_desktop_app
```

3. **고려사항**:

   * 파일 시스템 접근
   * 네이티브 메뉴 및 윈도우 관리
   * 플랫폼별 패키징 및 배포
   * 하드웨어 가속

4. **추천 패키지**:

   * `window_size`: 창 크기 및 위치 조정
   * `flutter_acrylic`: 윈도우 불투명도 및 효과
   * `desktop_window`: 데스크톱 창 제어
   * `file_picker`: 네이티브 파일 선택 대화상자

Flutter Desktop은 계속 발전 중이며, 대부분의 기업용 앱과 도구 개발에 충분한 기능을 제공합니다.

# iOS 라이브 액티비티

iOS 16부터 도입된 라이브 액티비티(Live Activities)는 사용자가 앱을 열지 않고도 실시간으로 업데이트되는 정보를 잠금 화면이나 동적 섬(Dynamic Island)에서 확인할 수 있게 해주는 기능입니다. 이 문서에서는 Flutter 앱에서 iOS 라이브 액티비티를 구현하는 방법에 대해 알아보겠습니다.

## 라이브 액티비티 개요

[Section titled “라이브 액티비티 개요”](#라이브-액티비티-개요)

라이브 액티비티는 다음과 같은 상황에 유용합니다:

* 음식 배달 상태 추적
* 스포츠 경기 점수 업데이트
* 차량 호출 위치 추적
* 운동 세션 통계 표시
* 타이머 또는 카운트다운

라이브 액티비티는 iOS 16.1 이상에서 지원되며, 동적 섬은 iPhone 14 Pro 이상의 모델에서만 사용할 수 있습니다.

## 구현 개요

[Section titled “구현 개요”](#구현-개요)

Flutter 앱에서 iOS 라이브 액티비티를 구현하려면 다음과 같은 단계가 필요합니다:

1. iOS 위젯 익스텐션 생성
2. 익스텐션용 Swift 코드 작성
3. Flutter 앱에서 라이브 액티비티 제어 구현
4. 푸시 알림을 통한 원격 업데이트 구성

Flutter는 네이티브 iOS 위젯을 직접 렌더링할 수 없으므로, 네이티브 Swift 코드를 통해 라이브 액티비티를 구현해야 합니다.

## 필요한 패키지

[Section titled “필요한 패키지”](#필요한-패키지)

라이브 액티비티를 구현하기 위해 다음 패키지를 사용합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  live_activities: ^1.9.0 # iOS 라이브 액티비티 제어용 플러그인
```

## 1. iOS 위젯 익스텐션 생성

[Section titled “1. iOS 위젯 익스텐션 생성”](#1-ios-위젯-익스텐션-생성)

먼저, Xcode에서 iOS 위젯 익스텐션을 생성해야 합니다:

1. Xcode에서 Flutter 프로젝트의 iOS 폴더 열기 (Runner.xcworkspace)
2. File > New > Target 선택
3. “Widget Extension” 템플릿 선택 후 “Next” 클릭
4. 익스텐션 이름 입력 (예: “LiveActivitiesExtension”)
5. “Include Live Activity” 옵션 체크
6. “Finish” 클릭

## 2. 활동 정보 모델 정의

[Section titled “2. 활동 정보 모델 정의”](#2-활동-정보-모델-정의)

라이브 액티비티에 표시할 데이터 모델을 정의합니다:

ActivityAttributes.swift

```swift
1
import ActivityKit
2
import SwiftUI
3


4
struct DeliveryAttributes: ActivityAttributes {
5
    public struct ContentState: Codable, Hashable {
6
        var status: String
7
        var estimatedDeliveryTime: Date
8
        var driverName: String
9
        var driverLocation: String
10
        var progressPercentage: Double
11
    }
12


13
    var orderNumber: String
14
    var restaurantName: String
15
}
```

## 3. 라이브 액티비티 뷰 디자인

[Section titled “3. 라이브 액티비티 뷰 디자인”](#3-라이브-액티비티-뷰-디자인)

라이브 액티비티의 레이아웃을 정의합니다:

LiveActivitiesExtensionLiveActivity.swift

```swift
1
import ActivityKit
2
import WidgetKit
3
import SwiftUI
4


5
struct LiveActivitiesExtensionLiveActivity: Widget {
6
    var body: some WidgetConfiguration {
7
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
8
            // 잠금 화면, 알림 센터 레이아웃
9
            HStack {
10
                VStack(alignment: .leading) {
11
                    Text(context.attributes.restaurantName)
12
                        .font(.headline)
13


14
                    Text("주문 번호: \(context.attributes.orderNumber)")
15
                        .font(.subheadline)
16


17
                    Text("배달원: \(context.state.driverName)")
18
                        .font(.body)
19


20
                    Text(context.state.status)
21
                        .font(.body)
22
                        .foregroundColor(.blue)
23


24
                    Text("예상 도착 시간: \(formatDate(context.state.estimatedDeliveryTime))")
25
                        .font(.caption)
26
                }
27


28
                Spacer()
29


30
                VStack {
31
                    ProgressView(value: context.state.progressPercentage, total: 100)
32
                        .progressViewStyle(CircularProgressViewStyle())
33


34
                    Text("\(Int(context.state.progressPercentage))%")
35
                        .font(.caption)
36
                }
37
            }
38
            .padding()
39
        } dynamicIsland: { context in
40
            // 동적 섬 레이아웃
41
            DynamicIsland {
42
                // 확장되지 않은 상태 - 콤팩트 뷰
43
                DynamicIslandExpandedRegion(.leading) {
44
                    Text(context.attributes.restaurantName)
45
                        .font(.headline)
46
                }
47


48
                DynamicIslandExpandedRegion(.trailing) {
49
                    Text(context.state.status)
50
                        .font(.caption)
51
                        .foregroundColor(.blue)
52
                }
53


54
                DynamicIslandExpandedRegion(.bottom) {
55
                    HStack {
56
                        VStack(alignment: .leading) {
57
                            Text("배달원: \(context.state.driverName)")
58
                                .font(.caption)
59
                            Text(context.state.driverLocation)
60
                                .font(.caption2)
61
                        }
62


63
                        Spacer()
64


65
                        VStack(alignment: .trailing) {
66
                            Text("도착 예정")
67
                                .font(.caption)
68
                            Text(formatTime(context.state.estimatedDeliveryTime))
69
                                .font(.caption)
70
                        }
71
                    }
72
                }
73
            } compactLeading: {
74
                Text(context.attributes.restaurantName.prefix(1))
75
                    .font(.caption)
76
            } compactTrailing: {
77
                Text("\(Int(context.state.progressPercentage))%")
78
                    .font(.caption)
79
            } minimal: {
80
                ProgressView(value: context.state.progressPercentage, total: 100)
81
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
82
                    .frame(width: 20, height: 20)
83
            }
84
        }
85
    }
86


87
    private func formatDate(_ date: Date) -> String {
88
        let formatter = DateFormatter()
89
        formatter.dateStyle = .none
90
        formatter.timeStyle = .short
91
        return formatter.string(from: date)
92
    }
93


94
    private func formatTime(_ date: Date) -> String {
95
        let formatter = DateFormatter()
96
        formatter.dateFormat = "HH:mm"
97
        return formatter.string(from: date)
98
    }
99
}
```

## 4. Info.plist 권한 추가

[Section titled “4. Info.plist 권한 추가”](#4-infoplist-권한-추가)

라이브 액티비티 익스텐션의 Info.plist에 다음 키를 추가합니다:

```xml
1
<key>NSSupportsLiveActivities</key>
2
<true/>
```

## 5. Flutter 앱에서 라이브 액티비티 연동

[Section titled “5. Flutter 앱에서 라이브 액티비티 연동”](#5-flutter-앱에서-라이브-액티비티-연동)

Flutter 측 코드에서 라이브 액티비티를 제어하는 서비스를 구현합니다:

```dart
1
import 'dart:io';
2
import 'package:live_activities/live_activities.dart';
3
import 'package:flutter/services.dart';
4


5
class LiveActivityService {
6
  final LiveActivities _liveActivities = LiveActivities();
7


8
  // 활동 ID를 저장할 변수
9
  String? _activityId;
10


11
  // 라이브 액티비티 시작
12
  Future<bool> startDeliveryActivity({
13
    required String orderNumber,
14
    required String restaurantName,
15
    required String status,
16
    required DateTime estimatedDeliveryTime,
17
    required String driverName,
18
    required String driverLocation,
19
    required double progressPercentage,
20
  }) async {
21
    if (!Platform.isIOS) return false;
22


23
    try {
24
      final Map<String, dynamic> attributes = {
25
        'orderNumber': orderNumber,
26
        'restaurantName': restaurantName,
27
      };
28


29
      final Map<String, dynamic> contentState = {
30
        'status': status,
31
        'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
32
        'driverName': driverName,
33
        'driverLocation': driverLocation,
34
        'progressPercentage': progressPercentage,
35
      };
36


37
      final activityId = await _liveActivities.createActivity(
38
        'DeliveryAttributes',  // ActivityAttributes 클래스 이름과 일치해야 함
39
        attributes,
40
        contentState,
41
      );
42


43
      if (activityId != null) {
44
        _activityId = activityId;
45
        return true;
46
      }
47


48
      return false;
49
    } on PlatformException catch (e) {
50
      print('라이브 액티비티 시작 오류: ${e.message}');
51
      return false;
52
    }
53
  }
54


55
  // 라이브 액티비티 업데이트
56
  Future<bool> updateDeliveryActivity({
57
    required String status,
58
    required DateTime estimatedDeliveryTime,
59
    required String driverName,
60
    required String driverLocation,
61
    required double progressPercentage,
62
  }) async {
63
    if (!Platform.isIOS || _activityId == null) return false;
64


65
    try {
66
      final Map<String, dynamic> contentState = {
67
        'status': status,
68
        'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
69
        'driverName': driverName,
70
        'driverLocation': driverLocation,
71
        'progressPercentage': progressPercentage,
72
      };
73


74
      await _liveActivities.updateActivity(
75
        _activityId!,
76
        contentState,
77
      );
78


79
      return true;
80
    } on PlatformException catch (e) {
81
      print('라이브 액티비티 업데이트 오류: ${e.message}');
82
      return false;
83
    }
84
  }
85


86
  // 라이브 액티비티 종료
87
  Future<bool> endDeliveryActivity({
88
    String? finalStatus,
89
  }) async {
90
    if (!Platform.isIOS || _activityId == null) return false;
91


92
    try {
93
      final Map<String, dynamic>? contentState = finalStatus != null
94
          ? {
95
              'status': finalStatus,
96
              'progressPercentage': 100.0,
97
            }
98
          : null;
99


100
      await _liveActivities.endActivity(
101
        _activityId!,
102
        contentState,
103
      );
104


105
      _activityId = null;
106
      return true;
107
    } on PlatformException catch (e) {
108
      print('라이브 액티비티 종료 오류: ${e.message}');
109
      return false;
110
    }
111
  }
112


113
  // 모든 라이브 액티비티 종료
114
  Future<bool> endAllActivities() async {
115
    if (!Platform.isIOS) return false;
116


117
    try {
118
      await _liveActivities.endAllActivities();
119
      _activityId = null;
120
      return true;
121
    } on PlatformException catch (e) {
122
      print('모든 라이브 액티비티 종료 오류: ${e.message}');
123
      return false;
124
    }
125
  }
126


127
  // 액티비티 상태 확인
128
  Future<bool> isLiveActivityAvailable() async {
129
    if (!Platform.isIOS) return false;
130


131
    try {
132
      return await _liveActivities.isLiveActivityAvailable() ?? false;
133
    } on PlatformException catch (e) {
134
      print('라이브 액티비티 상태 확인 오류: ${e.message}');
135
      return false;
136
    }
137
  }
138
}
```

## 6. 라이브 액티비티 사용 예시

[Section titled “6. 라이브 액티비티 사용 예시”](#6-라이브-액티비티-사용-예시)

다음은 Flutter 앱에서 라이브 액티비티를 시작, 업데이트 및 종료하는 방법의 예시입니다:

```dart
1
class DeliveryViewModel extends StateNotifier<DeliveryState> {
2
  final LiveActivityService _liveActivityService = LiveActivityService();
3


4
  DeliveryViewModel() : super(DeliveryState.initial());
5


6
  // 배달 시작
7
  Future<void> startDelivery() async {
8
    // 배달 정보 초기화
9
    state = DeliveryState(
10
      orderNumber: 'ORD-12345',
11
      restaurantName: '맛있는 식당',
12
      status: '배달 준비 중',
13
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
14
      driverName: '홍길동',
15
      driverLocation: '식당에서 음식 픽업 중',
16
      progressPercentage: 10.0,
17
    );
18


19
    // 라이브 액티비티 시작
20
    if (Platform.isIOS) {
21
      final isAvailable = await _liveActivityService.isLiveActivityAvailable();
22


23
      if (isAvailable) {
24
        await _liveActivityService.startDeliveryActivity(
25
          orderNumber: state.orderNumber,
26
          restaurantName: state.restaurantName,
27
          status: state.status,
28
          estimatedDeliveryTime: state.estimatedDeliveryTime,
29
          driverName: state.driverName,
30
          driverLocation: state.driverLocation,
31
          progressPercentage: state.progressPercentage,
32
        );
33
      }
34
    }
35
  }
36


37
  // 배달 상태 업데이트
38
  Future<void> updateDeliveryStatus({
39
    required String status,
40
    required String driverLocation,
41
    required double progressPercentage,
42
  }) async {
43
    // 상태 업데이트
44
    state = state.copyWith(
45
      status: status,
46
      driverLocation: driverLocation,
47
      progressPercentage: progressPercentage,
48
    );
49


50
    // 라이브 액티비티 업데이트
51
    if (Platform.isIOS) {
52
      await _liveActivityService.updateDeliveryActivity(
53
        status: state.status,
54
        estimatedDeliveryTime: state.estimatedDeliveryTime,
55
        driverName: state.driverName,
56
        driverLocation: state.driverLocation,
57
        progressPercentage: state.progressPercentage,
58
      );
59
    }
60
  }
61


62
  // 배달 완료
63
  Future<void> completeDelivery() async {
64
    // 상태 업데이트
65
    state = state.copyWith(
66
      status: '배달 완료',
67
      progressPercentage: 100.0,
68
    );
69


70
    // 라이브 액티비티 종료
71
    if (Platform.isIOS) {
72
      await _liveActivityService.endDeliveryActivity(
73
        finalStatus: '배달 완료',
74
      );
75
    }
76
  }
77


78
  // 배달 취소
79
  Future<void> cancelDelivery() async {
80
    // 상태 업데이트
81
    state = state.copyWith(
82
      status: '배달 취소됨',
83
    );
84


85
    // 라이브 액티비티 종료
86
    if (Platform.isIOS) {
87
      await _liveActivityService.endDeliveryActivity(
88
        finalStatus: '배달 취소됨',
89
      );
90
    }
91
  }
92
}
```

## 7. 원격 업데이트 설정

[Section titled “7. 원격 업데이트 설정”](#7-원격-업데이트-설정)

푸시 알림을 통해 라이브 액티비티를 원격으로 업데이트하려면 추가 설정이 필요합니다:

### 7.1. APNs (Apple Push Notification Service) 설정

[Section titled “7.1. APNs (Apple Push Notification Service) 설정”](#71-apns-apple-push-notification-service-설정)

1. Apple Developer 계정에서 Push Notifications 활성화
2. 앱 ID에 Push Notifications 기능 추가
3. 푸시 알림 인증서 생성 및 다운로드

### 7.2. ActivityKit 푸시 페이로드 구조

[Section titled “7.2. ActivityKit 푸시 페이로드 구조”](#72-activitykit-푸시-페이로드-구조)

라이브 액티비티를 업데이트하기 위한 푸시 알림은 특별한 형식을 따릅니다:

```json
1
{
2
  "aps": {
3
    "timestamp": 1728349874,
4
    "event": "update",
5
    "content-state": {
6
      "status": "배달 중",
7
      "estimatedDeliveryTime": "2023-08-15T12:45:00Z",
8
      "driverName": "홍길동",
9
      "driverLocation": "목적지로 이동 중",
10
      "progressPercentage": 65.0
11
    },
12
    "alert": {
13
      "title": "배달 상태 업데이트",
14
      "body": "음식이 곧 도착할 예정입니다."
15
    }
16
  }
17
}
```

푸시 알림을 처리하기 위해 AppDelegate를 수정합니다:

AppDelegate.swift

```swift
1
import UIKit
2
import Flutter
3
import ActivityKit
4


5
@UIApplicationMain
6
@objc class AppDelegate: FlutterAppDelegate {
7
  override func application(
8
    _ application: UIApplication,
9
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
10
  ) -> Bool {
11
    // 푸시 알림 권한 요청
12
    UNUserNotificationCenter.current().delegate = self
13
    application.registerForRemoteNotifications()
14


15
    GeneratedPluginRegistrant.register(with: self)
16
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
17
  }
18


19
  // 푸시 토큰 수신
20
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
21
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
22
    let token = tokenParts.joined()
23
    print("디바이스 토큰: \(token)")
24


25
    // 토큰을 서버로 전송하는 로직 추가
26


27
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
28
  }
29


30
  // 푸시 등록 실패
31
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
32
    print("푸시 알림 등록 실패: \(error)")
33
    super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
34
  }
35
}
36


37
// 푸시 알림 수신 처리
38
extension AppDelegate {
39
  override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
40
    let userInfo = response.notification.request.content.userInfo
41
    print("푸시 알림 수신: \(userInfo)")
42
    completionHandler()
43
  }
44


45
  override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
46
    let userInfo = notification.request.content.userInfo
47
    print("앱 활성화 상태에서 푸시 알림 수신: \(userInfo)")
48
    completionHandler([.banner, .sound])
49
  }
50
}
```

## 8. 애니메이션 및 디자인 커스터마이징

[Section titled “8. 애니메이션 및 디자인 커스터마이징”](#8-애니메이션-및-디자인-커스터마이징)

라이브 액티비티의 시각적 효과를 향상시키기 위해 애니메이션과 커스텀 디자인을 추가할 수 있습니다:

```swift
1
struct AnimatedProgressView: View {
2
    var progress: Double
3
    @State private var animateProgress: Double = 0
4


5
    var body: some View {
6
        ZStack {
7
            Circle()
8
                .stroke(lineWidth: 6)
9
                .opacity(0.3)
10
                .foregroundColor(.blue)
11


12
            Circle()
13
                .trim(from: 0.0, to: CGFloat(min(animateProgress, 1.0)))
14
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
15
                .foregroundColor(.blue)
16
                .rotationEffect(Angle(degrees: 270.0))
17
                .animation(.linear(duration: 1.0), value: animateProgress)
18


19
            Text("\(Int(animateProgress * 100))%")
20
                .font(.caption)
21
                .fontWeight(.bold)
22
        }
23
        .frame(width: 50, height: 50)
24
        .onAppear {
25
            animateProgress = progress / 100
26
        }
27
        .onChange(of: progress) { newValue in
28
            animateProgress = newValue / 100
29
        }
30
    }
31
}
```

## 9. 제한사항 및 고려사항

[Section titled “9. 제한사항 및 고려사항”](#9-제한사항-및-고려사항)

라이브 액티비티 구현 시 고려해야 할 사항:

1. **업데이트 빈도 제한**

   * iOS는 라이브 액티비티 업데이트 빈도를 제한합니다(일반적으로 15분에 최대 4회).
   * 너무 자주 업데이트하면 시스템에서 무시될 수 있습니다.

2. **배터리 및 성능 영향**

   * 라이브 액티비티는 백그라운드에서도 리소스를 사용하므로 배터리 소모에 영향을 줍니다.
   * 필요한 정보만 효율적으로 표시하도록 설계해야 합니다.

3. **활동 지속 시간**

   * 라이브 액티비티는 최대 8시간까지 활성화됩니다.
   * 8시간이 지나면 시스템에서 자동으로 종료됩니다.

4. **테스트 제한**

   * 시뮬레이터에서는 동적 섬 테스트가 제한적입니다.
   * 완전한 테스트를 위해 실제 기기를 사용하는 것이 좋습니다.

## 10. 문제 해결

[Section titled “10. 문제 해결”](#10-문제-해결)

### 라이브 액티비티가 표시되지 않는 경우

[Section titled “라이브 액티비티가 표시되지 않는 경우”](#라이브-액티비티가-표시되지-않는-경우)

1. iOS 버전이 16.1 이상인지 확인
2. Info.plist에 NSSupportsLiveActivities 키가 true로 설정되어 있는지 확인
3. 동적 섬은 iPhone 14 Pro 이상 모델만 지원되는지 확인
4. 사용자가 설정에서 라이브 액티비티를 비활성화했는지 확인

### 업데이트가 반영되지 않는 경우

[Section titled “업데이트가 반영되지 않는 경우”](#업데이트가-반영되지-않는-경우)

1. 업데이트 빈도가 제한을 초과하지 않았는지 확인
2. 활동 ID가 올바르게 저장 및 사용되고 있는지 확인
3. 콘솔 로그에서 오류 메시지 확인

### 푸시 업데이트가 동작하지 않는 경우

[Section titled “푸시 업데이트가 동작하지 않는 경우”](#푸시-업데이트가-동작하지-않는-경우)

1. 앱이 푸시 알림 권한을 가지고 있는지 확인
2. APNs 인증서가 올바르게 설정되었는지 확인
3. 푸시 페이로드 형식이 ActivityKit 요구사항을 준수하는지 확인

## 결론

[Section titled “결론”](#결론)

iOS 라이브 액티비티는 Flutter 앱에 실시간 업데이트 기능을 추가하여 사용자 경험을 향상시키는 강력한 기능입니다. 네이티브 코드 작성이 필요하지만, 적절한 플러그인과 Swift 코드를 통해 Flutter 앱에서도 효과적으로 구현할 수 있습니다.

라이브 액티비티는 사용자에게 앱을 열지 않고도 중요한 정보를 제공할 수 있으므로, 배달 앱, 스포츠 앱, 피트니스 앱 등 실시간 정보가 중요한 애플리케이션에 특히 유용합니다.

# 소셜 로그인

모바일 앱에서 사용자 인증은 핵심 기능 중 하나입니다. 소셜 로그인은 사용자가 기존 소셜 미디어 계정을 사용하여 앱에 로그인할 수 있게 해주므로 편의성을 높이고 가입 과정을 간소화합니다. 이 문서에서는 Flutter 앱에서 주요 소셜 로그인(카카오, 네이버, 애플)을 구현하는 방법을 다룹니다.

## 소셜 로그인 공통 설정

[Section titled “소셜 로그인 공통 설정”](#소셜-로그인-공통-설정)

각 소셜 로그인을 구현하기 전에 공통적으로 필요한 설정을 살펴보겠습니다.

### 1. 플랫폼별 환경 설정

[Section titled “1. 플랫폼별 환경 설정”](#1-플랫폼별-환경-설정)

#### Android 설정

[Section titled “Android 설정”](#android-설정)

`android/app/src/main/AndroidManifest.xml` 파일에 인터넷 권한을 추가합니다:

```xml
1
<manifest ...>
2
  <uses-permission android:name="android.permission.INTERNET"/>
3
  <!-- 기타 권한 -->
4
</manifest>
```

#### iOS 설정

[Section titled “iOS 설정”](#ios-설정)

`ios/Runner/Info.plist` 파일에 URL 스킴 처리를 위한 설정을 추가합니다:

```xml
1
<key>CFBundleURLTypes</key>
2
<array>
3
  <!-- 각 소셜 로그인별 URL 스킴 설정이 여기에 추가됩니다 -->
4
</array>
```

### 2. 공통 로그인 시스템 구현

[Section titled “2. 공통 로그인 시스템 구현”](#2-공통-로그인-시스템-구현)

소셜 로그인을 통합적으로 관리하기 위한 인터페이스와 모델을 정의합니다:

```dart
1
// 소셜 로그인 결과 모델
2
@freezed
3
class SocialLoginResult with _$SocialLoginResult {
4
  const factory SocialLoginResult.success({
5
    required String accessToken,
6
    required String provider,
7
    String? email,
8
    String? name,
9
    String? profileImage,
10
  }) = _SocialLoginResultSuccess;
11


12
  const factory SocialLoginResult.error({
13
    required String message,
14
    required String provider,
15
  }) = _SocialLoginResultError;
16


17
  const factory SocialLoginResult.cancelled({
18
    required String provider,
19
  }) = _SocialLoginResultCancelled;
20
}
21


22
// 소셜 로그인 인터페이스
23
abstract class SocialLoginProvider {
24
  Future<SocialLoginResult> login();
25
  Future<void> logout();
26
}
```

## 카카오 로그인 구현

[Section titled “카카오 로그인 구현”](#카카오-로그인-구현)

카카오 로그인을 구현하려면 먼저 [Kakao Developers](https://developers.kakao.com/)에서 애플리케이션을 등록해야 합니다.

### 1. 패키지 설치

[Section titled “1. 패키지 설치”](#1-패키지-설치)

`pubspec.yaml` 파일에 카카오 로그인 패키지를 추가합니다:

```yaml
1
dependencies:
2
  kakao_flutter_sdk_user: ^1.9.7+3
```

### 2. 플랫폼별 설정

[Section titled “2. 플랫폼별 설정”](#2-플랫폼별-설정)

#### Android 설정

[Section titled “Android 설정”](#android-설정-1)

1. `android/app/src/main/AndroidManifest.xml` 파일에 카카오 관련 설정 추가:

```xml
1
<manifest ...>
2
  <application ...>
3
    <activity ...>
4
      <!-- ... -->
5


6
      <!-- 카카오 로그인 커스텀 URL 스킴 설정 -->
7
      <intent-filter>
8
        <action android:name="android.intent.action.VIEW" />
9
        <category android:name="android.intent.category.DEFAULT" />
10
        <category android:name="android.intent.category.BROWSABLE" />
11


12
        <!-- "kakao${YOUR_NATIVE_APP_KEY}" 형식의 스킴 설정 -->
13
        <data android:scheme="kakao${YOUR_NATIVE_APP_KEY}" android:host="oauth"/>
14
      </intent-filter>
15
    </activity>
16
  </application>
17
</manifest>
```

2. `android/app/build.gradle` 파일의 `defaultConfig` 섹션에 매니페스트 플레이스홀더 추가:

```txt
1
defaultConfig {
2
    // ...
3
    manifestPlaceholders += [
4
        'kakaoNativeAppKey': '${YOUR_NATIVE_APP_KEY}'
5
    ]
6
}
```

#### iOS 설정

[Section titled “iOS 설정”](#ios-설정-1)

1. `ios/Runner/Info.plist` 파일에 카카오 설정 추가:

```xml
1
<key>CFBundleURLTypes</key>
2
<array>
3
  <dict>
4
    <key>CFBundleTypeRole</key>
5
    <string>Editor</string>
6
    <key>CFBundleURLSchemes</key>
7
    <array>
8
      <!-- "kakao${YOUR_NATIVE_APP_KEY}" 형식의 스킴 설정 -->
9
      <string>kakao${YOUR_NATIVE_APP_KEY}</string>
10
    </array>
11
  </dict>
12
</array>
13


14
<key>LSApplicationQueriesSchemes</key>
15
<array>
16
  <string>kakaokompassauth</string>
17
  <string>kakaolink</string>
18
</array>
```

### 3. 카카오 로그인 구현

[Section titled “3. 카카오 로그인 구현”](#3-카카오-로그인-구현)

```dart
1
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
2


3
class KakaoLoginProvider implements SocialLoginProvider {
4
  @override
5
  Future<SocialLoginResult> login() async {
6
    try {
7
      // 카카오톡 설치 여부 확인
8
      if (await isKakaoTalkInstalled()) {
9
        try {
10
          // 카카오톡으로 로그인
11
          await UserApi.instance.loginWithKakaoTalk();
12
        } catch (error) {
13
          // 사용자가 카카오톡 로그인을 취소한 경우 카카오계정으로 로그인 시도
14
          if (error is PlatformException && error.code == 'CANCELED') {
15
            return const SocialLoginResult.cancelled(provider: 'kakao');
16
          }
17


18
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
19
          await UserApi.instance.loginWithKakaoAccount();
20
        }
21
      } else {
22
        // 카카오톡이 설치되어 있지 않은 경우, 카카오계정으로 로그인
23
        await UserApi.instance.loginWithKakaoAccount();
24
      }
25


26
      // 사용자 정보 요청
27
      User user = await UserApi.instance.me();
28


29
      // 액세스 토큰 가져오기
30
      OAuthToken token = await TokenManagerProvider.instance.manager.getToken();
31


32
      return SocialLoginResult.success(
33
        accessToken: token.accessToken,
34
        provider: 'kakao',
35
        email: user.kakaoAccount?.email,
36
        name: user.kakaoAccount?.profile?.nickname,
37
        profileImage: user.kakaoAccount?.profile?.profileImageUrl,
38
      );
39
    } catch (error) {
40
      return SocialLoginResult.error(
41
        message: error.toString(),
42
        provider: 'kakao',
43
      );
44
    }
45
  }
46


47
  @override
48
  Future<void> logout() async {
49
    await UserApi.instance.logout();
50
  }
51
}
```

### 4. 앱 초기화 설정

[Section titled “4. 앱 초기화 설정”](#4-앱-초기화-설정)

앱 시작 시 카카오 SDK를 초기화합니다:

```dart
1
void main() {
2
  // 카카오 SDK 초기화
3
  KakaoSdk.init(
4
    nativeAppKey: '${YOUR_NATIVE_APP_KEY}',
5
    javaScriptAppKey: '${YOUR_JAVASCRIPT_APP_KEY}', // 웹 환경에서 필요한 경우
6
  );
7


8
  runApp(MyApp());
9
}
```

## 네이버 로그인 구현

[Section titled “네이버 로그인 구현”](#네이버-로그인-구현)

네이버 로그인을 구현하려면 먼저 [네이버 개발자 센터](https://developers.naver.com/)에서 애플리케이션을 등록해야 합니다.

### 1. 패키지 설치

[Section titled “1. 패키지 설치”](#1-패키지-설치-1)

`pubspec.yaml` 파일에 네이버 로그인 패키지를 추가합니다:

```yaml
1
dependencies:
2
  naver_login_sdk: ^3.0.0
```

> 준비중입니다.

## 애플 로그인 구현

[Section titled “애플 로그인 구현”](#애플-로그인-구현)

애플 로그인은 iOS 13 이상에서 지원되며, iOS 앱에서는 소셜 로그인 옵션으로 애플 로그인을 제공해야 합니다.

### 1. 패키지 설치

[Section titled “1. 패키지 설치”](#1-패키지-설치-2)

`pubspec.yaml` 파일에 애플 로그인 패키지를 추가합니다:

```yaml
1
dependencies:
2
  sign_in_with_apple: ^5.0.0
3
  crypto: ^3.0.3
```

### 2. 플랫폼별 설정

[Section titled “2. 플랫폼별 설정”](#2-플랫폼별-설정-1)

#### iOS 설정

[Section titled “iOS 설정”](#ios-설정-2)

1. Xcode에서 `Runner` 프로젝트를 열고 `Signing & Capabilities` 탭에서 `+ Capability` 버튼을 클릭하여 `Sign in with Apple` 기능을 추가합니다.

2. `ios/Runner/Info.plist` 파일에 관련 설정 추가:

```xml
1
<key>CFBundleURLTypes</key>
2
<array>
3
  <!-- 기존 URL 스킴 설정 -->
4
</array>
```

#### Android 설정

[Section titled “Android 설정”](#android-설정-2)

Android에서 애플 로그인을 지원하려면 웹 기반 인증 흐름을 사용해야 합니다:

1. `android/app/src/main/AndroidManifest.xml` 파일에 인텐트 필터 추가:

```xml
1
<manifest ...>
2
  <application ...>
3
    <activity ...>
4
      <!-- ... -->
5


6
      <intent-filter>
7
        <action android:name="android.intent.action.VIEW" />
8
        <category android:name="android.intent.category.DEFAULT" />
9
        <category android:name="android.intent.category.BROWSABLE" />
10
        <data android:scheme="signinwithapple" android:path="callback" />
11
      </intent-filter>
12
    </activity>
13
  </application>
14
</manifest>
```

2. 웹 서비스에 Apple 개발자 계정에서 서비스 ID와 키를 설정해야 합니다.

### 3. 애플 로그인 구현

[Section titled “3. 애플 로그인 구현”](#3-애플-로그인-구현)

```dart
1
import 'dart:convert';
2
import 'dart:math';
3


4
import 'package:crypto/crypto.dart';
5
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
6


7
class AppleLoginProvider implements SocialLoginProvider {
8
  /// Generates a cryptographically secure random nonce, to be included in a
9
  /// credential request.
10
  String _generateNonce([int length = 32]) {
11
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
12
    final random = Random.secure();
13
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
14
  }
15


16
  /// Returns the sha256 hash of [input] in hex notation.
17
  String _sha256ofString(String input) {
18
    final bytes = utf8.encode(input);
19
    final digest = sha256.convert(bytes);
20
    return digest.toString();
21
  }
22


23
  @override
24
  Future<SocialLoginResult> login() async {
25
    try {
26
      // 보안을 위한 nonce 생성
27
      final rawNonce = _generateNonce();
28
      final nonce = _sha256ofString(rawNonce);
29


30
      // 애플 로그인 요청
31
      final credential = await SignInWithApple.getAppleIDCredential(
32
        scopes: [
33
          AppleIDAuthorizationScopes.email,
34
          AppleIDAuthorizationScopes.fullName,
35
        ],
36
        nonce: nonce,
37
        webAuthenticationOptions: WebAuthenticationOptions(
38
          clientId: 'your.app.bundle.id.service',
39
          redirectUri: Uri.parse(
40
            'https://your-redirect-uri.example.com/callbacks/sign_in_with_apple',
41
          ),
42
        ),
43
      );
44


45
      // 사용자 이름 생성 (애플은 첫 로그인 후에만 이름 정보 제공)
46
      final name = [
47
        credential.givenName,
48
        credential.familyName,
49
      ].where((name) => name != null && name.isNotEmpty).join(' ');
50


51
      return SocialLoginResult.success(
52
        accessToken: credential.identityToken ?? '',
53
        provider: 'apple',
54
        email: credential.email,
55
        name: name.isNotEmpty ? name : null,
56
        profileImage: null, // 애플은 프로필 이미지를 제공하지 않음
57
      );
58
    } catch (error) {
59
      if (error is SignInWithAppleAuthorizationException) {
60
        if (error.code == AuthorizationErrorCode.canceled) {
61
          return const SocialLoginResult.cancelled(provider: 'apple');
62
        }
63
      }
64


65
      return SocialLoginResult.error(
66
        message: error.toString(),
67
        provider: 'apple',
68
      );
69
    }
70
  }
71


72
  @override
73
  Future<void> logout() async {
74
    // 애플은 클라이언트 측에서 직접 로그아웃 기능을 제공하지 않음
75
    // 필요한 경우 서버 측에서 토큰 무효화 처리
76
  }
77
}
```

## 소셜 로그인 통합 관리

[Section titled “소셜 로그인 통합 관리”](#소셜-로그인-통합-관리)

여러 소셜 로그인 방식을 통합적으로 관리하기 위한 서비스를 구현합니다:

```dart
1
class SocialLoginService {
2
  final KakaoLoginProvider _kakaoLoginProvider = KakaoLoginProvider();
3
  final NaverLoginProvider _naverLoginProvider = NaverLoginProvider();
4
  final AppleLoginProvider _appleLoginProvider = AppleLoginProvider();
5


6
  Future<SocialLoginResult> loginWithKakao() async {
7
    return await _kakaoLoginProvider.login();
8
  }
9


10
  Future<SocialLoginResult> loginWithNaver() async {
11
    return await _naverLoginProvider.login();
12
  }
13


14
  Future<SocialLoginResult> loginWithApple() async {
15
    return await _appleLoginProvider.login();
16
  }
17


18
  Future<void> logoutFrom(String provider) async {
19
    switch (provider.toLowerCase()) {
20
      case 'kakao':
21
        await _kakaoLoginProvider.logout();
22
        break;
23
      case 'naver':
24
        await _naverLoginProvider.logout();
25
        break;
26
      case 'apple':
27
        // 애플 로그아웃은 서버에서 처리
28
        break;
29
    }
30
  }
31


32
  // 모든 소셜 계정 로그아웃
33
  Future<void> logoutAll() async {
34
    await _kakaoLoginProvider.logout();
35
    await _naverLoginProvider.logout();
36
    // 애플 로그아웃은 서버에서 처리
37
  }
38
}
```

## Riverpod을 활용한 인증 상태 관리

[Section titled “Riverpod을 활용한 인증 상태 관리”](#riverpod을-활용한-인증-상태-관리)

Riverpod을 사용하여 소셜 로그인 상태를 관리하는 예제입니다:

```dart
1
// 사용자 상태 모델
2
@freezed
3
class AuthState with _$AuthState {
4
  const factory AuthState.initial() = _Initial;
5
  const factory AuthState.loading() = _Loading;
6
  const factory AuthState.authenticated({
7
    required String accessToken,
8
    required String provider,
9
    String? email,
10
    String? name,
11
    String? profileImage,
12
  }) = _Authenticated;
13
  const factory AuthState.error(String message) = _Error;
14
}
15


16
// 인증 제공자
17
@riverpod
18
class Auth extends _$Auth {
19
  final SocialLoginService _socialLoginService = SocialLoginService();
20


21
  @override
22
  AuthState build() {
23
    return const AuthState.initial();
24
  }
25


26
  Future<void> loginWithKakao() async {
27
    state = const AuthState.loading();
28


29
    final result = await _socialLoginService.loginWithKakao();
30


31
    state = result.when(
32
      success: (accessToken, provider, email, name, profileImage) {
33
        return AuthState.authenticated(
34
          accessToken: accessToken,
35
          provider: provider,
36
          email: email,
37
          name: name,
38
          profileImage: profileImage,
39
        );
40
      },
41
      error: (message, provider) {
42
        return AuthState.error(message);
43
      },
44
      cancelled: (provider) {
45
        return const AuthState.initial();
46
      },
47
    );
48
  }
49


50
  Future<void> loginWithNaver() async {
51
    state = const AuthState.loading();
52


53
    final result = await _socialLoginService.loginWithNaver();
54


55
    state = result.when(
56
      success: (accessToken, provider, email, name, profileImage) {
57
        return AuthState.authenticated(
58
          accessToken: accessToken,
59
          provider: provider,
60
          email: email,
61
          name: name,
62
          profileImage: profileImage,
63
        );
64
      },
65
      error: (message, provider) {
66
        return AuthState.error(message);
67
      },
68
      cancelled: (provider) {
69
        return const AuthState.initial();
70
      },
71
    );
72
  }
73


74
  Future<void> loginWithApple() async {
75
    state = const AuthState.loading();
76


77
    final result = await _socialLoginService.loginWithApple();
78


79
    state = result.when(
80
      success: (accessToken, provider, email, name, profileImage) {
81
        return AuthState.authenticated(
82
          accessToken: accessToken,
83
          provider: provider,
84
          email: email,
85
          name: name,
86
          profileImage: profileImage,
87
        );
88
      },
89
      error: (message, provider) {
90
        return AuthState.error(message);
91
      },
92
      cancelled: (provider) {
93
        return const AuthState.initial();
94
      },
95
    );
96
  }
97


98
  Future<void> logout() async {
99
    if (state is _Authenticated) {
100
      final provider = (state as _Authenticated).provider;
101
      await _socialLoginService.logoutFrom(provider);
102
    }
103


104
    state = const AuthState.initial();
105
  }
106
}
```

## UI 구현 예제

[Section titled “UI 구현 예제”](#ui-구현-예제)

소셜 로그인 버튼을 포함한 로그인 화면 예제입니다:

```dart
1
class LoginScreen extends ConsumerWidget {
2
  const LoginScreen({super.key});
3


4
  @override
5
  Widget build(BuildContext context, WidgetRef ref) {
6
    final authState = ref.watch(authProvider);
7


8
    return Scaffold(
9
      appBar: AppBar(title: const Text('로그인')),
10
      body: Center(
11
        child: authState.when(
12
          initial: () => _buildLoginButtons(ref),
13
          loading: () => const CircularProgressIndicator(),
14
          authenticated: (token, provider, email, name, profileImage) {
15
            return _buildUserInfo(ref, name, email, profileImage);
16
          },
17
          error: (message) => Column(
18
            mainAxisSize: MainAxisSize.min,
19
            children: [
20
              Text('오류: $message', style: const TextStyle(color: Colors.red)),
21
              const SizedBox(height: 16),
22
              _buildLoginButtons(ref),
23
            ],
24
          ),
25
        ),
26
      ),
27
    );
28
  }
29


30
  Widget _buildLoginButtons(WidgetRef ref) {
31
    return Column(
32
      mainAxisSize: MainAxisSize.min,
33
      children: [
34
        // 카카오 로그인 버튼
35
        ElevatedButton(
36
          onPressed: () => ref.read(authProvider.notifier).loginWithKakao(),
37
          style: ElevatedButton.styleFrom(
38
            backgroundColor: const Color(0xFFFEE500),
39
            foregroundColor: Colors.black87,
40
            minimumSize: const Size(250, 50),
41
          ),
42
          child: const Row(
43
            mainAxisSize: MainAxisSize.min,
44
            children: [
45
              Icon(Icons.chat_bubble, color: Colors.black87),
46
              SizedBox(width: 8),
47
              Text('카카오 로그인'),
48
            ],
49
          ),
50
        ),
51


52
        const SizedBox(height: 16),
53


54
        // 네이버 로그인 버튼
55
        ElevatedButton(
56
          onPressed: () => ref.read(authProvider.notifier).loginWithNaver(),
57
          style: ElevatedButton.styleFrom(
58
            backgroundColor: const Color(0xFF03C75A),
59
            foregroundColor: Colors.white,
60
            minimumSize: const Size(250, 50),
61
          ),
62
          child: const Row(
63
            mainAxisSize: MainAxisSize.min,
64
            children: [
65
              Text('N', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
66
              SizedBox(width: 8),
67
              Text('네이버 로그인'),
68
            ],
69
          ),
70
        ),
71


72
        const SizedBox(height: 16),
73


74
        // 애플 로그인 버튼
75
        if (Platform.isIOS)
76
          ElevatedButton(
77
            onPressed: () => ref.read(authProvider.notifier).loginWithApple(),
78
            style: ElevatedButton.styleFrom(
79
              backgroundColor: Colors.black,
80
              foregroundColor: Colors.white,
81
              minimumSize: const Size(250, 50),
82
            ),
83
            child: const Row(
84
              mainAxisSize: MainAxisSize.min,
85
              children: [
86
                Icon(Icons.apple),
87
                SizedBox(width: 8),
88
                Text('Apple로 로그인'),
89
              ],
90
            ),
91
          ),
92
      ],
93
    );
94
  }
95


96
  Widget _buildUserInfo(WidgetRef ref, String? name, String? email, String? profileImage) {
97
    return Column(
98
      mainAxisSize: MainAxisSize.min,
99
      children: [
100
        if (profileImage != null)
101
          CircleAvatar(
102
            radius: 50,
103
            backgroundImage: NetworkImage(profileImage),
104
          ),
105
        const SizedBox(height: 16),
106
        Text('이름: ${name ?? '정보 없음'}', style: const TextStyle(fontSize: 18)),
107
        const SizedBox(height: 8),
108
        Text('이메일: ${email ?? '정보 없음'}', style: const TextStyle(fontSize: 16)),
109
        const SizedBox(height: 24),
110
        ElevatedButton(
111
          onPressed: () => ref.read(authProvider.notifier).logout(),
112
          style: ElevatedButton.styleFrom(
113
            backgroundColor: Colors.red,
114
            foregroundColor: Colors.white,
115
          ),
116
          child: const Text('로그아웃'),
117
        ),
118
      ],
119
    );
120
  }
121
}
```

## 보안 고려사항

[Section titled “보안 고려사항”](#보안-고려사항)

소셜 로그인 구현 시 고려해야 할 보안 측면:

1. **토큰 관리**

   * 액세스 토큰은 안전하게 저장해야 합니다(flutter\_secure\_storage 사용 권장).
   * 앱 내에서 토큰 유효성 검사 메커니즘 구현.

2. **백엔드 인증**

   * 소셜 로그인 토큰을 백엔드로 전송하여 검증 후 자체 JWT 토큰 발급.
   * 서버 측에서 OAuth 토큰 갱신 및 관리.

3. **개인정보 처리**

   * 사용자 정보는 필요한 최소한으로 요청.
   * 개인정보 처리방침에 소셜 로그인을 통해 수집되는 정보 명시.

4. **사용자 식별**

   * 동일 사용자가 다른 소셜 계정으로 로그인할 경우 처리 방안 마련.
   * 이메일 주소를 기준으로 계정 연동 기능 구현 고려.

## 결론

[Section titled “결론”](#결론)

Flutter 앱에서 카카오, 네이버, 애플 소셜 로그인을 구현하는 방법을 살펴보았습니다. 각 플랫폼마다 설정 방법이 다르므로 공식 문서를 참조하여 최신 정보를 확인하는 것이 중요합니다. 소셜 로그인은 사용자 경험을 개선하고 가입 과정을 간소화하는 데 큰 도움이 되지만, 보안과 개인정보 보호에도 각별한 주의가 필요합니다.

각 소셜 로그인 패키지는 지속적으로 업데이트되므로, 항상 최신 버전의 패키지와 공식 문서를 확인하십시오.

# 개발 도구와 링크 모음

Flutter 개발을 효과적으로 수행하기 위해서는 적절한 도구를 활용하고, 좋은 학습 자료를 참고하는 것이 중요합니다. 이 페이지에서는 Flutter 개발자에게 유용한 도구와 리소스들을 소개합니다.

## 개발 도구

[Section titled “개발 도구”](#개발-도구)

### IDE 및 에디터

[Section titled “IDE 및 에디터”](#ide-및-에디터)

| 도구                 | 설명                                               | 링크                                           |
| ------------------ | ------------------------------------------------ | -------------------------------------------- |
| **VS Code**        | 가벼운 에디터로 Flutter 확장 프로그램 지원                      | [다운로드](https://code.visualstudio.com/)       |
| **Android Studio** | Google의 공식 Android 개발 IDE, 전문적인 Flutter 개발 환경 제공 | [다운로드](https://developer.android.com/studio) |

### VS Code 필수 확장 프로그램

[Section titled “VS Code 필수 확장 프로그램”](#vs-code-필수-확장-프로그램)

| 확장 프로그램                      | 설명                       |
| ---------------------------- | ------------------------ |
| **Flutter**                  | Flutter SDK와 통합된 지원 제공   |
| **Dart**                     | Dart 언어 지원               |
| **Awesome Flutter Snippets** | 자주 사용되는 Flutter 코드 조각 제공 |
| **Flutter Widget Snippets**  | 위젯 코드 스니펫 제공             |
| **Pubspec Assist**           | pubspec.yaml 파일 관리 도우미   |
| **Git History**              | Git 이력 관리 시각화            |
| **Error Lens**               | 인라인 오류 하이라이팅             |

### 디버깅 및 성능 분석 도구

[Section titled “디버깅 및 성능 분석 도구”](#디버깅-및-성능-분석-도구)

| 도구                   | 설명                      | 링크                                                        |
| -------------------- | ----------------------- | --------------------------------------------------------- |
| **Flutter DevTools** | 성능 및 디버깅 도구 모음          | [문서](https://docs.flutter.dev/development/tools/devtools) |
| **Dart Observatory** | 메모리 및 CPU 프로파일링         | [문서](https://dart.dev/tools/dart-devtools)                |
| **Flipper**          | Facebook의 모바일 앱 디버깅 플랫폼 | [웹사이트](https://fbflipper.com/)                            |
| **Sentry**           | 실시간 에러 추적               | [웹사이트](https://sentry.io/)                                |

### CI/CD 도구

[Section titled “CI/CD 도구”](#cicd-도구)

| 도구                 | 설명                  | 링크                                       |
| ------------------ | ------------------- | ---------------------------------------- |
| **Codemagic**      | Flutter 특화 CI/CD 도구 | [웹사이트](https://codemagic.io/)            |
| **Bitrise**        | 모바일 앱 CI/CD 플랫폼     | [웹사이트](https://www.bitrise.io/)          |
| **GitHub Actions** | GitHub 내장 CI/CD     | [문서](https://docs.github.com/en/actions) |
| **fastlane**       | 앱 자동화 배포 도구         | [웹사이트](https://fastlane.tools/)          |

## 학습 자료

[Section titled “학습 자료”](#학습-자료)

### 공식 문서

[Section titled “공식 문서”](#공식-문서)

| 리소스                     | 설명               | 링크                                        |
| ----------------------- | ---------------- | ----------------------------------------- |
| **Flutter 공식 문서**       | 상세한 API 문서 및 가이드 | [웹사이트](https://docs.flutter.dev/)         |
| **Dart 공식 문서**          | Dart 언어 문서       | [웹사이트](https://dart.dev/guides)           |
| **Material Design 가이드** | 구글의 디자인 가이드라인    | [웹사이트](https://material.io/design)        |
| **Flutter 쿡북**          | 일반적인 문제 해결 방법    | [웹사이트](https://docs.flutter.dev/cookbook) |

### 추천 블로그 및 뉴스레터

[Section titled “추천 블로그 및 뉴스레터”](#추천-블로그-및-뉴스레터)

| 리소스                   | 설명                   | 링크                                         |
| --------------------- | -------------------- | ------------------------------------------ |
| **Flutter Medium**    | Flutter 팀의 공식 블로그    | [링크](https://medium.com/flutter)           |
| **Flutter Community** | 커뮤니티 기여 아티클          | [링크](https://medium.com/flutter-community) |
| **Flutter Weekly**    | 주간 Flutter 뉴스 및 튜토리얼 | [링크](https://flutterweekly.net/)           |
| **Flutter Awesome**   | 큐레이션된 패키지 및 가이드      | [링크](https://flutterawesome.com/)          |
| **Flutter Force**     | 뉴스레터 및 팁             | [링크](https://twitter.com/flutterforce)     |

### 영상 자료

[Section titled “영상 자료”](#영상-자료)

| 리소스                   | 설명                | 링크                                               |
| --------------------- | ----------------- | ------------------------------------------------ |
| **Flutter 공식 유튜브**    | Flutter 팀의 영상     | [링크](https://www.youtube.com/c/flutterdev)       |
| **The Flutter Way**   | 고품질 UI 구현 튜토리얼    | [링크](https://www.youtube.com/c/TheFlutterWay)    |
| **Flutter Explained** | 개념 설명 및 실습        | [링크](https://www.youtube.com/c/FlutterExplained) |
| **Reso Coder**        | 아키텍처 및 고급 주제      | [링크](https://www.youtube.com/c/ResoCoder)        |
| **Code With Andrea**  | 심층적인 Flutter 튜토리얼 | [링크](https://www.youtube.com/c/CodeWithAndrea)   |

### 온라인 코스

[Section titled “온라인 코스”](#온라인-코스)

| 리소스                                | 설명           | 링크                                                                               |
| ---------------------------------- | ------------ | -------------------------------------------------------------------------------- |
| **Flutter 부트캠프**                   | Udemy 인기 코스  | [링크](https://www.udemy.com/course/flutter-bootcamp-with-dart/)                   |
| **Flutter 앱 개발 - Zero to Mastery** | 전체 개발 과정 학습  | [링크](https://www.udemy.com/course/flutter-made-easy-zero-to-mastery/)            |
| **Dart and Flutter: 완전 개발자 가이드**   | Academind 코스 | [링크](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/) |

## 커뮤니티

[Section titled “커뮤니티”](#커뮤니티)

| 커뮤니티                     | 설명               | 링크                                                               |
| ------------------------ | ---------------- | ---------------------------------------------------------------- |
| **Stack Overflow**       | 질문 및 답변          | [Flutter 태그](https://stackoverflow.com/questions/tagged/flutter) |
| **GitHub Discussions**   | Flutter 리포지토리 토론 | [링크](https://github.com/flutter/flutter/discussions)             |
| **Discord Flutter 커뮤니티** | 실시간 채팅           | [초대 링크](https://discord.gg/flutter)                              |
| **Reddit Flutter**       | 포럼 토론            | [링크](https://www.reddit.com/r/FlutterDev/)                       |

## 유용한 패키지 모음 사이트

[Section titled “유용한 패키지 모음 사이트”](#유용한-패키지-모음-사이트)

| 사이트                  | 설명                      | 링크                                |
| -------------------- | ----------------------- | --------------------------------- |
| **Pub.dev**          | 공식 Dart/Flutter 패키지 저장소 | [링크](https://pub.dev/)            |
| **Flutter Gems**     | 큐레이션된 Flutter 패키지       | [링크](https://fluttergems.dev/)    |
| **It’s All Widgets** | Flutter로 제작된 앱 사례       | [링크](https://itsallwidgets.com/)  |
| **Flutter Awesome**  | 패키지 및 앱 모음              | [링크](https://flutterawesome.com/) |

## 문제 해결 자료

[Section titled “문제 해결 자료”](#문제-해결-자료)

| 리소스                       | 설명            | 링크                                                                            |
| ------------------------- | ------------- | ----------------------------------------------------------------------------- |
| **Flutter GitHub Issues** | 알려진 이슈 및 해결책  | [링크](https://github.com/flutter/flutter/issues)                               |
| **Flutter Doctor 가이드**    | 환경 문제 진단 및 해결 | [문서](https://docs.flutter.dev/get-started/install/windows#run-flutter-doctor) |
| **Flutter 포럼**            | 공식 포럼         | [링크](https://flutter.dev/community)                                           |

## 코드 품질 및 분석 도구

[Section titled “코드 품질 및 분석 도구”](#코드-품질-및-분석-도구)

| 도구                 | 설명              | 링크                                                      |
| ------------------ | --------------- | ------------------------------------------------------- |
| **Dart Analyzer**  | 코드 정적 분석 도구     | [문서](https://dart.dev/guides/language/analysis-options) |
| **Effective Dart** | Dart 코딩 스타일 가이드 | [문서](https://dart.dev/guides/language/effective-dart)   |
| **Flutter Lints**  | 권장 린트 규칙        | [패키지](https://pub.dev/packages/flutter_lints)           |

# WidgetBook을 활용한 Flutter UI 문서화

Flutter 애플리케이션을 개발할 때 일관된 디자인 시스템을 유지하고 UI 컴포넌트를 문서화하는 것은 중요합니다. WidgetBook은 Flutter 위젯을 카탈로그화하고 대화형으로 테스트할 수 있는 도구로, Storybook이나 Styleguidist와 같은 웹 개발 도구에서 영감을 받았습니다. 이 문서에서는 WidgetBook을 설정하고 효과적으로 활용하는 방법에 대해 알아보겠습니다.

## WidgetBook이란?

[Section titled “WidgetBook이란?”](#widgetbook이란)

WidgetBook은 다음과 같은 기능을 제공하는 Flutter 패키지입니다:

* UI 컴포넌트 문서화 및 카탈로그화
* 다양한 데이터 및 상태로 위젯 테스트
* 디자인 시스템 구축 및 유지보수
* 디자이너와 개발자 간 협업 촉진
* 위젯의 반응형 동작 시각화

## 패키지 설치

[Section titled “패키지 설치”](#패키지-설치)

먼저 pubspec.yaml 파일에 필요한 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  # 기타 의존성...
5


6
dev_dependencies:
7
  flutter_test:
8
    sdk: flutter
9
  widgetbook: ^3.0.0 # 위젯북 코어 패키지
10
  widgetbook_generator: ^3.0.0 # 코드 생성 도구
11
  build_runner: ^2.1.10 # 코드 생성 실행기
```

## 기본 구조 설정

[Section titled “기본 구조 설정”](#기본-구조-설정)

WidgetBook을 구성하기 위한 기본 파일을 생성합니다:

### 1. WidgetBook 실행 파일 생성

[Section titled “1. WidgetBook 실행 파일 생성”](#1-widgetbook-실행-파일-생성)

독립적인 WidgetBook 앱을 위한 진입점을 생성합니다. 프로젝트 루트에 `widgetbook.dart` 파일을 생성합니다:

widgetbook.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook/widgetbook.dart';
3
import 'package:your_app/theme.dart'; // 앱 테마 임포트
4


5
void main() {
6
  runApp(const WidgetbookApp());
7
}
8


9
class WidgetbookApp extends StatelessWidget {
10
  const WidgetbookApp({super.key});
11


12
  @override
13
  Widget build(BuildContext context) {
14
    return Widgetbook.material(
15
      // 앱 정보 설정
16
      appInfo: AppInfo(name: 'MyApp 컴포넌트'),
17


18
      // 테마 설정
19
      themes: [
20
        WidgetbookTheme(
21
          name: '라이트 테마',
22
          data: AppTheme.lightTheme,
23
        ),
24
        WidgetbookTheme(
25
          name: '다크 테마',
26
          data: AppTheme.darkTheme,
27
        ),
28
      ],
29


30
      // 디바이스 프레임 설정
31
      devices: [
32
        Apple.iPhone13,
33
        Samsung.s21ultra,
34
        const DeviceInfo.custom(
35
          name: '태블릿',
36
          resolution: Resolution(
37
            nativeSize: DeviceSize(width: 1024, height: 768),
38
            scaleFactor: 1,
39
          ),
40
        ),
41
      ],
42


43
      // 위젯 카테고리 설정
44
      categories: [
45
        WidgetbookCategory(
46
          name: '기본 컴포넌트',
47
          widgets: [
48
            // 여기에 위젯 사용 사례 추가
49
          ],
50
          categories: [
51
            WidgetbookCategory(
52
              name: '버튼',
53
              widgets: [
54
                // 버튼 위젯 사용 사례
55
              ],
56
            ),
57
            WidgetbookCategory(
58
              name: '입력 필드',
59
              widgets: [
60
                // 입력 필드 위젯 사용 사례
61
              ],
62
            ),
63
          ],
64
        ),
65
      ],
66
    );
67
  }
68
}
```

### 2. 시작 스크립트 설정

[Section titled “2. 시작 스크립트 설정”](#2-시작-스크립트-설정)

package.json 파일이나 Makefile에 WidgetBook 실행 명령어를 추가합니다:

```json
1
{
2
  "scripts": {
3
    "widgetbook": "flutter run -d chrome -t widgetbook.dart"
4
  }
5
}
```

## 자동 코드 생성 설정

[Section titled “자동 코드 생성 설정”](#자동-코드-생성-설정)

WidgetBook은 코드 생성을 통해 설정의 복잡성을 줄일 수 있습니다. 다음과 같이 설정합니다:

### 1. widgetbook\_component.dart 파일 생성

[Section titled “1. widgetbook\_component.dart 파일 생성”](#1-widgetbook_componentdart-파일-생성)

프로젝트에 `lib/widgetbook/widgetbook_component.dart` 파일을 생성합니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
// 코드 생성을 위한 애너테이션
5
@widgetbook.App()
6
class App extends StatelessWidget {
7
  const App({super.key});
8


9
  @override
10
  Widget build(BuildContext context) {
11
    return Container();
12
  }
13
}
```

### 2. build.yaml 설정

[Section titled “2. build.yaml 설정”](#2-buildyaml-설정)

프로젝트 루트에 `build.yaml` 파일을 생성하여 코드 생성 설정을 추가합니다:

```yaml
1
targets:
2
  $default:
3
    builders:
4
      widgetbook_generator:
5
        options:
6
          output_directory: lib/widgetbook
7
          generator_type: widgetbook
```

### 3. 코드 생성 실행

[Section titled “3. 코드 생성 실행”](#3-코드-생성-실행)

다음 명령어로 코드를 생성합니다:

```bash
1
dart run build_runner build
```

## 위젯 사용 사례 문서화

[Section titled “위젯 사용 사례 문서화”](#위젯-사용-사례-문서화)

위젯을 문서화하기 위해 사용 사례(use case)를 정의합니다:

### 1. 기본 버튼 사용 사례 예제

[Section titled “1. 기본 버튼 사용 사례 예제”](#1-기본-버튼-사용-사례-예제)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
@widgetbook.UseCase(
5
  name: '기본 버튼',
6
  type: ElevatedButton,
7
  designLink: 'https://www.figma.com/file/...',
8
)
9
Widget elevatedButtonUseCase(BuildContext context) {
10
  return Center(
11
    child: ElevatedButton(
12
      onPressed: () {},
13
      child: const Text('기본 버튼'),
14
    ),
15
  );
16
}
17


18
@widgetbook.UseCase(
19
  name: '비활성화된 버튼',
20
  type: ElevatedButton,
21
)
22
Widget disabledElevatedButtonUseCase(BuildContext context) {
23
  return Center(
24
    child: ElevatedButton(
25
      onPressed: null, // null은 버튼을 비활성화함
26
      child: const Text('비활성화된 버튼'),
27
    ),
28
  );
29
}
30


31
@widgetbook.UseCase(
32
  name: '아이콘 버튼',
33
  type: ElevatedButton,
34
)
35
Widget iconElevatedButtonUseCase(BuildContext context) {
36
  return Center(
37
    child: ElevatedButton.icon(
38
      onPressed: () {},
39
      icon: const Icon(Icons.favorite),
40
      label: const Text('좋아요'),
41
    ),
42
  );
43
}
```

### 2. 텍스트 필드 사용 사례 예제

[Section titled “2. 텍스트 필드 사용 사례 예제”](#2-텍스트-필드-사용-사례-예제)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
@widgetbook.UseCase(
5
  name: '기본 텍스트 필드',
6
  type: TextField,
7
)
8
Widget textFieldUseCase(BuildContext context) {
9
  return const Padding(
10
    padding: EdgeInsets.all(16.0),
11
    child: TextField(
12
      decoration: InputDecoration(
13
        labelText: '이름',
14
        hintText: '이름을 입력하세요',
15
      ),
16
    ),
17
  );
18
}
19


20
@widgetbook.UseCase(
21
  name: '비밀번호 텍스트 필드',
22
  type: TextField,
23
)
24
Widget passwordTextFieldUseCase(BuildContext context) {
25
  return const Padding(
26
    padding: EdgeInsets.all(16.0),
27
    child: TextField(
28
      obscureText: true,
29
      decoration: InputDecoration(
30
        labelText: '비밀번호',
31
        hintText: '비밀번호를 입력하세요',
32
        suffixIcon: Icon(Icons.visibility),
33
      ),
34
    ),
35
  );
36
}
37


38
@widgetbook.UseCase(
39
  name: '오류 상태 텍스트 필드',
40
  type: TextField,
41
)
42
Widget errorTextFieldUseCase(BuildContext context) {
43
  return const Padding(
44
    padding: EdgeInsets.all(16.0),
45
    child: TextField(
46
      decoration: InputDecoration(
47
        labelText: '이메일',
48
        hintText: '이메일을 입력하세요',
49
        errorText: '유효한 이메일 주소를 입력해주세요',
50
      ),
51
    ),
52
  );
53
}
```

## 매개변수 제어를 위한 Knobs 사용

[Section titled “매개변수 제어를 위한 Knobs 사용”](#매개변수-제어를-위한-knobs-사용)

Knobs를 사용하면 UI를 통해 위젯의 매개변수를 동적으로 변경할 수 있습니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook/widgetbook.dart';
3
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
4


5
@widgetbook.UseCase(
6
  name: '커스터마이징 가능한 버튼',
7
  type: ElevatedButton,
8
)
9
Widget customizableButtonUseCase(BuildContext context) {
10
  // 텍스트 Knob
11
  final buttonText = context.knobs.text(
12
    label: '버튼 텍스트',
13
    initialValue: '버튼',
14
  );
15


16
  // 색상 Knob
17
  final buttonColor = context.knobs.color(
18
    label: '버튼 색상',
19
    initialValue: Colors.blue,
20
  );
21


22
  // 숫자 Knob (크기 조절)
23
  final fontSize = context.knobs.number(
24
    label: '글자 크기',
25
    initialValue: 16,
26
    min: 10,
27
    max: 30,
28
  );
29


30
  // 불리언 Knob (활성화/비활성화)
31
  final isEnabled = context.knobs.boolean(
32
    label: '활성화',
33
    initialValue: true,
34
  );
35


36
  // 옵션 Knob (버튼 형태)
37
  final buttonShape = context.knobs.options(
38
    label: '버튼 형태',
39
    options: [
40
      Option(label: '기본', value: 0.0),
41
      Option(label: '둥근 모서리', value: 8.0),
42
      Option(label: '원형', value: 20.0),
43
    ],
44
  );
45


46
  return Center(
47
    child: ElevatedButton(
48
      onPressed: isEnabled ? () {} : null,
49
      style: ElevatedButton.styleFrom(
50
        backgroundColor: buttonColor,
51
        shape: RoundedRectangleBorder(
52
          borderRadius: BorderRadius.circular(buttonShape),
53
        ),
54
      ),
55
      child: Text(
56
        buttonText,
57
        style: TextStyle(fontSize: fontSize),
58
      ),
59
    ),
60
  );
61
}
```

## 복잡한 컴포넌트 문서화

[Section titled “복잡한 컴포넌트 문서화”](#복잡한-컴포넌트-문서화)

더 복잡한 컴포넌트나 화면을 문서화하는 방법입니다:

### 1. 회원가입 폼 예제

[Section titled “1. 회원가입 폼 예제”](#1-회원가입-폼-예제)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
@widgetbook.UseCase(
5
  name: '회원가입 폼',
6
  type: SignUpForm,
7
  designLink: 'https://www.figma.com/file/...',
8
)
9
Widget signUpFormUseCase(BuildContext context) {
10
  return const Padding(
11
    padding: EdgeInsets.all(16.0),
12
    child: SignUpForm(),
13
  );
14
}
15


16
class SignUpForm extends StatefulWidget {
17
  const SignUpForm({super.key});
18


19
  @override
20
  State<SignUpForm> createState() => _SignUpFormState();
21
}
22


23
class _SignUpFormState extends State<SignUpForm> {
24
  final _formKey = GlobalKey<FormState>();
25
  bool _obscurePassword = true;
26


27
  @override
28
  Widget build(BuildContext context) {
29
    return Form(
30
      key: _formKey,
31
      child: Column(
32
        crossAxisAlignment: CrossAxisAlignment.stretch,
33
        mainAxisSize: MainAxisSize.min,
34
        children: [
35
          const Text(
36
            '회원가입',
37
            style: TextStyle(
38
              fontSize: 24,
39
              fontWeight: FontWeight.bold,
40
            ),
41
            textAlign: TextAlign.center,
42
          ),
43
          const SizedBox(height: 24),
44
          TextFormField(
45
            decoration: const InputDecoration(
46
              labelText: '이름',
47
              prefixIcon: Icon(Icons.person),
48
            ),
49
            validator: (value) {
50
              if (value == null || value.isEmpty) {
51
                return '이름을 입력해주세요';
52
              }
53
              return null;
54
            },
55
          ),
56
          const SizedBox(height: 16),
57
          TextFormField(
58
            decoration: const InputDecoration(
59
              labelText: '이메일',
60
              prefixIcon: Icon(Icons.email),
61
            ),
62
            keyboardType: TextInputType.emailAddress,
63
            validator: (value) {
64
              if (value == null || value.isEmpty) {
65
                return '이메일을 입력해주세요';
66
              }
67
              if (!value.contains('@')) {
68
                return '유효한 이메일 주소를 입력해주세요';
69
              }
70
              return null;
71
            },
72
          ),
73
          const SizedBox(height: 16),
74
          TextFormField(
75
            decoration: InputDecoration(
76
              labelText: '비밀번호',
77
              prefixIcon: const Icon(Icons.lock),
78
              suffixIcon: IconButton(
79
                icon: Icon(
80
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
81
                ),
82
                onPressed: () {
83
                  setState(() {
84
                    _obscurePassword = !_obscurePassword;
85
                  });
86
                },
87
              ),
88
            ),
89
            obscureText: _obscurePassword,
90
            validator: (value) {
91
              if (value == null || value.isEmpty) {
92
                return '비밀번호를 입력해주세요';
93
              }
94
              if (value.length < 8) {
95
                return '비밀번호는 8자 이상이어야 합니다';
96
              }
97
              return null;
98
            },
99
          ),
100
          const SizedBox(height: 24),
101
          ElevatedButton(
102
            onPressed: () {
103
              if (_formKey.currentState!.validate()) {
104
                // 폼 처리 로직
105
              }
106
            },
107
            child: const Text('가입하기'),
108
          ),
109
          const SizedBox(height: 16),
110
          TextButton(
111
            onPressed: () {},
112
            child: const Text('이미 계정이 있으신가요? 로그인하기'),
113
          ),
114
        ],
115
      ),
116
    );
117
  }
118
}
```

### 2. 카드 컴포넌트 예제

[Section titled “2. 카드 컴포넌트 예제”](#2-카드-컴포넌트-예제)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
@widgetbook.UseCase(
5
  name: '제품 카드',
6
  type: ProductCard,
7
)
8
Widget productCardUseCase(BuildContext context) {
9
  final isDiscounted = context.knobs.boolean(
10
    label: '할인 적용',
11
    initialValue: false,
12
  );
13


14
  final rating = context.knobs.slider(
15
    label: '평점',
16
    initialValue: 4.5,
17
    min: 1.0,
18
    max: 5.0,
19
    divisions: 8,
20
  );
21


22
  return Center(
23
    child: ProductCard(
24
      title: '스마트폰',
25
      imageUrl: 'https://example.com/smartphone.jpg',
26
      price: 1000000,
27
      discountPrice: isDiscounted ? 850000 : null,
28
      rating: rating,
29
      onPressed: () {},
30
    ),
31
  );
32
}
33


34
class ProductCard extends StatelessWidget {
35
  final String title;
36
  final String imageUrl;
37
  final int price;
38
  final int? discountPrice;
39
  final double rating;
40
  final VoidCallback onPressed;
41


42
  const ProductCard({
43
    super.key,
44
    required this.title,
45
    required this.imageUrl,
46
    required this.price,
47
    this.discountPrice,
48
    required this.rating,
49
    required this.onPressed,
50
  });
51


52
  @override
53
  Widget build(BuildContext context) {
54
    return Card(
55
      clipBehavior: Clip.antiAlias,
56
      elevation: 2,
57
      child: InkWell(
58
        onTap: onPressed,
59
        child: Column(
60
          crossAxisAlignment: CrossAxisAlignment.start,
61
          children: [
62
            // 이미지 플레이스홀더
63
            AspectRatio(
64
              aspectRatio: 16 / 9,
65
              child: Container(
66
                color: Colors.grey[300],
67
                child: const Center(child: Icon(Icons.image)),
68
              ),
69
            ),
70
            Padding(
71
              padding: const EdgeInsets.all(12.0),
72
              child: Column(
73
                crossAxisAlignment: CrossAxisAlignment.start,
74
                children: [
75
                  Text(
76
                    title,
77
                    style: const TextStyle(
78
                      fontWeight: FontWeight.bold,
79
                      fontSize: 16,
80
                    ),
81
                  ),
82
                  const SizedBox(height: 4),
83
                  if (discountPrice != null) ...[
84
                    Text(
85
                      '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
86
                      style: TextStyle(
87
                        decoration: TextDecoration.lineThrough,
88
                        color: Colors.grey[600],
89
                      ),
90
                    ),
91
                    Text(
92
                      '${discountPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
93
                      style: const TextStyle(
94
                        fontWeight: FontWeight.bold,
95
                        color: Colors.red,
96
                      ),
97
                    ),
98
                  ] else
99
                    Text(
100
                      '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
101
                      style: const TextStyle(fontWeight: FontWeight.bold),
102
                    ),
103
                  const SizedBox(height: 8),
104
                  Row(
105
                    children: [
106
                      Icon(Icons.star, color: Colors.amber, size: 18),
107
                      const SizedBox(width: 4),
108
                      Text(rating.toStringAsFixed(1)),
109
                    ],
110
                  ),
111
                ],
112
              ),
113
            ),
114
          ],
115
        ),
116
      ),
117
    );
118
  }
119
}
```

## 반응형 디자인 테스트

[Section titled “반응형 디자인 테스트”](#반응형-디자인-테스트)

WidgetBook을 사용하여 반응형 디자인을 테스트하는 방법:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
@widgetbook.UseCase(
5
  name: '반응형 레이아웃',
6
  type: ResponsiveLayout,
7
)
8
Widget responsiveLayoutUseCase(BuildContext context) {
9
  return const ResponsiveLayout(
10
    mobileChild: MobileView(),
11
    tabletChild: TabletView(),
12
    desktopChild: DesktopView(),
13
  );
14
}
15


16
class ResponsiveLayout extends StatelessWidget {
17
  final Widget mobileChild;
18
  final Widget tabletChild;
19
  final Widget desktopChild;
20


21
  const ResponsiveLayout({
22
    super.key,
23
    required this.mobileChild,
24
    required this.tabletChild,
25
    required this.desktopChild,
26
  });
27


28
  @override
29
  Widget build(BuildContext context) {
30
    final width = MediaQuery.of(context).size.width;
31


32
    if (width < 600) {
33
      return mobileChild;
34
    } else if (width < 1200) {
35
      return tabletChild;
36
    } else {
37
      return desktopChild;
38
    }
39
  }
40
}
41


42
class MobileView extends StatelessWidget {
43
  const MobileView({super.key});
44


45
  @override
46
  Widget build(BuildContext context) {
47
    return Scaffold(
48
      appBar: AppBar(title: const Text('모바일 뷰')),
49
      body: ListView(
50
        children: List.generate(
51
          10,
52
          (index) => ListTile(
53
            leading: CircleAvatar(child: Text('${index + 1}')),
54
            title: Text('항목 ${index + 1}'),
55
            subtitle: const Text('모바일 레이아웃'),
56
          ),
57
        ),
58
      ),
59
      bottomNavigationBar: BottomNavigationBar(
60
        items: const [
61
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
62
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
63
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
64
        ],
65
        currentIndex: 0,
66
        onTap: (_) {},
67
      ),
68
    );
69
  }
70
}
71


72
class TabletView extends StatelessWidget {
73
  const TabletView({super.key});
74


75
  @override
76
  Widget build(BuildContext context) {
77
    return Scaffold(
78
      appBar: AppBar(title: const Text('태블릿 뷰')),
79
      body: Row(
80
        children: [
81
          NavigationRail(
82
            selectedIndex: 0,
83
            onDestinationSelected: (_) {},
84
            destinations: const [
85
              NavigationRailDestination(
86
                icon: Icon(Icons.home),
87
                label: Text('홈'),
88
              ),
89
              NavigationRailDestination(
90
                icon: Icon(Icons.search),
91
                label: Text('검색'),
92
              ),
93
              NavigationRailDestination(
94
                icon: Icon(Icons.person),
95
                label: Text('프로필'),
96
              ),
97
            ],
98
          ),
99
          Expanded(
100
            child: GridView.builder(
101
              padding: const EdgeInsets.all(16),
102
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
103
                crossAxisCount: 2,
104
                crossAxisSpacing: 16,
105
                mainAxisSpacing: 16,
106
              ),
107
              itemCount: 10,
108
              itemBuilder: (context, index) {
109
                return Card(
110
                  child: Column(
111
                    mainAxisAlignment: MainAxisAlignment.center,
112
                    children: [
113
                      CircleAvatar(
114
                        radius: 30,
115
                        child: Text('${index + 1}'),
116
                      ),
117
                      const SizedBox(height: 8),
118
                      Text('항목 ${index + 1}'),
119
                      const Text('태블릿 레이아웃'),
120
                    ],
121
                  ),
122
                );
123
              },
124
            ),
125
          ),
126
        ],
127
      ),
128
    );
129
  }
130
}
131


132
class DesktopView extends StatelessWidget {
133
  const DesktopView({super.key});
134


135
  @override
136
  Widget build(BuildContext context) {
137
    return Scaffold(
138
      appBar: AppBar(title: const Text('데스크톱 뷰')),
139
      body: Row(
140
        children: [
141
          Drawer(
142
            child: ListView(
143
              children: [
144
                const DrawerHeader(
145
                  child: Text(
146
                    '메뉴',
147
                    style: TextStyle(
148
                      color: Colors.white,
149
                      fontSize: 24,
150
                    ),
151
                  ),
152
                  decoration: BoxDecoration(
153
                    color: Colors.blue,
154
                  ),
155
                ),
156
                ListTile(
157
                  leading: const Icon(Icons.home),
158
                  title: const Text('홈'),
159
                  selected: true,
160
                  onTap: () {},
161
                ),
162
                ListTile(
163
                  leading: const Icon(Icons.search),
164
                  title: const Text('검색'),
165
                  onTap: () {},
166
                ),
167
                ListTile(
168
                  leading: const Icon(Icons.person),
169
                  title: const Text('프로필'),
170
                  onTap: () {},
171
                ),
172
              ],
173
            ),
174
          ),
175
          Expanded(
176
            child: GridView.builder(
177
              padding: const EdgeInsets.all(16),
178
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
179
                crossAxisCount: 4,
180
                crossAxisSpacing: 16,
181
                mainAxisSpacing: 16,
182
              ),
183
              itemCount: 20,
184
              itemBuilder: (context, index) {
185
                return Card(
186
                  child: Column(
187
                    mainAxisAlignment: MainAxisAlignment.center,
188
                    children: [
189
                      CircleAvatar(
190
                        radius: 30,
191
                        child: Text('${index + 1}'),
192
                      ),
193
                      const SizedBox(height: 8),
194
                      Text('항목 ${index + 1}'),
195
                      const Text('데스크톱 레이아웃'),
196
                    ],
197
                  ),
198
                );
199
              },
200
            ),
201
          ),
202
        ],
203
      ),
204
    );
205
  }
206
}
```

## 위젯북에서 상태 관리

[Section titled “위젯북에서 상태 관리”](#위젯북에서-상태-관리)

WidgetBook에서 Provider, Riverpod 등의 상태 관리 도구를 사용하는 방법:

### Riverpod과 함께 사용하기

[Section titled “Riverpod과 함께 사용하기”](#riverpod과-함께-사용하기)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_riverpod/flutter_riverpod.dart';
3
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
4


5
// 카운터 상태 제공자
6
final counterProvider = StateProvider<int>((ref) => 0);
7


8
@widgetbook.UseCase(
9
  name: 'Riverpod 카운터',
10
  type: CounterWidget,
11
)
12
Widget riverpodCounterUseCase(BuildContext context) {
13
  return ProviderScope(
14
    child: CounterWidget(),
15
  );
16
}
17


18
class CounterWidget extends ConsumerWidget {
19
  const CounterWidget({super.key});
20


21
  @override
22
  Widget build(BuildContext context, WidgetRef ref) {
23
    final count = ref.watch(counterProvider);
24


25
    return Center(
26
      child: Column(
27
        mainAxisAlignment: MainAxisAlignment.center,
28
        children: [
29
          Text(
30
            '$count',
31
            style: Theme.of(context).textTheme.headline2,
32
          ),
33
          const SizedBox(height: 16),
34
          ElevatedButton(
35
            onPressed: () => ref.read(counterProvider.notifier).state++,
36
            child: const Text('증가'),
37
          ),
38
          const SizedBox(height: 8),
39
          ElevatedButton(
40
            onPressed: () => ref.read(counterProvider.notifier).state--,
41
            child: const Text('감소'),
42
          ),
43
        ],
44
      ),
45
    );
46
  }
47
}
```

## 동적 API 데이터 모의 처리

[Section titled “동적 API 데이터 모의 처리”](#동적-api-데이터-모의-처리)

실제 API 데이터를 시뮬레이션하여 데이터 의존적인 위젯을 문서화하는 방법:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
3


4
// 모의 데이터 서비스
5
class MockDataService {
6
  Future<List<User>> getUsers() async {
7
    // API 호출 시뮬레이션
8
    await Future.delayed(const Duration(seconds: 1));
9


10
    return [
11
      User(id: 1, name: '홍길동', email: 'hong@example.com'),
12
      User(id: 2, name: '김철수', email: 'kim@example.com'),
13
      User(id: 3, name: '이영희', email: 'lee@example.com'),
14
    ];
15
  }
16
}
17


18
class User {
19
  final int id;
20
  final String name;
21
  final String email;
22


23
  User({required this.id, required this.name, required this.email});
24
}
25


26
@widgetbook.UseCase(
27
  name: '사용자 목록',
28
  type: UserListWidget,
29
)
30
Widget userListUseCase(BuildContext context) {
31
  final isLoading = context.knobs.boolean(
32
    label: '로딩 중',
33
    initialValue: false,
34
  );
35


36
  final hasError = context.knobs.boolean(
37
    label: '오류 발생',
38
    initialValue: false,
39
  );
40


41
  final isEmpty = context.knobs.boolean(
42
    label: '빈 목록',
43
    initialValue: false,
44
  );
45


46
  return UserListWidget(
47
    mockService: MockDataService(),
48
    isLoading: isLoading,
49
    hasError: hasError,
50
    isEmpty: isEmpty,
51
  );
52
}
53


54
class UserListWidget extends StatefulWidget {
55
  final MockDataService mockService;
56
  final bool isLoading;
57
  final bool hasError;
58
  final bool isEmpty;
59


60
  const UserListWidget({
61
    super.key,
62
    required this.mockService,
63
    this.isLoading = false,
64
    this.hasError = false,
65
    this.isEmpty = false,
66
  });
67


68
  @override
69
  State<UserListWidget> createState() => _UserListWidgetState();
70
}
71


72
class _UserListWidgetState extends State<UserListWidget> {
73
  late Future<List<User>> _usersFuture;
74


75
  @override
76
  void initState() {
77
    super.initState();
78
    _loadUsers();
79
  }
80


81
  @override
82
  void didUpdateWidget(UserListWidget oldWidget) {
83
    super.didUpdateWidget(oldWidget);
84


85
    if (oldWidget.isLoading != widget.isLoading ||
86
        oldWidget.hasError != widget.hasError ||
87
        oldWidget.isEmpty != widget.isEmpty) {
88
      _loadUsers();
89
    }
90
  }
91


92
  void _loadUsers() {
93
    if (widget.isLoading) {
94
      _usersFuture = Future.delayed(const Duration(days: 1), () => <User>[]);
95
    } else if (widget.hasError) {
96
      _usersFuture = Future.error('데이터 로드 중 오류가 발생했습니다.');
97
    } else if (widget.isEmpty) {
98
      _usersFuture = Future.value(<User>[]);
99
    } else {
100
      _usersFuture = widget.mockService.getUsers();
101
    }
102
  }
103


104
  @override
105
  Widget build(BuildContext context) {
106
    return Scaffold(
107
      appBar: AppBar(title: const Text('사용자 목록')),
108
      body: FutureBuilder<List<User>>(
109
        future: _usersFuture,
110
        builder: (context, snapshot) {
111
          if (snapshot.connectionState == ConnectionState.waiting) {
112
            return const Center(child: CircularProgressIndicator());
113
          }
114


115
          if (snapshot.hasError) {
116
            return Center(
117
              child: Column(
118
                mainAxisAlignment: MainAxisAlignment.center,
119
                children: [
120
                  const Icon(Icons.error, size: 48, color: Colors.red),
121
                  const SizedBox(height: 16),
122
                  Text('오류: ${snapshot.error}'),
123
                  const SizedBox(height: 16),
124
                  ElevatedButton(
125
                    onPressed: () => setState(() => _loadUsers()),
126
                    child: const Text('다시 시도'),
127
                  ),
128
                ],
129
              ),
130
            );
131
          }
132


133
          final users = snapshot.data ?? [];
134


135
          if (users.isEmpty) {
136
            return const Center(
137
              child: Column(
138
                mainAxisAlignment: MainAxisAlignment.center,
139
                children: [
140
                  Icon(Icons.people, size: 48, color: Colors.grey),
141
                  SizedBox(height: 16),
142
                  Text('사용자 정보가 없습니다.'),
143
                ],
144
              ),
145
            );
146
          }
147


148
          return ListView.builder(
149
            itemCount: users.length,
150
            itemBuilder: (context, index) {
151
              final user = users[index];
152


153
              return ListTile(
154
                leading: CircleAvatar(
155
                  child: Text(user.name.substring(0, 1)),
156
                ),
157
                title: Text(user.name),
158
                subtitle: Text(user.email),
159
                trailing: const Icon(Icons.chevron_right),
160
                onTap: () {},
161
              );
162
            },
163
          );
164
        },
165
      ),
166
    );
167
  }
168
}
```

## 효과적인 위젯북 구성 팁

[Section titled “효과적인 위젯북 구성 팁”](#효과적인-위젯북-구성-팁)

위젯북을 더 효과적으로 활용하기 위한 팁:

1. **논리적으로 카테고리화**:

   * 위젯을 기능, 유형 또는 페이지별로 그룹화
   * 데이터 입력, 탐색, 표시 등으로 분류

2. **일관된 명명 규칙**:

   * 명확하고 일관된 이름으로 컴포넌트와 사용 사례 명명
   * 패턴 사용(예: “기본”, “비활성화”, “오류 상태”)

3. **연동 문서화**:

   * Figma나 Zeplin 링크 포함하여 디자인과 코드 매핑
   * 필요한 경우 추가 설명이나 사용 지침 제공

4. **자동화 및 CI 통합**:

   * 커밋 또는 병합 시 위젯북 자동 빌드
   * 위젯북 웹 버전을 팀 내부 서버에 배포

## 결론

[Section titled “결론”](#결론)

WidgetBook은 Flutter 애플리케이션의 UI 컴포넌트를 문서화하고 테스트하기 위한 강력한 도구입니다. 이를 통해 디자이너와 개발자 간의 협업을 촉진하고, 일관된 디자인 시스템을 유지할 수 있습니다. 특히 팀 규모가 커지거나 프로젝트가 복잡해질수록 WidgetBook의 가치는 더욱 커집니다.

효과적인 UI 문서화는 코드의 재사용성을 높이고, 디자인 일관성을 유지하며, 신규 팀원의 온보딩을 용이하게 하는 등 다양한 이점을 제공합니다. WidgetBook을 프로젝트에 통합하여 효율적인 UI 개발 환경을 구축해 보세요.

# 변경사항

### 2025년 05월 16일

[Section titled “2025년 05월 16일”](#2025년-05월-16일)

* 📦 1. 시작하기 > 소개에 설문조사 추가

### 2025년 05월 15일

[Section titled “2025년 05월 15일”](#2025년-05월-15일)

* 📦 1. 시작하기에 **LLM 설정** 추가
* 📦 1. 시작하기에 **변경사항** 추가
* 💡 2. Dart 언어 기초 중 컬렉션과 반복문에 collection 패키지 안내 추가
* `flutter pub run build_runner build` 를 `dart run build_runner build` 로 변경
* JSON 직렬화 (freezed, json\_serializable)에 freezed\_annotation 팁 추가

### 2025년 05월 14일

[Section titled “2025년 05월 14일”](#2025년-05월-14일)

초안 공개

# 첫 프로젝트 생성 및 실행

이제 Flutter SDK와 개발 환경이 설정되었으므로, 첫 번째 Flutter 프로젝트를 생성하고 실행해 보겠습니다.

## 프로젝트 생성하기

[Section titled “프로젝트 생성하기”](#프로젝트-생성하기)

Flutter 프로젝트는 다양한 방법으로 생성할 수 있습니다. 터미널을 사용하거나 Visual Studio Code 또는 Android Studio와 같은 IDE를 사용할 수 있습니다.

### 터미널을 이용한 생성

[Section titled “터미널을 이용한 생성”](#터미널을-이용한-생성)

1. 터미널을 열고 프로젝트를 생성할 디렉토리로 이동합니다.
2. 다음 명령어를 실행하여 새 Flutter 프로젝트를 생성합니다:

```bash
1
flutter create my_first_app
```

이 명령어는 `my_first_app`이라는 이름의 새 Flutter 프로젝트를 생성합니다.

3. 프로젝트 디렉토리로 이동합니다:

```bash
1
cd my_first_app
```

### VS Code를 이용한 생성

[Section titled “VS Code를 이용한 생성”](#vs-code를-이용한-생성)

1. Visual Studio Code를 실행합니다.
2. Command Palette(`Ctrl+Shift+P` 또는 `Cmd+Shift+P`)를 열고 “Flutter: New Project”를 입력하고 선택합니다.
3. 프로젝트 이름을 입력합니다 (예: “my\_first\_app”).
4. 프로젝트를 저장할 디렉토리를 선택합니다.
5. VS Code가 자동으로 새 Flutter 프로젝트를 생성합니다.

### Android Studio를 이용한 생성

[Section titled “Android Studio를 이용한 생성”](#android-studio를-이용한-생성)

1. Android Studio를 실행합니다.
2. “Create New Flutter Project”를 선택합니다.
3. “Flutter Application”을 선택하고 “Next”를 클릭합니다.
4. 프로젝트 이름과 저장 위치, Flutter SDK 경로를 지정하고 “Next”를 클릭합니다.
5. 추가 정보를 입력하고 “Finish”를 클릭합니다.

## 프로젝트 구조 탐색

[Section titled “프로젝트 구조 탐색”](#프로젝트-구조-탐색)

Flutter 프로젝트가 생성되면, 다음과 같은 기본 파일 구조가 만들어집니다:

* my\_first\_app/

  * .dart\_tool/ # Dart 도구 관련 파일

    * …

  * .idea/ # IDE 설정 (Android Studio)

    * …

  * android/ # 안드로이드 특화 코드

    * …

  * build/ # 빌드 출력 파일

    * …

  * ios/ # iOS 특화 코드

    * …

  * lib/ # Dart 코드

    * …

  * main.dart # 앱의 진입점

  * linux/ # Linux 특화 코드

    * …

  * macos/ # macOS 특화 코드

    * …

  * test/ # 테스트 코드

    * …

  * web/ # 웹 특화 코드

    * …

  * windows/ # Windows 특화 코드

    * …

  * .gitignore # Git 무시 파일

  * .metadata # Flutter 메타데이터

  * analysis\_options.yaml # Dart 분석 설정

  * pubspec.lock # 의존성 버전 잠금 파일

  * pubspec.yaml # 프로젝트 설정 및 의존성

  * README.md # 프로젝트 설명

이 중에서 가장 중요한 파일은 다음과 같습니다:

* **lib/main.dart**: 앱의 메인 코드가 위치한 파일입니다.
* **pubspec.yaml**: 앱의 메타데이터와 의존성을 정의하는 파일입니다.
* **android/**, **ios/**: 플랫폼별 설정이 포함된 디렉토리입니다.

## 기본 앱 코드 이해하기

[Section titled “기본 앱 코드 이해하기”](#기본-앱-코드-이해하기)

기본적으로 생성된 `lib/main.dart` 파일을 살펴보겠습니다. 이 파일은 간단한 카운터 앱을 구현하고 있습니다:

```dart
1
import 'package:flutter/material.dart';
2


3
void main() {
4
  runApp(const MyApp());
5
}
6


7
class MyApp extends StatelessWidget {
8
  const MyApp({super.key});
9


10
  @override
11
  Widget build(BuildContext context) {
12
    return MaterialApp(
13
      title: 'Flutter Demo',
14
      theme: ThemeData(
15
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
16
        useMaterial3: true,
17
      ),
18
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
19
    );
20
  }
21
}
22


23
class MyHomePage extends StatefulWidget {
24
  const MyHomePage({super.key, required this.title});
25


26
  final String title;
27


28
  @override
29
  State<MyHomePage> createState() => _MyHomePageState();
30
}
31


32
class _MyHomePageState extends State<MyHomePage> {
33
  int _counter = 0;
34


35
  void _incrementCounter() {
36
    setState(() {
37
      _counter++;
38
    });
39
  }
40


41
  @override
42
  Widget build(BuildContext context) {
43
    return Scaffold(
44
      appBar: AppBar(
45
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
46
        title: Text(widget.title),
47
      ),
48
      body: Center(
49
        child: Column(
50
          mainAxisAlignment: MainAxisAlignment.center,
51
          children: <Widget>[
52
            const Text(
53
              'You have pushed the button this many times:',
54
            ),
55
            Text(
56
              '$_counter',
57
              style: Theme.of(context).textTheme.headlineMedium,
58
            ),
59
          ],
60
        ),
61
      ),
62
      floatingActionButton: FloatingActionButton(
63
        onPressed: _incrementCounter,
64
        tooltip: 'Increment',
65
        child: const Icon(Icons.add),
66
      ),
67
    );
68
  }
69
}
```

이 코드의 주요 구성 요소를 간략하게 설명하면:

1. **main() 함수**: 앱의 진입점으로, `runApp()`을 호출하여 앱을 시작합니다.
2. **MyApp 클래스**: 앱의 전체적인 테마와 구조를 정의하는 StatelessWidget입니다.
3. **MyHomePage 클래스**: 앱의 홈 화면을 정의하는 StatefulWidget입니다.
4. **\_MyHomePageState 클래스**: 홈 화면의 상태를 관리하는 State 클래스입니다.

## 앱 실행하기

[Section titled “앱 실행하기”](#앱-실행하기)

이제 생성된 Flutter 앱을 실행해 보겠습니다.

### 터미널에서 실행

[Section titled “터미널에서 실행”](#터미널에서-실행)

프로젝트 디렉토리에서 다음 명령어를 실행합니다:

```bash
1
flutter run
```

이 명령어는 연결된 기기나 에뮬레이터에서 앱을 실행합니다. 여러 기기가 연결되어 있다면, 실행할 기기를 선택하라는 메시지가 표시됩니다.

특정 기기에서 실행하려면 다음과 같이 명령할 수 있습니다:

```bash
1
flutter run -d <device_id>
```

기기 ID는 `flutter devices` 명령어로 확인할 수 있습니다.

### VS Code에서 실행

[Section titled “VS Code에서 실행”](#vs-code에서-실행)

1. VS Code에서 프로젝트를 엽니다.
2. 하단 상태 표시줄에서 기기 선택기를 클릭하여 실행할 기기를 선택합니다.
3. F5 키를 누르거나 “Run > Start Debugging”을 선택합니다.

### Android Studio에서 실행

[Section titled “Android Studio에서 실행”](#android-studio에서-실행)

1. Android Studio에서 프로젝트를 엽니다.
2. 상단 도구 모음에서 기기 선택기를 사용하여 실행할 기기를 선택합니다.
3. 실행 버튼(▶)을 클릭합니다.

## 앱 수정하기

[Section titled “앱 수정하기”](#앱-수정하기)

이제 앱을 조금 수정해 보겠습니다. `lib/main.dart` 파일을 열고 다음과 같이 변경해 보세요:

1. 앱 제목 변경:

```dart
1
return MaterialApp(
2
  title: '내 첫 번째 Flutter 앱',
3
  // ...
```

2. 홈 화면 타이틀 변경:

```dart
1
home: const MyHomePage(title: '내 첫 번째 Flutter 앱'),
```

3. 카운터 텍스트 변경:

```dart
1
const Text(
2
  '버튼을 눌러 카운터를 증가시키세요:',
3
),
```

## 핫 리로드 사용하기

[Section titled “핫 리로드 사용하기”](#핫-리로드-사용하기)

Flutter의 가장 강력한 기능 중 하나는 핫 리로드입니다. 이는 앱을 다시 시작하지 않고도 코드 변경 사항을 즉시 확인할 수 있게 해줍니다.

1. 앱이 실행 중인 상태에서 코드를 수정합니다.
2. 변경 사항을 저장합니다.
3. VS Code 또는 Android Studio에서는 자동으로 핫 리로드가 실행됩니다.
4. 터미널에서 실행 중인 경우, `r` 키를 눌러 핫 리로드를 실행합니다.

핫 리로드는 상태를 유지하므로, 예를 들어 카운터 값은 리셋되지 않습니다.

## 핫 리스타트 사용하기

[Section titled “핫 리스타트 사용하기”](#핫-리스타트-사용하기)

때로는 변경 사항이 핫 리로드로 적용되지 않을 수 있습니다. 이런 경우 핫 리스타트를 사용할 수 있습니다:

1. VS Code 또는 Android Studio에서 핫 리스타트 버튼을 클릭합니다.
2. 터미널에서 실행 중인 경우, `R` 키(대문자)를 눌러 핫 리스타트를 실행합니다.

핫 리스타트는 앱을 다시 시작하지만, 컴파일 과정은 건너뛰므로 일반적인 재시작보다 빠릅니다.

## 더 많은 기기에서 실행하기

[Section titled “더 많은 기기에서 실행하기”](#더-많은-기기에서-실행하기)

Flutter 앱은 다양한 플랫폼에서 실행할 수 있습니다.

### 웹에서 실행하기

[Section titled “웹에서 실행하기”](#웹에서-실행하기)

웹 버전을 실행하려면 다음 명령어를 사용합니다:

```bash
1
flutter run -d chrome
```

또는 VS Code와 Android Studio에서 Chrome을 기기로 선택할 수 있습니다.

### 데스크톱에서 실행하기

[Section titled “데스크톱에서 실행하기”](#데스크톱에서-실행하기)

데스크톱 버전을 실행하려면 다음 명령어를 사용합니다:

```bash
1
# Windows
2
flutter run -d windows
3


4
# macOS
5
flutter run -d macos
6


7
# Linux
8
flutter run -d linux
```

## 릴리즈 모드로 실행하기

[Section titled “릴리즈 모드로 실행하기”](#릴리즈-모드로-실행하기)

기본적으로 `flutter run` 명령어는 디버그 모드로 앱을 실행합니다. 릴리즈 모드로 실행하려면 다음 명령어를 사용합니다:

```bash
1
flutter run --release
```

릴리즈 모드는 디버그 정보가 제거되고 성능이 최적화된 버전입니다.

## 앱 빌드하기

[Section titled “앱 빌드하기”](#앱-빌드하기)

개발이 완료된 앱을 배포 가능한 형태로 빌드하려면 다음 명령어를 사용합니다:

```bash
1
# Android APK
2
flutter build apk
3


4
# Android App Bundle
5
flutter build appbundle
6


7
# iOS
8
flutter build ios
9


10
# 웹
11
flutter build web
12


13
# Windows
14
flutter build windows
15


16
# macOS
17
flutter build macos
18


19
# Linux
20
flutter build linux
```

## 결론

[Section titled “결론”](#결론)

축하합니다! 첫 번째 Flutter 앱을 성공적으로 생성하고 실행했습니다. 이 기본 앱을 출발점으로 삼아, Flutter의 다양한 위젯과 기능을 탐색하며 더 복잡한 앱을 개발할 수 있습니다.

다음 섹션에서는 Flutter 프로젝트의 구조를 더 자세히 살펴보고, 앱 개발에 필요한 주요 개념들을 배워보겠습니다.

# 소개

안녕하세요!

이 문서는 Flutter 프레임워크를 이용하여 앱을 개발하는 방법을 소개합니다.

현재 초안 단계이며 수정 및 추가 내용이 있을 예정입니다.

저희 팀은 4개 이상의 프로젝트를 Flutter 프레임워크를 이용하여 만들었습니다. 처음부터 Flutter로 작성한 앱과 기존의 네이티브로 개발한 앱을 Flutter로 마이그레이션 한 경험이 있습니다.

iOS(+ iPadOS), Android(+ 태블릿)에서 동작하는 여러 앱 서비스를 Flutter로 만들어 운영중이며 약 100만 MAU를 가진 서비스를 안정적으로 만들어 배포하였습니다.

위 경험을 토대로 Flutter 프레임워크를 이용하여 앱 개발하면서 필요한 내용들을 본 문서에 담았습니다.

이 문서 혹은 개발과 관련된 문의는 댓글 혹은 <changjoo.app@gmail.com> 으로 문의바랍니다.

# LLM 설정

이 문서는 코드 에디터를 위한 llms.txt 파일을 지원합니다.

다음 경로를 사용하는 에디터에 적용하시면 이 문서를 기준으로 프로젝트를 진행하실 수 있습니다.

루트 llms.txt

```plaintext
1
https://changjoo-park.github.io/learn-flutter/llms.txt
```

간소화 버전

```plaintext
1
https://changjoo-park.github.io/learn-flutter/llms-small.txt
```

전체 버전

```plaintext
1
https://changjoo-park.github.io/learn-flutter/llms-full.txt
```

## Visual Studio Code

[Section titled “Visual Studio Code”](#visual-studio-code)

프롬프트에 다음과 같이 입력합니다.

```text
1
#fetch https://changjoo-park.github.io/learn-flutter/llms-full.txt
```

프로젝트 레벨에서 이용하려면

1. 터미널에서 프로젝트 경로로 이동 후 다음과 같이 입력합니다.

```sh
1
curl -L https://changjoo-park.github.io/learn-flutter/llms-full.txt --create-dirs -o .vscode/learn_flutter.md
```

2. `.vscode/settings.json` 에 다음을 입력합니다.

.vscode/settings.json

```json
1
{
2
  "github.copilot.chat.codeGeneration.instructions": [
3
    {
4
      "file": "./.vscode/learn_flutter.md"
5
    }
6
  ]
7
}
```

## Cursor

[Section titled “Cursor”](#cursor)

프롬프트에 다음과 같이 입력합니다.

```text
1
@web https://changjoo-park.github.io/learn-flutter/llms-full.txt
```

계속 사용하려면

1. `CMD` + `Shift` + `P` 를 눌러 명령 팔레트를 엽니다.
2. `Add new custom docs` 를 입력합니다.
3. 아래 내용을 입력합니다.

```text
1
https://changjoo-park.github.io/learn-flutter/llms-full.txt
```

4. 채팅 UI에서 @docs 를 입력한 후 추가된 문서를 선택합니다.

# Flutter 프로젝트 구조 이해

Flutter 프로젝트는 여러 디렉토리와 파일로 구성되어 있으며, 각각은 프로젝트의 특정 측면을 담당합니다. 이 구조를 이해하면 Flutter 앱을 더 효율적으로 개발하고 관리할 수 있습니다.

## Flutter 프로젝트의 기본 구조

[Section titled “Flutter 프로젝트의 기본 구조”](#flutter-프로젝트의-기본-구조)

기본적인 Flutter 프로젝트 구조는 다음과 같습니다:

* my\_flutter\_app/

  * .dart\_tool/ # Dart 도구 관련 파일

    * …

  * .idea/ # IDE 설정 (Android Studio)

    * …

  * android/ # 안드로이드 특화 코드

    * …

  * build/ # 빌드 출력 파일

    * …

  * ios/ # iOS 특화 코드

    * …

  * lib/ # Dart 코드

    * …

  * main.dart # 앱의 진입점

  * linux/ # Linux 특화 코드

    * …

  * macos/ # macOS 특화 코드

    * …

  * test/ # 테스트 코드

    * …

  * web/ # 웹 특화 코드

    * …

  * windows/ # Windows 특화 코드

    * …

  * .gitignore # Git 무시 파일

  * .metadata # Flutter 메타데이터

  * analysis\_options.yaml # Dart 분석 설정

  * pubspec.lock # 의존성 버전 잠금 파일

  * pubspec.yaml # 프로젝트 설정 및 의존성

  * README.md # 프로젝트 설명

이제 각 디렉토리와 파일의 역할을 자세히 살펴보겠습니다.

## 주요 디렉토리

[Section titled “주요 디렉토리”](#주요-디렉토리)

### lib/ 디렉토리

[Section titled “lib/ 디렉토리”](#lib-디렉토리)

`lib/` 디렉토리는 Flutter 프로젝트의 핵심으로, 앱의 Dart 소스 코드가 저장되는 위치입니다.

* lib/

  * main.dart # 앱의 진입점

  * models/ # 데이터 모델

    * …

  * screens/ # 화면 UI

    * …

  * widgets/ # 재사용 가능한 위젯

    * …

  * services/ # 비즈니스 로직, API 호출 등

    * …

  * utils/ # 유틸리티 기능

    * …

**중요: 기본적으로 생성되는 것은 `main.dart` 파일뿐이며, 나머지 폴더 구조는 개발자가 필요에 따라 생성하고 구성합니다.**

#### main.dart

[Section titled “main.dart”](#maindart)

`main.dart` 파일은 앱의 진입점으로, `main()` 함수와 루트 위젯을 포함합니다:

```dart
1
import 'package:flutter/material.dart';
2


3
void main() {
4
  runApp(const MyApp());
5
}
6


7
class MyApp extends StatelessWidget {
8
  const MyApp({super.key});
9


10
  @override
11
  Widget build(BuildContext context) {
12
    return MaterialApp(
13
      title: 'Flutter Demo',
14
      theme: ThemeData(
15
        primarySwatch: Colors.blue,
16
      ),
17
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
18
    );
19
  }
20
}
```

### test/ 디렉토리

[Section titled “test/ 디렉토리”](#test-디렉토리)

`test/` 디렉토리는 앱의 자동화된 테스트 코드를 포함합니다. 단위 테스트, 위젯 테스트 등을 이 디렉토리에 작성합니다.

* test/

  * widget\_test.dart # 위젯 테스트

  * unit/

    * models\_test.dart # 단위 테스트

기본적으로 생성되는 `widget_test.dart` 파일은 앱의 메인 위젯을 테스트하는 간단한 예제를 포함합니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_test/flutter_test.dart';
3
import 'package:my_flutter_app/main.dart';
4


5
void main() {
6
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
7
    await tester.pumpWidget(const MyApp());
8
    expect(find.text('0'), findsOneWidget);
9
    expect(find.text('1'), findsNothing);
10
    await tester.tap(find.byIcon(Icons.add));
11
    await tester.pump();
12
    expect(find.text('0'), findsNothing);
13
    expect(find.text('1'), findsOneWidget);
14
  });
15
}
```

### android/ 디렉토리

[Section titled “android/ 디렉토리”](#android-디렉토리)

`android/` 디렉토리는 Android 플랫폼 관련 코드와 설정을 포함합니다.

* android/

  * app/

    * src/

      * main/

        * AndroidManifest.xml # 앱 선언 및 권한

        * kotlin/ # Kotlin 소스 코드

          * …

        * res/ # 리소스 (아이콘, 문자열 등)

          * …

      * profile/

        * …

    * build.gradle # 앱 수준 빌드 설정

    * …

  * build.gradle # 프로젝트 수준 빌드 설정

  * gradle/

    * …

  * gradle.properties

  * …

특히 중요한 파일들:

* **AndroidManifest.xml**: 앱의 이름, 아이콘, 필요한 권한 등을 정의합니다.
* **build.gradle**: 앱의 버전, 의존성, 빌드 설정 등을 구성합니다.

### ios/ 디렉토리

[Section titled “ios/ 디렉토리”](#ios-디렉토리)

`ios/` 디렉토리는 iOS 플랫폼 관련 코드와 설정을 포함합니다.

* ios/

  * Runner/

    * AppDelegate.swift # iOS 앱 진입점

    * Info.plist # 앱 구성 및 권한

    * Assets.xcassets/ # 이미지 에셋

      * …

    * …

  * Runner.xcodeproj/ # Xcode 프로젝트 파일

    * …

  * …

특히 중요한 파일들:

* **Info.plist**: 앱 이름, 버전, 권한 등의 메타데이터를 포함합니다.
* **AppDelegate.swift**: iOS 앱의 진입점 및 초기화 로직을 포함합니다.

### web/, macos/, linux/, windows/ 디렉토리

[Section titled “web/, macos/, linux/, windows/ 디렉토리”](#web-macos-linux-windows-디렉토리)

이 디렉토리들은 각각 웹, macOS, 리눅스, 윈도우 플랫폼을 위한 코드와 설정을 포함합니다. 구조는 플랫폼마다 다르지만, 모두 해당 플랫폼의 네이티브 코드와 구성을 담고 있습니다.

## 주요 설정 파일

[Section titled “주요 설정 파일”](#주요-설정-파일)

### pubspec.yaml

[Section titled “pubspec.yaml”](#pubspecyaml)

`pubspec.yaml`은 Flutter 프로젝트의 핵심 설정 파일로, 앱의 메타데이터, 의존성, 에셋 등을 정의합니다:

```yaml
1
name: my_flutter_app
2
description: A new Flutter project.
3


4
# The following defines the version and build number for your application.
5
version: 1.0.0+1
6


7
environment:
8
  sdk: ">=3.0.0 <4.0.0"
9


10
# Dependencies
11
dependencies:
12
  flutter:
13
    sdk: flutter
14
  http: ^1.0.0
15
  shared_preferences: ^2.1.1
16


17
dev_dependencies:
18
  flutter_test:
19
    sdk: flutter
20
  flutter_lints: ^2.0.0
21


22
# Flutter-specific configurations
23
flutter:
24
  uses-material-design: true
25


26
  # Assets
27
  assets:
28
    - assets/images/
29
    - assets/fonts/
30


31
  # Fonts
32
  fonts:
33
    - family: Roboto
34
      fonts:
35
        - asset: assets/fonts/Roboto-Regular.ttf
36
        - asset: assets/fonts/Roboto-Bold.ttf
37
          weight: 700
```

주요 항목들:

* **name**: 앱의 패키지 이름
* **version**: 앱의 버전(`버전 코드+빌드 번호` 형식)
* **dependencies**: 앱이 사용하는 패키지 의존성
* **dev\_dependencies**: 개발 시에만 필요한 패키지 의존성
* **flutter**: Flutter 특화 설정 (에셋, 폰트, 테마 등)

### analysis\_options.yaml

[Section titled “analysis\_options.yaml”](#analysis_optionsyaml)

`analysis_options.yaml`은 Dart 코드 분석기의 설정을 정의하여 코드 품질과 일관성을 유지하는 데 도움을 줍니다:

```yaml
1
include: package:flutter_lints/flutter.yaml
2


3
linter:
4
  rules:
5
    - avoid_print
6
    - avoid_empty_else
7
    - prefer_const_constructors
8
    - sort_child_properties_last
9


10
analyzer:
11
  errors:
12
    missing_required_param: error
13
    missing_return: error
```

### .gitignore

[Section titled “.gitignore”](#gitignore)

`.gitignore` 파일은 Git 버전 관리 시스템에서 무시해야 할 파일들을 지정합니다. Flutter 프로젝트에서는 빌드 결과물, 임시 파일, IDE 파일 등이 여기에 포함됩니다.

## 추가 디렉토리와 파일 (선택적)

[Section titled “추가 디렉토리와 파일 (선택적)”](#추가-디렉토리와-파일-선택적)

개발자들은 프로젝트의 규모와 복잡성에 따라 추가 디렉토리를 생성할 수 있습니다:

### assets/ 디렉토리

[Section titled “assets/ 디렉토리”](#assets-디렉토리)

* assets/

  * images/ # 이미지 파일

    * …

  * fonts/ # 폰트 파일

    * …

  * data/ # JSON, CSV 등의 데이터 파일

    * …

이 디렉토리는 `pubspec.yaml`에 명시적으로 등록해야 합니다:

```yaml
1
flutter:
2
  assets:
3
    - assets/images/
4
    - assets/fonts/
5
    - assets/data/
```

### l10n/ 또는 i18n/ 디렉토리

[Section titled “l10n/ 또는 i18n/ 디렉토리”](#l10n-또는-i18n-디렉토리)

다국어 지원을 위한 디렉토리:

* l10n/

  * app\_en.arb # 영어 번역
  * app\_ko.arb # 한국어 번역
  * app\_ja.arb # 일본어 번역

## 프로젝트 구조화 패턴

[Section titled “프로젝트 구조화 패턴”](#프로젝트-구조화-패턴)

Flutter 앱의 구조는 프로젝트의 성격과 팀의 선호도에 따라 달라질 수 있습니다. 일반적으로 많이 사용되는 패턴은 다음과 같습니다:

### 기능별 구조 (Feature-First)

[Section titled “기능별 구조 (Feature-First)”](#기능별-구조-feature-first)

앱의 기능별로 디렉토리를 구성하는 방식:

* lib/

  * main.dart

  * features/

    * auth/

      * screens/

        * …

      * widgets/

        * …

      * models/

        * …

      * services/

        * …

    * home/

      * …

    * profile/

      * …

    * settings/

      * …

  * shared/

    * widgets/

      * …

    * utils/

      * …

    * constants/

      * …

이 구조는 기능이 많은 대규모 앱에 적합합니다.

### 계층별 구조 (Layer-First)

[Section titled “계층별 구조 (Layer-First)”](#계층별-구조-layer-first)

앱의 아키텍처 계층별로 디렉토리를 구성하는 방식:

* lib/

  * main.dart

  * screens/ # 모든 화면 UI

    * …

  * widgets/ # 모든 재사용 위젯

    * …

  * models/ # 모든 데이터 모델

    * …

  * services/ # 모든 서비스 로직

    * …

  * repositories/ # 데이터 액세스 로직

    * …

  * utils/ # 유틸리티 함수

    * …

이 구조는 작거나 중간 규모의 앱에 적합합니다.

### MVVM 또는 Clean Architecture

[Section titled “MVVM 또는 Clean Architecture”](#mvvm-또는-clean-architecture)

보다 체계적인 아키텍처 패턴을 적용한 구조:

* lib/

  * main.dart

  * ui/

    * screens/

      * …

    * widgets/

      * …

  * viewmodels/

    * …

  * models/

    * …

  * services/

    * …

  * repositories/

    * …

  * core/

    * utils/

      * …

    * constants/

      * …

이 구조는 코드의 유지 관리성과 테스트 가능성을 높이는 데 도움이 됩니다.

## 모범 사례 및 권장 사항

[Section titled “모범 사례 및 권장 사항”](#모범-사례-및-권장-사항)

### 1. 명확한 명명 규칙

[Section titled “1. 명확한 명명 규칙”](#1-명확한-명명-규칙)

* 파일 이름: `snake_case.dart` (예: `user_profile.dart`)
* 클래스 이름: `PascalCase` (예: `UserProfile`)
* 변수 및 함수 이름: `camelCase` (예: `userName`, `getUserInfo()`)

### 2. 프로젝트 구조 일관성 유지

[Section titled “2. 프로젝트 구조 일관성 유지”](#2-프로젝트-구조-일관성-유지)

* 처음부터 명확한 구조 계획 수립
* 프로젝트 전체에 동일한 규칙 적용
* 팀 내 구조 합의 및 문서화

### 3. 관련 코드 그룹화

[Section titled “3. 관련 코드 그룹화”](#3-관련-코드-그룹화)

* 관련된 코드는 함께 위치
* 너무 깊은 중첩 디렉토리 피하기 (일반적으로 3-4 수준 이내)
* 디렉토리 이름은 내용을 명확히 반영

### 4. 불필요한 분할 피하기

[Section titled “4. 불필요한 분할 피하기”](#4-불필요한-분할-피하기)

* 파일이 너무 많아지면 관리가 어려울 수 있음
* 단일 위젯이나 작은 기능을 여러 파일로 나누지 않기
* 너무 큰 파일도 피하기 (일반적으로 300-500줄 이내)

## 기타 고려 사항

[Section titled “기타 고려 사항”](#기타-고려-사항)

### 환경 구성

[Section titled “환경 구성”](#환경-구성)

다양한 환경(개발, 스테이징, 프로덕션)에 대한 구성을 지원하기 위해 다음과 같은 접근 방식을 사용할 수 있습니다:

* lib/

  * main.dart # 공통 진입점

  * main\_dev.dart # 개발 환경 진입점

  * main\_staging.dart # 스테이징 환경 진입점

  * main\_prod.dart # 프로덕션 환경 진입점

  * config/

    * app\_config.dart # 환경 설정 클래스
    * dev\_config.dart
    * staging\_config.dart
    * prod\_config.dart

### 라우팅 구성

[Section titled “라우팅 구성”](#라우팅-구성)

앱의 화면 전환을 관리하기 위한 라우팅 구성:

* lib/

  * router/

    * app\_router.dart # 라우터 설정
    * routes.dart # 라우트 상수

### 상태 관리

[Section titled “상태 관리”](#상태-관리)

선택한 상태 관리 솔루션에 따라 구조가 달라질 수 있습니다:

* lib/

  * providers/ # Riverpod/Provider

    * …

  * blocs/ # Flutter\_bloc

    * …

  * stores/ # MobX

    * …

  * state/ # 기타 상태 관리

    * …

## 결론

[Section titled “결론”](#결론)

Flutter 프로젝트 구조는 규모와 복잡성에 따라 다양하게 적용할 수 있습니다. 중요한 것은 팀이 이해하기 쉽고 유지 관리가 용이한 일관된 구조를 선택하는 것입니다. 프로젝트가 성장함에 따라 구조도 진화할 수 있으므로, 리팩토링과 개선에 열린 자세를 유지하는 것이 좋습니다.

이제 Flutter 개발 환경 설정과 프로젝트 구조에 대한 이해를 바탕으로, 다음 챕터에서 Dart 언어 기초를 배워보겠습니다.

# 개발 환경 구성

Flutter 개발을 시작하기 위해 필요한 환경을 구성해 보겠습니다. 이 과정에는 Flutter SDK 설치, 코드 에디터 설정, 그리고 개발 도구 구성이 포함됩니다.

### 여러 버전을 사용하고 싶을 때

[Section titled “여러 버전을 사용하고 싶을 때”](#여러-버전을-사용하고-싶을-때)

가이드에 있는 공식적인 방법도 좋지만 여러 버전을 사용하고 싶을 때는 [Flutter Version Manager](https://fvm.app) 또는 [mise](https://mise.jdx.dev)를 사용하세요. Flutter의 최신 버전 업데이트 이후에 바로 사용하는 경우 패키지가 호환이 안되는 경우가 있어 버전을 유지하는데 어려움을 겪을 수 있습니다.

저는 mise를 조금 더 추천 드립니다. Flutter Version Manager와 달리 Flutter 외에 앱 개발에 필요한 Ruby, Node.js 등의 버전도 관리할 수 있습니다.

## Flutter SDK 설치

[Section titled “Flutter SDK 설치”](#flutter-sdk-설치)

### Windows에서 설치

[Section titled “Windows에서 설치”](#windows에서-설치)

1. [Flutter 공식 사이트](https://flutter.dev/docs/get-started/install/windows)에서 Flutter SDK를 다운로드합니다.

2. 다운로드한 zip 파일을 원하는 위치에 압축 해제합니다 (예: `C:\dev\flutter`).

3. 환경 변수 설정:

   * 시스템 환경 변수에서 `Path` 변수에 Flutter SDK의 `bin` 폴더 경로를 추가합니다.
   * 예: `C:\dev\flutter\bin`

4. 명령 프롬프트를 열고 다음 명령어를 실행하여 설치를 확인합니다:

   ```bash
   1
   flutter doctor
   ```

### macOS에서 설치

[Section titled “macOS에서 설치”](#macos에서-설치)

1. **Homebrew를 이용한 설치** (권장):

   ```bash
   1
   brew install --cask flutter
   ```

2. **수동 설치**:

   * [Flutter 공식 사이트](https://flutter.dev/docs/get-started/install/macos)에서 Flutter SDK를 다운로드합니다.

   * 다운로드한 zip 파일을 원하는 위치에 압축 해제합니다 (예: `~/development/flutter`).

   * 환경 변수 설정: `.zshrc` 또는 `.bash_profile` 파일에 다음 내용을 추가합니다:

     ```bash
     1
     export PATH="$PATH:~/development/flutter/bin"
     ```

   * 터미널을 열고 다음 명령어를 실행하여 설치를 확인합니다:

     ```bash
     1
     flutter doctor
     ```

### Linux에서 설치

[Section titled “Linux에서 설치”](#linux에서-설치)

1. [Flutter 공식 사이트](https://flutter.dev/docs/get-started/install/linux)에서 Flutter SDK를 다운로드합니다.

2. 다운로드한 tar.xz 파일을 원하는 위치에 압축 해제합니다:

   ```bash
   1
   tar xf flutter_linux_<version>-stable.tar.xz -C ~/development
   ```

3. 환경 변수 설정: `.bashrc` 또는 `.zshrc` 파일에 다음 내용을 추가합니다:

   ```bash
   1
   export PATH="$PATH:~/development/flutter/bin"
   ```

4. 터미널을 열고 다음 명령어를 실행하여 설치를 확인합니다:

   ```bash
   1
   flutter doctor
   ```

## Visual Studio Code 설정

[Section titled “Visual Studio Code 설정”](#visual-studio-code-설정)

Visual Studio Code는 Flutter 개발을 위한 권장 에디터입니다.

### VS Code 설치

[Section titled “VS Code 설치”](#vs-code-설치)

1. [Visual Studio Code 공식 사이트](https://code.visualstudio.com/)에서 에디터를 다운로드하고 설치합니다.
2. VS Code를 실행합니다.

### Flutter와 Dart 플러그인 설치

[Section titled “Flutter와 Dart 플러그인 설치”](#flutter와-dart-플러그인-설치)

1. VS Code의 Extensions 탭(`Ctrl+Shift+X` 또는 `Cmd+Shift+X`)을 엽니다.
2. “Flutter”를 검색하고 Flutter 확장 프로그램을 설치합니다 (Dart 확장 프로그램도 자동으로 설치됩니다).
3. VS Code를 재시작합니다.

### Dart DevTools 설정

[Section titled “Dart DevTools 설정”](#dart-devtools-설정)

Dart DevTools는 Flutter 앱 디버깅에 유용한 도구입니다.

1. VS Code에서 Command Palette(`Ctrl+Shift+P` 또는 `Cmd+Shift+P`)를 엽니다.
2. “Flutter: Open DevTools”를 입력하고 선택합니다.
3. 브라우저에서 DevTools가 열립니다.

## 에뮬레이터 / 실기기 연결

[Section titled “에뮬레이터 / 실기기 연결”](#에뮬레이터--실기기-연결)

### Android 에뮬레이터 설정

[Section titled “Android 에뮬레이터 설정”](#android-에뮬레이터-설정)

1. [Android Studio](https://developer.android.com/studio)를 다운로드하고 설치합니다.
2. Android Studio를 실행하고 “SDK Manager”를 엽니다.
3. “SDK Tools” 탭에서 “Android SDK Build-Tools”, “Android SDK Command-line Tools”, “Android Emulator”, “Android SDK Platform-Tools”를 설치합니다.
4. “AVD Manager”를 열고 “Create Virtual Device”를 클릭합니다.
5. 원하는 디바이스를 선택하고 시스템 이미지를 다운로드한 후 에뮬레이터를 생성합니다.
6. 에뮬레이터를 실행합니다.

### iOS 시뮬레이터 설정 (macOS만 해당)

[Section titled “iOS 시뮬레이터 설정 (macOS만 해당)”](#ios-시뮬레이터-설정-macos만-해당)

1. App Store에서 Xcode를 설치합니다.

2. Xcode를 실행하고 필요한 구성 요소를 설치합니다.

3. 터미널에서 다음 명령어를 실행하여, Flutter와 Xcode 간의 라이센스 동의를 진행합니다:

   ```bash
   1
   sudo xcodebuild -license
   ```

4. iOS 시뮬레이터를 실행합니다:

   ```bash
   1
   open -a Simulator
   ```

### 실제 안드로이드 기기 연결

[Section titled “실제 안드로이드 기기 연결”](#실제-안드로이드-기기-연결)

1. 안드로이드 디바이스의 설정에서 “개발자 옵션”을 활성화합니다:
   * 설정 > 휴대폰 정보 > 소프트웨어 정보 > 빌드 번호를 7번 탭합니다.

2. 개발자 옵션에서 “USB 디버깅”을 활성화합니다.

3. USB 케이블로 디바이스를 컴퓨터에 연결합니다.

4. 디바이스에 표시되는 USB 디버깅 권한 요청을 수락합니다.

5. 터미널에서 다음 명령어로 연결된 디바이스를 확인합니다:

   ```bash
   1
   flutter devices
   ```

### 실제 iOS 기기 연결 (macOS만 해당)

[Section titled “실제 iOS 기기 연결 (macOS만 해당)”](#실제-ios-기기-연결-macos만-해당)

1. Apple Developer 계정이 필요합니다.

2. Xcode를 열고 “Preferences > Accounts”에서 Apple ID를 추가합니다.

3. USB 케이블로 iOS 기기를 Mac에 연결합니다.

4. Xcode에서 프로젝트를 열고 디바이스를 선택한 후 “Trust”를 선택합니다.

5. 터미널에서 다음 명령어로 연결된 디바이스를 확인합니다:

   ```bash
   1
   flutter devices
   ```

## Flutter Doctor로 확인하기

[Section titled “Flutter Doctor로 확인하기”](#flutter-doctor로-확인하기)

설치 과정이 완료되면 다음 명령어를 실행하여 환경 설정이 올바르게 되었는지 확인합니다:

```bash
1
flutter doctor -v
```

이 명령어는 Flutter SDK, Android toolchain, iOS toolchain (macOS만 해당), VS Code 등의 설치 상태를 확인하고, 문제가 있다면 해결 방법을 제안합니다.

## 추가 설정 (선택사항)

[Section titled “추가 설정 (선택사항)”](#추가-설정-선택사항)

### Git 설정

[Section titled “Git 설정”](#git-설정)

Flutter 프로젝트는 Git을 이용한 버전 관리를 권장합니다:

1. [Git 공식 사이트](https://git-scm.com/)에서 Git을 다운로드하고 설치합니다.

2. 터미널 또는 명령 프롬프트에서 Git 설정을 구성합니다:

   ```bash
   1
   git config --global user.name "Your Name"
   2
   git config --global user.email "your.email@example.com"
   ```

### 추가 권장 VS Code 확장 프로그램

[Section titled “추가 권장 VS Code 확장 프로그램”](#추가-권장-vs-code-확장-프로그램)

* **Awesome Flutter Snippets**: 유용한 Flutter 코드 스니펫 제공
* **Flutter Widget Snippets**: 위젯 코드 생성 지원
* **Pubspec Assist**: 의존성 관리 도우미
* **Error Lens**: 인라인 오류 하이라이팅
* **Git Lens**: Git 통합 향상

## 문제 해결

[Section titled “문제 해결”](#문제-해결)

### ”flutter: command not found” 오류

[Section titled “”flutter: command not found” 오류”](#flutter-command-not-found-오류)

환경 변수가 올바르게 설정되지 않았을 수 있습니다. 시스템의 PATH 변수에 Flutter bin 디렉토리가 포함되어 있는지 확인하세요.

### Android Studio 설치 문제

[Section titled “Android Studio 설치 문제”](#android-studio-설치-문제)

안드로이드 설정에 문제가 있을 경우:

```bash
1
flutter doctor --android-licenses
```

명령어를 실행하여 Android 라이센스를 동의합니다.

### 에뮬레이터 성능 문제

[Section titled “에뮬레이터 성능 문제”](#에뮬레이터-성능-문제)

Windows와 Linux 사용자는 BIOS에서 가상화 기술(Intel VT-x 또는 AMD-V)이 활성화되어 있는지 확인하세요.

## 결론

[Section titled “결론”](#결론)

이제 Flutter 개발을 위한 환경 설정이 완료되었습니다. 다음 섹션에서는 첫 번째 Flutter 프로젝트를 생성하고 실행하는 방법을 알아보겠습니다.

# 접근성

모든 사용자가 앱을 편리하게 사용할 수 있도록 접근성(Accessibility)을 고려하는 것은 매우 중요합니다. 접근성이 높은 앱은 시각, 청각, 운동 능력 등에 제한이 있는 사용자들도 불편함 없이 이용할 수 있습니다. Flutter는 다양한 접근성 기능을 지원하여 개발자가 더 포용적인 앱을 만들 수 있도록 도와줍니다.

## 접근성의 중요성

[Section titled “접근성의 중요성”](#접근성의-중요성)

접근성을 고려하는 것은 다음과 같은 여러 가지 이유로 중요합니다:

1. **더 많은 사용자층**: 전 세계적으로 약 10억 명이 넘는 사람들이 장애를 갖고 있으며, 접근성을 고려하면 더 많은 사용자가 앱을 사용할 수 있습니다.
2. **법적 요구사항**: 많은 국가에서 디지털 접근성은 법적 요구사항입니다. 미국의 ADA(Americans with Disabilities Act)나 유럽의 EAA(European Accessibility Act) 등이 있습니다.
3. **윤리적 책임**: 모든 사용자에게 평등한 접근성을 제공하는 것은 개발자의 윤리적 책임입니다.
4. **사용자 경험 향상**: 접근성을 개선하면 모든 사용자의 경험이 향상됩니다. 예를 들어, 고대비 모드는 밝은 환경에서 모든 사용자에게 도움이 됩니다.
5. **검색 엔진 및 앱 스토어 최적화**: 접근성이 높은 앱은 검색 엔진 및 앱 스토어 알고리즘에서 더 높은 평가를 받을 수 있습니다.

## 플랫폼별 접근성 기능

[Section titled “플랫폼별 접근성 기능”](#플랫폼별-접근성-기능)

Flutter 앱에서 접근성을 구현할 때는 각 플랫폼의 접근성 서비스를 활용합니다:

* **Android**: TalkBack (화면 낭독기)
* **iOS**: VoiceOver (화면 낭독기)
* **웹**: 다양한 화면 낭독기 (NVDA, JAWS, VoiceOver 등)

Flutter는 이러한 서비스와 자연스럽게 연동되도록 설계되었습니다.

## Flutter에서의 접근성 구현

[Section titled “Flutter에서의 접근성 구현”](#flutter에서의-접근성-구현)

### 1. 기본적인 접근성 속성

[Section titled “1. 기본적인 접근성 속성”](#1-기본적인-접근성-속성)

Flutter의 대부분의 위젯은 기본적인 접근성 기능을 갖추고 있지만, `Semantics` 위젯을 사용하여 추가적인 접근성 정보를 제공할 수 있습니다.

```dart
1
Semantics(
2
  label: '이메일 보내기 버튼',
3
  hint: '탭하여 이메일 작성 화면으로 이동합니다',
4
  button: true,
5
  child: IconButton(
6
    icon: Icon(Icons.email),
7
    onPressed: () {
8
      // 이메일 작성 화면으로 이동
9
    },
10
  ),
11
)
```

### 2. 접근성 속성

[Section titled “2. 접근성 속성”](#2-접근성-속성)

`Semantics` 위젯의 주요 속성들:

* **label**: 요소를 설명하는 텍스트
* **hint**: 요소의 기능을 설명하는 추가 정보
* **value**: 요소의 현재 값 (예: 슬라이더의 현재 값)
* **button**: 요소가 버튼임을 나타냄
* **enabled**: 요소의 활성화 상태
* **checked**: 요소의 선택 상태 (체크박스, 라디오 버튼 등)
* **selected**: 요소의 선택 상태 (탭, 메뉴 아이템 등)
* **focusable**: 키보드 초점을 받을 수 있는지 여부
* **focused**: 현재 키보드 초점을 가지고 있는지 여부
* **onTap**, **onLongPress** 등: 제스처 콜백

### 3. MergeSemantics와 ExcludeSemantics

[Section titled “3. MergeSemantics와 ExcludeSemantics”](#3-mergesemantics와-excludesemantics)

여러 위젯의 의미론적 정보를 합치거나 제외하기 위한 위젯들:

```dart
1
// 여러 위젯의 의미론적 정보를 하나로 합치기
2
MergeSemantics(
3
  child: Row(
4
    children: [
5
      Icon(Icons.favorite),
6
      Text('좋아요'),
7
    ],
8
  ),
9
)
10


11
// 특정 위젯의 의미론적 정보 제외하기
12
ExcludeSemantics(
13
  child: DecorativeImage(), // 순수 장식용 이미지
14
)
```

### 4. Semantics 디버깅

[Section titled “4. Semantics 디버깅”](#4-semantics-디버깅)

Flutter DevTools를 사용하여 앱의 의미론적 트리를 검사할 수 있습니다:

1. Flutter 앱을 디버그 모드로 실행
2. DevTools 열기
3. “Flutter Inspector” 탭 선택
4. “Toggle Platform” 버튼 클릭하여 플랫폼 모드 전환
5. “Highlight Semantics” 버튼 클릭하여 의미론적 정보 강조 표시

### 5. 화면 낭독기 테스트

[Section titled “5. 화면 낭독기 테스트”](#5-화면-낭독기-테스트)

앱의 접근성을 테스트하기 위해 실제 기기에서 화면 낭독기를 활성화하고 테스트하는 것이 중요합니다:

* **Android**: 설정 > 접근성 > TalkBack
* **iOS**: 설정 > 접근성 > VoiceOver

## 접근성 구현 예제

[Section titled “접근성 구현 예제”](#접근성-구현-예제)

### 1. 이미지 접근성

[Section titled “1. 이미지 접근성”](#1-이미지-접근성)

```dart
1
// 장식용 이미지
2
ExcludeSemantics(
3
  child: Image.asset('assets/decorative_background.png'),
4
)
5


6
// 내용이 있는 이미지
7
Image.asset(
8
  'assets/chart.png',
9
  semanticLabel: '2023년 분기별 매출 차트: 1분기 100만, 2분기 150만, 3분기 200만, 4분기 250만',
10
)
```

### 2. 폼 요소 접근성

[Section titled “2. 폼 요소 접근성”](#2-폼-요소-접근성)

```dart
1
// 접근성이 향상된 텍스트 필드
2
TextField(
3
  decoration: InputDecoration(
4
    labelText: '이메일',
5
    hintText: '예: example@gmail.com',
6
  ),
7
  // 명시적 접근성 레이블 제공
8
  semanticsLabel: '이메일 주소 입력',
9
)
10


11
// 접근성이 향상된 버튼
12
ElevatedButton(
13
  onPressed: _submit,
14
  child: Text('제출'),
15
  // Semantics 위젯을 사용하여 추가 정보 제공
16
  child: Semantics(
17
    label: '양식 제출 버튼',
18
    hint: '탭하여 작성한 양식을 제출합니다',
19
    button: true,
20
    child: Text('제출'),
21
  ),
22
)
```

### 3. 커스텀 위젯 접근성

[Section titled “3. 커스텀 위젯 접근성”](#3-커스텀-위젯-접근성)

```dart
1
class RatingBar extends StatelessWidget {
2
  final int rating;
3
  final int maxRating;
4
  final ValueChanged<int>? onRatingChanged;
5


6
  const RatingBar({
7
    Key? key,
8
    required this.rating,
9
    this.maxRating = 5,
10
    this.onRatingChanged,
11
  }) : super(key: key);
12


13
  @override
14
  Widget build(BuildContext context) {
15
    return Semantics(
16
      label: '별점',
17
      value: '$rating/$maxRating',
18
      // onRatingChanged가 null이 아니면 조정 가능한 것으로 표시
19
      slider: onRatingChanged != null,
20
      hint: onRatingChanged != null ? '좌우로 스와이프하여 별점 조정' : null,
21
      child: Row(
22
        mainAxisSize: MainAxisSize.min,
23
        children: List.generate(maxRating, (index) {
24
          return GestureDetector(
25
            onTap: onRatingChanged == null ? null : () {
26
              onRatingChanged!(index + 1);
27
            },
28
            // 개별 별에 대한 의미론적 정보는 제외
29
            child: ExcludeSemantics(
30
              child: Icon(
31
                index < rating ? Icons.star : Icons.star_border,
32
                color: Colors.amber,
33
              ),
34
            ),
35
          );
36
        }),
37
      ),
38
    );
39
  }
40
}
```

### 4. 네비게이션 접근성

[Section titled “4. 네비게이션 접근성”](#4-네비게이션-접근성)

```dart
1
Scaffold(
2
  appBar: AppBar(
3
    title: Text('접근성 예제'),
4
    // 뒤로 가기 버튼의 접근성 레이블 설정
5
    leading: Semantics(
6
      label: '뒤로 가기',
7
      hint: '이전 화면으로 돌아갑니다',
8
      button: true,
9
      child: IconButton(
10
        icon: Icon(Icons.arrow_back),
11
        onPressed: () => Navigator.of(context).pop(),
12
      ),
13
    ),
14
  ),
15
  // 하단 탐색 바의 접근성 향상
16
  bottomNavigationBar: BottomNavigationBar(
17
    items: [
18
      BottomNavigationBarItem(
19
        icon: Semantics(
20
          label: '홈 탭',
21
          selected: _selectedIndex == 0,
22
          child: Icon(Icons.home),
23
        ),
24
        label: '홈',
25
      ),
26
      BottomNavigationBarItem(
27
        icon: Semantics(
28
          label: '검색 탭',
29
          selected: _selectedIndex == 1,
30
          child: Icon(Icons.search),
31
        ),
32
        label: '검색',
33
      ),
34
      BottomNavigationBarItem(
35
        icon: Semantics(
36
          label: '프로필 탭',
37
          selected: _selectedIndex == 2,
38
          child: Icon(Icons.person),
39
        ),
40
        label: '프로필',
41
      ),
42
    ],
43
    currentIndex: _selectedIndex,
44
    onTap: _onItemTapped,
45
  ),
46
)
```

## 고급 접근성 기법

[Section titled “고급 접근성 기법”](#고급-접근성-기법)

### 1. 키보드 탐색 및 초점 관리

[Section titled “1. 키보드 탐색 및 초점 관리”](#1-키보드-탐색-및-초점-관리)

키보드 사용자를 위한 탐색 및 초점 관리:

```dart
1
// 초점 관리를 위한 FocusNode 사용
2
class KeyboardNavigationExample extends StatefulWidget {
3
  @override
4
  _KeyboardNavigationExampleState createState() => _KeyboardNavigationExampleState();
5
}
6


7
class _KeyboardNavigationExampleState extends State<KeyboardNavigationExample> {
8
  final FocusNode _nameFocus = FocusNode();
9
  final FocusNode _emailFocus = FocusNode();
10
  final FocusNode _passwordFocus = FocusNode();
11
  final FocusNode _submitFocus = FocusNode();
12


13
  @override
14
  void dispose() {
15
    _nameFocus.dispose();
16
    _emailFocus.dispose();
17
    _passwordFocus.dispose();
18
    _submitFocus.dispose();
19
    super.dispose();
20
  }
21


22
  @override
23
  Widget build(BuildContext context) {
24
    return Scaffold(
25
      appBar: AppBar(title: Text('키보드 탐색 예제')),
26
      body: Padding(
27
        padding: EdgeInsets.all(16.0),
28
        child: Column(
29
          children: [
30
            // 이름 필드
31
            TextField(
32
              focusNode: _nameFocus,
33
              decoration: InputDecoration(labelText: '이름'),
34
              textInputAction: TextInputAction.next,
35
              onEditingComplete: () {
36
                FocusScope.of(context).requestFocus(_emailFocus);
37
              },
38
            ),
39
            SizedBox(height: 16),
40


41
            // 이메일 필드
42
            TextField(
43
              focusNode: _emailFocus,
44
              decoration: InputDecoration(labelText: '이메일'),
45
              keyboardType: TextInputType.emailAddress,
46
              textInputAction: TextInputAction.next,
47
              onEditingComplete: () {
48
                FocusScope.of(context).requestFocus(_passwordFocus);
49
              },
50
            ),
51
            SizedBox(height: 16),
52


53
            // 비밀번호 필드
54
            TextField(
55
              focusNode: _passwordFocus,
56
              decoration: InputDecoration(labelText: '비밀번호'),
57
              obscureText: true,
58
              textInputAction: TextInputAction.done,
59
              onEditingComplete: () {
60
                FocusScope.of(context).requestFocus(_submitFocus);
61
              },
62
            ),
63
            SizedBox(height: 24),
64


65
            // 제출 버튼
66
            Focus(
67
              focusNode: _submitFocus,
68
              child: ElevatedButton(
69
                onPressed: () {
70
                  // 폼 제출 로직
71
                },
72
                child: Text('제출'),
73
              ),
74
              onKeyEvent: (node, event) {
75
                if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
76
                  // 엔터 키 처리
77
                  // 폼 제출 로직
78
                  return KeyEventResult.handled;
79
                }
80
                return KeyEventResult.ignored;
81
              },
82
            ),
83
          ],
84
        ),
85
      ),
86
    );
87
  }
88
}
```

### 2. 접근성 서비스 감지

[Section titled “2. 접근성 서비스 감지”](#2-접근성-서비스-감지)

현재 활성화된 접근성 서비스에 따라 UI를 조정할 수 있습니다:

```dart
1
import 'package:flutter/semantics.dart';
2


3
class AccessibilityAwareWidget extends StatefulWidget {
4
  @override
5
  _AccessibilityAwareWidgetState createState() => _AccessibilityAwareWidgetState();
6
}
7


8
class _AccessibilityAwareWidgetState extends State<AccessibilityAwareWidget> {
9
  bool _isScreenReaderEnabled = false;
10


11
  @override
12
  void initState() {
13
    super.initState();
14
    _checkAccessibilityFeatures();
15
    SemanticsBinding.instance.window.onAccessibilityFeaturesChanged = _checkAccessibilityFeatures;
16
  }
17


18
  void _checkAccessibilityFeatures() {
19
    setState(() {
20
      _isScreenReaderEnabled = SemanticsBinding.instance.window.accessibilityFeatures.accessibleNavigation;
21
    });
22
  }
23


24
  @override
25
  Widget build(BuildContext context) {
26
    if (_isScreenReaderEnabled) {
27
      // 화면 낭독기가 활성화되었을 때 더 간단한 UI 제공
28
      return ListView(
29
        children: [
30
          ListTile(
31
            title: Text('항목 1'),
32
            onTap: () => _selectItem(1),
33
          ),
34
          ListTile(
35
            title: Text('항목 2'),
36
            onTap: () => _selectItem(2),
37
          ),
38
          // ... 더 많은 항목
39
        ],
40
      );
41
    } else {
42
      // 일반 UI
43
      return GridView.builder(
44
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
45
        itemBuilder: (context, index) {
46
          return GestureDetector(
47
            onTap: () => _selectItem(index + 1),
48
            child: Card(
49
              child: Center(
50
                child: Text('항목 ${index + 1}'),
51
              ),
52
            ),
53
          );
54
        },
55
        itemCount: 9,
56
      );
57
    }
58
  }
59


60
  void _selectItem(int number) {
61
    // 항목 선택 처리
62
  }
63
}
```

### 3. 커스텀 접근성 액션

[Section titled “3. 커스텀 접근성 액션”](#3-커스텀-접근성-액션)

특정 제스처나 액션을 정의하여 접근성 서비스에 노출할 수 있습니다:

```dart
1
Semantics(
2
  customSemanticsActions: {
3
    CustomSemanticsAction(label: '새로고침'): () {
4
      _refreshData();
5
    },
6
    CustomSemanticsAction(label: '공유'): () {
7
      _shareContent();
8
    },
9
  },
10
  child: Container(
11
    // 콘텐츠
12
  ),
13
)
```

## 국제 접근성 가이드라인

[Section titled “국제 접근성 가이드라인”](#국제-접근성-가이드라인)

접근성을 올바르게 구현하기 위해 따를 수 있는 주요 국제 가이드라인:

### 1. WCAG 2.1 (Web Content Accessibility Guidelines)

[Section titled “1. WCAG 2.1 (Web Content Accessibility Guidelines)”](#1-wcag-21-web-content-accessibility-guidelines)

WCAG는 웹 콘텐츠의 접근성을 향상시키기 위한 가이드라인으로, 모바일 앱에도 적용할 수 있는 많은 원칙을 제공합니다:

1. **인식 가능(Perceivable)**: 정보와 인터페이스 요소는 사용자가 인식할 수 있어야 합니다.

   * 텍스트가 아닌 콘텐츠에 대체 텍스트 제공
   * 시간 기반 미디어에 대한 대안 제공
   * 내용을 다양한 방식으로 표현 가능하게 함
   * 사용자가 콘텐츠를 보고 들을 수 있도록 함

2. **운용 가능(Operable)**: 인터페이스 요소와 탐색은 조작 가능해야 합니다.

   * 모든 기능을 키보드로 사용 가능하게 함
   * 콘텐츠를 읽고 사용할 충분한 시간 제공
   * 발작이나 신체적 반응을 유발하는 콘텐츠 방지
   * 탐색 및 위치 찾기를 도울 수 있는 방법 제공

3. **이해 가능(Understandable)**: 정보와 인터페이스 조작은 이해 가능해야 합니다.

   * 텍스트 내용을 읽고 이해할 수 있게 함
   * 콘텐츠가 예측 가능한 방식으로 나타나고 작동하게 함
   * 사용자의 실수를 방지하고 수정할 수 있게 함

4. **견고함(Robust)**: 콘텐츠는 다양한 사용자 에이전트에서 해석될 수 있도록 충분히 견고해야 합니다.

   * 현재 및 미래의 사용자 도구와의 호환성 최대화

### 2. 모바일 앱 접근성 가이드라인

[Section titled “2. 모바일 앱 접근성 가이드라인”](#2-모바일-앱-접근성-가이드라인)

모바일 앱에 특화된 접근성 가이드라인도 있습니다:

* **BBC 모바일 접근성 가이드라인**
* **미국 재활법 508조**
* **구글의 Android 접근성 가이드라인**
* **애플의 iOS 접근성 가이드라인**

## 접근성 체크리스트

[Section titled “접근성 체크리스트”](#접근성-체크리스트)

다음은 Flutter 앱의 접근성을 평가하기 위한 간단한 체크리스트입니다:

### 기본 요소

[Section titled “기본 요소”](#기본-요소)

* [ ] 모든 이미지에 적절한 대체 텍스트(alt text) 제공
* [ ] 컬러 대비 충족 (최소 4.5:1, 큰 텍스트는 3:1)
* [ ] 컬러만으로 정보를 전달하지 않음 (아이콘, 텍스트 등 병행)
* [ ] 인터랙티브 요소의 최소 터치 영역 48x48dp 이상
* [ ] 모든 인터랙티브 요소에 명확한 포커스 표시
* [ ] 키보드로 모든 기능 접근 가능
* [ ] 터치 제스처에 대체 방법 제공

### 화면 낭독기 지원

[Section titled “화면 낭독기 지원”](#화면-낭독기-지원)

* [ ] 모든 UI 요소에 적절한 의미론적 레이블 제공
* [ ] 장식용 이미지 의미론적 트리에서 제외
* [ ] 커스텀 위젯에 적절한 접근성 역할 및 속성 정의
* [ ] 관련 요소 그룹화 (`MergeSemantics` 사용)
* [ ] 화면 낭독기로 앱의 주요 흐름 테스트 완료

### 텍스트 및 언어

[Section titled “텍스트 및 언어”](#텍스트-및-언어)

* [ ] 앱 전체에서 명확하고 일관된 언어 사용
* [ ] 복잡한 용어와 약어 최소화 또는 설명 제공
* [ ] 텍스트 크기 조정 지원
* [ ] 적절한 줄 간격 및 문단 간격

### 시간 및 동작

[Section titled “시간 및 동작”](#시간-및-동작)

* [ ] 자동 시간 제한이 있는 경우 연장 또는 해제 옵션 제공
* [ ] 움직이는 콘텐츠 일시 중지, 정지, 숨기기 가능
* [ ] 깜박이는 콘텐츠 없음 (또는 3회/초 미만)

### 오류 및 피드백

[Section titled “오류 및 피드백”](#오류-및-피드백)

* [ ] 오류 메시지가 명확하고 해결 방법 제시
* [ ] 중요한 액션 시 확인 요청
* [ ] 폼 제출 시 오류 식별 및 정정 안내
* [ ] 시각, 청각, 촉각 등 다중 피드백 제공

## 접근성 테스트 도구

[Section titled “접근성 테스트 도구”](#접근성-테스트-도구)

Flutter 앱의 접근성을 테스트할 수 있는 다양한 도구가 있습니다:

1. **Flutter 접근성 검사기**:

   main.dart

   ```dart
   1
   import 'package:flutter/material.dart';
   2


   3
   void main() {
   4
     runApp(MyApp());
   5
   }
   6


   7
   class MyApp extends StatelessWidget {
   8
     @override
   9
     Widget build(BuildContext context) {
   10
       return MaterialApp(
   11
         // 접근성 디버깅 모드 활성화
   12
         showSemanticsDebugger: true,
   13
         home: MyHomePage(),
   14
       );
   15
     }
   16
   }
   ```

2. **디바이스 내장 접근성 도구**:

   * Android: 접근성 스캐너 앱
   * iOS: 접근성 검사기

3. **Flutter DevTools**: 의미론적 트리 및 접근성 속성 검사

4. **색상 대비 검사기**:

   * [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
   * [Contrast Ratio](https://contrast-ratio.com/)

## 접근성을 고려한 앱 설계 모범 사례

[Section titled “접근성을 고려한 앱 설계 모범 사례”](#접근성을-고려한-앱-설계-모범-사례)

### 1. 디자인 단계부터 접근성 고려

[Section titled “1. 디자인 단계부터 접근성 고려”](#1-디자인-단계부터-접근성-고려)

접근성은 개발 과정의 마지막에 추가되는 기능이 아니라, 디자인 단계부터 고려해야 하는 핵심 요소입니다.

* 다양한 사용자 persona를 개발하여 다양한 접근성 요구사항 이해
* 디자인 시스템에 접근성 가이드라인 포함
* 와이어프레임과 프로토타입에 접근성 요소 포함

### 2. 충분한 색상 대비 제공

[Section titled “2. 충분한 색상 대비 제공”](#2-충분한-색상-대비-제공)

텍스트와 배경 간의 적절한 색상 대비는 모든 사용자에게 중요합니다:

```dart
1
// 접근성을 고려한 테마 설정
2
ThemeData(
3
  // 기본 색상 대비 확인 필요
4
  primaryColor: Colors.blue.shade700, // 밝은 배경에 충분한 대비
5
  colorScheme: ColorScheme.fromSwatch(
6
    primarySwatch: Colors.blue,
7
    // 어두운 배경에 충분한 대비를 가진 강조 색상
8
    accentColor: Colors.orangeAccent.shade700,
9
  ),
10
  // 높은 대비의 텍스트 스타일
11
  textTheme: TextTheme(
12
    bodyText1: TextStyle(
13
      color: Colors.black87, // 밝은 배경에 적합
14
      fontSize: 16,
15
    ),
16
    bodyText2: TextStyle(
17
      color: Colors.black87,
18
      fontSize: 14,
19
    ),
20
    // 강조 텍스트에 충분한 크기와 굵기
21
    headline6: TextStyle(
22
      color: Colors.black,
23
      fontSize: 18,
24
      fontWeight: FontWeight.bold,
25
    ),
26
  ),
27
  // 다크 모드 텍스트 스타일
28
  // 다크 테마에서는 충분한 대비를 위해 텍스트 색상을 더 밝게 조정
29
)
```

### 3. 텍스트 크기 조정 지원

[Section titled “3. 텍스트 크기 조정 지원”](#3-텍스트-크기-조정-지원)

사용자가 시스템 설정에서 텍스트 크기를 조정할 수 있도록 지원합니다:

```dart
1
// 시스템 텍스트 크기 설정 반영
2
MaterialApp(
3
  builder: (context, child) {
4
    return MediaQuery(
5
      // 시스템 텍스트 크기 설정 적용
6
      data: MediaQuery.of(context).copyWith(
7
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
8
      ),
9
      child: child!,
10
    );
11
  },
12
  // ...
13
)
```

### 4. 제스처 및 터치 영역 최적화

[Section titled “4. 제스처 및 터치 영역 최적화”](#4-제스처-및-터치-영역-최적화)

충분한 터치 영역과 대체 입력 방법 제공:

```dart
1
// 충분한 터치 영역 제공
2
GestureDetector(
3
  onTap: () {
4
    // 탭 동작
5
  },
6
  // 최소 48x48 크기의 터치 영역 보장
7
  child: Container(
8
    width: 48,
9
    height: 48,
10
    alignment: Alignment.center,
11
    child: Icon(Icons.add, size: 24),
12
  ),
13
)
14


15
// 복잡한 제스처에 대체 방법 제공
16
class SwipeOrButtonsWidget extends StatelessWidget {
17
  final Function onNext;
18
  final Function onPrevious;
19


20
  const SwipeOrButtonsWidget({
21
    Key? key,
22
    required this.onNext,
23
    required this.onPrevious,
24
  }) : super(key: key);
25


26
  @override
27
  Widget build(BuildContext context) {
28
    return Column(
29
      children: [
30
        // 스와이프 동작
31
        GestureDetector(
32
          onHorizontalDragEnd: (details) {
33
            if (details.primaryVelocity! < 0) {
34
              onNext();
35
            } else if (details.primaryVelocity! > 0) {
36
              onPrevious();
37
            }
38
          },
39
          child: Container(
40
            // 콘텐츠
41
          ),
42
        ),
43


44
        // 대체 탐색 버튼 (접근성용)
45
        Semantics(
46
          label: '탐색 버튼',
47
          explicitChildNodes: true,
48
          child: Row(
49
            mainAxisAlignment: MainAxisAlignment.center,
50
            children: [
51
              ElevatedButton(
52
                onPressed: () => onPrevious(),
53
                child: Text('이전'),
54
              ),
55
              SizedBox(width: 16),
56
              ElevatedButton(
57
                onPressed: () => onNext(),
58
                child: Text('다음'),
59
              ),
60
            ],
61
          ),
62
        ),
63
      ],
64
    );
65
  }
66
}
```

## 결론

[Section titled “결론”](#결론)

접근성은 모든 사용자가 앱을 불편 없이 사용할 수 있도록 하는 중요한 요소입니다. Flutter는 `Semantics` 위젯을 통해 풍부한 접근성 기능을 제공하며, 이를 활용하면 다양한 사용자의 요구에 맞는 앱을 개발할 수 있습니다.

효과적인 접근성 구현은 디자인 초기 단계부터 시작되어야 하며, 개발 중에 지속적으로 테스트해야 합니다. 접근성을 고려한 앱 개발은 단지 장애가 있는 사용자만을 위한 것이 아니라, 모든 사용자에게 더 나은 경험을 제공하는 과정임을 기억하세요.

다음 장에서는 Flutter 앱의 다국어 처리에 대해 알아보겠습니다.

# 애니메이션

애니메이션은 사용자 경험(UX)을 향상시키는 중요한 요소입니다. 적절한 애니메이션은 사용자 인터페이스에 생동감을 부여하고, 상태 변화를 자연스럽게 표현하며, 사용자의 주의를 필요한 곳으로 유도합니다. Flutter는 다양한 애니메이션 기법을 쉽게 구현할 수 있는 풍부한 API를 제공합니다.

## Flutter 애니메이션의 기본 개념

[Section titled “Flutter 애니메이션의 기본 개념”](#flutter-애니메이션의-기본-개념)

Flutter 애니메이션을 이해하기 위한 핵심 개념들을 살펴보겠습니다.

### 주요 구성 요소

[Section titled “주요 구성 요소”](#주요-구성-요소)

1. **AnimationController**: 애니메이션의 시작, 정지, 반복 등을 제어하는 중앙 관리자
2. **Animation\<T>**: 시간에 따라 변화하는 값(double, Color, Offset 등)을 제공
3. **Tween**: 시작 값과 끝 값 사이의 보간(interpolation)을 정의
4. **Curve**: 애니메이션의 가속도와 시간 흐름을 결정하는 곡선

## 기본 애니메이션 구현하기

[Section titled “기본 애니메이션 구현하기”](#기본-애니메이션-구현하기)

### 1. 암시적(Implicit) 애니메이션

[Section titled “1. 암시적(Implicit) 애니메이션”](#1-암시적implicit-애니메이션)

Flutter는 많은 내장 암시적 애니메이션 위젯을 제공합니다. 이 위젯들은 `Animated` 접두사로 시작하며, 값이 변경될 때 자동으로 애니메이션이 적용됩니다.

```dart
1
class ImplicitAnimationExample extends StatefulWidget {
2
  @override
3
  _ImplicitAnimationExampleState createState() => _ImplicitAnimationExampleState();
4
}
5


6
class _ImplicitAnimationExampleState extends State<ImplicitAnimationExample> {
7
  double _width = 100.0;
8
  double _height = 100.0;
9
  Color _color = Colors.blue;
10
  double _borderRadius = 8.0;
11


12
  void _changeProperties() {
13
    setState(() {
14
      _width = _width == 100.0 ? 200.0 : 100.0;
15
      _height = _height == 100.0 ? 300.0 : 100.0;
16
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
17
      _borderRadius = _borderRadius == 8.0 ? 60.0 : 8.0;
18
    });
19
  }
20


21
  @override
22
  Widget build(BuildContext context) {
23
    return GestureDetector(
24
      onTap: _changeProperties,
25
      child: Center(
26
        child: AnimatedContainer(
27
          width: _width,
28
          height: _height,
29
          decoration: BoxDecoration(
30
            color: _color,
31
            borderRadius: BorderRadius.circular(_borderRadius),
32
          ),
33
          duration: Duration(milliseconds: 500),
34
          curve: Curves.easeInOut,
35
          child: Center(
36
            child: Text('탭하여 변경'),
37
          ),
38
        ),
39
      ),
40
    );
41
  }
42
}
```

#### 주요 암시적 애니메이션 위젯

[Section titled “주요 암시적 애니메이션 위젯”](#주요-암시적-애니메이션-위젯)

| 위젯                         | 용도                           |
| -------------------------- | ---------------------------- |
| `AnimatedContainer`        | 컨테이너 속성 애니메이션(크기, 색상, 테두리 등) |
| `AnimatedOpacity`          | 투명도 애니메이션                    |
| `AnimatedPadding`          | 패딩 애니메이션                     |
| `AnimatedPositioned`       | `Stack` 내에서 위치 애니메이션         |
| `AnimatedSwitcher`         | 위젯 전환 애니메이션                  |
| `AnimatedDefaultTextStyle` | 텍스트 스타일 애니메이션                |
| `AnimatedCrossFade`        | 두 위젯 간 교차 페이드 애니메이션          |
| `TweenAnimationBuilder`    | 사용자 정의 암시적 애니메이션             |

### 2. 명시적(Explicit) 애니메이션

[Section titled “2. 명시적(Explicit) 애니메이션”](#2-명시적explicit-애니메이션)

명시적 애니메이션은 더 세밀한 제어가 필요한 경우 사용합니다. `AnimationController`를 직접 조작하여 애니메이션의 시작, 중지, 역방향 재생 등을 제어할 수 있습니다.

```dart
1
class ExplicitAnimationExample extends StatefulWidget {
2
  @override
3
  _ExplicitAnimationExampleState createState() => _ExplicitAnimationExampleState();
4
}
5


6
class _ExplicitAnimationExampleState extends State<ExplicitAnimationExample>
7
    with SingleTickerProviderStateMixin {
8
  late AnimationController _controller;
9
  late Animation<double> _sizeAnimation;
10
  late Animation<Color?> _colorAnimation;
11
  late Animation<double> _borderRadiusAnimation;
12


13
  @override
14
  void initState() {
15
    super.initState();
16


17
    _controller = AnimationController(
18
      duration: Duration(milliseconds: 500),
19
      vsync: this,
20
    );
21


22
    // 크기 애니메이션
23
    _sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(
24
      CurvedAnimation(
25
        parent: _controller,
26
        curve: Curves.elasticOut,
27
      ),
28
    );
29


30
    // 색상 애니메이션
31
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
32
      CurvedAnimation(
33
        parent: _controller,
34
        curve: Curves.easeInOut,
35
      ),
36
    );
37


38
    // 테두리 반경 애니메이션
39
    _borderRadiusAnimation = Tween<double>(begin: 8.0, end: 60.0).animate(
40
      CurvedAnimation(
41
        parent: _controller,
42
        curve: Curves.easeInOut,
43
      ),
44
    );
45
  }
46


47
  @override
48
  void dispose() {
49
    _controller.dispose();
50
    super.dispose();
51
  }
52


53
  void _toggleAnimation() {
54
    if (_controller.isCompleted) {
55
      _controller.reverse();
56
    } else {
57
      _controller.forward();
58
    }
59
  }
60


61
  @override
62
  Widget build(BuildContext context) {
63
    return GestureDetector(
64
      onTap: _toggleAnimation,
65
      child: Center(
66
        child: AnimatedBuilder(
67
          animation: _controller,
68
          builder: (context, child) {
69
            return Container(
70
              width: _sizeAnimation.value,
71
              height: _sizeAnimation.value,
72
              decoration: BoxDecoration(
73
                color: _colorAnimation.value,
74
                borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
75
              ),
76
              child: child,
77
            );
78
          },
79
          child: Center(
80
            child: Text('탭하여 애니메이션'),
81
          ),
82
        ),
83
      ),
84
    );
85
  }
86
}
```

#### AnimationController의 주요 메서드

[Section titled “AnimationController의 주요 메서드”](#animationcontroller의-주요-메서드)

* `forward()`: 애니메이션을 시작하거나 계속 진행
* `reverse()`: 애니메이션을 역방향으로 재생
* `repeat()`: 애니메이션을 반복
* `reset()`: 애니메이션을 초기 상태로 재설정
* `stop()`: 애니메이션을 현재 위치에서 정지

### 3. Hero 애니메이션

[Section titled “3. Hero 애니메이션”](#3-hero-애니메이션)

Hero 애니메이션은 두 화면 간에 위젯을 자연스럽게 전환하는 데 사용됩니다. 사용자가 목록에서 세부 정보 화면으로 이동할 때 특히 유용합니다.

```dart
1
// 목록 화면
2
class HeroListScreen extends StatelessWidget {
3
  @override
4
  Widget build(BuildContext context) {
5
    return Scaffold(
6
      appBar: AppBar(title: Text('Hero 애니메이션')),
7
      body: ListView.builder(
8
        itemCount: 10,
9
        itemBuilder: (context, index) {
10
          return ListTile(
11
            leading: Hero(
12
              tag: 'hero-$index', // 고유한 태그
13
              child: CircleAvatar(
14
                backgroundImage: NetworkImage(
15
                  'https://picsum.photos/id/${index + 10}/200/200',
16
                ),
17
              ),
18
            ),
19
            title: Text('아이템 $index'),
20
            onTap: () {
21
              Navigator.of(context).push(
22
                MaterialPageRoute(
23
                  builder: (context) => HeroDetailScreen(
24
                    imageUrl: 'https://picsum.photos/id/${index + 10}/400/400',
25
                    heroTag: 'hero-$index',
26
                    title: '아이템 $index',
27
                  ),
28
                ),
29
              );
30
            },
31
          );
32
        },
33
      ),
34
    );
35
  }
36
}
37


38
// 상세 화면
39
class HeroDetailScreen extends StatelessWidget {
40
  final String imageUrl;
41
  final String heroTag;
42
  final String title;
43


44
  const HeroDetailScreen({
45
    required this.imageUrl,
46
    required this.heroTag,
47
    required this.title,
48
  });
49


50
  @override
51
  Widget build(BuildContext context) {
52
    return Scaffold(
53
      appBar: AppBar(title: Text(title)),
54
      body: Center(
55
        child: Column(
56
          mainAxisAlignment: MainAxisAlignment.center,
57
          children: [
58
            Hero(
59
              tag: heroTag,
60
              child: Image.network(
61
                imageUrl,
62
                width: 300,
63
                height: 300,
64
                fit: BoxFit.cover,
65
              ),
66
            ),
67
            SizedBox(height: 20),
68
            Text(
69
              title,
70
              style: TextStyle(fontSize: 24),
71
            ),
72
          ],
73
        ),
74
      ),
75
    );
76
  }
77
}
```

### 4. 페이지 전환 애니메이션

[Section titled “4. 페이지 전환 애니메이션”](#4-페이지-전환-애니메이션)

Flutter에서는 페이지 간의 전환도 애니메이션으로 꾸밀 수 있습니다. `PageRouteBuilder`를 사용하여 사용자 정의 전환 효과를 만들 수 있습니다.

```dart
1
// 페이드 전환
2
Navigator.of(context).push(
3
  PageRouteBuilder(
4
    pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
5
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
6
      const begin = 0.0;
7
      const end = 1.0;
8
      var tween = Tween(begin: begin, end: end);
9
      var fadeAnimation = animation.drive(tween);
10


11
      return FadeTransition(
12
        opacity: fadeAnimation,
13
        child: child,
14
      );
15
    },
16
    transitionDuration: Duration(milliseconds: 500),
17
  ),
18
);
19


20
// 슬라이드 전환
21
Navigator.of(context).push(
22
  PageRouteBuilder(
23
    pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
24
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
25
      var begin = Offset(1.0, 0.0);
26
      var end = Offset.zero;
27
      var curve = Curves.ease;
28


29
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
30
      var offsetAnimation = animation.drive(tween);
31


32
      return SlideTransition(
33
        position: offsetAnimation,
34
        child: child,
35
      );
36
    },
37
    transitionDuration: Duration(milliseconds: 500),
38
  ),
39
);
```

go\_router를 사용하는 경우 다음과 같이 페이지 전환을 설정할 수 있습니다:

```dart
1
final router = GoRouter(
2
  routes: [
3
    GoRoute(
4
      path: '/',
5
      builder: (context, state) => HomeScreen(),
6
    ),
7
    GoRoute(
8
      path: '/detail/:id',
9
      pageBuilder: (context, state) {
10
        return CustomTransitionPage(
11
          key: state.pageKey,
12
          child: DetailScreen(id: state.params['id']!),
13
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
14
            return FadeTransition(
15
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
16
              child: child,
17
            );
18
          },
19
        );
20
      },
21
    ),
22
  ],
23
);
```

## 고급 애니메이션 기법

[Section titled “고급 애니메이션 기법”](#고급-애니메이션-기법)

### 1. Staggered Animation (단계별 애니메이션)

[Section titled “1. Staggered Animation (단계별 애니메이션)”](#1-staggered-animation-단계별-애니메이션)

단계별 애니메이션은 여러 애니메이션이 서로 다른 타이밍으로 실행되도록 조정하는 기법입니다. 더 복잡하고 흥미로운 효과를 만들 수 있습니다.

```dart
1
class StaggeredAnimationExample extends StatefulWidget {
2
  @override
3
  _StaggeredAnimationExampleState createState() => _StaggeredAnimationExampleState();
4
}
5


6
class _StaggeredAnimationExampleState extends State<StaggeredAnimationExample>
7
    with SingleTickerProviderStateMixin {
8
  late AnimationController _controller;
9
  late Animation<double> _heightAnimation;
10
  late Animation<double> _widthAnimation;
11
  late Animation<BorderRadius?> _borderRadiusAnimation;
12
  late Animation<Color?> _colorAnimation;
13


14
  @override
15
  void initState() {
16
    super.initState();
17


18
    _controller = AnimationController(
19
      duration: Duration(milliseconds: 1500),
20
      vsync: this,
21
    );
22


23
    // 단계별 애니메이션 간격 설정
24
    var _heightInterval = Interval(0.0, 0.3, curve: Curves.easeInOut);
25
    var _widthInterval = Interval(0.2, 0.5, curve: Curves.easeInOut);
26
    var _borderInterval = Interval(0.5, 0.8, curve: Curves.easeInOut);
27
    var _colorInterval = Interval(0.7, 1.0, curve: Curves.easeInOut);
28


29
    // 애니메이션 정의
30
    _heightAnimation = Tween<double>(begin: 100.0, end: 300.0).animate(
31
      CurvedAnimation(parent: _controller, curve: _heightInterval),
32
    );
33


34
    _widthAnimation = Tween<double>(begin: 100.0, end: 300.0).animate(
35
      CurvedAnimation(parent: _controller, curve: _widthInterval),
36
    );
37


38
    _borderRadiusAnimation = BorderRadiusTween(
39
      begin: BorderRadius.circular(0.0),
40
      end: BorderRadius.circular(150.0),
41
    ).animate(
42
      CurvedAnimation(parent: _controller, curve: _borderInterval),
43
    );
44


45
    _colorAnimation = ColorTween(
46
      begin: Colors.blue,
47
      end: Colors.purple,
48
    ).animate(
49
      CurvedAnimation(parent: _controller, curve: _colorInterval),
50
    );
51
  }
52


53
  @override
54
  void dispose() {
55
    _controller.dispose();
56
    super.dispose();
57
  }
58


59
  void _playAnimation() {
60
    if (_controller.status == AnimationStatus.completed) {
61
      _controller.reverse();
62
    } else {
63
      _controller.forward();
64
    }
65
  }
66


67
  @override
68
  Widget build(BuildContext context) {
69
    return GestureDetector(
70
      onTap: _playAnimation,
71
      child: Center(
72
        child: AnimatedBuilder(
73
          animation: _controller,
74
          builder: (context, child) {
75
            return Container(
76
              height: _heightAnimation.value,
77
              width: _widthAnimation.value,
78
              decoration: BoxDecoration(
79
                color: _colorAnimation.value,
80
                borderRadius: _borderRadiusAnimation.value,
81
              ),
82
              child: Center(
83
                child: Text(
84
                  '탭하여 애니메이션',
85
                  style: TextStyle(color: Colors.white),
86
                ),
87
              ),
88
            );
89
          },
90
        ),
91
      ),
92
    );
93
  }
94
}
```

### 2. 물리 기반 애니메이션

[Section titled “2. 물리 기반 애니메이션”](#2-물리-기반-애니메이션)

Flutter는 실제 물리 법칙에 기반한 자연스러운 애니메이션을 위한 `SpringSimulation` 및 `GravitySimulation` 등을 제공합니다.

```dart
1
class PhysicsBasedAnimationExample extends StatefulWidget {
2
  @override
3
  _PhysicsBasedAnimationExampleState createState() =>
4
      _PhysicsBasedAnimationExampleState();
5
}
6


7
class _PhysicsBasedAnimationExampleState extends State<PhysicsBasedAnimationExample>
8
    with SingleTickerProviderStateMixin {
9
  late AnimationController _controller;
10
  late SpringSimulation _simulation;
11
  double _position = 0.0;
12


13
  @override
14
  void initState() {
15
    super.initState();
16


17
    // 스프링 시뮬레이션 설정
18
    // 매개변수: 질량, 강성, 감쇠, 초기 위치
19
    _simulation = SpringSimulation(
20
      SpringDescription(
21
        mass: 1.0,      // 질량
22
        stiffness: 100.0, // 강성 (높을수록 빠른 진동)
23
        damping: 10.0,   // 감쇠 (높을수록 빠르게 안정화)
24
      ),
25
      0.0, // 시작 위치
26
      1.0, // 목표 위치
27
      0.0, // 초기 속도
28
    );
29


30
    _controller = AnimationController(
31
      vsync: this,
32
      duration: Duration(milliseconds: 1500),
33
    )..addListener(() {
34
        setState(() {
35
          // 현재 시뮬레이션 위치 계산
36
          _position = _simulation.x(_controller.value * 1.5);
37
        });
38
      });
39
  }
40


41
  @override
42
  void dispose() {
43
    _controller.dispose();
44
    super.dispose();
45
  }
46


47
  @override
48
  Widget build(BuildContext context) {
49
    return GestureDetector(
50
      onTap: () {
51
        if (_controller.status == AnimationStatus.completed) {
52
          _controller.reset();
53
        }
54
        _controller.forward();
55
      },
56
      child: Column(
57
        mainAxisAlignment: MainAxisAlignment.center,
58
        children: [
59
          Text('스프링 애니메이션'),
60
          SizedBox(height: 20),
61
          Container(
62
            height: 300,
63
            width: double.infinity,
64
            child: Stack(
65
              alignment: Alignment.topCenter,
66
              children: [
67
                Positioned(
68
                  top: 200 * _position,
69
                  child: Container(
70
                    width: 50,
71
                    height: 50,
72
                    decoration: BoxDecoration(
73
                      color: Colors.blue,
74
                      shape: BoxShape.circle,
75
                    ),
76
                  ),
77
                ),
78
              ],
79
            ),
80
          ),
81
          Text('탭하여 공을 떨어뜨리세요'),
82
        ],
83
      ),
84
    );
85
  }
86
}
```

### 3. 애니메이션 시퀀스

[Section titled “3. 애니메이션 시퀀스”](#3-애니메이션-시퀀스)

여러 애니메이션을 순차적으로 실행해야 할 때는 다음과 같이 작성할 수 있습니다:

```dart
1
class SequentialAnimationExample extends StatefulWidget {
2
  @override
3
  _SequentialAnimationExampleState createState() =>
4
      _SequentialAnimationExampleState();
5
}
6


7
class _SequentialAnimationExampleState extends State<SequentialAnimationExample>
8
    with SingleTickerProviderStateMixin {
9
  late AnimationController _controller;
10
  late Animation<double> _animation1;
11
  late Animation<double> _animation2;
12
  late Animation<double> _animation3;
13


14
  @override
15
  void initState() {
16
    super.initState();
17


18
    _controller = AnimationController(
19
      duration: Duration(milliseconds: 3000),
20
      vsync: this,
21
    );
22


23
    // 애니메이션 1: 0초~1초 (0.0~0.33)
24
    _animation1 = Tween<double>(begin: 100, end: 200).animate(
25
      CurvedAnimation(
26
        parent: _controller,
27
        curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
28
      ),
29
    );
30


31
    // 애니메이션 2: 1초~2초 (0.33~0.66)
32
    _animation2 = Tween<double>(begin: 0, end: 2 * pi).animate(
33
      CurvedAnimation(
34
        parent: _controller,
35
        curve: Interval(0.33, 0.66, curve: Curves.easeInOut),
36
      ),
37
    );
38


39
    // 애니메이션 3: 2초~3초 (0.66~1.0)
40
    _animation3 = Tween<double>(begin: 1.0, end: 0.3).animate(
41
      CurvedAnimation(
42
        parent: _controller,
43
        curve: Interval(0.66, 1.0, curve: Curves.easeInOut),
44
      ),
45
    );
46
  }
47


48
  @override
49
  void dispose() {
50
    _controller.dispose();
51
    super.dispose();
52
  }
53


54
  void _startAnimation() {
55
    _controller.reset();
56
    _controller.forward();
57
  }
58


59
  @override
60
  Widget build(BuildContext context) {
61
    return Column(
62
      mainAxisAlignment: MainAxisAlignment.center,
63
      children: [
64
        AnimatedBuilder(
65
          animation: _controller,
66
          builder: (context, child) {
67
            return Transform.scale(
68
              scale: _animation3.value,
69
              child: Transform.rotate(
70
                angle: _animation2.value,
71
                child: Container(
72
                  width: _animation1.value,
73
                  height: _animation1.value,
74
                  decoration: BoxDecoration(
75
                    color: Colors.blue,
76
                    borderRadius: BorderRadius.circular(24),
77
                  ),
78
                  child: Icon(
79
                    Icons.star,
80
                    color: Colors.yellow,
81
                    size: 80,
82
                  ),
83
                ),
84
              ),
85
            );
86
          },
87
        ),
88
        SizedBox(height: 40),
89
        ElevatedButton(
90
          onPressed: _startAnimation,
91
          child: Text('시퀀스 애니메이션 시작'),
92
        ),
93
      ],
94
    );
95
  }
96
}
```

### 4. flutter\_animate 패키지 사용하기

[Section titled “4. flutter\_animate 패키지 사용하기”](#4-flutter_animate-패키지-사용하기)

`flutter_animate` 패키지는 복잡한 애니메이션을 간편하게 구현할 수 있도록 도와줍니다.

```dart
1
import 'package:flutter_animate/flutter_animate.dart';
2


3
class FlutterAnimateExample extends StatelessWidget {
4
  @override
5
  Widget build(BuildContext context) {
6
    return Center(
7
      child: Column(
8
        mainAxisAlignment: MainAxisAlignment.center,
9
        children: [
10
          // 체인 애니메이션
11
          Text('Flutter Animate')
12
              .animate()
13
              .fadeIn(duration: 500.ms)
14
              .slideY(begin: -0.3, end: 0, duration: 500.ms)
15
              .then(delay: 200.ms) // 지연
16
              .shimmer(duration: 1000.ms) // 반짝임 효과
17
              .scale(delay: 200.ms, duration: 600.ms), // 크기 변경
18


19
          SizedBox(height: 48),
20


21
          // 병렬 애니메이션
22
          Row(
23
            mainAxisAlignment: MainAxisAlignment.center,
24
            children: [
25
              for (int i = 0; i < 5; i++)
26
                Container(
27
                  width: 50,
28
                  height: 50,
29
                  margin: EdgeInsets.all(8),
30
                  color: Colors.blue,
31
                )
32
                .animate(delay: (100 * i).ms) // 각 항목마다 지연 증가
33
                .fade(duration: 500.ms)
34
                .scale(begin: 0.5, end: 1)
35
                .move(begin: Offset(0, 100), end: Offset.zero)
36
            ],
37
          ),
38
        ],
39
      ),
40
    );
41
  }
42
}
```

## 애니메이션 성능 최적화

[Section titled “애니메이션 성능 최적화”](#애니메이션-성능-최적화)

### 1. RepaintBoundary 사용하기

[Section titled “1. RepaintBoundary 사용하기”](#1-repaintboundary-사용하기)

복잡한 애니메이션의 경우, `RepaintBoundary`를 사용하여 다시 그려야 하는 영역을 제한합니다:

```dart
1
RepaintBoundary(
2
  child: AnimatedBuilder(
3
    animation: _controller,
4
    builder: (context, child) {
5
      return Transform.rotate(
6
        angle: _controller.value * 2 * pi,
7
        child: child,
8
      );
9
    },
10
    child: Container(
11
      width: 200,
12
      height: 200,
13
      color: Colors.blue,
14
    ),
15
  ),
16
)
```

### 2. Transform 활용하기

[Section titled “2. Transform 활용하기”](#2-transform-활용하기)

`setState`를 호출하는 대신 `Transform` 위젯을 사용하면 위젯 트리를 재구성하지 않고 변형만 적용할 수 있습니다:

```dart
1
AnimatedBuilder(
2
  animation: _animation,
3
  builder: (context, child) {
4
    return Transform.translate(
5
      offset: Offset(0, 100 * _animation.value),
6
      child: child, // 변경되지 않는 부분
7
    );
8
  },
9
  child: const MyComplexWidget(), // 재사용 가능한 위젯
10
)
```

### 3. ValueListenableBuilder 사용하기

[Section titled “3. ValueListenableBuilder 사용하기”](#3-valuelistenablebuilder-사용하기)

단일 값 변경에 반응할 때는 `AnimatedBuilder` 대신 `ValueListenableBuilder`를 사용하는 것이 더 효율적일 수 있습니다:

```dart
1
ValueListenableBuilder<double>(
2
  valueListenable: _progressNotifier,
3
  builder: (context, value, child) {
4
    return CircularProgressIndicator(value: value);
5
  },
6
)
```

## 애니메이션 디자인 패턴 및 모범 사례

[Section titled “애니메이션 디자인 패턴 및 모범 사례”](#애니메이션-디자인-패턴-및-모범-사례)

### 1. 상태별 애니메이션 모델 분리

[Section titled “1. 상태별 애니메이션 모델 분리”](#1-상태별-애니메이션-모델-분리)

복잡한 애니메이션은 로직을 별도의 클래스로 분리하는 것이 좋습니다:

```dart
1
class LoadingAnimationModel {
2
  final AnimationController controller;
3
  late final Animation<double> scaleAnimation;
4
  late final Animation<Color?> colorAnimation;
5


6
  LoadingAnimationModel({required this.controller}) {
7
    scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
8
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut),
9
    );
10


11
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.purple).animate(
12
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
13
    );
14
  }
15


16
  void startLoading() {
17
    controller.repeat(reverse: true);
18
  }
19


20
  void stopLoading() {
21
    controller.stop();
22
    controller.reset();
23
  }
24


25
  void dispose() {
26
    controller.dispose();
27
  }
28
}
29


30
// 사용 예시
31
class LoadingScreen extends StatefulWidget {
32
  @override
33
  _LoadingScreenState createState() => _LoadingScreenState();
34
}
35


36
class _LoadingScreenState extends State<LoadingScreen>
37
    with SingleTickerProviderStateMixin {
38
  late LoadingAnimationModel _animationModel;
39


40
  @override
41
  void initState() {
42
    super.initState();
43
    _animationModel = LoadingAnimationModel(
44
      controller: AnimationController(
45
        duration: Duration(milliseconds: 800),
46
        vsync: this,
47
      ),
48
    );
49
    _animationModel.startLoading();
50
  }
51


52
  @override
53
  void dispose() {
54
    _animationModel.dispose();
55
    super.dispose();
56
  }
57


58
  @override
59
  Widget build(BuildContext context) {
60
    return AnimatedBuilder(
61
      animation: _animationModel.controller,
62
      builder: (context, child) {
63
        return Transform.scale(
64
          scale: _animationModel.scaleAnimation.value,
65
          child: Container(
66
            width: 50,
67
            height: 50,
68
            decoration: BoxDecoration(
69
              color: _animationModel.colorAnimation.value,
70
              shape: BoxShape.circle,
71
            ),
72
          ),
73
        );
74
      },
75
    );
76
  }
77
}
```

### 2. Riverpod와 애니메이션 통합

[Section titled “2. Riverpod와 애니메이션 통합”](#2-riverpod와-애니메이션-통합)

Riverpod을 사용할 때는 애니메이션 컨트롤러를 프로바이더로 관리할 수 있습니다:

```dart
1
// 애니메이션 컨트롤러 프로바이더
2
final animationControllerProvider = Provider.autoDispose<AnimationController>((ref) {
3
  final controller = AnimationController(
4
    duration: Duration(milliseconds: 500),
5
    vsync: ref.watch(tickerProvider),
6
  );
7


8
  ref.onDispose(() {
9
    controller.dispose();
10
  });
11


12
  return controller;
13
});
14


15
// TickerProvider 프로바이더
16
final tickerProvider = Provider<TickerProvider>((ref) {
17
  throw UnimplementedError('TickerProvider가 설정되지 않았습니다.');
18
});
19


20
// 애니메이션 프로바이더
21
final fadeAnimationProvider = Provider.autoDispose<Animation<double>>((ref) {
22
  final controller = ref.watch(animationControllerProvider);
23
  return Tween<double>(begin: 0.0, end: 1.0).animate(controller);
24
});
25


26
// 사용 예시
27
class AnimatedPage extends ConsumerStatefulWidget {
28
  @override
29
  _AnimatedPageState createState() => _AnimatedPageState();
30
}
31


32
class _AnimatedPageState extends ConsumerState<AnimatedPage>
33
    with TickerProviderStateMixin {
34
  @override
35
  void initState() {
36
    super.initState();
37
    // TickerProvider 설정
38
    ref.read(tickerProvider.overrideWithValue(this));
39


40
    // 애니메이션 시작
41
    WidgetsBinding.instance.addPostFrameCallback((_) {
42
      ref.read(animationControllerProvider).forward();
43
    });
44
  }
45


46
  @override
47
  Widget build(BuildContext context) {
48
    final fadeAnimation = ref.watch(fadeAnimationProvider);
49


50
    return FadeTransition(
51
      opacity: fadeAnimation,
52
      child: const MyPageContent(),
53
    );
54
  }
55
}
```

## 애니메이션 UX 지침

[Section titled “애니메이션 UX 지침”](#애니메이션-ux-지침)

### 1. 애니메이션 지속 시간

[Section titled “1. 애니메이션 지속 시간”](#1-애니메이션-지속-시간)

애니메이션의 적절한 지속 시간은 애니메이션 유형과 목적에 따라 다릅니다:

* **기본 UI 전환**: 150ms \~ 300ms
* **엘리먼트 입장/퇴장**: 200ms \~ 500ms
* **복잡한 애니메이션**: 500ms \~ 1000ms
* **강조 애니메이션**: 800ms \~ 1500ms

### 2. 애니메이션 곡선 선택

[Section titled “2. 애니메이션 곡선 선택”](#2-애니메이션-곡선-선택)

적절한 Curve는 애니메이션의 느낌을 결정합니다:

* **Curves.easeInOut**: 자연스러운 가속 및 감속, 대부분의 UI 전환에 적합
* **Curves.easeOut**: 빠른 시작과 부드러운 종료, 요소가 화면에 등장할 때 좋음
* **Curves.easeIn**: 부드러운 시작과 빠른 종료, 요소가 화면을 떠날 때 적합
* **Curves.elasticOut**: 탄력 있는 효과, 강조하거나 놀라운 요소에 적합
* **Curves.bounceOut**: 튀는 효과, 재미있고 활기찬 느낌을 줄 때 사용

### 3. 모바일 고려사항

[Section titled “3. 모바일 고려사항”](#3-모바일-고려사항)

모바일 디바이스에서는 다음 사항을 고려하세요:

* **배터리 수명**: 과도한 애니메이션은 배터리 소모를 증가시킴
* **성능**: 저사양 기기에서도 원활하게 작동하는지 확인
* **사용자 설정**: 사용자가 애니메이션을 줄이거나 비활성화할 수 있는 옵션 제공

## 결론

[Section titled “결론”](#결론)

Flutter의 애니메이션 시스템은 풍부하고 유연합니다. 암시적 애니메이션부터 복잡한 물리 기반 애니메이션까지, 다양한 사용자 경험을 구현할 수 있는 도구를 제공합니다.

애니메이션을 효과적으로 사용하려면 목적을 명확히 하고, 과도하게 사용하지 않으며, 성능을 고려해야 합니다. 적절한 애니메이션은 앱의 사용성과 매력을 크게 향상시키는 강력한 도구입니다.

다음 장에서는 Flutter에서 접근성을 구현하여 더 많은 사용자가 앱을 이용할 수 있도록 하는 방법에 대해 알아보겠습니다.

# CustomPainter와 RenderBox 이해

Flutter에서 복잡한 사용자 정의 UI를 구현하기 위해서는 기본 위젯만으로는 한계가 있습니다. 더 유연하고 세밀한 UI를 구현하기 위해 Flutter는 저수준 그래픽 API인 `CustomPainter`와 렌더링 시스템의 기본 요소인 `RenderBox`를 제공합니다. 이 장에서는 이 두 가지 중요한 개념을 자세히 알아보겠습니다.

## CustomPainter 개요

[Section titled “CustomPainter 개요”](#custompainter-개요)

`CustomPainter`는 Flutter에서 직접 캔버스에 그리기 위한 강력한 도구입니다. 벡터 그래픽, 차트, 복잡한 애니메이션, 커스텀 진행 표시기 등을 구현할 때 매우 유용합니다.

### CustomPainter 사용 방법

[Section titled “CustomPainter 사용 방법”](#custompainter-사용-방법)

`CustomPainter`를 사용하려면 다음 세 가지 주요 구성 요소가 필요합니다:

1. `CustomPainter`를 상속받는 클래스
2. `CustomPaint` 위젯
3. `Paint` 객체로 스타일 정의

#### 1. CustomPainter 클래스 구현

[Section titled “1. CustomPainter 클래스 구현”](#1-custompainter-클래스-구현)

```dart
1
class MyPainter extends CustomPainter {
2
  @override
3
  void paint(Canvas canvas, Size size) {
4
    // 여기에 그리기 코드 작성
5
  }
6


7
  @override
8
  bool shouldRepaint(covariant MyPainter oldDelegate) {
9
    // 다시 그려야 하는지 결정
10
    return false;
11
  }
12
}
```

#### 2. CustomPaint 위젯 사용

[Section titled “2. CustomPaint 위젯 사용”](#2-custompaint-위젯-사용)

```dart
1
CustomPaint(
2
  painter: MyPainter(),
3
  size: Size(300, 200), // 명시적 크기 지정
4
  child: Container(), // 선택적 자식 위젯
5
)
```

또는 자식 위젯의 크기에 맞추기:

```dart
1
SizedBox(
2
  width: 300,
3
  height: 200,
4
  child: CustomPaint(
5
    painter: MyPainter(),
6
    child: Container(), // 선택적 자식 위젯
7
  ),
8
)
```

### 기본 도형 그리기

[Section titled “기본 도형 그리기”](#기본-도형-그리기)

`Canvas` 객체는 다양한 도형을 그리기 위한 메서드를 제공합니다:

```dart
1
class BasicShapesPainter extends CustomPainter {
2
  @override
3
  void paint(Canvas canvas, Size size) {
4
    final paint = Paint()
5
      ..color = Colors.blue
6
      ..strokeWidth = 4.0
7
      ..style = PaintingStyle.stroke;
8


9
    // 선 그리기
10
    canvas.drawLine(
11
      Offset(0, 0),
12
      Offset(size.width, size.height),
13
      paint,
14
    );
15


16
    // 사각형 그리기
17
    canvas.drawRect(
18
      Rect.fromLTWH(50, 50, 100, 100),
19
      paint..color = Colors.red,
20
    );
21


22
    // 원 그리기
23
    canvas.drawCircle(
24
      Offset(size.width / 2, size.height / 2),
25
      50,
26
      paint..color = Colors.green,
27
    );
28


29
    // 둥근 사각형 그리기
30
    canvas.drawRRect(
31
      RRect.fromRectAndRadius(
32
        Rect.fromLTWH(200, 50, 100, 100),
33
        Radius.circular(20),
34
      ),
35
      paint..color = Colors.orange,
36
    );
37
  }
38


39
  @override
40
  bool shouldRepaint(covariant BasicShapesPainter oldDelegate) => false;
41
}
```

### Path를 사용한 복잡한 도형 그리기

[Section titled “Path를 사용한 복잡한 도형 그리기”](#path를-사용한-복잡한-도형-그리기)

더 복잡한 도형은 `Path` 클래스를 사용하여 그릴 수 있습니다:

```dart
1
class PathPainter extends CustomPainter {
2
  @override
3
  void paint(Canvas canvas, Size size) {
4
    final paint = Paint()
5
      ..color = Colors.purple
6
      ..style = PaintingStyle.stroke
7
      ..strokeWidth = 3;
8


9
    final path = Path();
10


11
    // 시작점 설정
12
    path.moveTo(0, size.height / 2);
13


14
    // 곡선 그리기
15
    path.quadraticBezierTo(
16
      size.width / 4, 0,
17
      size.width / 2, size.height / 2,
18
    );
19


20
    path.quadraticBezierTo(
21
      size.width * 3 / 4, size.height,
22
      size.width, size.height / 2,
23
    );
24


25
    canvas.drawPath(path, paint);
26
  }
27


28
  @override
29
  bool shouldRepaint(covariant PathPainter oldDelegate) => false;
30
}
```

### 실제 예제: 커스텀 차트 구현

[Section titled “실제 예제: 커스텀 차트 구현”](#실제-예제-커스텀-차트-구현)

다음은 간단한 막대 차트를 구현하는 예제입니다:

```dart
1
class BarChartPainter extends CustomPainter {
2
  final List<double> dataPoints;
3
  final double maxValue;
4


5
  BarChartPainter({
6
    required this.dataPoints,
7
    required this.maxValue,
8
  });
9


10
  @override
11
  void paint(Canvas canvas, Size size) {
12
    final barWidth = size.width / dataPoints.length;
13
    final paint = Paint()
14
      ..color = Colors.blue
15
      ..style = PaintingStyle.fill;
16


17
    // 데이터 포인트에 따라 막대 그리기
18
    for (int i = 0; i < dataPoints.length; i++) {
19
      final barHeight = (dataPoints[i] / maxValue) * size.height;
20


21
      canvas.drawRect(
22
        Rect.fromLTWH(
23
          i * barWidth,
24
          size.height - barHeight,
25
          barWidth - 4, // 막대 사이 간격
26
          barHeight,
27
        ),
28
        paint,
29
      );
30
    }
31


32
    // x축 그리기
33
    canvas.drawLine(
34
      Offset(0, size.height),
35
      Offset(size.width, size.height),
36
      Paint()
37
        ..color = Colors.black
38
        ..strokeWidth = 2,
39
    );
40
  }
41


42
  @override
43
  bool shouldRepaint(covariant BarChartPainter oldDelegate) {
44
    return oldDelegate.dataPoints != dataPoints ||
45
        oldDelegate.maxValue != maxValue;
46
  }
47
}
48


49
// 사용 예시
50
CustomPaint(
51
  painter: BarChartPainter(
52
    dataPoints: [30, 80, 40, 90, 60],
53
    maxValue: 100,
54
  ),
55
  size: Size(300, 200),
56
)
```

## shouldRepaint 메서드 최적화

[Section titled “shouldRepaint 메서드 최적화”](#shouldrepaint-메서드-최적화)

`shouldRepaint` 메서드는 이전에 그린 것과 비교하여 다시 그려야 하는지 결정합니다. 이 메서드를 올바르게 구현하면 성능을 크게 향상시킬 수 있습니다:

```dart
1
class OptimizedPainter extends CustomPainter {
2
  final Color color;
3
  final double strokeWidth;
4


5
  OptimizedPainter({
6
    required this.color,
7
    required this.strokeWidth,
8
  });
9


10
  @override
11
  void paint(Canvas canvas, Size size) {
12
    // 그리기 로직...
13
  }
14


15
  @override
16
  bool shouldRepaint(covariant OptimizedPainter oldDelegate) {
17
    // 변경 사항이 있을 때만 다시 그리기
18
    return oldDelegate.color != color ||
19
        oldDelegate.strokeWidth != strokeWidth;
20
  }
21
}
```

## CustomPainter 애니메이션

[Section titled “CustomPainter 애니메이션”](#custompainter-애니메이션)

`AnimationController`와 `CustomPainter`를 결합하여 애니메이션 효과를 만들 수 있습니다:

```dart
1
class AnimatedCirclePainter extends CustomPainter {
2
  final double animationValue;
3


4
  AnimatedCirclePainter({required this.animationValue});
5


6
  @override
7
  void paint(Canvas canvas, Size size) {
8
    final center = Offset(size.width / 2, size.height / 2);
9
    final radius = 50.0 + 20.0 * animationValue;
10


11
    final paint = Paint()
12
      ..color = Color.lerp(
13
        Colors.blue,
14
        Colors.red,
15
        animationValue,
16
      )!
17
      ..style = PaintingStyle.fill;
18


19
    canvas.drawCircle(center, radius, paint);
20
  }
21


22
  @override
23
  bool shouldRepaint(covariant AnimatedCirclePainter oldDelegate) {
24
    return oldDelegate.animationValue != animationValue;
25
  }
26
}
27


28
// 사용 예시 (StatefulWidget 내부)
29
Widget build(BuildContext context) {
30
  return AnimatedBuilder(
31
    animation: _controller, // AnimationController
32
    builder: (context, child) {
33
      return CustomPaint(
34
        painter: AnimatedCirclePainter(
35
          animationValue: _controller.value,
36
        ),
37
        size: Size(300, 300),
38
      );
39
    },
40
  );
41
}
```

## RenderBox 이해하기

[Section titled “RenderBox 이해하기”](#renderbox-이해하기)

`RenderBox`는 Flutter 렌더링 시스템의 핵심 요소로, 위젯의 레이아웃과 그리기 로직을 담당합니다. 일반적으로 개발자는 직접 `RenderBox`를 다루기보다는 위젯 API를 통해 간접적으로 사용합니다.

### RenderBox 계층 구조

[Section titled “RenderBox 계층 구조”](#renderbox-계층-구조)

Flutter의 렌더링 시스템은 세 가지 주요 계층으로 구성됩니다:

1. **위젯(Widget)**: 불변의 설정 객체
2. **요소(Element)**: 위젯의 인스턴스
3. **렌더 객체(RenderObject/RenderBox)**: 실제 레이아웃과 그리기 담당

### 커스텀 RenderBox 만들기

[Section titled “커스텀 RenderBox 만들기”](#커스텀-renderbox-만들기)

커스텀 `RenderBox`를 만드는 것은 고급 주제이지만, 특수한 레이아웃 동작이 필요할 때 유용합니다. 전체 과정은 다음과 같습니다:

1. `RenderBox`를 상속받는 클래스 구현
2. `SingleChildRenderObjectWidget`을 상속받는 위젯 구현
3. `SingleChildRenderObjectElement`를 확장하는 요소 구현 (선택적)

간단한 예제를 살펴보겠습니다:

```dart
1
// 1. RenderBox 구현
2
class RenderCenterSquare extends RenderBox {
3
  @override
4
  void performLayout() {
5
    // 원하는 크기 계산
6
    size = constraints.biggest;
7
  }
8


9
  @override
10
  void paint(PaintingContext context, Offset offset) {
11
    // 중앙에 정사각형 그리기
12
    final canvas = context.canvas;
13
    final squareSize = size.shortestSide / 2;
14
    final center = Offset(size.width / 2, size.height / 2);
15
    final rect = Rect.fromCenter(
16
      center: center,
17
      width: squareSize,
18
      height: squareSize,
19
    );
20


21
    canvas.drawRect(
22
      rect,
23
      Paint()..color = Colors.purple,
24
    );
25
  }
26
}
27


28
// 2. SingleChildRenderObjectWidget 구현
29
class CenterSquare extends SingleChildRenderObjectWidget {
30
  const CenterSquare({Key? key, Widget? child}) : super(key: key, child: child);
31


32
  @override
33
  RenderObject createRenderObject(BuildContext context) {
34
    return RenderCenterSquare();
35
  }
36
}
```

### RenderBox vs CustomPainter

[Section titled “RenderBox vs CustomPainter”](#renderbox-vs-custompainter)

`RenderBox`와 `CustomPainter`의 주요 차이점은:

1. **목적**:

   * `CustomPainter`: 그리기 전용
   * `RenderBox`: 레이아웃과 그리기 모두 담당

2. **복잡성**:

   * `CustomPainter`: 비교적 간단한 구현
   * `RenderBox`: 더 복잡하지만 유연성 높음

3. **사용 사례**:

   * `CustomPainter`: 복잡한 그래픽, 차트, 사용자 정의 표시
   * `RenderBox`: 사용자 정의 레이아웃 동작이 필요한 경우

## 실전 사례: 서명 패드 구현

[Section titled “실전 사례: 서명 패드 구현”](#실전-사례-서명-패드-구현)

`CustomPainter`를 사용한 실제 응용 사례로 서명 패드를 구현해 보겠습니다:

```dart
1
class SignaturePainter extends CustomPainter {
2
  final List<List<Offset>> strokes;
3


4
  SignaturePainter({required this.strokes});
5


6
  @override
7
  void paint(Canvas canvas, Size size) {
8
    final paint = Paint()
9
      ..color = Colors.black
10
      ..strokeWidth = 3.0
11
      ..strokeCap = StrokeCap.round
12
      ..style = PaintingStyle.stroke;
13


14
    for (final stroke in strokes) {
15
      if (stroke.length < 2) continue;
16


17
      final path = Path();
18
      path.moveTo(stroke[0].dx, stroke[0].dy);
19


20
      for (int i = 1; i < stroke.length; i++) {
21
        path.lineTo(stroke[i].dx, stroke[i].dy);
22
      }
23


24
      canvas.drawPath(path, paint);
25
    }
26
  }
27


28
  @override
29
  bool shouldRepaint(covariant SignaturePainter oldDelegate) {
30
    return oldDelegate.strokes != strokes;
31
  }
32
}
33


34
// 사용 예시 (StatefulWidget 내부)
35
class SignaturePad extends StatefulWidget {
36
  @override
37
  _SignaturePadState createState() => _SignaturePadState();
38
}
39


40
class _SignaturePadState extends State<SignaturePad> {
41
  List<List<Offset>> strokes = [];
42
  List<Offset> currentStroke = [];
43


44
  @override
45
  Widget build(BuildContext context) {
46
    return GestureDetector(
47
      onPanStart: (details) {
48
        setState(() {
49
          currentStroke = [details.localPosition];
50
          strokes.add(currentStroke);
51
        });
52
      },
53
      onPanUpdate: (details) {
54
        setState(() {
55
          currentStroke.add(details.localPosition);
56
          // 참조를 통해 strokes가 자동으로 업데이트됨
57
        });
58
      },
59
      child: CustomPaint(
60
        painter: SignaturePainter(strokes: strokes),
61
        size: Size.infinite,
62
      ),
63
    );
64
  }
65
}
```

## 성능 최적화 팁

[Section titled “성능 최적화 팁”](#성능-최적화-팁)

### 1. Path 최적화

[Section titled “1. Path 최적화”](#1-path-최적화)

많은 점을 그릴 때는 개별 선보다 `Path`를 사용하는 것이 훨씬 효율적입니다:

```dart
1
// 비효율적인 방법
2
for (int i = 1; i < points.length; i++) {
3
  canvas.drawLine(points[i - 1], points[i], paint);
4
}
5


6
// 더 효율적인 방법
7
final path = Path();
8
path.moveTo(points[0].dx, points[0].dy);
9
for (int i = 1; i < points.length; i++) {
10
  path.lineTo(points[i].dx, points[i].dy);
11
}
12
canvas.drawPath(path, paint);
```

### 2. 클리핑 사용

[Section titled “2. 클리핑 사용”](#2-클리핑-사용)

필요한 영역만 그리기 위해 클리핑을 활용할 수 있습니다:

```dart
1
canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
```

### 3. 캐싱 활용

[Section titled “3. 캐싱 활용”](#3-캐싱-활용)

자주 변경되지 않는 복잡한 그림은 캐싱을 고려하세요:

```dart
1
class CachedPainter extends CustomPainter {
2
  ui.Image? _cachedImage;
3


4
  Future<void> _createCachedImage(Size size) async {
5
    if (_cachedImage != null) return;
6


7
    final pictureRecorder = ui.PictureRecorder();
8
    final canvas = Canvas(pictureRecorder);
9


10
    // 복잡한 그리기 작업 수행
11


12
    final picture = pictureRecorder.endRecording();
13
    _cachedImage = await picture.toImage(
14
      size.width.toInt(),
15
      size.height.toInt(),
16
    );
17
  }
18


19
  @override
20
  void paint(Canvas canvas, Size size) async {
21
    await _createCachedImage(size);
22
    if (_cachedImage != null) {
23
      canvas.drawImage(_cachedImage!, Offset.zero, Paint());
24
    }
25
  }
26


27
  @override
28
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
29
}
```

## 결론

[Section titled “결론”](#결론)

`CustomPainter`와 `RenderBox`는 Flutter에서 복잡한 UI와 그래픽을 구현하기 위한 강력한 도구입니다. `CustomPainter`는 비교적 쉽게 시작할 수 있으며 대부분의 사용자 정의 그리기 요구사항을 충족합니다. 반면 `RenderBox`는 더 복잡하지만 완전히 사용자 정의된 레이아웃 동작이 필요한 경우에 유용합니다.

이러한 도구를 이해하고 활용하면 기본 위젯으로는 구현하기 어려운 복잡한 UI 요소를 만들 수 있습니다. 차트, 그래프, 커스텀 애니메이션, 게임 UI 등 다양한 응용 분야에서 활용할 수 있습니다.

다음 장에서는 위젯 캐싱과 `RepaintBoundary`를 활용하여 Flutter 앱의 렌더링 성능을 최적화하는 방법에 대해 알아보겠습니다.

# 다국어 지원

글로벌 시장에서 앱의 경쟁력을 높이기 위해서는 다양한 언어와 지역 설정을 지원하는 것이 중요합니다. Flutter는 `flutter_localizations` 패키지와 `intl` 패키지를 통해 앱의 다국어 처리(internationalization)와 지역화(localization)를 지원합니다.

## 다국어 처리의 중요성

[Section titled “다국어 처리의 중요성”](#다국어-처리의-중요성)

사용자의 언어로 앱을 제공하면 다음과 같은 장점이 있습니다:

1. **확장된 사용자 기반**: 더 많은 국가와 지역의 사용자에게 다가갈 수 있습니다.
2. **향상된 사용자 경험**: 사용자는 자신의 모국어로 앱을 사용할 때 더 편안함을 느낍니다.
3. **법적 요구사항 충족**: 일부 국가에서는 특정 유형의 앱에 현지어 지원을 요구합니다.
4. **경쟁 우위**: 다국어를 지원하는 앱은 그렇지 않은 앱보다 경쟁 우위를 가질 수 있습니다.

## Flutter 다국어 처리 기본 설정

[Section titled “Flutter 다국어 처리 기본 설정”](#flutter-다국어-처리-기본-설정)

### 1. 필요한 패키지 추가

[Section titled “1. 필요한 패키지 추가”](#1-필요한-패키지-추가)

`pubspec.yaml` 파일에 필요한 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  flutter_localizations:
5
    sdk: flutter
6
  intl: ^0.17.0
7


8
flutter:
9
  generate: true
```

`generate: true`는 Flutter에게 `l10n.yaml` 파일을 기반으로 지역화 파일을 생성하도록 지시합니다.

### 2. l10n.yaml 파일 생성

[Section titled “2. l10n.yaml 파일 생성”](#2-l10nyaml-파일-생성)

프로젝트 루트 디렉토리에 `l10n.yaml` 파일을 생성합니다:

```yaml
1
arb-dir: lib/l10n
2
template-arb-file: app_en.arb
3
output-localization-file: app_localizations.dart
```

### 3. ARB 파일 생성

[Section titled “3. ARB 파일 생성”](#3-arb-파일-생성)

`lib/l10n` 디렉토리를 생성하고 기본 언어(영어) ARB 파일을 작성합니다:

lib/l10n/app\_en.arb

```json
1
{
2
  "helloWorld": "Hello World",
3
  "@helloWorld": {
4
    "description": "The conventional greeting"
5
  },
6
  "hello": "Hello {username}",
7
  "@hello": {
8
    "description": "A welcome message",
9
    "placeholders": {
10
      "username": {
11
        "type": "String",
12
        "example": "Bob"
13
      }
14
    }
15
  },
16
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
17
  "@itemCount": {
18
    "description": "A plural message",
19
    "placeholders": {
20
      "count": {
21
        "type": "int",
22
        "format": "compact"
23
      }
24
    }
25
  }
26
}
```

이제 다른 언어에 대한 ARB 파일도 생성합니다:

lib/l10n/app\_ko.arb

```json
1
{
2
  "helloWorld": "안녕 세상",
3
  "hello": "{username}님 안녕하세요",
4
  "itemCount": "{count, plural, =0{항목 없음} =1{1개 항목} other{{count}개 항목}}"
5
}
```

lib/l10n/app\_ja.arb

```json
1
{
2
  "helloWorld": "こんにちは世界",
3
  "hello": "こんにちは、{username}さん",
4
  "itemCount": "{count, plural, =0{アイテムなし} =1{1 アイテム} other{{count} アイテム}}"
5
}
```

### 4. 앱에 지역화 대리자 설정

[Section titled “4. 앱에 지역화 대리자 설정”](#4-앱에-지역화-대리자-설정)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_localizations/flutter_localizations.dart';
3
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
4


5
void main() {
6
  runApp(const MyApp());
7
}
8


9
class MyApp extends StatelessWidget {
10
  const MyApp({Key? key}) : super(key: key);
11


12
  @override
13
  Widget build(BuildContext context) {
14
    return MaterialApp(
15
      title: 'Flutter Demo',
16
      // 지원하는 언어 목록
17
      supportedLocales: AppLocalizations.supportedLocales,
18
      // 지역화 대리자
19
      localizationsDelegates: const [
20
        AppLocalizations.delegate,
21
        GlobalMaterialLocalizations.delegate,
22
        GlobalWidgetsLocalizations.delegate,
23
        GlobalCupertinoLocalizations.delegate,
24
      ],
25
      // 사용자 기기의 언어 설정을 따름
26
      localeResolutionCallback: (locale, supportedLocales) {
27
        for (var supportedLocale in supportedLocales) {
28
          if (supportedLocale.languageCode == locale?.languageCode &&
29
              supportedLocale.countryCode == locale?.countryCode) {
30
            return supportedLocale;
31
          }
32
        }
33
        // 지원하지 않는 언어의 경우 첫 번째 언어로 대체
34
        return supportedLocales.first;
35
      },
36
      home: const MyHomePage(),
37
    );
38
  }
39
}
```

### 5. 지역화된 문자열 사용

[Section titled “5. 지역화된 문자열 사용”](#5-지역화된-문자열-사용)

```dart
1
class MyHomePage extends StatelessWidget {
2
  const MyHomePage({Key? key}) : super(key: key);
3


4
  @override
5
  Widget build(BuildContext context) {
6
    final localizations = AppLocalizations.of(context)!;
7


8
    return Scaffold(
9
      appBar: AppBar(
10
        title: Text(localizations.helloWorld),
11
      ),
12
      body: Center(
13
        child: Column(
14
          mainAxisAlignment: MainAxisAlignment.center,
15
          children: [
16
            Text(localizations.hello('Flutter 사용자')),
17
            const SizedBox(height: 16),
18
            Text(localizations.itemCount(5)),
19
          ],
20
        ),
21
      ),
22
    );
23
  }
24
}
```

## 날짜, 시간, 숫자 형식화

[Section titled “날짜, 시간, 숫자 형식화”](#날짜-시간-숫자-형식화)

`intl` 패키지를 사용하여 날짜, 시간, 숫자 등을 현지화된 형식으로 표시할 수 있습니다.

### 1. 날짜 및 시간 형식화

[Section titled “1. 날짜 및 시간 형식화”](#1-날짜-및-시간-형식화)

```dart
1
import 'package:intl/intl.dart';
2


3
class DateTimeFormatExample extends StatelessWidget {
4
  const DateTimeFormatExample({Key? key}) : super(key: key);
5


6
  @override
7
  Widget build(BuildContext context) {
8
    final now = DateTime.now();
9


10
    // 현재 로케일에 따른 날짜 형식
11
    final dateFormat = DateFormat.yMMMMd(Localizations.localeOf(context).toString());
12
    final timeFormat = DateFormat.jms(Localizations.localeOf(context).toString());
13


14
    return Column(
15
      children: [
16
        Text('날짜: ${dateFormat.format(now)}'),
17
        Text('시간: ${timeFormat.format(now)}'),
18
      ],
19
    );
20
  }
21
}
```

### 2. 숫자 형식화

[Section titled “2. 숫자 형식화”](#2-숫자-형식화)

```dart
1
import 'package:intl/intl.dart';
2


3
class NumberFormatExample extends StatelessWidget {
4
  const NumberFormatExample({Key? key}) : super(key: key);
5


6
  @override
7
  Widget build(BuildContext context) {
8
    final locale = Localizations.localeOf(context).toString();
9
    final number = 1234567.89;
10


11
    // 일반 숫자 형식
12
    final numberFormat = NumberFormat.decimalPattern(locale);
13
    // 통화 형식
14
    final currencyFormat = NumberFormat.currency(
15
      locale: locale,
16
      symbol: '₩', // 한국 원화 기호
17
    );
18
    // 백분율 형식
19
    final percentFormat = NumberFormat.percentPattern(locale);
20


21
    return Column(
22
      children: [
23
        Text('숫자: ${numberFormat.format(number)}'),
24
        Text('통화: ${currencyFormat.format(number)}'),
25
        Text('백분율: ${percentFormat.format(number / 100)}'),
26
      ],
27
    );
28
  }
29
}
```

## 언어 선택 기능 구현

[Section titled “언어 선택 기능 구현”](#언어-선택-기능-구현)

사용자가 앱 내에서 언어를 변경할 수 있도록 하려면 `Provider` 또는 `Riverpod`을 사용하여 언어 설정을 관리할 수 있습니다.

### 1. 언어 설정 상태 관리 (Riverpod 사용)

[Section titled “1. 언어 설정 상태 관리 (Riverpod 사용)”](#1-언어-설정-상태-관리-riverpod-사용)

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2
import 'package:shared_preferences/shared_preferences.dart';
3
import 'package:flutter/material.dart';
4


5
// 언어 설정을 저장하기 위한 키
6
const String languagePreferenceKey = 'language_code';
7


8
// 로케일 상태를 관리하는 프로바이더
9
@riverpod
10
class LocaleNotifier extends _$LocaleNotifier {
11
  @override
12
  Locale build() {
13
    // 기본값으로 디바이스 로케일 또는 영어 사용
14
    return const Locale('en');
15
  }
16


17
  // 앱 초기화 시 저장된 언어 설정 불러오기
18
  Future<void> loadSavedLocale() async {
19
    final prefs = await SharedPreferences.getInstance();
20
    final languageCode = prefs.getString(languagePreferenceKey);
21


22
    if (languageCode != null) {
23
      state = Locale(languageCode);
24
    }
25
  }
26


27
  // 언어 변경 함수
28
  Future<void> setLocale(String languageCode) async {
29
    final prefs = await SharedPreferences.getInstance();
30
    await prefs.setString(languagePreferenceKey, languageCode);
31


32
    state = Locale(languageCode);
33
  }
34
}
```

### 2. 앱에 언어 설정 적용

[Section titled “2. 앱에 언어 설정 적용”](#2-앱에-언어-설정-적용)

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_riverpod/flutter_riverpod.dart';
3
import 'package:flutter_localizations/flutter_localizations.dart';
4
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
5


6
void main() {
7
  runApp(const ProviderScope(child: MyApp()));
8
}
9


10
class MyApp extends ConsumerWidget {
11
  const MyApp({Key? key}) : super(key: key);
12


13
  @override
14
  Widget build(BuildContext context, WidgetRef ref) {
15
    // 현재 로케일 가져오기
16
    final locale = ref.watch(localeNotifierProvider);
17


18
    // 앱 시작 시 저장된 로케일 불러오기
19
    WidgetsBinding.instance.addPostFrameCallback((_) {
20
      ref.read(localeNotifierProvider.notifier).loadSavedLocale();
21
    });
22


23
    return MaterialApp(
24
      title: 'Flutter Demo',
25
      // 현재 선택된 로케일 적용
26
      locale: locale,
27
      supportedLocales: AppLocalizations.supportedLocales,
28
      localizationsDelegates: const [
29
        AppLocalizations.delegate,
30
        GlobalMaterialLocalizations.delegate,
31
        GlobalWidgetsLocalizations.delegate,
32
        GlobalCupertinoLocalizations.delegate,
33
      ],
34
      home: const LanguageSelectionPage(),
35
    );
36
  }
37
}
```

### 3. 언어 선택 페이지

[Section titled “3. 언어 선택 페이지”](#3-언어-선택-페이지)

```dart
1
class LanguageSelectionPage extends ConsumerWidget {
2
  const LanguageSelectionPage({Key? key}) : super(key: key);
3


4
  @override
5
  Widget build(BuildContext context, WidgetRef ref) {
6
    final localizations = AppLocalizations.of(context)!;
7
    final currentLocale = ref.watch(localeNotifierProvider);
8


9
    // 지원하는 언어 목록
10
    final supportedLanguages = [
11
      {'code': 'en', 'name': 'English'},
12
      {'code': 'ko', 'name': '한국어'},
13
      {'code': 'ja', 'name': '日本語'},
14
    ];
15


16
    return Scaffold(
17
      appBar: AppBar(
18
        title: Text(localizations.helloWorld),
19
      ),
20
      body: ListView.builder(
21
        itemCount: supportedLanguages.length,
22
        itemBuilder: (context, index) {
23
          final language = supportedLanguages[index];
24
          final isSelected = currentLocale.languageCode == language['code'];
25


26
          return ListTile(
27
            title: Text(language['name']!),
28
            trailing: isSelected ? const Icon(Icons.check) : null,
29
            onTap: () {
30
              ref.read(localeNotifierProvider.notifier)
31
                 .setLocale(language['code']!);
32
            },
33
          );
34
        },
35
      ),
36
    );
37
  }
38
}
```

## 리소스 지역화

[Section titled “리소스 지역화”](#리소스-지역화)

텍스트 외에도 이미지, 아이콘 등의 리소스도 지역화할 수 있습니다.

### 1. 이미지 지역화

[Section titled “1. 이미지 지역화”](#1-이미지-지역화)

```dart
1
// 로케일에 따라 다른 이미지 로드
2
class LocalizedImage extends StatelessWidget {
3
  const LocalizedImage({Key? key}) : super(key: key);
4


5
  @override
6
  Widget build(BuildContext context) {
7
    final locale = Localizations.localeOf(context);
8


9
    // 언어 코드에 따라 다른 이미지 경로 반환
10
    String getLocalizedImagePath() {
11
      switch (locale.languageCode) {
12
        case 'ko':
13
          return 'assets/images/banner_ko.png';
14
        case 'ja':
15
          return 'assets/images/banner_ja.png';
16
        default:
17
          return 'assets/images/banner_en.png';
18
      }
19
    }
20


21
    return Image.asset(getLocalizedImagePath());
22
  }
23
}
```

## 양방향 텍스트 지원 (RTL/LTR)

[Section titled “양방향 텍스트 지원 (RTL/LTR)”](#양방향-텍스트-지원-rtlltr)

아랍어나 히브리어와 같은 오른쪽에서 왼쪽으로 쓰는 언어(RTL)를 지원해야 할 경우 고려해야 할 사항입니다.

```dart
1
// MaterialApp 설정
2
MaterialApp(
3
  // RTL 언어 지원
4
  supportedLocales: const [
5
    Locale('en'), // 영어 (LTR)
6
    Locale('ko'), // 한국어 (LTR)
7
    Locale('ar'), // 아랍어 (RTL)
8
    Locale('he'), // 히브리어 (RTL)
9
  ],
10
)
11


12
// RTL/LTR을 고려한 UI 구성
13
class BidirectionalAwareWidget extends StatelessWidget {
14
  const BidirectionalAwareWidget({Key? key}) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    // 현재 텍스트 방향 확인
19
    final isRTL = Directionality.of(context) == TextDirection.rtl;
20


21
    return Row(
22
      children: [
23
        // RTL에서는 아이콘과 텍스트 순서가 반대가 됨
24
        if (!isRTL) const Icon(Icons.arrow_back),
25
        const SizedBox(width: 8),
26
        const Text('뒤로 가기'),
27
        if (isRTL) const Icon(Icons.arrow_back),
28
      ],
29
    );
30
  }
31
}
```

## 다국어 앱 테스트

[Section titled “다국어 앱 테스트”](#다국어-앱-테스트)

다국어 앱을 효과적으로 테스트하려면 다음 사항을 고려해야 합니다:

1. **모든 지원 언어 테스트**: 각 지원 언어로 앱을 실행하고 모든 화면을 확인합니다.
2. **자동 테스트 작성**: 주요 언어 전환 기능에 대한 위젯 테스트를 작성합니다.
3. **텍스트 오버플로우 확인**: 같은 문장이라도 언어에 따라 길이가 다를 수 있습니다.
4. **문화적 고려사항 테스트**: 날짜, 시간, 숫자 형식 등이 각 문화권에 맞게 표시되는지 확인합니다.

```dart
1
// 위젯 테스트 예시
2
testWidgets('지원하는 모든 언어로 앱을 렌더링할 수 있어야 함', (WidgetTester tester) async {
3
  for (final locale in AppLocalizations.supportedLocales) {
4
    await tester.pumpWidget(
5
      MaterialApp(
6
        locale: locale,
7
        localizationsDelegates: const [
8
          AppLocalizations.delegate,
9
          GlobalMaterialLocalizations.delegate,
10
          GlobalWidgetsLocalizations.delegate,
11
          GlobalCupertinoLocalizations.delegate,
12
        ],
13
        home: const MyHomePage(),
14
      ),
15
    );
16


17
    // 번역된 문자열이 올바르게 표시되는지 확인
18
    expect(find.byType(MyHomePage), findsOneWidget);
19
    await expectLater(find.byType(MyHomePage), matchesGoldenFile('home_page_${locale.languageCode}.png'));
20
  }
21
});
```

## 다국어 처리 모범 사례

[Section titled “다국어 처리 모범 사례”](#다국어-처리-모범-사례)

### 1. 번역 키 구성

[Section titled “1. 번역 키 구성”](#1-번역-키-구성)

```json
1
// 좋은 예시: 명확한 키와 컨텍스트
2
{
3
  "auth.login.button": "로그인",
4
  "auth.login.email.label": "이메일",
5
  "auth.login.password.label": "비밀번호",
6
  "feed.empty.message": "표시할 게시물이 없습니다"
7
}
8


9
// 피해야 할 예시: 모호한 키
10
{
11
  "login": "로그인",
12
  "email": "이메일",
13
  "password": "비밀번호",
14
  "empty": "표시할 게시물이 없습니다"
15
}
```

### 2. 복수형 처리

[Section titled “2. 복수형 처리”](#2-복수형-처리)

```dart
1
// 복수형 처리 예시
2
String getItemText(int count) {
3
  return localizations.itemCount(count);
4
}
5


6
// ARB 파일 설정
7
// app_en.arb
8
{
9
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
10
  "@itemCount": {
11
    "description": "A plural message",
12
    "placeholders": {
13
      "count": {
14
        "type": "int"
15
      }
16
    }
17
  }
18
}
19


20
// app_ko.arb
21
{
22
  "itemCount": "{count, plural, =0{항목 없음} =1{1개 항목} other{{count}개 항목}}"
23
}
```

### 3. 문맥 제공

[Section titled “3. 문맥 제공”](#3-문맥-제공)

```dart
1
// ARB 파일에 문맥 추가
2
{
3
  "save": "저장",
4
  "@save": {
5
    "description": "General action to save current changes"
6
  },
7


8
  "save_photo": "저장",
9
  "@save_photo": {
10
    "description": "Button to save a photo to gallery"
11
  }
12
}
```

### 4. 하드코딩 피하기

[Section titled “4. 하드코딩 피하기”](#4-하드코딩-피하기)

```dart
1
// 잘못된 예시: 하드코딩된 문자열
2
Text('로그인');
3


4
// 올바른 예시: 번역 사용
5
Text(localizations.login);
```

## 결론

[Section titled “결론”](#결론)

Flutter에서 다국어 처리는 앱의 글로벌 도달 범위를 확장하는 중요한 기능입니다. `flutter_localizations`와 `intl` 패키지를 사용하면 앱을 여러 언어로 쉽게 제공할 수 있으며, 사용자에게 더 나은 경험을 제공할 수 있습니다.

효과적인 다국어 처리를 위해서는 초기 단계부터 국제화를 고려한 설계가 중요하며, 번역 키의 체계적인 관리, 복수형 처리, 문맥 제공 등의 모범 사례를 따라야 합니다.

다음 장에서는 Flutter 앱의 성능을 최적화하는 방법에 대해 알아보겠습니다.

# 성능 최적화

Flutter 앱의 성능은 사용자 경험에 직접적인 영향을 미치는 중요한 요소입니다. 앱이 부드럽게 작동하고, 반응이 빠르며, 자원을 효율적으로 사용할 때 사용자 만족도가 높아집니다. 이 장에서는 Flutter 앱의 성능을 최적화하기 위한 다양한 전략과 기법을 살펴보겠습니다.

## 성능 최적화의 원칙

[Section titled “성능 최적화의 원칙”](#성능-최적화의-원칙)

Flutter 앱 성능 최적화의 기본 원칙은 다음과 같습니다:

1. **계측 먼저, 최적화는 나중에**: 추측이 아닌 측정된 데이터를 기반으로 최적화를 진행합니다.
2. **단순함 유지**: 복잡한 위젯 트리는 성능 문제를 일으킬 수 있습니다.
3. **유지보수성과 균형**: 성능을 위해 코드 가독성과 유지보수성을 희생하지 않습니다.
4. **적절한 추상화 레벨 선택**: 상황에 맞는 수준의 추상화를 사용합니다.

## 성능 측정 도구

[Section titled “성능 측정 도구”](#성능-측정-도구)

최적화 작업을 시작하기 전에 앱의 성능을 측정하고 병목 현상을 파악해야 합니다.

### 1. Flutter DevTools

[Section titled “1. Flutter DevTools”](#1-flutter-devtools)

Flutter DevTools는 앱 성능 분석을 위한 강력한 도구입니다.

```bash
1
# DevTools 실행
2
flutter pub global activate devtools
3
flutter pub global run devtools
```

주요 기능:

* **Flutter Inspector**: 위젯 트리 검사
* **Timeline**: 프레임 렌더링 시간 분석
* **CPU Profiler**: 메서드 실행 시간 분석
* **Memory**: 메모리 사용량 모니터링
* **Performance**: 프레임 레이트 및 UI/GPU 스레드 분석

### 2. 성능 오버레이

[Section titled “2. 성능 오버레이”](#2-성능-오버레이)

개발 중에 실시간으로 성능을 모니터링하려면 성능 오버레이를 사용합니다:

```dart
1
import 'package:flutter/rendering.dart';
2


3
void main() {
4
  // 성능 오버레이 활성화
5
  debugPaintSizeEnabled = false;       // 크기 시각화
6
  debugPaintBaselinesEnabled = false;  // 텍스트 기준선 시각화
7
  debugPaintPointersEnabled = false;   // 포인터 이벤트 시각화
8
  debugPaintLayerBordersEnabled = false; // 레이어 경계 시각화
9
  debugRepaintRainbowEnabled = false;  // 리페인트 영역 시각화
10


11
  // 성능 오버레이 표시
12
  WidgetsApp.showPerformanceOverlay = true;
13


14
  runApp(const MyApp());
15
}
```

### 3. 프로파일 모드에서 실행

[Section titled “3. 프로파일 모드에서 실행”](#3-프로파일-모드에서-실행)

프로파일 모드는 디버그 오버헤드 없이 성능을 측정할 수 있게 해줍니다:

```bash
1
# 프로파일 모드로 앱 실행
2
flutter run --profile
```

## 빌드 최적화 전략

[Section titled “빌드 최적화 전략”](#빌드-최적화-전략)

### 1. const 위젯 사용

[Section titled “1. const 위젯 사용”](#1-const-위젯-사용)

상태가 변하지 않는 위젯에는 `const` 생성자를 사용하여 재빌드 비용을 줄입니다:

```dart
1
// 좋지 않은 예
2
Widget build(BuildContext context) {
3
  return Container(
4
    padding: EdgeInsets.all(8.0),
5
    color: Colors.blue,
6
    child: Text('Hello'),
7
  );
8
}
9


10
// 좋은 예
11
Widget build(BuildContext context) {
12
  return const Container(
13
    padding: EdgeInsets.all(8.0),
14
    color: Colors.blue,
15
    child: Text('Hello'),
16
  );
17
}
```

### 2. StatefulWidget 대신 StatelessWidget 사용

[Section titled “2. StatefulWidget 대신 StatelessWidget 사용”](#2-statefulwidget-대신-statelesswidget-사용)

가능한 경우 `StatefulWidget` 대신 `StatelessWidget`을 사용합니다:

```dart
1
// 상태가 필요하지 않은 경우 StatelessWidget 사용
2
class MyWidget extends StatelessWidget {
3
  final String text;
4


5
  const MyWidget({Key? key, required this.text}) : super(key: key);
6


7
  @override
8
  Widget build(BuildContext context) {
9
    return Text(text);
10
  }
11
}
```

### 3. Riverpod과 같은 상태 관리 라이브러리 활용

[Section titled “3. Riverpod과 같은 상태 관리 라이브러리 활용”](#3-riverpod과-같은-상태-관리-라이브러리-활용)

Riverpod은 효율적인 상태 관리와 UI 업데이트를 제공합니다:

```dart
1
// Riverpod을 사용한 상태 관리
2
@riverpod
3
class Counter extends _$Counter {
4
  @override
5
  int build() => 0;
6


7
  void increment() => state++;
8
}
9


10
// UI에서 사용
11
class CounterWidget extends ConsumerWidget {
12
  const CounterWidget({Key? key}) : super(key: key);
13


14
  @override
15
  Widget build(BuildContext context, WidgetRef ref) {
16
    final count = ref.watch(counterProvider);
17


18
    return Text('Count: $count');
19
  }
20
}
```

### 4. 빌드 메서드 최적화

[Section titled “4. 빌드 메서드 최적화”](#4-빌드-메서드-최적화)

빌드 메서드를 작게 유지하고 중첩된 함수를 피합니다:

```dart
1
// 좋지 않은 예: 거대한 빌드 메서드
2
@override
3
Widget build(BuildContext context) {
4
  return Scaffold(
5
    appBar: AppBar(title: Text('My App')),
6
    body: ListView(
7
      children: [
8
        // 수십 개의 위젯...
9
      ],
10
    ),
11
  );
12
}
13


14
// 좋은 예: 위젯으로 분리
15
@override
16
Widget build(BuildContext context) {
17
  return Scaffold(
18
    appBar: AppBar(title: const Text('My App')),
19
    body: const MyListView(),
20
  );
21
}
22


23
// 별도의 위젯으로 분리
24
class MyListView extends StatelessWidget {
25
  const MyListView({Key? key}) : super(key: key);
26


27
  @override
28
  Widget build(BuildContext context) {
29
    return ListView(
30
      children: [
31
        // 위젯들...
32
      ],
33
    );
34
  }
35
}
```

## 렌더링 최적화

[Section titled “렌더링 최적화”](#렌더링-최적화)

### 1. RepaintBoundary 사용

[Section titled “1. RepaintBoundary 사용”](#1-repaintboundary-사용)

자주 변경되는 위젯을 `RepaintBoundary`로 감싸 다시 그리는 영역을 제한합니다:

```dart
1
class MyWidget extends StatelessWidget {
2
  const MyWidget({Key? key}) : super(key: key);
3


4
  @override
5
  Widget build(BuildContext context) {
6
    return Stack(
7
      children: [
8
        // 정적 배경
9
        const BackgroundWidget(),
10


11
        // 자주 업데이트되는 위젯은 RepaintBoundary로 감싸기
12
        RepaintBoundary(
13
          child: AnimatedWidget(),
14
        ),
15
      ],
16
    );
17
  }
18
}
```

### 2. 이미지 캐싱

[Section titled “2. 이미지 캐싱”](#2-이미지-캐싱)

이미지를 효율적으로 로드하고 캐싱하려면 `cached_network_image` 패키지를 사용합니다:

```dart
1
import 'package:cached_network_image/cached_network_image.dart';
2


3
CachedNetworkImage(
4
  imageUrl: 'https://example.com/image.jpg',
5
  placeholder: (context, url) => const CircularProgressIndicator(),
6
  errorWidget: (context, url, error) => const Icon(Icons.error),
7
)
```

### 3. BuildContext 확장으로 MediaQuery 최적화

[Section titled “3. BuildContext 확장으로 MediaQuery 최적화”](#3-buildcontext-확장으로-mediaquery-최적화)

`MediaQuery.of(context)`를 반복 호출하는 대신 확장 함수를 사용합니다:

```dart
1
extension BuildContextExtensions on BuildContext {
2
  MediaQueryData get mediaQuery => MediaQuery.of(this);
3
  Size get screenSize => mediaQuery.size;
4
  double get screenWidth => screenSize.width;
5
  double get screenHeight => screenSize.height;
6
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
7
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
8
}
9


10
// 사용 예시
11
Widget build(BuildContext context) {
12
  final width = context.screenWidth;
13
  return SizedBox(width: width * 0.8);
14
}
```

### 4. 리스트 최적화

[Section titled “4. 리스트 최적화”](#4-리스트-최적화)

긴 리스트를 렌더링할 때는 `ListView.builder`를 사용합니다:

```dart
1
ListView.builder(
2
  itemCount: items.length,
3
  itemBuilder: (context, index) {
4
    return ListTile(
5
      title: Text(items[index].title),
6
    );
7
  },
8
)
```

매우 긴 리스트에는 `ListView.builder` 대신 `ListView.separated`를 사용하여 분리선을 효율적으로 추가할 수 있습니다:

```dart
1
ListView.separated(
2
  itemCount: items.length,
3
  separatorBuilder: (context, index) => const Divider(),
4
  itemBuilder: (context, index) {
5
    return ListTile(
6
      title: Text(items[index].title),
7
    );
8
  },
9
)
```

### 5. const 생성자 사용

[Section titled “5. const 생성자 사용”](#5-const-생성자-사용)

가능한 한 많은 위젯에 `const` 생성자를 사용하세요:

```dart
1
// 바람직하지 않은 예
2
Widget build(BuildContext context) {
3
  return Padding(
4
    padding: EdgeInsets.all(8.0),
5
    child: Icon(Icons.star),
6
  );
7
}
8


9
// 바람직한 예
10
Widget build(BuildContext context) {
11
  return const Padding(
12
    padding: EdgeInsets.all(8.0),
13
    child: Icon(Icons.star),
14
  );
15
}
```

## 메모리 최적화

[Section titled “메모리 최적화”](#메모리-최적화)

### 1. 대형 객체 캐싱

[Section titled “1. 대형 객체 캐싱”](#1-대형-객체-캐싱)

자주 사용되는 대형 객체는 캐싱하여 재사용합니다:

```dart
1
class ImageCache {
2
  static final Map<String, Image> _cache = {};
3


4
  static Image getImage(String url) {
5
    if (_cache.containsKey(url)) {
6
      return _cache[url]!;
7
    }
8


9
    final image = Image.network(url);
10
    _cache[url] = image;
11
    return image;
12
  }
13


14
  static void clearCache() {
15
    _cache.clear();
16
  }
17
}
```

### 2. 해제 패턴

[Section titled “2. 해제 패턴”](#2-해제-패턴)

`StatefulWidget`에서 리소스를 적절히 해제합니다:

```dart
1
class MyWidget extends StatefulWidget {
2
  const MyWidget({Key? key}) : super(key: key);
3


4
  @override
5
  _MyWidgetState createState() => _MyWidgetState();
6
}
7


8
class _MyWidgetState extends State<MyWidget> {
9
  late AnimationController _controller;
10
  late StreamSubscription _subscription;
11


12
  @override
13
  void initState() {
14
    super.initState();
15
    _controller = AnimationController(vsync: this);
16
    _subscription = someStream.listen((_) {});
17
  }
18


19
  @override
20
  void dispose() {
21
    // 리소스 해제
22
    _controller.dispose();
23
    _subscription.cancel();
24
    super.dispose();
25
  }
26


27
  @override
28
  Widget build(BuildContext context) {
29
    return Container();
30
  }
31
}
```

### 3. 이미지 크기 최적화

[Section titled “3. 이미지 크기 최적화”](#3-이미지-크기-최적화)

네트워크 이미지를 로드할 때 적절한 크기로 리사이징합니다:

```dart
1
Image.network(
2
  'https://example.com/large_image.jpg?width=300&height=200',
3
  width: 300,
4
  height: 200,
5
  fit: BoxFit.cover,
6
)
```

## 비동기 작업 최적화

[Section titled “비동기 작업 최적화”](#비동기-작업-최적화)

### 1. Future와 FutureBuilder 사용

[Section titled “1. Future와 FutureBuilder 사용”](#1-future와-futurebuilder-사용)

비동기 데이터 로딩은 `FutureBuilder`를 사용합니다:

```dart
1
FutureBuilder<List<Item>>(
2
  future: _fetchItems(),
3
  builder: (context, snapshot) {
4
    if (snapshot.connectionState == ConnectionState.waiting) {
5
      return const CircularProgressIndicator();
6
    } else if (snapshot.hasError) {
7
      return Text('Error: ${snapshot.error}');
8
    } else if (snapshot.hasData) {
9
      final items = snapshot.data!;
10
      return ListView.builder(
11
        itemCount: items.length,
12
        itemBuilder: (context, index) => ItemWidget(item: items[index]),
13
      );
14
    } else {
15
      return const Text('No data');
16
    }
17
  },
18
)
```

### 2. 컴퓨팅 집약적 작업 격리

[Section titled “2. 컴퓨팅 집약적 작업 격리”](#2-컴퓨팅-집약적-작업-격리)

무거운 연산은 별도의 isolate에서 실행합니다:

```dart
1
import 'dart:isolate';
2


3
Future<List<int>> computeFactorials(List<int> numbers) async {
4
  final receivePort = ReceivePort();
5


6
  await Isolate.spawn(_factorialIsolate, {
7
    'sendPort': receivePort.sendPort,
8
    'numbers': numbers,
9
  });
10


11
  return await receivePort.first as List<int>;
12
}
13


14
void _factorialIsolate(Map<String, dynamic> data) {
15
  final SendPort sendPort = data['sendPort'];
16
  final List<int> numbers = data['numbers'];
17


18
  final results = numbers.map(_factorial).toList();
19


20
  Isolate.exit(sendPort, results);
21
}
22


23
int _factorial(int n) {
24
  int result = 1;
25
  for (int i = 2; i <= n; i++) {
26
    result *= i;
27
  }
28
  return result;
29
}
30


31
// 사용 예시
32
final results = await computeFactorials([5, 10, 15]);
```

더 간단한 방법은 Flutter의 `compute` 함수를 사용하는 것입니다:

```dart
1
import 'package:flutter/foundation.dart';
2


3
Future<int> calculateFactorial(int n) async {
4
  return compute(_factorial, n);
5
}
6


7
int _factorial(int n) {
8
  int result = 1;
9
  for (int i = 2; i <= n; i++) {
10
    result *= i;
11
  }
12
  return result;
13
}
```

## 네트워크 최적화

[Section titled “네트워크 최적화”](#네트워크-최적화)

### 1. 요청 캐싱

[Section titled “1. 요청 캐싱”](#1-요청-캐싱)

네트워크 요청 결과를 캐싱하여 중복 요청을 방지합니다:

```dart
1
class ApiCache {
2
  static final Map<String, dynamic> _cache = {};
3
  static final Map<String, DateTime> _timestamps = {};
4
  static const Duration _maxAge = Duration(minutes: 10);
5


6
  static Future<T> get<T>(
7
    String url,
8
    Future<T> Function() fetchFunction,
9
  ) async {
10
    final now = DateTime.now();
11


12
    // 캐시된 데이터가 있고 유효기간 내인지 확인
13
    if (_cache.containsKey(url) && _timestamps.containsKey(url)) {
14
      final timestamp = _timestamps[url]!;
15
      if (now.difference(timestamp) < _maxAge) {
16
        return _cache[url] as T;
17
      }
18
    }
19


20
    // 데이터 가져오기
21
    final result = await fetchFunction();
22


23
    // 캐시에 저장
24
    _cache[url] = result;
25
    _timestamps[url] = now;
26


27
    return result;
28
  }
29


30
  static void clear() {
31
    _cache.clear();
32
    _timestamps.clear();
33
  }
34
}
35


36
// 사용 예시
37
final data = await ApiCache.get(
38
  'https://api.example.com/data',
39
  () => dio.get('https://api.example.com/data'),
40
);
```

### 2. 지연 로딩 및 페이징

[Section titled “2. 지연 로딩 및 페이징”](#2-지연-로딩-및-페이징)

대량의 데이터를 한 번에 로드하지 않고 페이징 처리합니다:

```dart
1
class PaginatedListView extends StatefulWidget {
2
  const PaginatedListView({Key? key}) : super(key: key);
3


4
  @override
5
  _PaginatedListViewState createState() => _PaginatedListViewState();
6
}
7


8
class _PaginatedListViewState extends State<PaginatedListView> {
9
  final List<Item> _items = [];
10
  int _page = 1;
11
  bool _isLoading = false;
12
  bool _hasMore = true;
13
  final int _pageSize = 20;
14
  final ScrollController _scrollController = ScrollController();
15


16
  @override
17
  void initState() {
18
    super.initState();
19
    _loadMore();
20


21
    _scrollController.addListener(() {
22
      if (_scrollController.position.pixels >=
23
          _scrollController.position.maxScrollExtent * 0.8) {
24
        if (!_isLoading && _hasMore) {
25
          _loadMore();
26
        }
27
      }
28
    });
29
  }
30


31
  Future<void> _loadMore() async {
32
    if (_isLoading) return;
33


34
    setState(() {
35
      _isLoading = true;
36
    });
37


38
    try {
39
      final newItems = await fetchItems(_page, _pageSize);
40


41
      setState(() {
42
        _page++;
43
        _items.addAll(newItems);
44
        _isLoading = false;
45
        _hasMore = newItems.length == _pageSize;
46
      });
47
    } catch (e) {
48
      setState(() {
49
        _isLoading = false;
50
      });
51
    }
52
  }
53


54
  @override
55
  void dispose() {
56
    _scrollController.dispose();
57
    super.dispose();
58
  }
59


60
  @override
61
  Widget build(BuildContext context) {
62
    return ListView.builder(
63
      controller: _scrollController,
64
      itemCount: _items.length + (_hasMore ? 1 : 0),
65
      itemBuilder: (context, index) {
66
        if (index < _items.length) {
67
          return ItemWidget(item: _items[index]);
68
        } else {
69
          return const Center(child: CircularProgressIndicator());
70
        }
71
      },
72
    );
73
  }
74
}
```

## 앱 시작 시간 최적화

[Section titled “앱 시작 시간 최적화”](#앱-시작-시간-최적화)

### 1. 지연 초기화

[Section titled “1. 지연 초기화”](#1-지연-초기화)

앱 시작 시 모든 리소스를 로드하지 않고 필요할 때 초기화합니다:

```dart
1
class MyApp extends StatelessWidget {
2
  const MyApp({Key? key}) : super(key: key);
3


4
  @override
5
  Widget build(BuildContext context) {
6
    return MaterialApp(
7
      home: const HomePage(),
8
      onGenerateRoute: (settings) {
9
        // 라우트가 처음 요청될 때만 초기화
10
        if (settings.name == '/heavy_page') {
11
          return MaterialPageRoute(
12
            builder: (context) => const HeavyResourcePage(),
13
          );
14
        }
15
        return null;
16
      },
17
    );
18
  }
19
}
```

### 2. 유지 상태 최소화

[Section titled “2. 유지 상태 최소화”](#2-유지-상태-최소화)

`main.dart`에서 무거운 상태를 초기화하지 않습니다:

```dart
1
// 지양할 방법
2
void main() {
3
  // 무거운 초기화
4
  final complexData = loadComplexData();
5
  runApp(MyApp(data: complexData));
6
}
7


8
// 권장 방법
9
void main() {
10
  runApp(const MyApp());
11
}
12


13
class MyApp extends StatelessWidget {
14
  const MyApp({Key? key}) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    return MaterialApp(
19
      home: FutureBuilder<ComplexData>(
20
        future: loadComplexData(), // 비동기적으로 데이터 로드
21
        builder: (context, snapshot) {
22
          if (snapshot.connectionState == ConnectionState.waiting) {
23
            return const SplashScreen();
24
          }
25
          return HomePage(data: snapshot.data);
26
        },
27
      ),
28
    );
29
  }
30
}
```

## Flutter 웹 최적화

[Section titled “Flutter 웹 최적화”](#flutter-웹-최적화)

### 1. 초기 로드 최적화

[Section titled “1. 초기 로드 최적화”](#1-초기-로드-최적화)

Flutter 웹 앱의 초기 로드 시간을 개선합니다:

```dart
1
// index.html에 스플래시 스크린 추가
2
<div id="splash">
3
  <style>
4
    #splash {
5
      position: fixed;
6
      width: 100%;
7
      height: 100%;
8
      background-color: #ffffff;
9
      display: flex;
10
      justify-content: center;
11
      align-items: center;
12
    }
13
    .loader {
14
      width: 48px;
15
      height: 48px;
16
      border: 5px solid #3498db;
17
      border-radius: 50%;
18
      border-top-color: transparent;
19
      animation: spin 1s linear infinite;
20
    }
21
    @keyframes spin {
22
      to { transform: rotate(360deg); }
23
    }
24
  </style>
25
  <div class="loader"></div>
26
</div>
```

### 2. 코드 분할

[Section titled “2. 코드 분할”](#2-코드-분할)

대규모 웹 앱의 경우 코드 분할을 통해 초기 로드 크기를 줄입니다:

```dart
1
// 지연 로드 라이브러리
2
@JS('loadLibrary')
3
external Future<void> loadMyLibrary();
4


5
// 필요할 때 라이브러리 로드
6
ElevatedButton(
7
  onPressed: () async {
8
    await loadMyLibrary();
9
    Navigator.of(context).push(
10
      MaterialPageRoute(builder: (_) => const HeavyFeaturePage()),
11
    );
12
  },
13
  child: const Text('Load Feature'),
14
)
```

## 특정 상황에 대한 최적화

[Section titled “특정 상황에 대한 최적화”](#특정-상황에-대한-최적화)

### 1. 텍스트 렌더링 최적화

[Section titled “1. 텍스트 렌더링 최적화”](#1-텍스트-렌더링-최적화)

텍스트가 많은 앱에서는 텍스트 렌더링을 최적화합니다:

```dart
1
// 정적 텍스트에 const 사용
2
const Text('Static text that never changes')
3


4
// 긴 텍스트는 RichText로 분할
5
RichText(
6
  text: TextSpan(
7
    style: DefaultTextStyle.of(context).style,
8
    children: <TextSpan>[
9
      const TextSpan(text: 'First part of text. '),
10
      TextSpan(
11
        text: 'Important part. ',
12
        style: const TextStyle(fontWeight: FontWeight.bold),
13
      ),
14
      const TextSpan(text: 'Last part of text.'),
15
    ],
16
  ),
17
)
```

### 2. 애니메이션 최적화

[Section titled “2. 애니메이션 최적화”](#2-애니메이션-최적화)

애니메이션 성능을 향상시킵니다:

```dart
1
// 단순한 애니메이션에는 암시적 애니메이션 사용
2
AnimatedContainer(
3
  duration: const Duration(milliseconds: 300),
4
  curve: Curves.easeInOut,
5
  width: _expanded ? 200 : 100,
6
  height: _expanded ? 200 : 100,
7
  color: _expanded ? Colors.blue : Colors.red,
8
)
9


10
// 복잡한 애니메이션은 Tween 사용
11
TweenAnimationBuilder<double>(
12
  tween: Tween<double>(begin: 0, end: _progress),
13
  duration: const Duration(milliseconds: 500),
14
  builder: (context, value, child) {
15
    return CircularProgressIndicator(value: value);
16
  },
17
)
```

## Flutter 프로파일링 및 디버깅

[Section titled “Flutter 프로파일링 및 디버깅”](#flutter-프로파일링-및-디버깅)

### 1. Flutter Performance 프로파일링

[Section titled “1. Flutter Performance 프로파일링”](#1-flutter-performance-프로파일링)

앱 성능을 분석하려면 다음 단계를 따릅니다:

1. 프로파일 모드에서 앱 실행: `flutter run --profile`
2. DevTools 연결
3. Performance 탭에서 타임라인 레코딩
4. 병목 현상 분석

### 2. Flutter Doctor

[Section titled “2. Flutter Doctor”](#2-flutter-doctor)

잠재적인 개발 환경 문제를 확인합니다:

```bash
1
flutter doctor -v
```

### 3. 메모리 누수 감지

[Section titled “3. 메모리 누수 감지”](#3-메모리-누수-감지)

메모리 누수를 찾기 위해 DevTools의 Memory 탭을 사용합니다:

1. Memory 탭 열기
2. 앱 실행 중에 스냅샷 수집
3. 여러 작업 후 두 번째 스냅샷 수집
4. 스냅샷 비교하여 누수 식별

## Flutter 성능 체크리스트

[Section titled “Flutter 성능 체크리스트”](#flutter-성능-체크리스트)

효율적인 앱 개발을 위한 체크리스트:

### 1. 빌드 최적화

[Section titled “1. 빌드 최적화”](#1-빌드-최적화)

* [ ] 가능한 한 모든 위젯에 `const` 생성자 사용
* [ ] 큰 위젯 트리를 작은 위젯으로 분할
* [ ] 긴 리스트에 `ListView.builder` 사용
* [ ] 가능한 경우 `StatelessWidget` 사용

### 2. 렌더링 최적화

[Section titled “2. 렌더링 최적화”](#2-렌더링-최적화)

* [ ] 자주 변경되는 위젯에 `RepaintBoundary` 사용
* [ ] 이미지에 `cached_network_image` 사용
* [ ] 오프스크린 렌더링 방지 (큰 페이지에 `ListView` 대신 `ListView.builder` 사용)
* [ ] 복잡한 그래픽에 `CustomPainter` 대신 사전 렌더링된 이미지 사용

### 3. 메모리 관리

[Section titled “3. 메모리 관리”](#3-메모리-관리)

* [ ] 리소스 제대로 해제 (`dispose` 메서드 구현)
* [ ] 이미지 크기 최적화
* [ ] 대용량 데이터 로드에 페이징 적용
* [ ] 앱 수명 주기에 적절히 대응하여 리소스 관리

### 4. 상태 관리

[Section titled “4. 상태 관리”](#4-상태-관리)

* [ ] 효율적인 상태 관리 라이브러리 사용 (Riverpod 등)
* [ ] 불필요한 상태 리빌드 방지
* [ ] 중첩된 Provider 최소화

### 5. 네트워크 요청

[Section titled “5. 네트워크 요청”](#5-네트워크-요청)

* [ ] 요청 캐싱 구현
* [ ] 이미지 및 데이터 사전 로드
* [ ] 대량 데이터에 페이징 적용
* [ ] 오프라인 기능 지원

## 결론

[Section titled “결론”](#결론)

Flutter 앱의 성능을 최적화하는 것은 지속적인 과정입니다. 초기 단계부터 성능을 고려하고, 정기적으로 성능을 측정하며, 사용자 경험을 저하시키는 병목 현상을 해결해야 합니다.

최적화 작업을 시작하기 전에 항상 측정을 통해 실제 성능 문제를 식별하고, 코드 복잡성과 성능 사이에서 균형을 유지하는 것이 중요합니다. Flutter DevTools와 프로파일링 기능을 활용하여 앱의 성능을 정기적으로 모니터링하고 개선하세요.

다음 장에서는 Flutter 앱 개발에 유용한 추천 패키지들에 대해 알아보겠습니다.

# 추천 패키지 모음

Flutter 앱을 개발할 때 모든 기능을 직접 구현할 필요는 없습니다. 커뮤니티가 개발하고 유지 관리하는 수많은 패키지를 활용하면 개발 시간을 단축하고 코드 품질을 향상시킬 수 있습니다. 이 장에서는 Flutter 앱 개발에 유용한 추천 패키지들을 카테고리별로 소개합니다.

## 패키지 선택 기준

[Section titled “패키지 선택 기준”](#패키지-선택-기준)

패키지를 선택할 때는 다음 사항을 고려하세요:

1. **활성 유지보수**: 최근 업데이트 날짜와 이슈 해결 속도 확인
2. **문서화 품질**: 좋은 README와 사용 예제
3. **인기도와 채택률**: ‘likes’ 및 ‘popularity’ 점수
4. **종속성**: 최소한의 종속성을 가진 패키지 선호
5. **안정성**: 정식 출시 버전(non-prerelease) 선호
6. **라이선스**: 프로젝트에 호환되는 라이선스인지 확인

## 상태 관리

[Section titled “상태 관리”](#상태-관리)

### 1. Riverpod

[Section titled “1. Riverpod”](#1-riverpod)

[riverpod](https://pub.dev/packages/flutter_riverpod) - 효율적이고 유연한 상태 관리

Riverpod는 Provider 패턴의 진화 버전으로, 타입 안전성과 코드 구성을 개선했습니다.

```dart
1
// 기본 Riverpod 사용법
2
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
3
  return Counter();
4
});
5


6
class Counter extends StateNotifier<int> {
7
  Counter() : super(0);
8


9
  void increment() => state++;
10
}
11


12
// 코드에서 사용
13
class CounterWidget extends ConsumerWidget {
14
  @override
15
  Widget build(BuildContext context, WidgetRef ref) {
16
    final count = ref.watch(counterProvider);
17


18
    return Text('카운트: $count');
19
  }
20
}
```

Riverpod 2.0 이상에서는 코드 생성을 활용한 더 간결한 문법을 제공합니다:

```dart
1
@riverpod
2
class Counter extends _$Counter {
3
  @override
4
  int build() => 0;
5


6
  void increment() => state++;
7
}
```

### 2. Bloc/Cubit

[Section titled “2. Bloc/Cubit”](#2-bloccubit)

[flutter\_bloc](https://pub.dev/packages/flutter_bloc) - 예측 가능한 상태 관리

블록 패턴을 사용하면 UI와 비즈니스 로직을 명확히 분리할 수 있습니다.

```dart
1
// 상태 정의
2
abstract class CounterState {}
3
class CounterInitial extends CounterState {}
4
class CounterValue extends CounterState {
5
  final int value;
6
  CounterValue(this.value);
7
}
8


9
// Cubit 정의
10
class CounterCubit extends Cubit<CounterState> {
11
  CounterCubit() : super(CounterValue(0));
12


13
  void increment() {
14
    final currentState = state;
15
    if (currentState is CounterValue) {
16
      emit(CounterValue(currentState.value + 1));
17
    }
18
  }
19
}
20


21
// UI에서 사용
22
BlocProvider(
23
  create: (context) => CounterCubit(),
24
  child: BlocBuilder<CounterCubit, CounterState>(
25
    builder: (context, state) {
26
      if (state is CounterValue) {
27
        return Text('카운트: ${state.value}');
28
      }
29
      return const Text('로딩 중...');
30
    },
31
  ),
32
)
```

## 네트워크 및 API

[Section titled “네트워크 및 API”](#네트워크-및-api)

### 1. Dio

[Section titled “1. Dio”](#1-dio)

[dio](https://pub.dev/packages/dio) - 강력한 HTTP 클라이언트

Dio는 인터셉터, 폼 데이터, 취소 및 시간 초과 기능을 갖춘 HTTP 클라이언트입니다.

```dart
1
final dio = Dio();
2


3
// GET 요청
4
Future<User> getUser(int id) async {
5
  final response = await dio.get('https://api.example.com/users/$id');
6
  return User.fromJson(response.data);
7
}
8


9
// POST 요청
10
Future<Response> createUser(User user) async {
11
  return await dio.post(
12
    'https://api.example.com/users',
13
    data: user.toJson(),
14
    options: Options(headers: {'Authorization': 'Bearer $token'}),
15
  );
16
}
17


18
// 인터셉터 설정
19
dio.interceptors.add(LogInterceptor(responseBody: true));
```

### 2. Retrofit

[Section titled “2. Retrofit”](#2-retrofit)

[retrofit](https://pub.dev/packages/retrofit) - 타입 안전한 REST 클라이언트

Dio와 함께 사용하여 타입 안전한 API 클라이언트를 생성합니다.

```dart
1
@RestApi(baseUrl: "https://api.example.com")
2
abstract class RestClient {
3
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
4


5
  @GET("/users/{id}")
6
  Future<User> getUser(@Path("id") int id);
7


8
  @POST("/users")
9
  Future<User> createUser(@Body() User user);
10
}
11


12
// 사용 방법
13
final dio = Dio();
14
final client = RestClient(dio);
15
final user = await client.getUser(1);
```

### 3. GraphQL

[Section titled “3. GraphQL”](#3-graphql)

[graphql\_flutter](https://pub.dev/packages/graphql_flutter) - GraphQL 클라이언트

GraphQL API와 통신하기 위한 클라이언트입니다.

```dart
1
// 클라이언트 설정
2
final HttpLink httpLink = HttpLink('https://api.example.com/graphql');
3
final AuthLink authLink = AuthLink(
4
  getToken: () async => 'Bearer $token',
5
);
6
final Link link = authLink.concat(httpLink);
7


8
final GraphQLClient client = GraphQLClient(
9
  cache: GraphQLCache(),
10
  link: link,
11
);
12


13
// 쿼리 실행
14
const String readRepositories = r'''
15
  query ReadRepositories($nRepositories: Int!) {
16
    viewer {
17
      repositories(last: $nRepositories) {
18
        nodes {
19
          id
20
          name
21
          viewerHasStarred
22
        }
23
      }
24
    }
25
  }
26
''';
27


28
final QueryOptions options = QueryOptions(
29
  document: gql(readRepositories),
30
  variables: {'nRepositories': 50},
31
);
32


33
final QueryResult result = await client.query(options);
```

## 로컬 데이터 저장

[Section titled “로컬 데이터 저장”](#로컬-데이터-저장)

### 1. Hive

[Section titled “1. Hive”](#1-hive)

[hive](https://pub.dev/packages/hive) - 경량 NoSQL 데이터베이스

Hive는 빠른 키-값 데이터베이스로, 간단한 데이터 저장에 적합합니다.

```dart
1
// 모델 정의
2
@HiveType(typeId: 0)
3
class Person extends HiveObject {
4
  @HiveField(0)
5
  late String name;
6


7
  @HiveField(1)
8
  late int age;
9
}
10


11
// 초기화
12
await Hive.initFlutter();
13
Hive.registerAdapter(PersonAdapter());
14
final box = await Hive.openBox<Person>('people');
15


16
// 데이터 저장 및 검색
17
final person = Person()
18
  ..name = '홍길동'
19
  ..age = 30;
20
await box.put('person_1', person);
21


22
final retrievedPerson = box.get('person_1');
```

### 2. Shared Preferences

[Section titled “2. Shared Preferences”](#2-shared-preferences)

[shared\_preferences](https://pub.dev/packages/shared_preferences) - 간단한 키-값 저장소

작은 데이터를 저장하는 데 사용하는 간단한 키-값 저장소입니다.

```dart
1
// 데이터 저장
2
final prefs = await SharedPreferences.getInstance();
3
await prefs.setString('name', '홍길동');
4
await prefs.setInt('age', 30);
5
await prefs.setBool('isLoggedIn', true);
6


7
// 데이터 검색
8
final name = prefs.getString('name') ?? '이름 없음';
9
final age = prefs.getInt('age') ?? 0;
10
final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
11


12
// 데이터 삭제
13
await prefs.remove('name');
```

### 3. SQLite (via Drift)

[Section titled “3. SQLite (via Drift)”](#3-sqlite-via-drift)

[drift](https://pub.dev/packages/drift) - 타입 안전한 SQLite ORM

Drift(이전의 Moor)는 Flutter용 타입 안전한 SQL 도구입니다.

```dart
1
// 테이블 정의
2
class TodoItems extends Table {
3
  IntColumn get id => integer().autoIncrement()();
4
  TextColumn get title => text().withLength(min: 1, max: 50)();
5
  TextColumn get content => text().nullable()();
6
  DateTimeColumn get createdAt => dateTime().nullable()();
7
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
8
}
9


10
// 데이터베이스 정의
11
@DriftDatabase(tables: [TodoItems])
12
class AppDatabase extends _$AppDatabase {
13
  AppDatabase(QueryExecutor e) : super(e);
14


15
  @override
16
  int get schemaVersion => 1;
17


18
  // 모든 할 일 얻기
19
  Future<List<TodoItem>> getAllTodos() => select(todoItems).get();
20


21
  // 할 일 추가
22
  Future<int> addTodo(TodoItemsCompanion todo) => into(todoItems).insert(todo);
23


24
  // 할 일 업데이트
25
  Future<bool> updateTodo(TodoItem todo) => update(todoItems).replace(todo);
26


27
  // 완료된 할 일 삭제
28
  Future<int> deleteCompleted() =>
29
    (delete(todoItems)..where((t) => t.completed)).go();
30
}
```

## UI 컴포넌트 및 스타일링

[Section titled “UI 컴포넌트 및 스타일링”](#ui-컴포넌트-및-스타일링)

### 1. Flex Color Scheme

[Section titled “1. Flex Color Scheme”](#1-flex-color-scheme)

[flex\_color\_scheme](https://pub.dev/packages/flex_color_scheme) - 테마 생성 및 관리

Material Design 기반의 테마를 쉽게 생성하고 관리할 수 있습니다.

```dart
1
import 'package:flex_color_scheme/flex_color_scheme.dart';
2


3
// 라이트 테마
4
final lightTheme = FlexThemeData.light(
5
  scheme: FlexScheme.mandyRed,
6
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
7
  blendLevel: 9,
8
  appBarOpacity: 0.95,
9
  subThemesData: const FlexSubThemesData(
10
    blendOnLevel: 10,
11
    blendOnColors: false,
12
    inputDecoratorRadius: 25.0,
13
  ),
14
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
15
  useMaterial3: true,
16
);
17


18
// 다크 테마
19
final darkTheme = FlexThemeData.dark(
20
  scheme: FlexScheme.mandyRed,
21
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
22
  blendLevel: 15,
23
  appBarOpacity: 0.90,
24
  subThemesData: const FlexSubThemesData(
25
    blendOnLevel: 20,
26
    inputDecoratorRadius: 25.0,
27
  ),
28
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
29
  useMaterial3: true,
30
);
31


32
// 앱에 적용
33
MaterialApp(
34
  theme: lightTheme,
35
  darkTheme: darkTheme,
36
  themeMode: ThemeMode.system,
37
  // ...
38
)
```

### 2. Flutter Screenutil

[Section titled “2. Flutter Screenutil”](#2-flutter-screenutil)

[flutter\_screenutil](https://pub.dev/packages/flutter_screenutil) - 반응형 UI 지원

다양한 화면 크기에 맞게 UI 요소의 크기를 조정합니다.

```dart
1
// 초기화 (디자인 파일 기준 크기)
2
void main() {
3
  runApp(const MyApp());
4
}
5


6
class MyApp extends StatelessWidget {
7
  const MyApp({Key? key}) : super(key: key);
8


9
  @override
10
  Widget build(BuildContext context) {
11
    return ScreenUtilInit(
12
      designSize: const Size(360, 690),
13
      minTextAdapt: true,
14
      splitScreenMode: true,
15
      builder: (context, child) {
16
        return MaterialApp(
17
          debugShowCheckedModeBanner: false,
18
          title: '반응형 UI',
19
          theme: ThemeData(
20
            primarySwatch: Colors.blue,
21
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
22
          ),
23
          home: child,
24
        );
25
      },
26
      child: const HomePage(),
27
    );
28
  }
29
}
30


31
// 사용 예시
32
Container(
33
  width: 100.w,   // 디자인 파일의 100px을 비율에 맞게 조정
34
  height: 50.h,   // 디자인 파일의 50px을 비율에 맞게 조정
35
  padding: EdgeInsets.all(10.r), // 반응형 패딩
36
  child: Text(
37
    '반응형 텍스트',
38
    style: TextStyle(fontSize: 14.sp), // 반응형 폰트 크기
39
  ),
40
)
```

### 3. Cached Network Image

[Section titled “3. Cached Network Image”](#3-cached-network-image)

[cached\_network\_image](https://pub.dev/packages/cached_network_image) - 이미지 캐싱

네트워크 이미지를 로드하고 캐싱합니다.

```dart
1
CachedNetworkImage(
2
  imageUrl: 'https://example.com/image.jpg',
3
  placeholder: (context, url) => const CircularProgressIndicator(),
4
  errorWidget: (context, url, error) => const Icon(Icons.error),
5
  fit: BoxFit.cover,
6
  width: 200,
7
  height: 200,
8
)
```

### 4. Infinite Scroll Pagination

[Section titled “4. Infinite Scroll Pagination”](#4-infinite-scroll-pagination)

[infinite\_scroll\_pagination](https://pub.dev/packages/infinite_scroll_pagination) - 페이징 처리

대량의 데이터를 페이징 처리하여 스크롤 목록에 표시합니다.

```dart
1
class PaginatedItemsScreen extends StatefulWidget {
2
  @override
3
  _PaginatedItemsScreenState createState() => _PaginatedItemsScreenState();
4
}
5


6
class _PaginatedItemsScreenState extends State<PaginatedItemsScreen> {
7
  static const _pageSize = 20;
8


9
  final PagingController<int, Item> _pagingController =
10
      PagingController(firstPageKey: 0);
11


12
  @override
13
  void initState() {
14
    _pagingController.addPageRequestListener((pageKey) {
15
      _fetchPage(pageKey);
16
    });
17
    super.initState();
18
  }
19


20
  Future<void> _fetchPage(int pageKey) async {
21
    try {
22
      final newItems = await fetchItems(pageKey, _pageSize);
23
      final isLastPage = newItems.length < _pageSize;
24


25
      if (isLastPage) {
26
        _pagingController.appendLastPage(newItems);
27
      } else {
28
        final nextPageKey = pageKey + newItems.length;
29
        _pagingController.appendPage(newItems, nextPageKey);
30
      }
31
    } catch (error) {
32
      _pagingController.error = error;
33
    }
34
  }
35


36
  @override
37
  Widget build(BuildContext context) {
38
    return PagedListView<int, Item>(
39
      pagingController: _pagingController,
40
      builderDelegate: PagedChildBuilderDelegate<Item>(
41
        itemBuilder: (context, item, index) => ItemWidget(item: item),
42
      ),
43
    );
44
  }
45


46
  @override
47
  void dispose() {
48
    _pagingController.dispose();
49
    super.dispose();
50
  }
51
}
```

## 네비게이션 및 라우팅

[Section titled “네비게이션 및 라우팅”](#네비게이션-및-라우팅)

### 1. Go Router

[Section titled “1. Go Router”](#1-go-router)

[go\_router](https://pub.dev/packages/go_router) - 선언적 라우팅

Go Router는 Flutter에서 선언적 라우팅을 구현합니다.

```dart
1
final router = GoRouter(
2
  routes: [
3
    GoRoute(
4
      path: '/',
5
      builder: (context, state) => const HomePage(),
6
    ),
7
    GoRoute(
8
      path: '/users',
9
      builder: (context, state) => const UsersPage(),
10
      routes: [
11
        GoRoute(
12
          path: ':id',
13
          builder: (context, state) {
14
            final id = state.params['id']!;
15
            return UserDetailsPage(id: id);
16
          },
17
        ),
18
      ],
19
    ),
20
    GoRoute(
21
      path: '/settings',
22
      builder: (context, state) => const SettingsPage(),
23
    ),
24
  ],
25
  errorBuilder: (context, state) => NotFoundPage(),
26
);
27


28
// MaterialApp에 라우터 설정
29
MaterialApp.router(
30
  routerConfig: router,
31
  title: 'Go Router 예제',
32
)
33


34
// 탐색
35
context.go('/users/123');
36
context.push('/settings');
```

### 2. Auto Route

[Section titled “2. Auto Route”](#2-auto-route)

[auto\_route](https://pub.dev/packages/auto_route) - 코드 생성 기반 라우팅

코드 생성을 활용한 타입 안전한 라우팅 솔루션입니다.

```dart
1
@MaterialAutoRouter(
2
  replaceInRouteName: 'Page,Route',
3
  routes: <AutoRoute>[
4
    AutoRoute(page: HomePage, initial: true),
5
    AutoRoute(page: UsersPage),
6
    AutoRoute(page: UserDetailsPage, path: '/users/:id'),
7
    AutoRoute(page: SettingsPage),
8
  ],
9
)
10
class $AppRouter {}
11


12
// AppRouter 인스턴스 생성
13
final appRouter = AppRouter();
14


15
// MaterialApp에 라우터 설정
16
MaterialApp.router(
17
  routerDelegate: appRouter.delegate(),
18
  routeInformationParser: appRouter.defaultRouteParser(),
19
)
20


21
// 타입 안전한 탐색
22
context.router.push(const UsersRoute());
23
context.router.push(UserDetailsRoute(id: '123'));
```

## 유틸리티 및 생산성

[Section titled “유틸리티 및 생산성”](#유틸리티-및-생산성)

### 1. Freezed

[Section titled “1. Freezed”](#1-freezed)

[freezed](https://pub.dev/packages/freezed) - 코드 생성 기반 불변 모델

불변 모델 클래스를 쉽게 생성할 수 있는 코드 생성 패키지입니다.

```dart
1
@freezed
2
class User with _$User {
3
  const factory User({
4
    required String id,
5
    required String name,
6
    required int age,
7
    String? email,
8
  }) = _User;
9


10
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
11
}
12


13
// 사용 예시
14
const user = User(id: '1', name: '홍길동', age: 30);
15


16
// 불변 복사
17
final updatedUser = user.copyWith(age: 31, email: 'hong@example.com');
```

### 2. Flutter Hooks

[Section titled “2. Flutter Hooks”](#2-flutter-hooks)

[flutter\_hooks](https://pub.dev/packages/flutter_hooks) - 함수형 위젯 구성

React Hooks에서 영감을 받은 패키지로, 상태 관리 및 수명 주기 로직을 재사용 가능하게 만듭니다.

```dart
1
class CounterWithHooks extends HookWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    // useState 훅을 사용하여 상태 생성
5
    final counter = useState(0);
6


7
    // useEffect 훅을 사용하여 부수 효과 처리
8
    useEffect(() {
9
      print('카운터: ${counter.value}');
10
      return () => print('정리: ${counter.value}');
11
    }, [counter.value]);
12


13
    // 사용자 정의 훅 사용
14
    final animation = useAnimationController(
15
      duration: const Duration(seconds: 1),
16
    );
17


18
    return Column(
19
      children: [
20
        Text('카운트: ${counter.value}'),
21
        ElevatedButton(
22
          onPressed: () => counter.value++,
23
          child: const Text('증가'),
24
        ),
25
      ],
26
    );
27
  }
28
}
```

### 3. GetIt

[Section titled “3. GetIt”](#3-getit)

[get\_it](https://pub.dev/packages/get_it) - 서비스 로케이터

간단한 서비스 로케이터 및 의존성 주입 컨테이너입니다.

```dart
1
// GetIt 인스턴스 생성
2
final getIt = GetIt.instance;
3


4
// 의존성 등록
5
void setupDependencies() {
6
  // 싱글톤 등록
7
  getIt.registerSingleton<ApiClient>(ApiClient());
8


9
  // 팩토리 등록
10
  getIt.registerFactory<UserRepository>(() => UserRepository(getIt<ApiClient>()));
11


12
  // 지연 싱글톤 등록
13
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<ApiClient>()));
14
}
15


16
// 의존성 사용
17
final userRepository = getIt<UserRepository>();
18
final apiClient = getIt<ApiClient>();
```

## 이미지 및 미디어

[Section titled “이미지 및 미디어”](#이미지-및-미디어)

### 1. Photo View

[Section titled “1. Photo View”](#1-photo-view)

[photo\_view](https://pub.dev/packages/photo_view) - 이미지 뷰어

확대/축소 및 팬 제스처가 있는 이미지 뷰어입니다.

```dart
1
PhotoView(
2
  imageProvider: const NetworkImage('https://example.com/image.jpg'),
3
  minScale: PhotoViewComputedScale.contained * 0.8,
4
  maxScale: PhotoViewComputedScale.covered * 2,
5
  initialScale: PhotoViewComputedScale.contained,
6
  backgroundDecoration: BoxDecoration(
7
    color: Colors.black,
8
  ),
9
)
```

### 2. Video Player

[Section titled “2. Video Player”](#2-video-player)

[video\_player](https://pub.dev/packages/video_player) - 비디오 재생

다양한 비디오 소스에서 비디오를 재생할 수 있습니다.

```dart
1
class VideoPlayerScreen extends StatefulWidget {
2
  @override
3
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
4
}
5


6
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
7
  late VideoPlayerController _controller;
8


9
  @override
10
  void initState() {
11
    super.initState();
12
    // 네트워크 비디오 로드
13
    _controller = VideoPlayerController.network(
14
      'https://example.com/video.mp4',
15
    )..initialize().then((_) {
16
      setState(() {});
17
    });
18
  }
19


20
  @override
21
  Widget build(BuildContext context) {
22
    return _controller.value.isInitialized
23
        ? AspectRatio(
24
            aspectRatio: _controller.value.aspectRatio,
25
            child: Stack(
26
              alignment: Alignment.bottomCenter,
27
              children: [
28
                VideoPlayer(_controller),
29
                VideoProgressIndicator(_controller, allowScrubbing: true),
30
                Positioned(
31
                  child: IconButton(
32
                    icon: Icon(
33
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
34
                    ),
35
                    onPressed: () {
36
                      setState(() {
37
                        _controller.value.isPlaying
38
                            ? _controller.pause()
39
                            : _controller.play();
40
                      });
41
                    },
42
                  ),
43
                ),
44
              ],
45
            ),
46
          )
47
        : const Center(child: CircularProgressIndicator());
48
  }
49


50
  @override
51
  void dispose() {
52
    _controller.dispose();
53
    super.dispose();
54
  }
55
}
```

## 인증 및 권한

[Section titled “인증 및 권한”](#인증-및-권한)

### 1. Firebase Auth

[Section titled “1. Firebase Auth”](#1-firebase-auth)

[firebase\_auth](https://pub.dev/packages/firebase_auth) - Firebase 인증

Firebase 인증 서비스를 사용하여 사용자 인증을 처리합니다.

```dart
1
// Firebase 초기화
2
await Firebase.initializeApp();
3
final FirebaseAuth auth = FirebaseAuth.instance;
4


5
// 이메일/비밀번호로 회원가입
6
Future<UserCredential> signUp(String email, String password) async {
7
  return await auth.createUserWithEmailAndPassword(
8
    email: email,
9
    password: password,
10
  );
11
}
12


13
// 이메일/비밀번호로 로그인
14
Future<UserCredential> signIn(String email, String password) async {
15
  return await auth.signInWithEmailAndPassword(
16
    email: email,
17
    password: password,
18
  );
19
}
20


21
// 로그아웃
22
Future<void> signOut() async {
23
  await auth.signOut();
24
}
25


26
// 현재 사용자 가져오기
27
User? getCurrentUser() {
28
  return auth.currentUser;
29
}
30


31
// 인증 상태 변경 감지
32
auth.authStateChanges().listen((User? user) {
33
  if (user == null) {
34
    print('로그아웃 상태');
35
  } else {
36
    print('로그인 상태: ${user.email}');
37
  }
38
});
```

### 2. Permission Handler

[Section titled “2. Permission Handler”](#2-permission-handler)

[permission\_handler](https://pub.dev/packages/permission_handler) - 권한 처리

앱 권한을 요청하고 확인합니다.

```dart
1
// 카메라 권한 요청
2
Future<void> requestCameraPermission() async {
3
  final status = await Permission.camera.request();
4


5
  if (status.isGranted) {
6
    // 권한이 부여됨, 카메라 관련 기능 실행
7
    openCamera();
8
  } else if (status.isDenied) {
9
    // 권한이 거부됨, 사용자에게 권한의 필요성 설명
10
    showPermissionDialog();
11
  } else if (status.isPermanentlyDenied) {
12
    // 권한이 영구적으로 거부됨, 앱 설정으로 이동하도록 안내
13
    await openAppSettings();
14
  }
15
}
16


17
// 여러 권한 동시 요청
18
Future<void> requestMultiplePermissions() async {
19
  Map<Permission, PermissionStatus> statuses = await [
20
    Permission.camera,
21
    Permission.microphone,
22
    Permission.storage,
23
  ].request();
24


25
  if (statuses[Permission.camera]!.isGranted &&
26
      statuses[Permission.microphone]!.isGranted) {
27
    // 카메라와 마이크 권한이 부여됨, 비디오 녹화 시작
28
    startVideoRecording();
29
  }
30
}
```

## 폼 처리 및 검증

[Section titled “폼 처리 및 검증”](#폼-처리-및-검증)

### 1. Formz

[Section titled “1. Formz”](#1-formz)

[formz](https://pub.dev/packages/formz) - 폼 상태 관리

폼 입력 및 검증을 간소화합니다.

```dart
1
// 이메일 입력 모델
2
enum EmailValidationError { empty, invalid }
3


4
class Email extends FormzInput<String, EmailValidationError> {
5
  const Email.pure() : super.pure('');
6
  const Email.dirty([String value = '']) : super.dirty(value);
7


8
  static final _emailRegex = RegExp(
9
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
10
  );
11


12
  @override
13
  EmailValidationError? validator(String value) {
14
    if (value.isEmpty) return EmailValidationError.empty;
15
    if (!_emailRegex.hasMatch(value)) return EmailValidationError.invalid;
16
    return null;
17
  }
18
}
19


20
// 비밀번호 입력 모델
21
enum PasswordValidationError { empty, tooShort }
22


23
class Password extends FormzInput<String, PasswordValidationError> {
24
  const Password.pure() : super.pure('');
25
  const Password.dirty([String value = '']) : super.dirty(value);
26


27
  @override
28
  PasswordValidationError? validator(String value) {
29
    if (value.isEmpty) return PasswordValidationError.empty;
30
    if (value.length < 8) return PasswordValidationError.tooShort;
31
    return null;
32
  }
33
}
34


35
// Riverpod과 함께 사용
36
@riverpod
37
class LoginForm extends _$LoginForm {
38
  @override
39
  FormzStatus build() {
40
    return FormzStatus.pure;
41
  }
42


43
  Email _email = const Email.pure();
44
  Password _password = const Password.pure();
45


46
  void emailChanged(String value) {
47
    _email = Email.dirty(value);
48
    _validateForm();
49
  }
50


51
  void passwordChanged(String value) {
52
    _password = Password.dirty(value);
53
    _validateForm();
54
  }
55


56
  void _validateForm() {
57
    state = Formz.validate([_email, _password]);
58
  }
59


60
  String? get emailError {
61
    switch (_email.error) {
62
      case EmailValidationError.empty:
63
        return '이메일을 입력해주세요';
64
      case EmailValidationError.invalid:
65
        return '유효한 이메일 주소를 입력해주세요';
66
      default:
67
        return null;
68
    }
69
  }
70


71
  String? get passwordError {
72
    switch (_password.error) {
73
      case PasswordValidationError.empty:
74
        return '비밀번호를 입력해주세요';
75
      case PasswordValidationError.tooShort:
76
        return '비밀번호는 최소 8자 이상이어야 합니다';
77
      default:
78
        return null;
79
    }
80
  }
81


82
  Future<void> submit() async {
83
    if (state.isInvalid) return;
84


85
    // 로그인 로직
86
  }
87
}
```

### 2. Flutter Form Builder

[Section titled “2. Flutter Form Builder”](#2-flutter-form-builder)

[flutter\_form\_builder](https://pub.dev/packages/flutter_form_builder) - 선언적 폼 빌더

쉽게 폼을 작성하고 관리할 수 있는 위젯 모음입니다.

```dart
1
final _formKey = GlobalKey<FormBuilderState>();
2


3
FormBuilder(
4
  key: _formKey,
5
  autovalidateMode: AutovalidateMode.onUserInteraction,
6
  child: Column(
7
    children: [
8
      FormBuilderTextField(
9
        name: 'email',
10
        decoration: const InputDecoration(labelText: '이메일'),
11
        validator: FormBuilderValidators.compose([
12
          FormBuilderValidators.required(),
13
          FormBuilderValidators.email(),
14
        ]),
15
      ),
16
      FormBuilderTextField(
17
        name: 'password',
18
        decoration: const InputDecoration(labelText: '비밀번호'),
19
        obscureText: true,
20
        validator: FormBuilderValidators.compose([
21
          FormBuilderValidators.required(),
22
          FormBuilderValidators.minLength(8),
23
        ]),
24
      ),
25
      FormBuilderCheckbox(
26
        name: 'agree',
27
        title: const Text('이용약관에 동의합니다'),
28
        validator: FormBuilderValidators.equal(
29
          true,
30
          errorText: '이용약관에 동의해야 합니다',
31
        ),
32
      ),
33
      ElevatedButton(
34
        onPressed: () {
35
          if (_formKey.currentState?.saveAndValidate() ?? false) {
36
            final formData = _formKey.currentState!.value;
37
            // 폼 제출 로직
38
            print(formData);
39
          }
40
        },
41
        child: const Text('제출'),
42
      ),
43
    ],
44
  ),
45
)
```

## 애니메이션 및 UI 효과

[Section titled “애니메이션 및 UI 효과”](#애니메이션-및-ui-효과)

### 1. Lottie

[Section titled “1. Lottie”](#1-lottie)

[lottie](https://pub.dev/packages/lottie) - Lottie 애니메이션

After Effects 애니메이션을 Lottie 형식으로 재생합니다.

```dart
1
// 애셋에서 Lottie 파일 로드
2
Lottie.asset(
3
  'assets/animations/loading.json',
4
  width: 200,
5
  height: 200,
6
  fit: BoxFit.cover,
7
)
8


9
// 네트워크에서 Lottie 파일 로드
10
Lottie.network(
11
  'https://example.com/animation.json',
12
  controller: _controller,
13
  onLoaded: (composition) {
14
    _controller.duration = composition.duration;
15
    _controller.forward();
16
  },
17
)
```

### 2. Flutter Animate

[Section titled “2. Flutter Animate”](#2-flutter-animate)

[flutter\_animate](https://pub.dev/packages/flutter_animate) - 선언적 애니메이션

위젯 애니메이션을 간소화하는 선언적 API입니다.

```dart
1
// 단일 애니메이션
2
Text('안녕하세요!')
3
  .animate()
4
  .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
5
  .slideX(begin: -1, end: 0)
6


7
// 연속 애니메이션
8
Text('안녕하세요!')
9
  .animate()
10
  .fadeIn(duration: 500.ms)
11
  .then(delay: 200.ms) // 지연
12
  .slideY(begin: 1, end: 0, duration: 400.ms, curve: Curves.easeOut)
13


14
// 다수의 위젯 애니메이션
15
Column(
16
  children: [
17
    for (int i = 0; i < 10; i++)
18
      ListTile(title: Text('항목 $i'))
19
        .animate()
20
        .fadeIn(delay: 100.ms * i) // 순차적 지연
21
        .slideX() // 기본값 사용
22
  ],
23
)
```

## 결론

[Section titled “결론”](#결론)

이 장에서 소개한 패키지들은 Flutter 앱 개발을 더 효율적이고 생산적으로 만들어 줍니다. 모든 앱이 동일한 패키지 세트를 필요로 하는 것은 아니므로, 프로젝트의 특정 요구 사항에 맞는 패키지를 선택하는 것이 중요합니다.

패키지를 선택할 때는 문서화 품질, 유지 관리 상태, 커뮤니티 지원 및 라이선스를 고려하세요. 또한 앱에 불필요한 크기를 추가하지 않도록 패키지의 크기와 종속성도 확인하는 것이 좋습니다.

Flutter는 계속 발전하고 있으며, 새로운 패키지와 라이브러리가 정기적으로 출시되고 있습니다. pub.dev에서 최신 패키지를 확인하고, 원하는 기능을 구현하기 전에 먼저 훌륭한 패키지가 이미 존재하는지 확인하는 습관을 들이세요.

# 위젯 캐싱

Flutter 앱의 성능을 최적화하는 데 있어 중요한 측면 중 하나는 불필요한 위젯 빌드(rebuild)과 그리기(repaint)를 최소화하는 것입니다. 이번 장에서는 Flutter에서 위젯을 효율적으로 캐싱하고 렌더링 성능을 향상시키는 다양한 기법에 대해 알아보겠습니다.

## 불필요한 재구성 문제 이해하기

[Section titled “불필요한 재구성 문제 이해하기”](#불필요한-재구성-문제-이해하기)

Flutter의 선언적 UI 모델에서는 상태가 변경될 때마다 `build` 메서드가 호출되어 위젯 트리를 재구성합니다. 이 과정은 다음과 같은 문제를 야기할 수 있습니다:

1. **성능 저하**: 복잡한 위젯 트리를 자주 재구성하면 프레임 드롭이 발생할 수 있습니다.
2. **불필요한 계산**: 변경되지 않은 위젯도 재구성될 수 있습니다.
3. **배터리 소모**: 과도한 CPU 및 GPU 사용으로 배터리 소모가 증가합니다.

## RepaintBoundary 이해하기

[Section titled “RepaintBoundary 이해하기”](#repaintboundary-이해하기)

`RepaintBoundary`는 Flutter에서 제공하는 중요한 최적화 도구로, 렌더링 레이어를 분리하여 변경이 필요한 부분만 다시 그리도록 합니다.

### RepaintBoundary 작동 원리

[Section titled “RepaintBoundary 작동 원리”](#repaintboundary-작동-원리)

`RepaintBoundary`는 자식 위젯을 별도의 레이어로 분리합니다:

1. 부모 위젯이 변경되면 자식은 다시 그려지지 않습니다.
2. 자식 위젯이 변경되면 부모는 영향을 받지 않습니다.
3. 각 레이어는 GPU에 개별적으로 래스터화되고 캐시됩니다.

### RepaintBoundary 사용 방법

[Section titled “RepaintBoundary 사용 방법”](#repaintboundary-사용-방법)

기본 사용법은 간단합니다:

```dart
1
RepaintBoundary(
2
  child: MyComplexWidget(),
3
)
```

일반적으로 다음과 같은 경우에 `RepaintBoundary`를 사용하는 것이 좋습니다:

1. **복잡한 UI**: 계산 비용이 높은 위젯이나 복잡한 렌더링이 필요한 경우
2. **독립적으로 변경되는 부분**: 애니메이션이 있는 위젯이나 자주 업데이트되는 위젯
3. **ListView 내부 항목**: 스크롤 성능 향상을 위해 각 항목을 분리

### 실용적인 예제

[Section titled “실용적인 예제”](#실용적인-예제)

스크롤 목록에서 복잡한 항목을 최적화하는 예:

```dart
1
ListView.builder(
2
  itemCount: items.length,
3
  itemBuilder: (context, index) {
4
    return RepaintBoundary(
5
      child: ComplexListItem(item: items[index]),
6
    );
7
  },
8
)
```

애니메이션이 있는 UI 부분 분리:

```dart
1
class AnimatedProfilePage extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    return Column(
5
      children: [
6
        // 자주 변경되지 않는 프로필 정보
7
        UserProfileHeader(),
8


9
        // 독립적으로 애니메이션되는 부분
10
        RepaintBoundary(
11
          child: AnimatedActivityGraph(),
12
        ),
13


14
        // 정적 콘텐츠
15
        UserDetails(),
16
      ],
17
    );
18
  }
19
}
```

## const 생성자를 활용한 위젯 캐싱

[Section titled “const 생성자를 활용한 위젯 캐싱”](#const-생성자를-활용한-위젯-캐싱)

Flutter에서 가장 간단하고 효과적인 캐싱 방법 중 하나는 `const` 생성자를 사용하는 것입니다. `const` 위젯은 빌드 시간이 아닌 컴파일 시간에 생성되어 재사용됩니다.

### const 위젯의 이점

[Section titled “const 위젯의 이점”](#const-위젯의-이점)

1. **메모리 효율성**: 동일한 `const` 위젯은 메모리에 한 번만 생성됩니다.
2. **빌드 스킵**: Flutter는 동일한 `const` 위젯을 다시 빌드하지 않습니다.
3. **빠른 비교**: `operator ==`를 호출하지 않고 참조 비교만 수행합니다.

### const 위젯 사용 예시

[Section titled “const 위젯 사용 예시”](#const-위젯-사용-예시)

```dart
1
// 좋음: const 생성자 사용
2
const MyWidget(
3
  title: 'Hello',
4
  padding: EdgeInsets.all(16.0),
5
)
6


7
// 나쁨: 매번 새로운 인스턴스 생성
8
MyWidget(
9
  title: 'Hello',
10
  padding: EdgeInsets.all(16.0),
11
)
```

모든 자식 위젯에 `const`를 적용한 예:

```dart
1
const Scaffold(
2
  appBar: const AppBar(
3
    title: const Text('Cached Widgets Demo'),
4
  ),
5
  body: const Center(
6
    child: const Column(
7
      mainAxisAlignment: MainAxisAlignment.center,
8
      children: const [
9
        const Text('This is a cached widget'),
10
        const SizedBox(height: 20),
11
        const Icon(Icons.cached),
12
      ],
13
    ),
14
  ),
15
)
```

### const 사용 시 주의사항

[Section titled “const 사용 시 주의사항”](#const-사용-시-주의사항)

1. 모든 인스턴스 변수는 `final`이어야 합니다.
2. 모든 인스턴스 변수는 컴파일 타임 상수여야 합니다.
3. 런타임에 결정되는 값(예: `DateTime.now()`)은 사용할 수 없습니다.

## ValueKey를 활용한 위젯 식별

[Section titled “ValueKey를 활용한 위젯 식별”](#valuekey를-활용한-위젯-식별)

Flutter의 요소 재활용 메커니즘을 최대한 활용하려면 적절한 키를 사용하는 것이 중요합니다.

### 키의 역할

[Section titled “키의 역할”](#키의-역할)

키는 Flutter가 위젯 트리 업데이트 중에 위젯을 식별하는 데 도움을 줍니다:

1. **요소 재사용**: 올바른 키를 사용하면 Flutter가 적절한 요소를 재활용할 수 있습니다.
2. **상태 보존**: 위젯이 이동하더라도 키를 통해 상태를 보존할 수 있습니다.
3. **불필요한 재구성 방지**: 올바른 비교를 통해 불필요한 재구성을 방지합니다.

### 키 사용 예시

[Section titled “키 사용 예시”](#키-사용-예시)

목록 항목에 대한 적절한 키 사용:

```dart
1
ListView.builder(
2
  itemCount: items.length,
3
  itemBuilder: (context, index) {
4
    final item = items[index];
5
    return ListTile(
6
      // 항목의 고유 식별자로 키 생성
7
      key: ValueKey(item.id),
8
      title: Text(item.title),
9
    );
10
  },
11
)
```

상태를 가진 위젯의 키 사용:

```dart
1
class TodoList extends StatelessWidget {
2
  final List<Todo> todos;
3


4
  @override
5
  Widget build(BuildContext context) {
6
    return Column(
7
      children: todos.map((todo) =>
8
        // 키를 사용하여 위젯 재정렬 시 상태 보존
9
        TodoItem(
10
          key: ValueKey(todo.id),
11
          todo: todo,
12
        ),
13
      ).toList(),
14
    );
15
  }
16
}
```

## 메모이제이션 기법

[Section titled “메모이제이션 기법”](#메모이제이션-기법)

메모이제이션은 함수의 결과를 캐싱하여 동일한 입력에 대해 계산을 반복하지 않는 기법입니다. Flutter에서는 다음과 같은 방법으로 구현할 수 있습니다.

### 1. 클래스 내부 캐싱

[Section titled “1. 클래스 내부 캐싱”](#1-클래스-내부-캐싱)

```dart
1
class ExpensiveWidgetBuilder extends StatelessWidget {
2
  final String data;
3


4
  // 캐시 변수
5
  Widget? _cachedWidget;
6
  String? _cachedData;
7


8
  ExpensiveWidgetBuilder({required this.data});
9


10
  @override
11
  Widget build(BuildContext context) {
12
    // 데이터가 변경되지 않았으면 캐시된 위젯 반환
13
    if (data == _cachedData && _cachedWidget != null) {
14
      return _cachedWidget!;
15
    }
16


17
    // 데이터가 변경되었으면 새로 계산하고 캐시
18
    _cachedData = data;
19
    _cachedWidget = _buildExpensiveWidget(data);
20


21
    return _cachedWidget!;
22
  }
23


24
  Widget _buildExpensiveWidget(String data) {
25
    // 비용이 많이 드는 위젯 생성 로직
26
    return Text('Processed: $data');
27
  }
28
}
```

### 2. 전역 캐시 맵 사용

[Section titled “2. 전역 캐시 맵 사용”](#2-전역-캐시-맵-사용)

여러 위젯에서 재사용해야 하는 경우:

```dart
1
// 전역 캐시
2
final Map<String, Widget> _widgetCache = {};
3


4
Widget getCachedWidget(String key, Widget Function() builder) {
5
  if (!_widgetCache.containsKey(key)) {
6
    _widgetCache[key] = builder();
7
  }
8
  return _widgetCache[key]!;
9
}
10


11
// 사용 예시
12
Widget build(BuildContext context) {
13
  return getCachedWidget(
14
    'unique_key_$parameterValue',
15
    () => ExpensiveWidget(parameter: parameterValue),
16
  );
17
}
```

### 3. 고급: 캐시 크기 제한 및 LRU 캐시

[Section titled “3. 고급: 캐시 크기 제한 및 LRU 캐시”](#3-고급-캐시-크기-제한-및-lru-캐시)

메모리 사용을 제한하기 위한 LRU(Least Recently Used) 캐시 구현:

```dart
1
import 'package:collection/collection.dart';
2


3
class LruWidgetCache {
4
  final int maxSize;
5
  final Map<String, Widget> _cache = {};
6
  final Queue<String> _lruQueue = Queue<String>();
7


8
  LruWidgetCache({this.maxSize = 100});
9


10
  Widget getWidget(String key, Widget Function() builder) {
11
    // 캐시에 있으면 최근 사용 큐 업데이트
12
    if (_cache.containsKey(key)) {
13
      _lruQueue.remove(key);
14
      _lruQueue.add(key);
15
      return _cache[key]!;
16
    }
17


18
    // 캐시 크기 제한 확인
19
    if (_lruQueue.length >= maxSize) {
20
      final oldest = _lruQueue.removeFirst();
21
      _cache.remove(oldest);
22
    }
23


24
    // 새 항목 캐싱
25
    final widget = builder();
26
    _cache[key] = widget;
27
    _lruQueue.add(key);
28


29
    return widget;
30
  }
31


32
  void clear() {
33
    _cache.clear();
34
    _lruQueue.clear();
35
  }
36
}
```

## Riverpod과 select를 활용한 최적화

[Section titled “Riverpod과 select를 활용한 최적화”](#riverpod과-select를-활용한-최적화)

Riverpod을 사용하는 경우 `select` 메서드를 활용하여 필요한 상태 변경만 감지하도록 최적화할 수 있습니다.

### select 메서드 사용 예시

[Section titled “select 메서드 사용 예시”](#select-메서드-사용-예시)

```dart
1
// 상태 구조
2
class UserState {
3
  final String name;
4
  final int age;
5
  final String address;
6


7
  UserState({required this.name, required this.age, required this.address});
8
}
9


10
// 프로바이더
11
final userProvider = StateProvider<UserState>((ref) =>
12
  UserState(name: 'John', age: 30, address: 'New York'));
13


14
// 최적화된 위젯
15
class UserNameWidget extends ConsumerWidget {
16
  @override
17
  Widget build(BuildContext context, WidgetRef ref) {
18
    // name 변경 시에만 재구성
19
    final name = ref.watch(userProvider.select((user) => user.name));
20


21
    return Text('Name: $name');
22
  }
23
}
24


25
class UserAgeWidget extends ConsumerWidget {
26
  @override
27
  Widget build(BuildContext context, WidgetRef ref) {
28
    // age 변경 시에만 재구성
29
    final age = ref.watch(userProvider.select((user) => user.age));
30


31
    return Text('Age: $age');
32
  }
33
}
```

### 대규모 앱에서의 Riverpod 캐싱 전략

[Section titled “대규모 앱에서의 Riverpod 캐싱 전략”](#대규모-앱에서의-riverpod-캐싱-전략)

복잡한 앱에서는 여러 프로바이더를 조합하여 효율적인 캐싱 전략을 구현할 수 있습니다:

```dart
1
// 1. 원본 데이터 프로바이더
2
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) =>
3
  TodosNotifier());
4


5
// 2. 필터링된 데이터 프로바이더 (파생)
6
final filteredTodosProvider = Provider<List<Todo>>((ref) {
7
  final todos = ref.watch(todosProvider);
8
  final filter = ref.watch(filterProvider);
9


10
  // 필터에 따라 할 일 필터링
11
  switch (filter) {
12
    case Filter.all:
13
      return todos;
14
    case Filter.completed:
15
      return todos.where((todo) => todo.completed).toList();
16
    case Filter.active:
17
      return todos.where((todo) => !todo.completed).toList();
18
  }
19
});
20


21
// 3. 통계 프로바이더 (파생)
22
final todoStatsProvider = Provider<TodoStats>((ref) {
23
  final todos = ref.watch(todosProvider);
24


25
  // 통계 계산 (비용이 많이 들 수 있음)
26
  int completed = todos.where((todo) => todo.completed).length;
27


28
  return TodoStats(
29
    total: todos.length,
30
    completed: completed,
31
    active: todos.length - completed,
32
  );
33
});
```

## 이미지 캐싱 최적화

[Section titled “이미지 캐싱 최적화”](#이미지-캐싱-최적화)

이미지는 앱에서 가장 메모리와 성능을 많이 사용하는 리소스 중 하나입니다. 효과적인 이미지 캐싱은 성능에 큰 영향을 미칩니다.

### cached\_network\_image 패키지 사용

[Section titled “cached\_network\_image 패키지 사용”](#cached_network_image-패키지-사용)

```dart
1
import 'package:cached_network_image/cached_network_image.dart';
2


3
CachedNetworkImage(
4
  imageUrl: 'https://example.com/image.jpg',
5
  placeholder: (context, url) => CircularProgressIndicator(),
6
  errorWidget: (context, url, error) => Icon(Icons.error),
7
  // 디스크 캐시 활성화
8
  cacheManager: CacheManager(
9
    Config(
10
      'customCacheKey',
11
      stalePeriod: Duration(days: 7),
12
      maxNrOfCacheObjects: 100,
13
    ),
14
  ),
15
)
```

### 성능을 위한 이미지 크기 최적화

[Section titled “성능을 위한 이미지 크기 최적화”](#성능을-위한-이미지-크기-최적화)

```dart
1
class OptimizedNetworkImage extends StatelessWidget {
2
  final String url;
3
  final double width;
4
  final double height;
5


6
  const OptimizedNetworkImage({
7
    required this.url,
8
    required this.width,
9
    required this.height,
10
  });
11


12
  @override
13
  Widget build(BuildContext context) {
14
    // 이미지 URL에 크기 파라미터 추가
15
    final optimizedUrl = '$url?w=${width.toInt()}&h=${height.toInt()}';
16


17
    return CachedNetworkImage(
18
      imageUrl: optimizedUrl,
19
      width: width,
20
      height: height,
21
      fit: BoxFit.cover,
22
      memCacheWidth: width.toInt(),
23
      memCacheHeight: height.toInt(),
24
    );
25
  }
26
}
```

## 캐싱 사례 연구: 복잡한 폼

[Section titled “캐싱 사례 연구: 복잡한 폼”](#캐싱-사례-연구-복잡한-폼)

복잡한 폼을 가진 앱의 성능을 최적화하는 전략을 살펴보겠습니다:

```dart
1
class OptimizedFormScreen extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    return Scaffold(
5
      appBar: AppBar(title: const Text('복잡한 폼')),
6
      body: Column(
7
        children: [
8
          // 자주 변경되지 않는 부분
9
          const RepaintBoundary(
10
            child: const FormHeader(),
11
          ),
12


13
          // 사용자 입력 필드들 (자주 변경됨)
14
          Expanded(
15
            child: ListView(
16
              children: [
17
                // 각 섹션을 독립적인 위젯으로 분리
18
                PersonalInfoSection(),
19


20
                const SizedBox(height: 16),
21


22
                // 복잡하지만 자주 변경되지 않는 섹션
23
                const RepaintBoundary(
24
                  child: const AddressSection(),
25
                ),
26


27
                const SizedBox(height: 16),
28


29
                PaymentInfoSection(),
30
              ],
31
            ),
32
          ),
33


34
          // 제출 버튼 (상태에 따라 변경됨)
35
          SubmitButton(),
36
        ],
37
      ),
38
    );
39
  }
40
}
41


42
// 각 섹션은 ConsumerWidget으로 구현하여
43
// 필요한 상태만 구독하도록 최적화
44
class PersonalInfoSection extends ConsumerWidget {
45
  @override
46
  Widget build(BuildContext context, WidgetRef ref) {
47
    // 개인 정보 관련 상태만 구독
48
    final personalInfo = ref.watch(
49
      formProvider.select((state) => state.personalInfo)
50
    );
51


52
    return Card(
53
      child: Padding(
54
        padding: const EdgeInsets.all(16.0),
55
        child: Column(
56
          crossAxisAlignment: CrossAxisAlignment.start,
57
          children: [
58
            const Text('개인 정보', style: TextStyle(fontWeight: FontWeight.bold)),
59
            TextField(
60
              decoration: const InputDecoration(labelText: '이름'),
61
              onChanged: (value) => ref.read(formProvider.notifier).updateName(value),
62
              controller: TextEditingController(text: personalInfo.name),
63
            ),
64
            // 기타 입력 필드...
65
          ],
66
        ),
67
      ),
68
    );
69
  }
70
}
```

## 위젯 캐싱 최적화 체크리스트

[Section titled “위젯 캐싱 최적화 체크리스트”](#위젯-캐싱-최적화-체크리스트)

효과적인 위젯 캐싱을 위한 체크리스트입니다:

1. **const 생성자 사용하기**

   * 가능한 모든 위젯에 `const` 생성자 사용
   * 리터럴 값으로 위젯 생성 시 `const` 키워드 사용

2. **적절한 위치에 RepaintBoundary 추가하기**

   * 복잡하지만 독립적으로 변경되는 UI 부분
   * 애니메이션이 있는 부분
   * 목록 항목 등

3. **위젯 분리 및 세분화**

   * 자주 변경되는 부분과 정적인 부분 분리
   * 큰 위젯을 작은 위젯으로 분리하여 최적화

4. **상태 관리 최적화**

   * Riverpod `select` 메서드 활용
   * 필요한 상태만 구독하도록 구현

5. **키 올바르게 사용하기**

   * 목록 항목에 적절한 키 사용
   * 위젯 재사용을 위한 식별자 제공

6. **불필요한 중복 계산 피하기**

   * 비용이 많이 드는 계산 결과 캐싱
   * 파생 데이터에 메모이제이션 적용

7. **이미지 최적화**

   * 적절한 크기의 이미지 요청
   * 효율적인 이미지 캐싱 구현

## 결론

[Section titled “결론”](#결론)

위젯 캐싱은 Flutter 앱의 성능을 크게 향상시킬 수 있는 중요한 기법입니다. `const` 생성자, `RepaintBoundary`, 적절한 키 사용, 메모이제이션, 상태 관리 최적화 등 다양한 방법을 함께 활용하면 부드럽고 반응성 좋은 앱을 만들 수 있습니다.

특히 중요한 점은 모든 상황에 일률적으로 적용할 수 있는 최적화 방법은 없다는 것입니다. 앱의 특성과 사용 패턴에 맞게 적절한 캐싱 전략을 선택하고, DevTools의 성능 프로파일러를 활용하여 실제 성능 개선을 측정하며 최적화해야 합니다.

다음 장에서는 Flutter의 다양한 애니메이션 기법과 활용법에 대해 알아보겠습니다.

# 비동기 프로그래밍

Dart는 비동기 프로그래밍을 위한 강력한 지원을 제공합니다. 비동기(asynchronous) 프로그래밍은 애플리케이션이 네트워크 요청, 파일 입출력, 데이터베이스 작업과 같은 시간이 오래 걸리는 작업을 처리할 때 UI가 멈추지 않도록 하는 중요한 패러다임입니다.

## 비동기 프로그래밍의 필요성

[Section titled “비동기 프로그래밍의 필요성”](#비동기-프로그래밍의-필요성)

동기(synchronous) 코드가 실행되면 각 작업은 이전 작업이 완료될 때까지 기다린 후 실행됩니다. 이는 UI 스레드에서 시간이 오래 걸리는 작업을 수행할 때 문제가 됩니다:

```dart
1
// 동기 코드 예시
2
void main() {
3
  print('작업 시작');
4
  String data = fetchDataSync(); // 이 작업이 3초 걸린다고 가정
5
  print('데이터: $data');
6
  print('다음 작업 진행');
7
}
8


9
String fetchDataSync() {
10
  // 네트워크 요청 시뮬레이션
11
  sleep(Duration(seconds: 3));
12
  return '서버에서 받은 데이터';
13
}
```

위 코드에서 `fetchDataSync()` 함수가 실행되는 동안 UI는 완전히 멈추게 됩니다. 이러한 문제를 해결하기 위해 Dart는 다음과 같은 비동기 프로그래밍 도구를 제공합니다:

1. `Future` 객체
2. `async` 및 `await` 키워드
3. `Stream` 객체

## Future

[Section titled “Future”](#future)

`Future`는 비동기 연산의 결과를 나타내는 객체입니다. 이는 나중에 값이나 오류를 포함할 약속(promise)과 같습니다.

### Future 기본

[Section titled “Future 기본”](#future-기본)

```dart
1
Future<String> fetchData() {
2
  return Future.delayed(Duration(seconds: 3), () {
3
    return '서버에서 받은 데이터';
4
  });
5
}
6


7
void main() {
8
  print('작업 시작');
9


10
  // fetchData()는 즉시 Future 객체를 반환
11
  fetchData().then((data) {
12
    print('데이터: $data');
13
  }).catchError((error) {
14
    print('오류 발생: $error');
15
  }).whenComplete(() {
16
    print('작업 완료');
17
  });
18


19
  print('다음 작업 진행'); // fetchData()가 완료되기 전에 실행됨
20
}
21


22
// 출력:
23
// 작업 시작
24
// 다음 작업 진행
25
// 데이터: 서버에서 받은 데이터
26
// 작업 완료
```

### Future 생성 방법

[Section titled “Future 생성 방법”](#future-생성-방법)

#### 1. Future.value()

[Section titled “1. Future.value()”](#1-futurevalue)

이미 알고 있는 값으로 즉시 완료되는 Future를 생성합니다:

```dart
1
Future<String> getFuture() {
2
  return Future.value('즉시 사용 가능한 값');
3
}
```

#### 2. Future.delayed()

[Section titled “2. Future.delayed()”](#2-futuredelayed)

지정된 시간 후에 완료되는 Future를 생성합니다:

```dart
1
Future<String> getDelayedFuture() {
2
  return Future.delayed(Duration(seconds: 2), () {
3
    return '2초 후 사용 가능한 값';
4
  });
5
}
```

#### 3. Future.error()

[Section titled “3. Future.error()”](#3-futureerror)

오류로 완료되는 Future를 생성합니다:

```dart
1
Future<String> getErrorFuture() {
2
  return Future.error('오류 발생');
3
}
```

#### 4. Completer 사용

[Section titled “4. Completer 사용”](#4-completer-사용)

복잡한 비동기 로직을 직접 제어하려면 `Completer`를 사용할 수 있습니다:

```dart
1
import 'dart:async';
2


3
Future<String> complexOperation() {
4
  final completer = Completer<String>();
5


6
  // 비동기 작업 시뮬레이션
7
  Timer(Duration(seconds: 2), () {
8
    if (DateTime.now().second % 2 == 0) {
9
      completer.complete('성공!');
10
    } else {
11
      completer.completeError('실패!');
12
    }
13
  });
14


15
  return completer.future;
16
}
```

### Future 체이닝

[Section titled “Future 체이닝”](#future-체이닝)

여러 비동기 작업을 순차적으로 처리하려면 Future 체이닝을 사용합니다:

```dart
1
void main() {
2
  fetchUserId()
3
    .then((id) => fetchUserData(id))
4
    .then((userData) => saveUserData(userData))
5
    .then((_) => print('모든 작업 완료'))
6
    .catchError((error) => print('오류 발생: $error'));
7
}
8


9
Future<String> fetchUserId() => Future.value('user123');
10
Future<Map<String, dynamic>> fetchUserData(String id) =>
11
    Future.value({'id': id, 'name': '홍길동', 'email': 'hong@example.com'});
12
Future<void> saveUserData(Map<String, dynamic> userData) =>
13
    Future.value(print('데이터 저장됨: $userData'));
```

## async 및 await

[Section titled “async 및 await”](#async-및-await)

`async`와 `await` 키워드를 사용하면 비동기 코드를 동기 코드처럼 작성할 수 있어 가독성이 향상됩니다.

### 기본 사용법

[Section titled “기본 사용법”](#기본-사용법)

```dart
1
Future<String> fetchData() async {
2
  // async 함수 내에서 await 사용
3
  await Future.delayed(Duration(seconds: 2));
4
  return '서버에서 받은 데이터';
5
}
6


7
void main() async {
8
  print('작업 시작');
9


10
  try {
11
    // await는 Future가 완료될 때까지 기다림
12
    String data = await fetchData();
13
    print('데이터: $data');
14
  } catch (e) {
15
    print('오류 발생: $e');
16
  } finally {
17
    print('작업 완료');
18
  }
19


20
  print('다음 작업 진행');
21
}
22


23
// 출력:
24
// 작업 시작
25
// 데이터: 서버에서 받은 데이터
26
// 작업 완료
27
// 다음 작업 진행
```

### async 함수의 특성

[Section titled “async 함수의 특성”](#async-함수의-특성)

1. `async` 표시된 함수는 항상 `Future`를 반환합니다.
2. 이미 Future를 반환하는 경우 추가 래핑이 발생하지 않습니다.
3. 함수 내에서 `await`를 사용할 수 있습니다.

```dart
1
// String을 반환하는 것처럼 보이지만 실제로는 Future<String>을 반환
2
Future<String> getString() async {
3
  return 'Hello';
4
}
5


6
// 이미 Future<String>을 반환하므로 Future<Future<String>>이 아닌 Future<String>을 반환
7
Future<String> getFuture() async {
8
  return Future.value('Hello');
9
}
```

### 여러 비동기 작업 처리

[Section titled “여러 비동기 작업 처리”](#여러-비동기-작업-처리)

#### 순차 처리

[Section titled “순차 처리”](#순차-처리)

```dart
1
Future<void> sequentialTasks() async {
2
  final startTime = DateTime.now();
3


4
  final result1 = await task1(); // 2초 소요
5
  final result2 = await task2(); // 3초 소요
6
  final result3 = await task3(); // 1초 소요
7


8
  // 총 약 6초 소요
9
  print('모든 작업 완료: $result1, $result2, $result3');
10
  print('소요 시간: ${DateTime.now().difference(startTime).inSeconds}초');
11
}
```

#### 병렬 처리

[Section titled “병렬 처리”](#병렬-처리)

```dart
1
Future<void> parallelTasks() async {
2
  final startTime = DateTime.now();
3


4
  // Future.wait를 사용하여 여러 작업을 동시에 시작하고 모두 완료될 때까지 기다림
5
  final results = await Future.wait([
6
    task1(), // 2초 소요
7
    task2(), // 3초 소요
8
    task3(), // 1초 소요
9
  ]);
10


11
  // 총 약 3초 소요 (가장 오래 걸리는 작업 기준)
12
  print('모든 작업 완료: ${results[0]}, ${results[1]}, ${results[2]}');
13
  print('소요 시간: ${DateTime.now().difference(startTime).inSeconds}초');
14
}
15


16
Future<String> task1() => Future.delayed(Duration(seconds: 2), () => '작업1 결과');
17
Future<String> task2() => Future.delayed(Duration(seconds: 3), () => '작업2 결과');
18
Future<String> task3() => Future.delayed(Duration(seconds: 1), () => '작업3 결과');
```

### Future API

[Section titled “Future API”](#future-api)

Future 클래스는 다양한 유용한 메서드를 제공합니다:

#### Future.wait

[Section titled “Future.wait”](#futurewait)

여러 Future가 모두 완료될 때까지 기다립니다:

```dart
1
Future<void> waitExample() async {
2
  final results = await Future.wait([
3
    Future.delayed(Duration(seconds: 1), () => '결과1'),
4
    Future.delayed(Duration(seconds: 2), () => '결과2'),
5
    Future.delayed(Duration(seconds: 3), () => '결과3'),
6
  ]);
7


8
  print(results); // [결과1, 결과2, 결과3]
9
}
```

#### Future.any

[Section titled “Future.any”](#futureany)

여러 Future 중 하나라도 완료되면 그 결과를 반환합니다:

```dart
1
Future<void> anyExample() async {
2
  final result = await Future.any([
3
    Future.delayed(Duration(seconds: 3), () => '느린 작업'),
4
    Future.delayed(Duration(seconds: 1), () => '빠른 작업'),
5
    Future.delayed(Duration(seconds: 2), () => '중간 작업'),
6
  ]);
7


8
  print(result); // 빠른 작업
9
}
```

#### Future.forEach

[Section titled “Future.forEach”](#futureforeach)

리스트의 각 항목에 대해 비동기 작업을 순차적으로 수행합니다:

```dart
1
Future<void> forEachExample() async {
2
  final items = [1, 2, 3, 4, 5];
3


4
  await Future.forEach(items, (int item) async {
5
    await Future.delayed(Duration(milliseconds: 500));
6
    print('처리 중: $item');
7
  });
8


9
  print('모든 항목 처리 완료');
10
}
```

## Stream

[Section titled “Stream”](#stream)

`Stream`은 시간에 따라 여러 비동기 이벤트를 제공하는 방법입니다. 이는 파일 읽기, 웹소켓 메시지, 사용자 입력 이벤트 등과 같이 여러 값을 비동기적으로 처리해야 할 때 유용합니다.

### Stream 기본

[Section titled “Stream 기본”](#stream-기본)

```dart
1
Stream<int> countStream(int max) async* {
2
  for (int i = 1; i <= max; i++) {
3
    await Future.delayed(Duration(seconds: 1));
4
    yield i; // 스트림에 값을 추가
5
  }
6
}
7


8
void main() async {
9
  // 스트림 구독
10
  final stream = countStream(5);
11


12
  // 첫 번째 방법: await for
13
  print('await for 사용:');
14
  await for (final count in stream) {
15
    print(count);
16
  }
17


18
  // 두 번째 방법: listen
19
  print('listen 사용:');
20
  countStream(5).listen(
21
    (data) => print(data),
22
    onError: (error) => print('오류: $error'),
23
    onDone: () => print('스트림 완료'),
24
  );
25
}
```

### Stream 생성 방법

[Section titled “Stream 생성 방법”](#stream-생성-방법)

#### 1. async\* 및 yield

[Section titled “1. async\* 및 yield”](#1-async-및-yield)

제너레이터 함수를 사용하여 스트림을 생성합니다:

```dart
1
Stream<int> countStream(int max) async* {
2
  for (int i = 1; i <= max; i++) {
3
    await Future.delayed(Duration(seconds: 1));
4
    yield i;
5
  }
6
}
```

#### 2. StreamController

[Section titled “2. StreamController”](#2-streamcontroller)

더 세밀한 제어가 필요할 때 `StreamController`를 사용합니다:

```dart
1
import 'dart:async';
2


3
Stream<int> getControllerStream() {
4
  final controller = StreamController<int>();
5


6
  // 데이터 추가 시뮬레이션
7
  Timer.periodic(Duration(seconds: 1), (timer) {
8
    if (timer.tick <= 5) {
9
      controller.add(timer.tick);
10
    } else {
11
      controller.close();
12
      timer.cancel();
13
    }
14
  });
15


16
  return controller.stream;
17
}
```

#### 3. Stream.fromIterable

[Section titled “3. Stream.fromIterable”](#3-streamfromiterable)

반복 가능한(Iterable) 객체에서 스트림을 생성합니다:

```dart
1
Stream<int> getIterableStream() {
2
  return Stream.fromIterable([1, 2, 3, 4, 5]);
3
}
```

#### 4. Stream.periodic

[Section titled “4. Stream.periodic”](#4-streamperiodic)

주기적으로 이벤트를 생성하는 스트림을 만듭니다:

```dart
1
Stream<int> getPeriodicStream() {
2
  return Stream.periodic(Duration(seconds: 1), (count) => count + 1)
3
      .take(5); // 처음 5개 이벤트만 가져옴
4
}
```

### Stream 변환 및 조작

[Section titled “Stream 변환 및 조작”](#stream-변환-및-조작)

Stream은 다양한 변환 및 조작 메서드를 제공합니다:

```dart
1
void streamTransformations() async {
2
  final stream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
3


4
  // 변환: 각 값을 두 배로
5
  final doubled = stream.map((value) => value * 2);
6


7
  // 필터링: 짝수만 선택
8
  final evenOnly = doubled.where((value) => value % 2 == 0);
9


10
  // 제한: 처음 3개 이벤트만
11
  final limited = evenOnly.take(3);
12


13
  // 결과 출력
14
  await for (final value in limited) {
15
    print(value); // 4, 8, 12
16
  }
17
}
```

### 일반적인 Stream 패턴

[Section titled “일반적인 Stream 패턴”](#일반적인-stream-패턴)

#### 브로드캐스트 스트림

[Section titled “브로드캐스트 스트림”](#브로드캐스트-스트림)

여러 리스너가 동시에 구독할 수 있는 스트림입니다:

```dart
1
void broadcastStreamExample() {
2
  final controller = StreamController<int>.broadcast();
3


4
  // 첫 번째 구독자
5
  final subscription1 = controller.stream.listen(
6
    (data) => print('구독자 1: $data'),
7
    onDone: () => print('구독자 1: 완료'),
8
  );
9


10
  // 두 번째 구독자
11
  final subscription2 = controller.stream.listen(
12
    (data) => print('구독자 2: $data'),
13
    onDone: () => print('구독자 2: 완료'),
14
  );
15


16
  // 데이터 추가
17
  controller.add(1);
18
  controller.add(2);
19
  controller.add(3);
20


21
  // 첫 번째 구독 취소
22
  subscription1.cancel();
23


24
  // 추가 데이터
25
  controller.add(4);
26
  controller.add(5);
27


28
  // 스트림 닫기
29
  controller.close();
30
}
```

#### 스트림 구독 관리

[Section titled “스트림 구독 관리”](#스트림-구독-관리)

스트림 구독을 적절히 취소하여 메모리 누수를 방지하는 것이 중요합니다:

```dart
1
class DataService {
2
  StreamSubscription<int>? _subscription;
3


4
  void startListening() {
5
    // 이미 구독 중이면 기존 구독 취소
6
    _subscription?.cancel();
7


8
    // 새로운 구독 시작
9
    _subscription = getPeriodicStream().listen(
10
      (data) => print('받은 데이터: $data'),
11
      onDone: () => print('스트림 완료'),
12
    );
13
  }
14


15
  void stopListening() {
16
    _subscription?.cancel();
17
    _subscription = null;
18
  }
19


20
  void dispose() {
21
    stopListening();
22
  }
23
}
```

### async\*/await for 대 StreamBuilder

[Section titled “async\*/await for 대 StreamBuilder”](#asyncawait-for-대-streambuilder)

Flutter에서는 스트림 데이터를 처리하는 두 가지 주요 방법이 있습니다:

#### async\*/await for (명령형)

[Section titled “async\*/await for (명령형)”](#asyncawait-for-명령형)

```dart
1
Future<void> processStream(Stream<int> stream) async {
2
  await for (final value in stream) {
3
    // 각 이벤트 처리
4
    print('처리 중: $value');
5
  }
6
}
```

#### StreamBuilder (선언적)

[Section titled “StreamBuilder (선언적)”](#streambuilder-선언적)

Flutter 위젯에서 스트림 데이터를 처리할 때는 `StreamBuilder`를 사용하는 것이 좋습니다:

```dart
1
StreamBuilder<int>(
2
  stream: countStream(10),
3
  builder: (context, snapshot) {
4
    if (snapshot.hasError) {
5
      return Text('오류 발생: ${snapshot.error}');
6
    }
7


8
    if (snapshot.connectionState == ConnectionState.waiting) {
9
      return CircularProgressIndicator();
10
    }
11


12
    if (snapshot.hasData) {
13
      return Text('현재 값: ${snapshot.data}');
14
    }
15


16
    return Text('데이터 없음');
17
  },
18
)
```

## Flutter에서의 비동기 프로그래밍

[Section titled “Flutter에서의 비동기 프로그래밍”](#flutter에서의-비동기-프로그래밍)

Flutter에서 비동기 프로그래밍은 UI의 응답성을 유지하는 데 중요합니다:

### 1. FutureBuilder

[Section titled “1. FutureBuilder”](#1-futurebuilder)

단일 비동기 작업의 결과를 UI에 표시할 때 사용합니다:

```dart
1
FutureBuilder<String>(
2
  future: fetchData(),
3
  builder: (context, snapshot) {
4
    if (snapshot.connectionState == ConnectionState.waiting) {
5
      return CircularProgressIndicator();
6
    } else if (snapshot.hasError) {
7
      return Text('오류 발생: ${snapshot.error}');
8
    } else if (snapshot.hasData) {
9
      return Text('데이터: ${snapshot.data}');
10
    } else {
11
      return Text('데이터 없음');
12
    }
13
  },
14
)
```

### 2. StreamBuilder

[Section titled “2. StreamBuilder”](#2-streambuilder)

지속적으로 업데이트되는 데이터를 UI에 표시할 때 사용합니다:

```dart
1
StreamBuilder<int>(
2
  stream: countdownStream(10),
3
  builder: (context, snapshot) {
4
    if (snapshot.connectionState == ConnectionState.active) {
5
      return Text('카운트다운: ${snapshot.data}');
6
    } else if (snapshot.connectionState == ConnectionState.done) {
7
      return Text('카운트다운 완료!');
8
    } else {
9
      return CircularProgressIndicator();
10
    }
11
  },
12
)
```

### 3. 실제 예제: 데이터 가져오기

[Section titled “3. 실제 예제: 데이터 가져오기”](#3-실제-예제-데이터-가져오기)

```dart
1
Future<List<User>> fetchUsers() async {
2
  final response = await http.get(Uri.parse('https://api.example.com/users'));
3


4
  if (response.statusCode == 200) {
5
    final List<dynamic> data = jsonDecode(response.body);
6
    return data.map((json) => User.fromJson(json)).toList();
7
  } else {
8
    throw Exception('Failed to load users');
9
  }
10
}
11


12
class UserListScreen extends StatelessWidget {
13
  @override
14
  Widget build(BuildContext context) {
15
    return Scaffold(
16
      appBar: AppBar(title: Text('사용자 목록')),
17
      body: FutureBuilder<List<User>>(
18
        future: fetchUsers(),
19
        builder: (context, snapshot) {
20
          if (snapshot.connectionState == ConnectionState.waiting) {
21
            return Center(child: CircularProgressIndicator());
22
          } else if (snapshot.hasError) {
23
            return Center(child: Text('오류: ${snapshot.error}'));
24
          } else if (snapshot.hasData) {
25
            final users = snapshot.data!;
26
            return ListView.builder(
27
              itemCount: users.length,
28
              itemBuilder: (context, index) {
29
                final user = users[index];
30
                return ListTile(
31
                  title: Text(user.name),
32
                  subtitle: Text(user.email),
33
                );
34
              },
35
            );
36
          } else {
37
            return Center(child: Text('사용자가 없습니다'));
38
          }
39
        },
40
      ),
41
    );
42
  }
43
}
```

## 비동기 관련 모범 사례

[Section titled “비동기 관련 모범 사례”](#비동기-관련-모범-사례)

### 1. 적절한 에러 처리

[Section titled “1. 적절한 에러 처리”](#1-적절한-에러-처리)

항상 try-catch로 비동기 작업의 오류를 처리하거나, Future의 catchError를 사용합니다:

```dart
1
Future<void> loadData() async {
2
  try {
3
    final data = await fetchData();
4
    processData(data);
5
  } catch (e) {
6
    print('데이터 로드 중 오류 발생: $e');
7
    showErrorDialog(e);
8
  }
9
}
```

### 2. 취소 가능한 작업

[Section titled “2. 취소 가능한 작업”](#2-취소-가능한-작업)

오래 실행되는 작업은 취소할 수 있도록 설계합니다:

```dart
1
Future<String> fetchWithTimeout() {
2
  return fetchData().timeout(
3
    Duration(seconds: 5),
4
    onTimeout: () => throw TimeoutException('요청 시간 초과'),
5
  );
6
}
```

### 3. 비동기 자원 해제

[Section titled “3. 비동기 자원 해제”](#3-비동기-자원-해제)

비동기 자원은 사용 후 적절히 해제합니다:

```dart
1
Future<void> processFile() async {
2
  final file = File('data.txt');
3
  final StreamSubscription<String> subscription =
4
      file.openRead()
5
          .transform(utf8.decoder)
6
          .transform(LineSplitter())
7
          .listen(processLine);
8


9
  // 작업 완료 후
10
  await Future.delayed(Duration(seconds: 5));
11
  await subscription.cancel();
12
}
```

### 4. 적절한 UI 피드백

[Section titled “4. 적절한 UI 피드백”](#4-적절한-ui-피드백)

사용자에게 비동기 작업의 상태를 항상 알려줍니다:

```dart
1
Future<void> saveData() async {
2
  // 로딩 표시 시작
3
  setState(() => _isLoading = true);
4


5
  try {
6
    await uploadData();
7
    // 성공 알림
8
    ScaffoldMessenger.of(context).showSnackBar(
9
      SnackBar(content: Text('데이터가 성공적으로 저장되었습니다')),
10
    );
11
  } catch (e) {
12
    // 오류 알림
13
    ScaffoldMessenger.of(context).showSnackBar(
14
      SnackBar(content: Text('저장 실패: $e')),
15
    );
16
  } finally {
17
    // 로딩 표시 종료
18
    setState(() => _isLoading = false);
19
  }
20
}
```

### 5. compute 함수 활용

[Section titled “5. compute 함수 활용”](#5-compute-함수-활용)

CPU를 많이 사용하는 작업은 `compute` 함수를 사용하여 별도의 격리된 환경(isolate)에서 실행합니다:

```dart
1
Future<List<ComplexData>> processLargeDataSet(List<RawData> rawData) {
2
  // 별도의 isolate에서 무거운 처리 실행
3
  return compute(processDataInBackground, rawData);
4
}
5


6
// 다른 isolate에서 실행될 함수 (전역 함수여야 함)
7
List<ComplexData> processDataInBackground(List<RawData> rawData) {
8
  // CPU 집약적인 작업 수행
9
  return rawData.map((raw) => ComplexData.process(raw)).toList();
10
}
```

## 결론

[Section titled “결론”](#결론)

Dart의 비동기 프로그래밍 도구는 Flutter 애플리케이션에서 반응성과 성능을 유지하는 데 필수적입니다. Future, async/await, Stream을 적절히 활용하면 네트워크 요청, 파일 접근, 사용자 이벤트 처리와 같은 작업을 효율적으로 구현할 수 있습니다.

다음 장에서는 Dart의 컬렉션과 반복문에 대해 알아보겠습니다.

# 기본 문법 및 변수

## Dart 프로그램의 구조

[Section titled “Dart 프로그램의 구조”](#dart-프로그램의-구조)

Dart 프로그램은 최상위 함수, 변수, 클래스 등으로 구성됩니다. 모든 Dart 프로그램은 `main()` 함수에서 시작합니다.

```dart
1
// 가장 기본적인 Dart 프로그램
2
void main() {
3
  print('안녕하세요, Dart!');
4
}
```

`main()` 함수는 프로그램의 진입점이며, `void`는 반환 값이 없음을 의미합니다. 커맨드라인에서 인자를 받을 때는 다음과 같이 작성할 수 있습니다.

```dart
1
void main(List<String> arguments) {
2
  print('프로그램 인자: $arguments');
3
}
```

## 주석

[Section titled “주석”](#주석)

Dart에서는 세 가지 유형의 주석을 사용할 수 있습니다.

```dart
1
// 한 줄 주석
2


3
/*
4
  여러 줄 주석
5
  여러 줄에 걸쳐 작성할 수 있습니다.
6
*/
7


8
/// 문서화 주석
9
/// 다트독(dartdoc) 도구가 API 문서를 생성할 때 사용합니다.
10
/// 클래스, 함수, 변수 등의 설명을 작성할 때 유용합니다.
```

## 기본 데이터 타입

[Section titled “기본 데이터 타입”](#기본-데이터-타입)

Dart는 다음과 같은 기본 데이터 타입을 제공합니다:

```dart
1
// 숫자 타입
2
int integerValue = 42;        // 정수
3
double doubleValue = 3.14;    // 실수
4
num numValue = 10;            // int나 double의 상위 타입
5


6
// 문자열 타입
7
String greeting = '안녕하세요';
8


9
// 불리언 타입
10
bool isTrue = true;
11
bool isFalse = false;
12


13
// 리스트 (배열)
14
List<int> numbers = [1, 2, 3, 4, 5];
15


16
// 맵 (key-value 쌍)
17
Map<String, dynamic> person = {
18
  'name': '홍길동',
19
  'age': 30,
20
  'isStudent': false
21
};
22


23
// 집합 (중복 없는 컬렉션)
24
Set<String> uniqueNames = {'홍길동', '김철수', '이영희'};
```

## 변수 선언

[Section titled “변수 선언”](#변수-선언)

Dart에서는 다양한 방법으로 변수를 선언할 수 있습니다.

### var

[Section titled “var”](#var)

타입을 명시적으로 선언하지 않고, 초기값에서 타입을 추론합니다.

```dart
1
var name = '홍길동';    // String으로 추론
2
var age = 30;         // int로 추론
3
var height = 175.5;   // double로 추론
4


5
// 타입이 추론된 후에는 다른 타입의 값을 할당할 수 없습니다.
6
name = '김철수';      // 가능 (String → String)
7
// name = 42;        // 오류 (String → int)
```

### 명시적 타입

[Section titled “명시적 타입”](#명시적-타입)

변수의 타입을 명시적으로 선언합니다.

```dart
1
String name = '홍길동';
2
int age = 30;
3
double height = 175.5;
```

### final과 const

[Section titled “final과 const”](#final과-const)

한 번 할당하면 변경할 수 없는 상수 변수를 선언합니다.

```dart
1
// final: 런타임에 값이 결정되는 상수
2
final String name = '홍길동';
3
final currentTime = DateTime.now();  // 타입 추론 가능
4


5
// const: 컴파일 타임에 값이 결정되는 상수
6
const int maxUsers = 100;
7
const double pi = 3.14159;
8


9
// name = '김철수';    // 오류: final 변수는 재할당 불가
10
// maxUsers = 200;     // 오류: const 변수는 재할당 불가
```

`final`과 `const`의 차이점:

* `final`: 런타임에 값이 결정됩니다. 런타임에 계산되는 값도 가능합니다.
* `const`: 컴파일 타임에 값이 결정됩니다. 컴파일 시점에 알 수 있는 상수값만 가능합니다.

```dart
1
// 런타임 값을 사용하는 예
2
final now = DateTime.now();       // 가능
3
// const today = DateTime.now();  // 오류: 컴파일 시점에 값을 알 수 없음
```

### late

[Section titled “late”](#late)

`late` 키워드는 변수를 나중에 초기화할 것임을 나타냅니다. Null 안전성이 도입된 Dart 2.12 이후에 유용합니다.

```dart
1
late String name;
2


3
void initName() {
4
  name = '홍길동';  // 나중에 값 할당
5
}
6


7
void main() {
8
  initName();
9
  print(name);  // '홍길동'
10


11
  // late 변수는 초기화 전에 접근하면 런타임 오류 발생
12
  late String address;
13
  // print(address);  // 오류: 초기화되지 않은 late 변수에 접근
14
}
```

### 동적 타입 (dynamic)

[Section titled “동적 타입 (dynamic)”](#동적-타입-dynamic)

`dynamic` 타입은 변수의 타입을 런타임까지 확정하지 않습니다. 타입 안전성이 필요하지 않을 때 사용합니다.

```dart
1
dynamic value = '문자열';
2
print(value);  // '문자열'
3


4
value = 42;
5
print(value);  // 42
6


7
value = true;
8
print(value);  // true
```

## 문자열

[Section titled “문자열”](#문자열)

Dart에서는 작은따옴표(`'`) 또는 큰따옴표(`"`)를 사용하여 문자열을 생성할 수 있습니다.

```dart
1
String _single = '작은따옴표 문자열';
2
String _double = "큰따옴표 문자열";
```

### 문자열 보간(Interpolation)

[Section titled “문자열 보간(Interpolation)”](#문자열-보간interpolation)

문자열 내에서 변수나 표현식을 사용할 수 있습니다.

```dart
1
String name = '홍길동';
2
int age = 30;
3


4
// $변수명 형태로 변수 값을 포함할 수 있습니다.
5
String message = '제 이름은 $name이고, 나이는 $age살입니다.';
6


7
// ${표현식} 형태로 표현식 결과를 포함할 수 있습니다.
8
String ageNextYear = '내년에는 ${age + 1}살이 됩니다.';
```

### 여러 줄 문자열

[Section titled “여러 줄 문자열”](#여러-줄-문자열)

여러 줄에 걸친 문자열은 삼중 따옴표(`'''` 또는 `"""`)를 사용합니다.

```dart
1
String multiLine = '''
2
이것은
3
여러 줄에 걸친
4
문자열입니다.
5
''';
6


7
String anotherMultiLine = """
8
이것도
9
여러 줄에 걸친
10
문자열입니다.
11
""";
```

### 원시 문자열 (Raw String)

[Section titled “원시 문자열 (Raw String)”](#원시-문자열-raw-string)

문자열 앞에 `r`을 붙이면 이스케이프 시퀀스를 처리하지 않는 원시 문자열이 됩니다.

```dart
1
String escaped = 'C:\\Program Files\\Dart';  // 이스케이프 시퀀스 사용
2
String raw = r'C:\Program Files\Dart';       // 원시 문자열 (이스케이프 처리 안 함)
```

## 연산자

[Section titled “연산자”](#연산자)

### 산술 연산자

[Section titled “산술 연산자”](#산술-연산자)

```dart
1
int a = 10;
2
int b = 3;
3


4
print(a + b);  // 13 (덧셈)
5
print(a - b);  // 7 (뺄셈)
6
print(a * b);  // 30 (곱셈)
7
print(a / b);  // 3.3333333333333335 (나눗셈, 결과는 double)
8
print(a ~/ b); // 3 (정수 나눗셈, 결과는 int)
9
print(a % b);  // 1 (나머지)
```

### 증감 연산자

[Section titled “증감 연산자”](#증감-연산자)

```dart
1
int a = 10;
2


3
a++;        // 후위 증가 (a = a + 1)
4
++a;        // 전위 증가
5
print(a);   // 12
6


7
a--;        // 후위 감소 (a = a - 1)
8
--a;        // 전위 감소
9
print(a);   // 10
```

### 할당 연산자

[Section titled “할당 연산자”](#할당-연산자)

```dart
1
int a = 10;
2


3
a += 5;      // a = a + 5
4
print(a);    // 15
5


6
a -= 3;      // a = a - 3
7
print(a);    // 12
8


9
a *= 2;      // a = a * 2
10
print(a);    // 24
11


12
a ~/= 5;     // a = a ~/ 5
13
print(a);    // 4
```

### 비교 연산자

[Section titled “비교 연산자”](#비교-연산자)

```dart
1
int a = 10;
2
int b = 5;
3


4
print(a == b);   // false (같음)
5
print(a != b);   // true (다름)
6
print(a > b);    // true (초과)
7
print(a < b);    // false (미만)
8
print(a >= b);   // true (이상)
9
print(a <= b);   // false (이하)
```

### 논리 연산자

[Section titled “논리 연산자”](#논리-연산자)

```dart
1
bool condition1 = true;
2
bool condition2 = false;
3


4
print(condition1 && condition2);  // false (AND)
5
print(condition1 || condition2);  // true (OR)
6
print(!condition1);              // false (NOT)
```

### 타입 테스트 연산자

[Section titled “타입 테스트 연산자”](#타입-테스트-연산자)

```dart
1
var value = '문자열';
2


3
print(value is String);       // true (value가 String 타입인지 확인)
4
print(value is! int);         // true (value가 int 타입이 아닌지 확인)
5


6
// as 연산자는 타입 변환에 사용됩니다.
7
dynamic someValue = 'Dart';
8
String text = someValue as String;
```

### 조건 연산자

[Section titled “조건 연산자”](#조건-연산자)

```dart
1
// 조건 ? 값1 : 값2
2
int a = 10;
3
int b = 5;
4
int max = a > b ? a : b;  // a가 b보다 크면 a, 아니면 b
5
print(max);  // 10
6


7
// ?? 연산자: 왼쪽 피연산자가 null이면 오른쪽 피연산자 반환
8
String? name;
9
String displayName = name ?? '이름 없음';
10
print(displayName);  // '이름 없음'
```

### 캐스케이드 연산자 (..)

[Section titled “캐스케이드 연산자 (..)”](#캐스케이드-연산자)

객체에 대해 연속적인 작업을 수행할 수 있는 캐스케이드 연산자입니다.

```dart
1
class Person {
2
  String name = '';
3
  int age = 0;
4


5
  void introduce() {
6
    print('내 이름은 $name이고, 나이는 $age살입니다.');
7
  }
8
}
9


10
void main() {
11
  var person = Person()
12
    ..name = '홍길동'
13
    ..age = 30
14
    ..introduce();
15


16
  // 위 코드는 다음과 동일합니다:
17
  // var person = Person();
18
  // person.name = '홍길동';
19
  // person.age = 30;
20
  // person.introduce();
21
}
```

## null 안전성

[Section titled “null 안전성”](#null-안전성)

Dart 2.12부터 도입된 null 안전성을 활용하면 null 참조 오류를 컴파일 타임에 방지할 수 있습니다.

### nullable과 non-nullable 타입

[Section titled “nullable과 non-nullable 타입”](#nullable과-non-nullable-타입)

```dart
1
// non-nullable 타입 (null을 할당할 수 없음)
2
String name = '홍길동';
3
// name = null;  // 컴파일 오류
4


5
// nullable 타입 (null을 할당할 수 있음)
6
String? nullableName = '홍길동';
7
nullableName = null;  // 허용됨
```

### null 검사와 null 조건 접근

[Section titled “null 검사와 null 조건 접근”](#null-검사와-null-조건-접근)

```dart
1
String? name = getNullableName();
2


3
// null 검사 후 사용
4
if (name != null) {
5
  print('이름의 길이: ${name.length}');
6
}
7


8
// 조건 프로퍼티 접근 (?.): 객체가 null이면 전체 표현식이 null이 됨
9
print('이름의 길이: ${name?.length}');
10


11
// null 병합 연산자 (??): 왼쪽 피연산자가 null이면 오른쪽 피연산자 반환
12
print('이름: ${name ?? '이름 없음'}');
13


14
// null 정의 연산자 (??=): 변수가 null이면 값을 할당
15
name ??= '이름 없음';
```

### Non-null 단언 연산자 (!)

[Section titled “Non-null 단언 연산자 (!)”](#non-null-단언-연산자)

변수가 null이 아님을 컴파일러에게 알려주는 연산자입니다. 변수가 실제로 null이면 런타임 오류가 발생합니다.

```dart
1
String? name = '홍길동';
2


3
// name이 null이 아니라고 확신할 때 사용
4
String nonNullName = name!;
5


6
// 그러나 실제로 null이면 런타임 오류 발생
7
name = null;
8
// String error = name!;  // 런타임 오류: null 참조
```

## 결론

[Section titled “결론”](#결론)

이 장에서는 Dart의 기본 문법과 변수 선언, 데이터 타입, 연산자, null 안전성 등에 대해 알아보았습니다. 이러한 기본 개념은 Dart 프로그래밍의 토대가 되며, Flutter를 활용한 앱 개발에도 필수적입니다.

다음 장에서는 Dart의 타입 시스템과 제네릭에 대해 더 자세히 알아보겠습니다.

# 클래스, 생성자, 팩토리

## 클래스 기본

[Section titled “클래스 기본”](#클래스-기본)

Dart는 완전한 객체 지향 언어로, 클래스와 객체 개념을 중심으로 설계되었습니다. Dart에서 모든 것이 객체이며, 모든 객체는 클래스의 인스턴스입니다.

### 클래스 정의하기

[Section titled “클래스 정의하기”](#클래스-정의하기)

```dart
1
class Person {
2
  // 필드(속성)
3
  String name;
4
  int age;
5


6
  // 생성자
7
  Person(this.name, this.age);
8


9
  // 메서드
10
  void introduce() {
11
    print('안녕하세요, 저는 $name이고 $age살입니다.');
12
  }
13


14
  // 게터(Getter)
15
  bool get isAdult => age >= 18;
16


17
  // 세터(Setter)
18
  set setAge(int newAge) {
19
    if (newAge >= 0) {
20
      age = newAge;
21
    }
22
  }
23
}
24


25
// 클래스 사용 예시
26
void main() {
27
  final person = Person('홍길동', 30);
28
  person.introduce();  // 안녕하세요, 저는 홍길동이고 30살입니다.
29


30
  print('성인 여부: ${person.isAdult}');  // 성인 여부: true
31


32
  person.setAge = 25;
33
  print('변경된 나이: ${person.age}');  // 변경된 나이: 25
34
}
```

### private 멤버

[Section titled “private 멤버”](#private-멤버)

Dart에서는 식별자 앞에 밑줄(`_`)을 붙여 라이브러리 수준에서 private 멤버를 정의합니다. private 멤버는 클래스가 정의된 파일 외부에서 접근할 수 없습니다.

```dart
1
// person.dart 파일
2
class Person {
3
  String name;
4
  int _age;  // private 필드
5


6
  Person(this.name, this._age);
7


8
  void introduce() {
9
    print('안녕하세요, 저는 $name이고 $_age살입니다.');
10
  }
11


12
  int get age => _age;  // private 필드에 접근하는 public 게터
13


14
  void _privateMethod() {  // private 메서드
15
    print('이 메서드는 클래스 내부에서만 호출할 수 있습니다.');
16
  }
17


18
  void publicMethod() {
19
    _privateMethod();  // private 메서드 호출
20
  }
21
}
22


23
// main.dart 파일
24
import 'person.dart';
25


26
void main() {
27
  final person = Person('홍길동', 30);
28
  print(person.name);  // 홍길동
29
  print(person.age);   // 30
30


31
  // 다음 코드는 컴파일 오류 발생
32
  // print(person._age);           // 오류: '_age' is not defined
33
  // person._privateMethod();      // 오류: '_privateMethod' is not defined
34


35
  person.publicMethod();  // OK: 클래스 내부에서 private 메서드 호출
36
}
```

## 생성자

[Section titled “생성자”](#생성자)

Dart에서는 다양한 방식으로 생성자를 정의할 수 있습니다.

### 기본 생성자

[Section titled “기본 생성자”](#기본-생성자)

```dart
1
class Person {
2
  String name;
3
  int age;
4


5
  // 기본 생성자
6
  Person(this.name, this.age);
7
}
```

### 이름이 있는 생성자

[Section titled “이름이 있는 생성자”](#이름이-있는-생성자)

한 클래스에 여러 생성자를 정의하고 싶을 때 이름이 있는 생성자를 사용합니다:

```dart
1
class Person {
2
  String name;
3
  int age;
4


5
  // 기본 생성자
6
  Person(this.name, this.age);
7


8
  // 이름이 있는 생성자
9
  Person.guest() {
10
    name = '손님';
11
    age = 0;
12
  }
13


14
  Person.child(this.name) {
15
    age = 10;
16
  }
17


18
  Person.adult(this.name) {
19
    age = 18;
20
  }
21
}
22


23
void main() {
24
  final person1 = Person('홍길동', 30);
25
  final person2 = Person.guest();
26
  final person3 = Person.child('아이');
27
  final person4 = Person.adult('성인');
28


29
  print('${person1.name}, ${person1.age}');  // 홍길동, 30
30
  print('${person2.name}, ${person2.age}');  // 손님, 0
31
  print('${person3.name}, ${person3.age}');  // 아이, 10
32
  print('${person4.name}, ${person4.age}');  // 성인, 18
33
}
```

### 초기화 리스트

[Section titled “초기화 리스트”](#초기화-리스트)

생성자 본문이 실행되기 전에 인스턴스 변수를 초기화해야 할 때 초기화 리스트를 사용합니다:

```dart
1
class Person {
2
  String name;
3
  int age;
4
  final DateTime birthDate;
5


6
  // 초기화 리스트 사용
7
  Person(this.name, this.age)
8
      : birthDate = DateTime.now().subtract(Duration(days: 365 * age));
9


10
  // 여러 필드 초기화
11
  Person.custom(String userName, int userAge)
12
      : name = userName.toUpperCase(),
13
        age = userAge > 0 ? userAge : 0,
14
        birthDate = DateTime.now().subtract(Duration(days: 365 * userAge));
15
}
```

### 상수 생성자

[Section titled “상수 생성자”](#상수-생성자)

인스턴스가 변경 불가능한 객체일 때 상수 생성자를 사용합니다:

```dart
1
class ImmutablePoint {
2
  final int x;
3
  final int y;
4


5
  // 상수 생성자
6
  const ImmutablePoint(this.x, this.y);
7
}
8


9
void main() {
10
  // 동일한 인스턴스를 참조
11
  var point1 = const ImmutablePoint(1, 2);
12
  var point2 = const ImmutablePoint(1, 2);
13


14
  print(identical(point1, point2));  // true: 같은 인스턴스
15


16
  // 다른 인스턴스
17
  var point3 = ImmutablePoint(1, 2);  // const 없이 생성
18
  var point4 = ImmutablePoint(1, 2);
19


20
  print(identical(point3, point4));  // false: 다른 인스턴스
21
}
```

### 리다이렉팅 생성자

[Section titled “리다이렉팅 생성자”](#리다이렉팅-생성자)

한 생성자에서 같은 클래스의 다른 생성자를 호출할 때 리다이렉팅 생성자를 사용합니다:

```dart
1
class Person {
2
  String name;
3
  int age;
4


5
  // 주 생성자
6
  Person(this.name, this.age);
7


8
  // 리다이렉팅 생성자
9
  Person.adult(String name) : this(name, 18);
10


11
  Person.child(String name) : this(name, 10);
12


13
  Person.fromJson(Map<String, dynamic> json)
14
      : this(json['name'] as String, json['age'] as int);
15
}
16


17
void main() {
18
  final person1 = Person.adult('홍길동');
19
  print('${person1.name}, ${person1.age}');  // 홍길동, 18
20


21
  final person2 = Person.fromJson({'name': '김철수', 'age': 25});
22
  print('${person2.name}, ${person2.age}');  // 김철수, 25
23
}
```

## 팩토리 생성자

[Section titled “팩토리 생성자”](#팩토리-생성자)

팩토리 생성자는 매번 새 인스턴스를 생성하지 않아도 되는 생성자입니다. 캐싱, 인스턴스 재사용, 하위 클래스 인스턴스 반환 등의 경우에 유용합니다.

```dart
1
class Logger {
2
  final String name;
3


4
  // 로거 인스턴스 캐시
5
  static final Map<String, Logger> _cache = <String, Logger>{};
6


7
  // private 생성자
8
  Logger._internal(this.name);
9


10
  // 팩토리 생성자
11
  factory Logger(String name) {
12
    // 캐시에 이미 있으면 기존 인스턴스 반환
13
    return _cache.putIfAbsent(
14
      name,
15
      () => Logger._internal(name),
16
    );
17
  }
18


19
  void log(String message) {
20
    print('[$name] $message');
21
  }
22
}
23


24
void main() {
25
  final logger1 = Logger('UI');
26
  final logger2 = Logger('API');
27
  final logger3 = Logger('UI');  // 캐시된 인스턴스 재사용
28


29
  print(identical(logger1, logger3));  // true: 같은 인스턴스
30
  print(identical(logger1, logger2));  // false: 다른 인스턴스
31


32
  logger1.log('버튼 클릭됨');  // [UI] 버튼 클릭됨
33
  logger2.log('데이터 로드 중');  // [API] 데이터 로드 중
34
}
```

### 하위 클래스 인스턴스 반환

[Section titled “하위 클래스 인스턴스 반환”](#하위-클래스-인스턴스-반환)

팩토리 생성자를 사용하여 조건에 따라 하위 클래스의 인스턴스를 반환할 수 있습니다:

```dart
1
abstract class Shape {
2
  // 팩토리 생성자
3
  factory Shape(String type) {
4
    switch (type) {
5
      case 'circle':
6
        return Circle(10);
7
      case 'rectangle':
8
        return Rectangle(10, 20);
9
      default:
10
        throw ArgumentError('지원하지 않는 도형 타입: $type');
11
    }
12
  }
13


14
  double get area;
15
}
16


17
class Circle implements Shape {
18
  final double radius;
19


20
  Circle(this.radius);
21


22
  @override
23
  double get area => 3.14 * radius * radius;
24
}
25


26
class Rectangle implements Shape {
27
  final double width;
28
  final double height;
29


30
  Rectangle(this.width, this.height);
31


32
  @override
33
  double get area => width * height;
34
}
35


36
void main() {
37
  final circle = Shape('circle');
38
  final rectangle = Shape('rectangle');
39


40
  print('원 면적: ${circle.area}');  // 원 면적: 314.0
41
  print('사각형 면적: ${rectangle.area}');  // 사각형 면적: 200.0
42
}
```

### fromJson 팩토리 생성자

[Section titled “fromJson 팩토리 생성자”](#fromjson-팩토리-생성자)

JSON 데이터로부터 객체를 생성하는 패턴은 매우 일반적입니다:

```dart
1
class User {
2
  final String name;
3
  final int age;
4
  final String email;
5


6
  User(this.name, this.age, this.email);
7


8
  // JSON에서 User 객체 생성
9
  factory User.fromJson(Map<String, dynamic> json) {
10
    return User(
11
      json['name'] as String,
12
      json['age'] as int,
13
      json['email'] as String,
14
    );
15
  }
16


17
  // User 객체를 JSON으로 변환
18
  Map<String, dynamic> toJson() {
19
    return {
20
      'name': name,
21
      'age': age,
22
      'email': email,
23
    };
24
  }
25
}
26


27
void main() {
28
  final jsonData = {
29
    'name': '홍길동',
30
    'age': 30,
31
    'email': 'hong@example.com',
32
  };
33


34
  final user = User.fromJson(jsonData);
35
  print('${user.name}, ${user.age}, ${user.email}');  // 홍길동, 30, hong@example.com
36


37
  final json = user.toJson();
38
  print(json);  // {name: 홍길동, age: 30, email: hong@example.com}
39
}
```

## 정적 멤버

[Section titled “정적 멤버”](#정적-멤버)

클래스의 특정 인스턴스가 아닌 클래스 자체에 속하는 멤버를 정의할 때 `static` 키워드를 사용합니다.

```dart
1
class MathUtils {
2
  // 정적 상수
3
  static const double PI = 3.14159;
4


5
  // 정적 변수
6
  static int calculationCount = 0;
7


8
  // 정적 메서드
9
  static double square(double num) {
10
    calculationCount++;
11
    return num * num;
12
  }
13


14
  static double cube(double num) {
15
    calculationCount++;
16
    return num * num * num;
17
  }
18
}
19


20
void main() {
21
  print('원주율: ${MathUtils.PI}');  // 원주율: 3.14159
22


23
  final sq = MathUtils.square(5);
24
  print('5의 제곱: $sq');  // 5의 제곱: 25.0
25


26
  final cb = MathUtils.cube(3);
27
  print('3의 세제곱: $cb');  // 3의 세제곱: 27.0
28


29
  print('계산 횟수: ${MathUtils.calculationCount}');  // 계산 횟수: 2
30
}
```

정적 멤버는 인스턴스를 생성하지 않고도 접근할 수 있으며, 클래스의 모든 인스턴스가 공유합니다.

## 추상 클래스와 인터페이스

[Section titled “추상 클래스와 인터페이스”](#추상-클래스와-인터페이스)

### 추상 클래스

[Section titled “추상 클래스”](#추상-클래스)

추상 클래스는 직접 인스턴스화할 수 없으며, 다른 클래스가 구현해야 하는 메서드와 프로퍼티를 정의합니다.

```dart
1
abstract class Animal {
2
  String name;
3


4
  Animal(this.name);
5


6
  // 추상 메서드 (구현 없음)
7
  void makeSound();
8


9
  // 구현된 메서드
10
  void sleep() {
11
    print('$name is sleeping');
12
  }
13
}
14


15
class Dog extends Animal {
16
  Dog(String name) : super(name);
17


18
  // 추상 메서드 구현
19
  @override
20
  void makeSound() {
21
    print('$name says Woof!');
22
  }
23
}
24


25
class Cat extends Animal {
26
  Cat(String name) : super(name);
27


28
  @override
29
  void makeSound() {
30
    print('$name says Meow!');
31
  }
32
}
33


34
void main() {
35
  // Animal animal = Animal('Generic');  // 오류: 추상 클래스는 인스턴스화할 수 없음
36


37
  final dog = Dog('Bobby');
38
  dog.makeSound();  // Bobby says Woof!
39
  dog.sleep();      // Bobby is sleeping
40


41
  final cat = Cat('Whiskers');
42
  cat.makeSound();  // Whiskers says Meow!
43
  cat.sleep();      // Whiskers is sleeping
44
}
```

### 인터페이스

[Section titled “인터페이스”](#인터페이스)

Dart에는 별도의 `interface` 키워드가 없습니다. 모든 클래스가 암묵적으로 인터페이스 역할을 할 수 있습니다. 클래스를 인터페이스로 구현하려면 `implements` 키워드를 사용합니다.

```dart
1
// 인터페이스 역할을 하는 클래스
2
class Vehicle {
3
  void move() {
4
    print('Vehicle is moving');
5
  }
6


7
  void stop() {
8
    print('Vehicle stopped');
9
  }
10
}
11


12
// Vehicle 인터페이스 구현
13
class Car implements Vehicle {
14
  @override
15
  void move() {
16
    print('Car is driving');
17
  }
18


19
  @override
20
  void stop() {
21
    print('Car stopped');
22
  }
23
}
24


25
class Airplane implements Vehicle {
26
  @override
27
  void move() {
28
    print('Airplane is flying');
29
  }
30


31
  @override
32
  void stop() {
33
    print('Airplane landed');
34
  }
35
}
36


37
void main() {
38
  final car = Car();
39
  car.move();  // Car is driving
40
  car.stop();  // Car stopped
41


42
  final airplane = Airplane();
43
  airplane.move();  // Airplane is flying
44
  airplane.stop();  // Airplane landed
45


46
  // 다형성: Vehicle 인터페이스를 구현한 객체는 Vehicle 타입 변수에 할당 가능
47
  Vehicle vehicle = Car();
48
  vehicle.move();  // Car is driving
49
}
```

## 상속

[Section titled “상속”](#상속)

Dart에서는 `extends` 키워드를 사용하여 클래스를 상속받습니다. Dart는 단일 상속만 지원합니다.

```dart
1
class Person {
2
  String name;
3
  int age;
4


5
  Person(this.name, this.age);
6


7
  void introduce() {
8
    print('안녕하세요, 저는 $name이고 $age살입니다.');
9
  }
10
}
11


12
class Student extends Person {
13
  String school;
14


15
  // 상위 클래스 생성자 호출
16
  Student(String name, int age, this.school) : super(name, age);
17


18
  // 메서드 오버라이드
19
  @override
20
  void introduce() {
21
    super.introduce();  // 상위 클래스 메서드 호출
22
    print('저는 $school에 다니고 있습니다.');
23
  }
24


25
  // 새로운 메서드 추가
26
  void study() {
27
    print('$name이(가) 공부하고 있습니다.');
28
  }
29
}
30


31
void main() {
32
  final person = Person('홍길동', 30);
33
  person.introduce();  // 안녕하세요, 저는 홍길동이고 30살입니다.
34


35
  final student = Student('김철수', 20, '서울대학교');
36
  student.introduce();  // 안녕하세요, 저는 김철수이고 20살입니다.
37
                        // 저는 서울대학교에 다니고 있습니다.
38
  student.study();      // 김철수이(가) 공부하고 있습니다.
39
}
```

## 믹스인(Mixin)

[Section titled “믹스인(Mixin)”](#믹스인mixin)

믹스인은 클래스 간에 코드를 재사용하는 방법을 제공합니다. `with` 키워드를 사용하여 믹스인의 기능을 클래스에 추가할 수 있습니다.

```dart
1
// 믹스인 정의
2
mixin Swimming {
3
  void swim() {
4
    print('수영하고 있습니다.');
5
  }
6
}
7


8
mixin Flying {
9
  void fly() {
10
    print('날고 있습니다.');
11
  }
12
}
13


14
// 믹스인 사용
15
class Animal {
16
  String name;
17


18
  Animal(this.name);
19


20
  void eat() {
21
    print('$name이(가) 먹고 있습니다.');
22
  }
23
}
24


25
class Bird extends Animal with Flying {
26
  Bird(String name) : super(name);
27
}
28


29
class Fish extends Animal with Swimming {
30
  Fish(String name) : super(name);
31
}
32


33
class Duck extends Animal with Swimming, Flying {
34
  Duck(String name) : super(name);
35
}
36


37
void main() {
38
  final bird = Bird('참새');
39
  bird.eat();   // 참새이(가) 먹고 있습니다.
40
  bird.fly();   // 날고 있습니다.
41


42
  final fish = Fish('금붕어');
43
  fish.eat();   // 금붕어이(가) 먹고 있습니다.
44
  fish.swim();  // 수영하고 있습니다.
45


46
  final duck = Duck('오리');
47
  duck.eat();   // 오리이(가) 먹고 있습니다.
48
  duck.swim();  // 수영하고 있습니다.
49
  duck.fly();   // 날고 있습니다.
50
}
```

믹스인 제한:

```dart
1
// on 키워드로 믹스인을 특정 클래스에만 사용하도록 제한
2
mixin CanFly on Bird {
3
  void fly() {
4
    print('새처럼 날고 있습니다.');
5
  }
6
}
7


8
class Bird {
9
  String name;
10
  Bird(this.name);
11
}
12


13
class Eagle extends Bird with CanFly {
14
  Eagle(String name) : super(name);
15
}
16


17
// 다음 코드는 컴파일 오류 발생
18
// class Airplane with CanFly { }  // 오류: 'on Bird'로 제한됨
```

## 생성자 초기화 패턴

[Section titled “생성자 초기화 패턴”](#생성자-초기화-패턴)

### 기본값과 명명된 매개변수

[Section titled “기본값과 명명된 매개변수”](#기본값과-명명된-매개변수)

```dart
1
class Person {
2
  String name;
3
  int age;
4
  String? address;  // nullable 필드
5


6
  // 명명된 매개변수와 기본값
7
  Person({
8
    required this.name,
9
    required this.age,
10
    this.address,
11
  });
12
}
13


14
void main() {
15
  final person1 = Person(name: '홍길동', age: 30);
16
  final person2 = Person(name: '김철수', age: 25, address: '서울시');
17
}
```

### 초기화 간소화

[Section titled “초기화 간소화”](#초기화-간소화)

```dart
1
class Point {
2
  final int x;
3
  final int y;
4


5
  // 간결한 생성자 문법
6
  const Point(this.x, this.y);
7


8
  // 명명된 매개변수
9
  const Point.origin()
10
      : x = 0,
11
        y = 0;
12
}
```

## 연산자 오버로딩

[Section titled “연산자 오버로딩”](#연산자-오버로딩)

클래스에 대한 연산자 동작을 재정의할 수 있습니다:

```dart
1
class Vector {
2
  final double x;
3
  final double y;
4


5
  const Vector(this.x, this.y);
6


7
  // 덧셈 연산자 오버로딩
8
  Vector operator +(Vector other) {
9
    return Vector(x + other.x, y + other.y);
10
  }
11


12
  // 뺄셈 연산자 오버로딩
13
  Vector operator -(Vector other) {
14
    return Vector(x - other.x, y - other.y);
15
  }
16


17
  // 비교 연산자 오버로딩
18
  @override
19
  bool operator ==(Object other) {
20
    if (identical(this, other)) return true;
21
    return other is Vector &&
22
           other.x == x &&
23
           other.y == y;
24
  }
25


26
  // hashCode 오버라이드 (== 연산자를 오버라이드할 때 항상 필요)
27
  @override
28
  int get hashCode => x.hashCode ^ y.hashCode;
29


30
  @override
31
  String toString() => 'Vector($x, $y)';
32
}
33


34
void main() {
35
  final v1 = Vector(1, 2);
36
  final v2 = Vector(3, 4);
37


38
  final sum = v1 + v2;
39
  print(sum);  // Vector(4.0, 6.0)
40


41
  final diff = v2 - v1;
42
  print(diff);  // Vector(2.0, 2.0)
43


44
  print(v1 == Vector(1, 2));  // true
45
  print(v1 == v2);            // false
46
}
```

## 결론

[Section titled “결론”](#결론)

Dart의 클래스 시스템은 강력하고 유연합니다. 생성자와 팩토리를 통해 다양한 객체 생성 패턴을 구현할 수 있으며, 상속, 믹스인, 인터페이스 구현을 통해 코드 재사용과 다형성을 달성할 수 있습니다.

이러한 객체 지향 기능을 잘 활용하면 유지 보수하기 쉽고 확장 가능한 코드를 작성할 수 있습니다. 다음 장에서는 Dart의 비동기 프로그래밍에 대해 알아보겠습니다.

# 컬렉션과 반복문

Dart는 데이터를 저장하고 조작하기 위한 다양한 컬렉션 타입과 반복문을 제공합니다. 이 장에서는 Dart의 컬렉션 타입(List, Set, Map)과 이를 처리하기 위한 다양한 반복문 및 반복 연산을 알아보겠습니다.

Tip

아래 내용 외에 컬렉션 타입을 조작하는 일이 잦은 경우 [collection](https://pub.dev/packages/collection) 패키지를 사용하세요.

```sh
1
dart pub add collection
```

## 컬렉션 타입

[Section titled “컬렉션 타입”](#컬렉션-타입)

### 1. List (리스트)

[Section titled “1. List (리스트)”](#1-list-리스트)

List는 순서가 있는 항목의 집합으로, 다른 언어의 배열과 유사합니다.

#### 리스트 생성

[Section titled “리스트 생성”](#리스트-생성)

```dart
1
// 리터럴을 사용한 생성
2
var fruits = ['사과', '바나나', '오렌지'];
3


4
// 타입을 지정한 리스트
5
List<String> names = ['홍길동', '김철수', '이영희'];
6


7
// 빈 리스트 생성
8
var emptyList = <int>[];
9


10
// 생성자를 이용한 리스트 생성
11
var fixedList = List<int>.filled(5, 0); // [0, 0, 0, 0, 0]
12
var growableList = List<int>.empty(growable: true);
13
var generatedList = List<int>.generate(5, (i) => i * i); // [0, 1, 4, 9, 16]
```

#### 리스트 접근 및 조작

[Section titled “리스트 접근 및 조작”](#리스트-접근-및-조작)

```dart
1
var fruits = ['사과', '바나나', '오렌지', '딸기', '포도'];
2


3
// 인덱스로 접근
4
print(fruits[0]); // 사과
5


6
// 길이 확인
7
print(fruits.length); // 5
8


9
// 첫 번째와 마지막 항목
10
print(fruits.first); // 사과
11
print(fruits.last); // 포도
12


13
// 추가
14
fruits.add('키위');
15
print(fruits); // [사과, 바나나, 오렌지, 딸기, 포도, 키위]
16


17
// 여러 항목 추가
18
fruits.addAll(['멜론', '수박']);
19
print(fruits); // [사과, 바나나, 오렌지, 딸기, 포도, 키위, 멜론, 수박]
20


21
// 삭제
22
fruits.remove('바나나');
23
print(fruits); // [사과, 오렌지, 딸기, 포도, 키위, 멜론, 수박]
24


25
// 인덱스로 삭제
26
fruits.removeAt(1);
27
print(fruits); // [사과, 딸기, 포도, 키위, 멜론, 수박]
28


29
// 조건으로 삭제
30
fruits.removeWhere((fruit) => fruit.length <= 2);
31
print(fruits); // [사과, 딸기, 포도, 키위, 멜론, 수박]
32


33
// 정렬
34
fruits.sort();
35
print(fruits); // [딸기, 멜론, 사과, 수박, 포도, 키위]
36


37
// 인덱스 찾기
38
print(fruits.indexOf('포도')); // 4
39


40
// 존재 여부 확인
41
print(fruits.contains('사과')); // true
42
print(fruits.contains('바나나')); // false
```

#### 리스트 변환

[Section titled “리스트 변환”](#리스트-변환)

```dart
1
var numbers = [1, 2, 3, 4, 5];
2


3
// 매핑 (각 요소 변환)
4
var doubled = numbers.map((n) => n * 2).toList();
5
print(doubled); // [2, 4, 6, 8, 10]
6


7
// 필터링 (조건에 맞는 요소만 선택)
8
var evenNumbers = numbers.where((n) => n.isEven).toList();
9
print(evenNumbers); // [2, 4]
10


11
// fold (누적 연산)
12
var sum = numbers.fold<int>(0, (prev, curr) => prev + curr);
13
print(sum); // 15
14


15
// reduce (항목들을 하나로 결합)
16
var product = numbers.reduce((a, b) => a * b);
17
print(product); // 120
18


19
// 평탄화 (중첩 리스트를 단일 리스트로)
20
var nested = [[1, 2], [3, 4], [5]];
21
var flattened = nested.expand((list) => list).toList();
22
print(flattened); // [1, 2, 3, 4, 5]
```

#### 리스트 슬라이싱과 세부 조작

[Section titled “리스트 슬라이싱과 세부 조작”](#리스트-슬라이싱과-세부-조작)

```dart
1
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
2


3
// 범위 추출 (sublist)
4
var slice = numbers.sublist(2, 5);
5
print(slice); // [3, 4, 5]
6


7
// 리스트 복사
8
var copy = List<int>.from(numbers);
9
print(copy); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
10


11
// 모든 요소 바꾸기
12
numbers.replaceRange(0, 3, [99, 98, 97]);
13
print(numbers); // [99, 98, 97, 4, 5, 6, 7, 8, 9, 10]
14


15
// 뒤집기
16
var reversed = numbers.reversed.toList();
17
print(reversed); // [10, 9, 8, 7, 6, 5, 4, 97, 98, 99]
18


19
// 리스트의 특정 부분 채우기
20
numbers.fillRange(5, 8, 0);
21
print(numbers); // [99, 98, 97, 4, 5, 0, 0, 0, 9, 10]
```

### 2. Set (집합)

[Section titled “2. Set (집합)”](#2-set-집합)

Set은 중복되지 않는 항목의 컬렉션입니다.

#### 집합 생성

[Section titled “집합 생성”](#집합-생성)

```dart
1
// 리터럴을 사용한 생성
2
var fruits = {'사과', '바나나', '오렌지'};
3


4
// 타입을 지정한 집합
5
Set<String> names = {'홍길동', '김철수', '이영희'};
6


7
// 빈 집합 생성
8
var emptySet = <int>{};
9


10
// 리스트에서 생성 (중복 제거됨)
11
var numbers = Set<int>.from([1, 2, 2, 3, 3, 3, 4, 5, 5]);
12
print(numbers); // {1, 2, 3, 4, 5}
```

#### 집합 연산

[Section titled “집합 연산”](#집합-연산)

```dart
1
var set1 = {1, 2, 3, 4, 5};
2
var set2 = {4, 5, 6, 7, 8};
3


4
// 합집합
5
var union = set1.union(set2);
6
print(union); // {1, 2, 3, 4, 5, 6, 7, 8}
7


8
// 교집합
9
var intersection = set1.intersection(set2);
10
print(intersection); // {4, 5}
11


12
// 차집합
13
var difference = set1.difference(set2);
14
print(difference); // {1, 2, 3}
15


16
// 요소 추가
17
set1.add(6);
18
print(set1); // {1, 2, 3, 4, 5, 6}
19


20
// 여러 요소 추가
21
set1.addAll({7, 8, 9});
22
print(set1); // {1, 2, 3, 4, 5, 6, 7, 8, 9}
23


24
// 요소 삭제
25
set1.remove(9);
26
print(set1); // {1, 2, 3, 4, 5, 6, 7, 8}
27


28
// 존재 여부 확인
29
print(set1.contains(5)); // true
30
print(set1.contains(10)); // false
31


32
// 부분집합 확인
33
print({1, 2}.isSubsetOf(set1)); // true
34
print(set1.isSupersetOf({1, 2})); // true
```

#### 집합 변환 및 조작

[Section titled “집합 변환 및 조작”](#집합-변환-및-조작)

```dart
1
var numbers = {1, 2, 3, 4, 5};
2


3
// 매핑 (집합으로 변환)
4
var doubled = numbers.map((n) => n * 2).toSet();
5
print(doubled); // {2, 4, 6, 8, 10}
6


7
// 필터링
8
var evenNumbers = numbers.where((n) => n.isEven).toSet();
9
print(evenNumbers); // {2, 4}
10


11
// 리스트로 변환
12
var numbersList = numbers.toList();
13
print(numbersList); // [1, 2, 3, 4, 5] (순서는 보장되지 않음)
```

### 3. Map (맵)

[Section titled “3. Map (맵)”](#3-map-맵)

Map은 키-값 쌍의 컬렉션으로, 키를 사용하여 값을 검색할 수 있습니다.

#### 맵 생성

[Section titled “맵 생성”](#맵-생성)

```dart
1
// 리터럴을 사용한 생성
2
var person = {
3
  'name': '홍길동',
4
  'age': 30,
5
  'isStudent': false
6
};
7


8
// 타입을 지정한 맵
9
Map<String, int> scores = {
10
  '수학': 90,
11
  '영어': 85,
12
  '과학': 95
13
};
14


15
// 빈 맵 생성
16
var emptyMap = <String, dynamic>{};
17


18
// 생성자를 이용한 맵 생성
19
var map1 = Map<String, int>();
20
var map2 = Map.from({'a': 1, 'b': 2});
21
var map3 = Map.of({'x': 10, 'y': 20});
```

#### 맵 접근 및 조작

[Section titled “맵 접근 및 조작”](#맵-접근-및-조작)

```dart
1
var person = {
2
  'name': '홍길동',
3
  'age': 30,
4
  'isStudent': false
5
};
6


7
// 값 접근
8
print(person['name']); // 홍길동
9


10
// 키 확인
11
print(person.containsKey('age')); // true
12
print(person.containsKey('email')); // false
13


14
// 값 확인
15
print(person.containsValue(30)); // true
16
print(person.containsValue('김철수')); // false
17


18
// 키 목록과 값 목록
19
print(person.keys.toList()); // [name, age, isStudent]
20
print(person.values.toList()); // [홍길동, 30, false]
21


22
// 항목 추가/업데이트
23
person['email'] = 'hong@example.com';
24
person['age'] = 31;
25
print(person); // {name: 홍길동, age: 31, isStudent: false, email: hong@example.com}
26


27
// 항목 삭제
28
person.remove('isStudent');
29
print(person); // {name: 홍길동, age: 31, email: hong@example.com}
30


31
// 여러 항목 추가
32
person.addAll({
33
  'address': '서울시',
34
  'phone': '010-1234-5678'
35
});
36
print(person);
37
// {name: 홍길동, age: 31, email: hong@example.com, address: 서울시, phone: 010-1234-5678}
38


39
// 조건부 추가
40
person.putIfAbsent('gender', () => '남성');
41
print(person);
42
// {name: 홍길동, age: 31, email: hong@example.com, address: 서울시, phone: 010-1234-5678, gender: 남성}
43


44
// 이미 있는 키에는 추가되지 않음
45
person.putIfAbsent('gender', () => '여성');
46
print(person['gender']); // 남성 (변경되지 않음)
```

#### 맵 변환 및 조작

[Section titled “맵 변환 및 조작”](#맵-변환-및-조작)

```dart
1
var scores = {
2
  '수학': 90,
3
  '영어': 85,
4
  '과학': 95,
5
  '국어': 80
6
};
7


8
// 매핑 변환
9
var scaledScores = scores.map((k, v) => MapEntry(k, v * 1.1));
10
print(scaledScores);
11
// {수학: 99.0, 영어: 93.5, 과학: 104.5, 국어: 88.0}
12


13
// 필터링
14
var highScores = scores.entries
15
    .where((entry) => entry.value >= 90)
16
    .fold(<String, int>{}, (map, entry) {
17
  map[entry.key] = entry.value;
18
  return map;
19
});
20
print(highScores); // {수학: 90, 과학: 95}
21


22
// forEach로 처리
23
scores.forEach((key, value) {
24
  print('$key: $value');
25
});
26
// 수학: 90
27
// 영어: 85
28
// 과학: 95
29
// 국어: 80
```

## 반복문

[Section titled “반복문”](#반복문)

Dart는 컬렉션과 다른 이터러블(iterable) 객체를 처리하기 위한 다양한 반복문을 제공합니다.

### 1. for 반복문

[Section titled “1. for 반복문”](#1-for-반복문)

#### 기본 for 반복문

[Section titled “기본 for 반복문”](#기본-for-반복문)

```dart
1
// 기본 for 루프
2
for (int i = 0; i < 5; i++) {
3
  print(i); // 0, 1, 2, 3, 4
4
}
5


6
// 복잡한 조건과 증가식
7
for (int i = 10; i > 0; i -= 2) {
8
  print(i); // 10, 8, 6, 4, 2
9
}
```

#### for-in 반복문

[Section titled “for-in 반복문”](#for-in-반복문)

```dart
1
var fruits = ['사과', '바나나', '오렌지'];
2


3
// 컬렉션 항목 반복
4
for (var fruit in fruits) {
5
  print(fruit); // 사과, 바나나, 오렌지
6
}
7


8
// 인덱스가 필요한 경우
9
for (int i = 0; i < fruits.length; i++) {
10
  print('${i + 1}번째 과일: ${fruits[i]}');
11
}
12
// 1번째 과일: 사과
13
// 2번째 과일: 바나나
14
// 3번째 과일: 오렌지
```

### 2. while과 do-while 반복문

[Section titled “2. while과 do-while 반복문”](#2-while과-do-while-반복문)

```dart
1
// while 반복문
2
int count = 0;
3
while (count < 5) {
4
  print(count);
5
  count++;
6
}
7
// 0, 1, 2, 3, 4
8


9
// do-while 반복문 (최소 한 번은 실행됨)
10
int num = 5;
11
do {
12
  print(num);
13
  num--;
14
} while (num > 0);
15
// 5, 4, 3, 2, 1
```

### 3. forEach 메서드

[Section titled “3. forEach 메서드”](#3-foreach-메서드)

```dart
1
var numbers = [1, 2, 3, 4, 5];
2


3
// 리스트의 forEach
4
numbers.forEach((number) {
5
  print(number * 2); // 2, 4, 6, 8, 10
6
});
7


8
// 맵의 forEach
9
var scores = {'수학': 90, '영어': 85, '과학': 95};
10
scores.forEach((subject, score) {
11
  print('$subject: $score점');
12
  // 수학: 90점
13
  // 영어: 85점
14
  // 과학: 95점
15
});
```

### 4. 반복 제어

[Section titled “4. 반복 제어”](#4-반복-제어)

```dart
1
// break로 반복 중단
2
for (int i = 0; i < 10; i++) {
3
  if (i == 5) break;
4
  print(i); // 0, 1, 2, 3, 4
5
}
6


7
// continue로 현재 반복 건너뛰기
8
for (int i = 0; i < 5; i++) {
9
  if (i == 2) continue;
10
  print(i); // 0, 1, 3, 4
11
}
12


13
// 레이블을 사용한 중첩 반복문 제어
14
outerLoop: for (int i = 0; i < 3; i++) {
15
  for (int j = 0; j < 3; j++) {
16
    if (i == 1 && j == 1) {
17
      break outerLoop; // 바깥 반복문까지 중단
18
    }
19
    print('$i, $j');
20
    // 0, 0
21
    // 0, 1
22
    // 0, 2
23
    // 1, 0
24
  }
25
}
```

## 컬렉션 처리 기법

[Section titled “컬렉션 처리 기법”](#컬렉션-처리-기법)

### 1. 컬렉션 for와 if

[Section titled “1. 컬렉션 for와 if”](#1-컬렉션-for와-if)

Dart에서는 컬렉션 리터럴 내에 for 루프와 if 조건을 삽입할 수 있습니다.

```dart
1
// 컬렉션 for
2
var numbers = [1, 2, 3];
3
var doubled = [
4
  0,
5
  for (var n in numbers) n * 2,
6
  4
7
];
8
print(doubled); // [0, 2, 4, 6, 4]
9


10
// 컬렉션 if
11
bool includeZ = true;
12
var letters = ['a', 'b', if (includeZ) 'z'];
13
print(letters); // [a, b, z]
14


15
// 복합 사용
16
var items = [
17
  'home',
18
  if (userLoggedIn) 'profile',
19
  for (var item in defaultItems) item,
20
  if (isAdmin) 'admin'
21
];
```

### 2. 스프레드 연산자

[Section titled “2. 스프레드 연산자”](#2-스프레드-연산자)

스프레드 연산자(`...`)를 사용하여 컬렉션을 다른 컬렉션에 삽입할 수 있습니다.

```dart
1
var list1 = [1, 2, 3];
2
var list2 = [0, ...list1, 4, 5];
3
print(list2); // [0, 1, 2, 3, 4, 5]
4


5
// null 조건부 스프레드 연산자 (...?)
6
List<int>? nullableList;
7
var combined = [0, ...?nullableList, 1];
8
print(combined); // [0, 1]
9


10
// 맵에 사용
11
var map1 = {'a': 1, 'b': 2};
12
var map2 = {'c': 3, ...map1};
13
print(map2); // {c: 3, a: 1, b: 2}
14


15
// 집합에 사용
16
var set1 = {1, 2, 3};
17
var set2 = {0, ...set1, 4};
18
print(set2); // {0, 1, 2, 3, 4}
```

### 3. 제너레이터 함수

[Section titled “3. 제너레이터 함수”](#3-제너레이터-함수)

제너레이터 함수는 값의 시퀀스를 생성할 수 있습니다. Dart는 두 가지 유형의 제너레이터 함수를 지원합니다.

#### 동기 제너레이터 (sync\*)

[Section titled “동기 제너레이터 (sync\*)”](#동기-제너레이터-sync)

`sync*`는 Iterable 객체를 생성합니다:

```dart
1
Iterable<int> getNumbers(int n) sync* {
2
  for (int i = 0; i < n; i++) {
3
    yield i;
4
  }
5
}
6


7
void main() {
8
  for (var num in getNumbers(5)) {
9
    print(num); // 0, 1, 2, 3, 4
10
  }
11
}
```

#### 비동기 제너레이터 (async\*)

[Section titled “비동기 제너레이터 (async\*)”](#비동기-제너레이터-async)

`async*`는 Stream 객체를 생성합니다:

```dart
1
Stream<int> countStream(int n) async* {
2
  for (int i = 1; i <= n; i++) {
3
    await Future.delayed(Duration(seconds: 1));
4
    yield i;
5
  }
6
}
7


8
void main() async {
9
  await for (var num in countStream(5)) {
10
    print(num); // 1초마다 1, 2, 3, 4, 5 출력
11
  }
12
}
```

### 4. 고급 컬렉션 변환 기법

[Section titled “4. 고급 컬렉션 변환 기법”](#4-고급-컬렉션-변환-기법)

```dart
1
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
2


3
// 연속 변환
4
var result = numbers
5
    .where((n) => n % 2 == 0) // 짝수만 선택
6
    .map((n) => n * n) // 제곱
7
    .takeWhile((n) => n <= 36) // 36 이하인 동안만
8
    .fold(0, (sum, n) => sum + n); // 합계 계산
9


10
print(result); // 4 + 16 + 36 = 56
11


12
// 그룹화
13
var fruits = ['사과', '바나나', '체리', '블루베리', '아보카도'];
14
var byFirstLetter = fruits.fold<Map<String, List<String>>>(
15
  {},
16
  (map, fruit) {
17
    var firstLetter = fruit[0];
18
    map[firstLetter] = (map[firstLetter] ?? [])..add(fruit);
19
    return map;
20
  },
21
);
22


23
print(byFirstLetter);
24
// {사: [사과], 바: [바나나], 체: [체리], 블: [블루베리], 아: [아보카도]}
```

## Dart 2.3 이상의 컬렉션 관련 기능

[Section titled “Dart 2.3 이상의 컬렉션 관련 기능”](#dart-23-이상의-컬렉션-관련-기능)

### 1. cascade notation (연쇄 표기법)

[Section titled “1. cascade notation (연쇄 표기법)”](#1-cascade-notation-연쇄-표기법)

연쇄 표기법(`..`)을 사용하면 동일한 객체에서 연속적인 작업을 수행할 수 있습니다:

```dart
1
var list = [1, 2, 3]
2
  ..add(4)
3
  ..addAll([5, 6])
4
  ..remove(2)
5
  ..sort();
6


7
print(list); // [1, 3, 4, 5, 6]
8


9
// 중첩 객체에도 사용 가능
10
var map = {'user': {'name': '홍길동', 'age': 30}}
11
  ..['user']['email'] = 'hong@example.com'
12
  ..['user']['age'] = 31
13
  ..['active'] = true;
14


15
print(map);
16
// {user: {name: 홍길동, age: 31, email: hong@example.com}, active: true}
```

### 2. null-aware 연산자와 컬렉션

[Section titled “2. null-aware 연산자와 컬렉션”](#2-null-aware-연산자와-컬렉션)

null-aware 연산자를 사용하면 null 처리가 더 간결해집니다:

```dart
1
// ?. 연산자 (null인 경우 실행하지 않음)
2
List<String>? nullableList;
3
nullableList?.add('항목'); // nullableList가 null이면 아무 일도 일어나지 않음
4


5
// ?? 연산자 (null인 경우 기본값 제공)
6
var list = nullableList ?? [];
7
list.add('항목');
8
print(list); // [항목]
9


10
// ??= 연산자 (null인 경우에만 값 할당)
11
Map<String, int>? scoresMap;
12
scoresMap ??= {};
13
scoresMap['수학'] = 90;
14
print(scoresMap); // {수학: 90}
```

## 실전 예제

[Section titled “실전 예제”](#실전-예제)

### 1. 데이터 변환 파이프라인

[Section titled “1. 데이터 변환 파이프라인”](#1-데이터-변환-파이프라인)

```dart
1
class Student {
2
  final String name;
3
  final int age;
4
  final Map<String, int> scores;
5


6
  Student(this.name, this.age, this.scores);
7
}
8


9
void main() {
10
  final students = [
11
    Student('홍길동', 20, {'수학': 90, '영어': 85, '과학': 95}),
12
    Student('김철수', 22, {'수학': 75, '영어': 90, '과학': 85}),
13
    Student('이영희', 21, {'수학': 85, '영어': 92, '과학': 88}),
14
    Student('박민수', 23, {'수학': 95, '영어': 80, '과학': 92}),
15
  ];
16


17
  // 각 학생의 평균 점수 계산
18
  final averageScores = students.map((student) {
19
    final total = student.scores.values.fold<int>(0, (sum, score) => sum + score);
20
    final average = total / student.scores.length;
21
    return {'name': student.name, 'average': average};
22
  }).toList();
23


24
  print('평균 점수:');
25
  for (var item in averageScores) {
26
    print('${item['name']}: ${item['average']}');
27
  }
28


29
  // 평균 90점 이상인 학생
30
  final highPerformers = students.where((student) {
31
    final total = student.scores.values.fold<int>(0, (sum, score) => sum + score);
32
    final average = total / student.scores.length;
33
    return average >= 90;
34
  }).map((student) => student.name).toList();
35


36
  print('\n우수 학생: $highPerformers');
37


38
  // 과목별 최고 점수 및 학생
39
  final subjects = {'수학', '영어', '과학'};
40


41
  final topScoresBySubject = subjects.fold<Map<String, Map<String, dynamic>>>(
42
    {},
43
    (map, subject) {
44
      var topStudent = students.reduce((a, b) =>
45
          (a.scores[subject] ?? 0) > (b.scores[subject] ?? 0) ? a : b);
46


47
      map[subject] = {
48
        'student': topStudent.name,
49
        'score': topStudent.scores[subject]
50
      };
51
      return map;
52
    },
53
  );
54


55
  print('\n과목별 최고 점수:');
56
  topScoresBySubject.forEach((subject, data) {
57
    print('$subject: ${data['student']} (${data['score']}점)');
58
  });
59
}
```

### 2. 복잡한 필터링과 정렬

[Section titled “2. 복잡한 필터링과 정렬”](#2-복잡한-필터링과-정렬)

```dart
1
class Product {
2
  final String id;
3
  final String name;
4
  final double price;
5
  final List<String> categories;
6
  final bool inStock;
7


8
  Product(this.id, this.name, this.price, this.categories, this.inStock);
9
}
10


11
void main() {
12
  final products = [
13
    Product('p1', '스마트폰', 850000, ['전자제품', '통신기기'], true),
14
    Product('p2', '노트북', 1200000, ['전자제품', '컴퓨터'], false),
15
    Product('p3', '헤드폰', 120000, ['전자제품', '오디오'], true),
16
    Product('p4', '키보드', 98000, ['전자제품', '컴퓨터', '주변기기'], true),
17
    Product('p5', '마우스', 45000, ['전자제품', '컴퓨터', '주변기기'], true),
18
    Product('p6', '모니터', 550000, ['전자제품', '컴퓨터', '주변기기'], false),
19
  ];
20


21
  // 1. 재고가 있는 제품만 필터링
22
  final inStockProducts = products.where((p) => p.inStock).toList();
23


24
  // 2. 컴퓨터 관련 제품만 필터링
25
  final computerProducts = products
26
      .where((p) => p.categories.contains('컴퓨터'))
27
      .toList();
28


29
  // 3. 가격 기준 정렬 (오름차순)
30
  final sortedByPrice = List<Product>.from(products)
31
    ..sort((a, b) => a.price.compareTo(b.price));
32


33
  // 4. 복합 필터: 재고 있는 주변기기 중 가격이 100,000원 미만인 제품
34
  final affordablePeripherals = products
35
      .where((p) => p.inStock &&
36
                    p.categories.contains('주변기기') &&
37
                    p.price < 100000)
38
      .toList();
39


40
  // 5. 카테고리별 제품 그룹화
41
  final productsByCategory = <String, List<Product>>{};
42


43
  for (var product in products) {
44
    for (var category in product.categories) {
45
      productsByCategory[category] ??= [];
46
      productsByCategory[category]!.add(product);
47
    }
48
  }
49


50
  // 결과 출력
51
  print('재고 있는 제품: ${inStockProducts.map((p) => p.name).toList()}');
52
  print('컴퓨터 관련 제품: ${computerProducts.map((p) => p.name).toList()}');
53
  print('저렴한 주변기기: ${affordablePeripherals.map((p) => p.name).toList()}');
54


55
  print('\n카테고리별 제품:');
56
  productsByCategory.forEach((category, categoryProducts) {
57
    print('$category: ${categoryProducts.map((p) => p.name).toList()}');
58
  });
59
}
```

## 결론

[Section titled “결론”](#결론)

Dart의 컬렉션과 반복문은 강력하고 유연한 도구를 제공하여 데이터를 효율적으로 처리할 수 있게 해줍니다. List, Set, Map과 같은 기본 컬렉션 타입은 다양한 메서드를 제공하며, 컬렉션 for, 스프레드 연산자, 제너레이터 함수 등의 기능은 복잡한 데이터 처리 작업을 간결하게 표현할 수 있게 해줍니다.

다음 장에서는 Dart의 예외 처리에 대해 알아보겠습니다.

# Dart 소개

## Dart란 무엇인가?

[Section titled “Dart란 무엇인가?”](#dart란-무엇인가)

Dart는 Google에서 개발한 클라이언트 최적화 프로그래밍 언어로, 모든 플랫폼에서 빠르고 안정적인 애플리케이션을 개발하기 위해 설계되었습니다. Dart는 Flutter 프레임워크의 기반이 되는 언어이며, 웹, 모바일, 데스크톱 애플리케이션을 개발하는 데 사용됩니다.

## Dart의 역사

[Section titled “Dart의 역사”](#dart의-역사)

* **2011년**: Google I/O에서 처음 발표
* **2013년**: Dart 1.0 출시
* **2018년**: Dart 2.0 출시 (타입 안전성 강화)
* **2021년**: Dart 2.13 출시 (null 안전성 도입)
* **2023년**: Dart 3.0 출시 (레코드, 패턴 매칭 도입)

Dart는 초기에 JavaScript를 대체하기 위한 웹 프로그래밍 언어로 시작했지만, 현재는 Flutter를 통한 크로스 플랫폼 애플리케이션 개발에 주로 사용됩니다.

## Dart의 주요 특징

[Section titled “Dart의 주요 특징”](#dart의-주요-특징)

### 1. 객체 지향 언어

[Section titled “1. 객체 지향 언어”](#1-객체-지향-언어)

Dart는 클래스 기반의 객체 지향 언어입니다. 모든 것이 객체이며, 모든 객체는 클래스의 인스턴스입니다. 심지어 함수와 `null`도 객체입니다.

```dart
1
class Person {
2
  String name;
3
  int age;
4


5
  Person(this.name, this.age);
6


7
  void introduce() {
8
    print('안녕하세요, 저는 $name이고 $age살입니다.');
9
  }
10
}
11


12
void main() {
13
  final person = Person('홍길동', 30);
14
  person.introduce();  // 출력: 안녕하세요, 저는 홍길동이고 30살입니다.
15
}
```

### 2. 강력한 타입 시스템

[Section titled “2. 강력한 타입 시스템”](#2-강력한-타입-시스템)

Dart는 정적 타입 언어이지만, 타입 추론을 지원하여 타입 명시를 생략할 수 있습니다.

```dart
1
// 타입 명시
2
String name = '홍길동';
3
int age = 30;
4


5
// 타입 추론
6
var name = '홍길동';    // String으로 추론
7
var age = 30;         // int로 추론
8
final height = 175.5;  // double로 추론
```

### 3. 비동기 프로그래밍 지원

[Section titled “3. 비동기 프로그래밍 지원”](#3-비동기-프로그래밍-지원)

Dart는 `Future`, `Stream`, `async`, `await` 등을 통해 비동기 프로그래밍을 지원합니다.

```dart
1
Future<String> fetchData() async {
2
  // 비동기 작업 시뮬레이션
3
  await Future.delayed(Duration(seconds: 2));
4
  return '데이터';
5
}
6


7
void main() async {
8
  print('데이터 요청 시작');
9
  final data = await fetchData();
10
  print('받은 데이터: $data');
11
}
```

### 4. Null 안전성

[Section titled “4. Null 안전성”](#4-null-안전성)

Dart 2.12부터 Null 안전성을 도입하여, 변수가 null 가능성을 타입 시스템에서 명시합니다.

```dart
1
// null이 될 수 없는 변수
2
String name = '홍길동';
3
// name = null;  // 컴파일 오류
4


5
// null이 될 수 있는 변수
6
String? nullableName = '홍길동';
7
nullableName = null;  // 허용됨
```

### 5. 다중 플랫폼 지원

[Section titled “5. 다중 플랫폼 지원”](#5-다중-플랫폼-지원)

Dart는 여러 플랫폼에서 실행될 수 있습니다:

* **네이티브 플랫폼**: Dart는 AoT(Ahead-of-Time) 컴파일을 통해 네이티브 바이너리로 컴파일됩니다. Flutter 앱은 이 방식으로 배포됩니다.
* **웹 플랫폼**: Dart는 JavaScript로 컴파일되어 브라우저에서 실행됩니다.
* **개발 환경**: Dart는 JIT(Just-in-Time) 컴파일을 통해 개발 중 핫 리로드와 같은 기능을 제공합니다.

### 6. 풍부한 표준 라이브러리

[Section titled “6. 풍부한 표준 라이브러리”](#6-풍부한-표준-라이브러리)

Dart는 다양한 기능을 제공하는 풍부한 표준 라이브러리를 포함하고 있습니다:

* 컬렉션 (`List`, `Map`, `Set` 등)
* 비동기 처리 (`Future`, `Stream`)
* 파일 I/O
* HTTP 클라이언트
* 정규 표현식
* 직렬화 지원

## Dart 실행 환경

[Section titled “Dart 실행 환경”](#dart-실행-환경)

Dart 코드는 다양한 환경에서 실행될 수 있습니다:

### 1. Dart VM

[Section titled “1. Dart VM”](#1-dart-vm)

Dart Virtual Machine(VM)은 Dart 코드를 직접 실행하는 환경으로, 개발 중 코드를 빠르게 실행하고 디버깅할 수 있습니다.

```bash
1
dart run main.dart
```

### 2. Flutter

[Section titled “2. Flutter”](#2-flutter)

Flutter는 Dart를 사용하여 크로스 플랫폼 모바일 애플리케이션을 개발하는 프레임워크입니다.

```bash
1
flutter run
```

### 3. Web (Dart2JS)

[Section titled “3. Web (Dart2JS)”](#3-web-dart2js)

Dart 코드는 JavaScript로 컴파일되어 웹 브라우저에서 실행될 수 있습니다.

```bash
1
dart compile js main.dart -o main.js
```

### 4. Native (Native AOT)

[Section titled “4. Native (Native AOT)”](#4-native-native-aot)

Dart 코드는 네이티브 바이너리로 컴파일되어 독립 실행 파일로 배포될 수 있습니다.

```bash
1
dart compile exe main.dart -o main
```

## Dart 패키지 생태계

[Section titled “Dart 패키지 생태계”](#dart-패키지-생태계)

Dart는 `pub.dev`라는 공식 패키지 저장소를 통해 풍부한 패키지 생태계를 제공합니다. 이 저장소에는 다양한 기능을 제공하는 수천 개의 오픈 소스 패키지가 있습니다.

패키지를 프로젝트에 추가하려면 `pubspec.yaml` 파일에 의존성을 추가합니다:

```yaml
1
dependencies:
2
  http: ^1.0.0
3
  path: ^1.8.0
```

그리고 다음 명령으로 패키지를 설치합니다:

```bash
1
dart pub get
```

## Dart와 다른 언어 비교

[Section titled “Dart와 다른 언어 비교”](#dart와-다른-언어-비교)

### Java와 비교

[Section titled “Java와 비교”](#java와-비교)

```dart
1
// Dart
2
class Person {
3
  String name;
4
  int age;
5


6
  Person(this.name, this.age);
7


8
  void sayHello() {
9
    print('Hello, I am $name');
10
  }
11
}
12


13
// Java
14
public class Person {
15
  private String name;
16
  private int age;
17


18
  public Person(String name, int age) {
19
    this.name = name;
20
    this.age = age;
21
  }
22


23
  public void sayHello() {
24
    System.out.println("Hello, I am " + name);
25
  }
26
}
```

### JavaScript와 비교

[Section titled “JavaScript와 비교”](#javascript와-비교)

```dart
1
// Dart
2
void main() {
3
  final list = [1, 2, 3, 4, 5];
4
  final doubled = list.map((item) => item * 2).toList();
5
  print(doubled);  // [2, 4, 6, 8, 10]
6
}
7


8
// JavaScript
9
function main() {
10
  const list = [1, 2, 3, 4, 5];
11
  const doubled = list.map(item => item * 2);
12
  console.log(doubled);  // [2, 4, 6, 8, 10]
13
}
```

### Swift와 비교

[Section titled “Swift와 비교”](#swift와-비교)

```dart
1
// Dart
2
class Person {
3
  String name;
4
  int? age;
5


6
  Person(this.name, {this.age});
7
}
8


9
// Swift
10
class Person {
11
  let name: String
12
  var age: Int?
13


14
  init(name: String, age: Int? = nil) {
15
    self.name = name
16
    self.age = age
17
  }
18
}
```

## Dart의 장점

[Section titled “Dart의 장점”](#dart의-장점)

1. **통합 개발 환경**: 단일 언어로 모바일, 웹, 데스크톱 앱을 개발할 수 있습니다.
2. **생산성**: 핫 리로드, 풍부한 도구, 직관적인 문법으로 개발 생산성을 높입니다.
3. **성능**: AoT 컴파일을 통해 네이티브 성능에 가까운 실행 속도를 제공합니다.
4. **안정성**: 강력한 타입 시스템과 null 안전성으로 많은 런타임 오류를 방지합니다.
5. **확장성**: 표준 라이브러리와 풍부한 패키지 생태계를 통해 다양한 기능을 추가할 수 있습니다.

## Dart 개발 환경 설정

[Section titled “Dart 개발 환경 설정”](#dart-개발-환경-설정)

### VS Code에서 Dart 개발 환경 설정

[Section titled “VS Code에서 Dart 개발 환경 설정”](#vs-code에서-dart-개발-환경-설정)

1. Dart SDK 설치 (Flutter SDK를 설치했다면 이미 포함되어 있습니다)

2. VS Code 설치

3. Dart 확장 프로그램 설치

4. 새 Dart 프로젝트 생성:

   ```bash
   1
   dart create my_dart_project
   ```

5. VS Code에서 프로젝트 열기

6. `main.dart` 파일 실행하기: F5 또는 “Run” 버튼 클릭

## 결론

[Section titled “결론”](#결론)

Dart는 현대적인 애플리케이션 개발을 위한 강력하고 유연한 프로그래밍 언어입니다. 특히 Flutter와 함께 사용하면, 단일 코드베이스로 고품질의 크로스 플랫폼 애플리케이션을 개발할 수 있습니다.

다음 장에서는 Dart의 기본 문법과 변수에 대해 더 자세히 알아보겠습니다.

# 예외 처리

소프트웨어 개발에서 오류는 피할 수 없는 부분입니다. Dart는 예외(Exception)를 사용하여 프로그램 실행 중 발생하는 오류를 처리합니다. 이 장에서는 Dart의 예외 처리 메커니즘, 내장 예외 타입, 사용자 정의 예외 생성 및 효과적인 예외 처리 전략에 대해 알아보겠습니다.

## 예외의 개념

[Section titled “예외의 개념”](#예외의-개념)

예외는 프로그램 실행 중 발생하는 비정상적인 상황이나 오류입니다. 예외가 발생하면 프로그램의 정상적인 흐름이 중단되고, 해당 예외를 처리하는 코드로 제어가 이동합니다.

### 예외와 오류의 차이

[Section titled “예외와 오류의 차이”](#예외와-오류의-차이)

Dart에서는 모든 예외가 `Exception` 또는 `Error` 클래스의 하위 타입입니다:

* **Exception**: 프로그램이 복구할 수 있는 오류 상황을 나타냅니다.
* **Error**: 프로그래밍 오류나 시스템 오류와 같이 일반적으로 복구할 수 없는 심각한 문제를 나타냅니다.

## 내장 예외 타입

[Section titled “내장 예외 타입”](#내장-예외-타입)

Dart는 다양한 내장 예외 타입을 제공합니다:

### Exception 하위 타입

[Section titled “Exception 하위 타입”](#exception-하위-타입)

```dart
1
// 포맷 예외
2
FormatException('잘못된 형식의 입력입니다.');
3


4
// 상태 예외
5
StateError('객체가 잘못된 상태입니다.');
6


7
// 타입 오류
8
TypeError(); // 예: 잘못된 타입 캐스팅
9


10
// 인수 오류
11
ArgumentError('잘못된 인수가 제공되었습니다.');
12
ArgumentError.notNull('필수 매개변수가 null입니다.');
13
ArgumentError.value(42, 'age', '0보다 커야 합니다.');
14


15
// 범위 오류
16
RangeError('인덱스가 범위를 벗어났습니다.');
17
RangeError.index(10, [1, 2, 3], 'index', '인덱스가 범위를 벗어났습니다.', 3);
18
RangeError.range(42, 0, 10, 'value', '값이 허용 범위를 벗어났습니다.');
19


20
// 동시성 예외
21
ConcurrentModificationError('반복 중 컬렉션이 수정되었습니다.');
22


23
// 타임아웃 예외
24
TimeoutException('작업이 시간 초과되었습니다.', Duration(seconds: 5));
```

### Error 하위 타입

[Section titled “Error 하위 타입”](#error-하위-타입)

```dart
1
// 어설션 오류
2
AssertionError('조건이 false입니다.');
3


4
// 형식 오류
5
TypeError();
6


7
// 캐스트 오류 (다운캐스팅 실패)
8
CastError();
9


10
// 널 참조 오류
11
NoSuchMethodError.withInvocation(null, Invocation.method(Symbol('toString'), []));
12


13
// 스택 오버플로우
14
StackOverflowError();
15


16
// 외부 오류
17
OutOfMemoryError();
```

## 예외 처리 기본

[Section titled “예외 처리 기본”](#예외-처리-기본)

### 1. try-catch-finally

[Section titled “1. try-catch-finally”](#1-try-catch-finally)

기본적인 예외 처리 구문은 다음과 같습니다:

```dart
1
try {
2
  // 예외가 발생할 수 있는 코드
3
  int result = 12 ~/ 0; // 0으로 나누기 시도
4
  print('결과: $result'); // 이 코드는 실행되지 않음
5
} catch (e) {
6
  // 모든 예외 처리
7
  print('예외 발생: $e');
8
} finally {
9
  // 예외 발생 여부와 관계없이 항상 실행
10
  print('finally 블록 실행');
11
}
12


13
// 출력:
14
// 예외 발생: IntegerDivisionByZeroException
15
// finally 블록 실행
```

### 2. 특정 예외 타입 잡기

[Section titled “2. 특정 예외 타입 잡기”](#2-특정-예외-타입-잡기)

여러 종류의 예외를 다르게 처리할 수 있습니다:

```dart
1
try {
2
  // 예외가 발생할 수 있는 코드
3
  dynamic value = 'not a number';
4
  int number = int.parse(value);
5
  print('숫자: $number');
6
} on FormatException catch (e) {
7
  // FormatException 처리
8
  print('숫자로 변환할 수 없음: $e');
9
} on TypeError catch (e) {
10
  // TypeError 처리
11
  print('타입 오류 발생: $e');
12
} catch (e, s) {
13
  // 기타 모든 예외 처리, 스택 트레이스 포함
14
  print('기타 예외 발생: $e');
15
  print('스택 트레이스: $s');
16
}
```

### 3. 예외 다시 던지기(rethrow)

[Section titled “3. 예외 다시 던지기(rethrow)”](#3-예외-다시-던지기rethrow)

예외를 잡은 후 처리하고 다시 상위 호출자에게 전파할 수 있습니다:

```dart
1
void processFile(String filename) {
2
  try {
3
    // 파일 처리 코드
4
    var file = File(filename);
5
    var contents = file.readAsStringSync();
6
    // 파일 내용 처리...
7
  } catch (e) {
8
    // 로그 기록
9
    print('파일 처리 중 오류 발생: $e');
10


11
    // 오류를 상위 호출자에게 전달
12
    rethrow;
13
  }
14
}
15


16
void main() {
17
  try {
18
    processFile('존재하지_않는_파일.txt');
19
  } catch (e) {
20
    print('메인에서 오류 처리: $e');
21
  }
22
}
```

## 사용자 정의 예외

[Section titled “사용자 정의 예외”](#사용자-정의-예외)

특정 상황에 맞는 예외를 직접 정의할 수 있습니다:

```dart
1
// 사용자 정의 예외 클래스 정의
2
class InsufficientBalanceException implements Exception {
3
  final double balance;
4
  final double withdrawal;
5


6
  InsufficientBalanceException(this.balance, this.withdrawal);
7


8
  @override
9
  String toString() {
10
    return '잔액 부족: 현재 잔액 $balance, 출금 요청액 $withdrawal';
11
  }
12
}
13


14
// 사용자 정의 예외 사용
15
class BankAccount {
16
  double balance = 0;
17
  final String owner;
18


19
  BankAccount(this.owner, [this.balance = 0]);
20


21
  void deposit(double amount) {
22
    if (amount <= 0) {
23
      throw ArgumentError('입금액은 0보다 커야 합니다.');
24
    }
25
    balance += amount;
26
  }
27


28
  void withdraw(double amount) {
29
    if (amount <= 0) {
30
      throw ArgumentError('출금액은 0보다 커야 합니다.');
31
    }
32


33
    if (amount > balance) {
34
      throw InsufficientBalanceException(balance, amount);
35
    }
36


37
    balance -= amount;
38
  }
39
}
40


41
// 사용 예시
42
void main() {
43
  var account = BankAccount('홍길동', 1000);
44


45
  try {
46
    account.withdraw(1500);
47
  } on InsufficientBalanceException catch (e) {
48
    print('출금 실패: $e');
49
    // 출금 실패: 잔액 부족: 현재 잔액 1000.0, 출금 요청액 1500.0
50
  } on ArgumentError catch (e) {
51
    print('인수 오류: $e');
52
  } catch (e) {
53
    print('기타 예외: $e');
54
  }
55
}
```

## 비동기 코드에서의 예외 처리

[Section titled “비동기 코드에서의 예외 처리”](#비동기-코드에서의-예외-처리)

### 1. async-await와 try-catch

[Section titled “1. async-await와 try-catch”](#1-async-await와-try-catch)

비동기 함수에서도 동기 코드와 마찬가지로 try-catch를 사용할 수 있습니다:

```dart
1
Future<String> fetchData() async {
2
  await Future.delayed(Duration(seconds: 1));
3
  throw Exception('데이터를 가져올 수 없습니다.');
4
}
5


6
Future<void> processData() async {
7
  try {
8
    String data = await fetchData();
9
    print('데이터: $data');
10
  } catch (e) {
11
    print('데이터 처리 중 오류 발생: $e');
12
  } finally {
13
    print('데이터 처리 완료');
14
  }
15
}
16


17
void main() async {
18
  await processData();
19


20
  // 출력:
21
  // 데이터 처리 중 오류 발생: Exception: 데이터를 가져올 수 없습니다.
22
  // 데이터 처리 완료
23
}
```

### 2. Future의 catchError

[Section titled “2. Future의 catchError”](#2-future의-catcherror)

`Future`의 메서드 체인을 사용할 때는 `catchError`를 사용할 수 있습니다:

```dart
1
Future<String> fetchData() {
2
  return Future.delayed(Duration(seconds: 1))
3
      .then((_) => throw Exception('네트워크 오류'));
4
}
5


6
void main() {
7
  fetchData()
8
      .then((data) => print('데이터: $data'))
9
      .catchError((e) => print('오류 발생: $e'))
10
      .whenComplete(() => print('작업 완료'));
11


12
  // 출력:
13
  // 오류 발생: Exception: 네트워크 오류
14
  // 작업 완료
15
}
```

### 3. 특정 예외만 처리하기

[Section titled “3. 특정 예외만 처리하기”](#3-특정-예외만-처리하기)

`catchError`에서 특정 예외만 처리할 수 있습니다:

```dart
1
Future<void> processTask() async {
2
  return Future.delayed(Duration(seconds: 1))
3
      .then((_) => throw TimeoutException('시간 초과', Duration(seconds: 1)))
4
      .then((_) => print('작업 완료'));
5
}
6


7
void main() {
8
  processTask()
9
      .catchError(
10
        (e) => print('타임아웃 발생: $e'),
11
        test: (e) => e is TimeoutException,
12
      )
13
      .catchError(
14
        (e) => print('기타 오류: $e'),
15
      )
16
      .whenComplete(() => print('모든 작업 완료'));
17


18
  // 출력:
19
  // 타임아웃 발생: TimeoutException: 시간 초과
20
  // 모든 작업 완료
21
}
```

## 스트림(Stream)에서의 예외 처리

[Section titled “스트림(Stream)에서의 예외 처리”](#스트림stream에서의-예외-처리)

### 1. try-catch와 await for

[Section titled “1. try-catch와 await for”](#1-try-catch와-await-for)

```dart
1
Stream<int> countStream(int to) async* {
2
  for (int i = 1; i <= to; i++) {
3
    if (i == 4) {
4
      throw Exception('4는 불길한 숫자입니다!');
5
    }
6
    yield i;
7
  }
8
}
9


10
Future<void> readStream() async {
11
  try {
12
    await for (var number in countStream(5)) {
13
      print('숫자: $number');
14
    }
15
    print('스트림 읽기 완료');
16
  } catch (e) {
17
    print('스트림 처리 중 오류 발생: $e');
18
  }
19
}
20


21
// 출력:
22
// 숫자: 1
23
// 숫자: 2
24
// 숫자: 3
25
// 스트림 처리 중 오류 발생: Exception: 4는 불길한 숫자입니다!
```

### 2. onError 리스너

[Section titled “2. onError 리스너”](#2-onerror-리스너)

```dart
1
Stream<int> countStream(int to) async* {
2
  for (int i = 1; i <= to; i++) {
3
    await Future.delayed(Duration(milliseconds: 500));
4
    if (i == 4) {
5
      throw Exception('4는 불길한 숫자입니다!');
6
    }
7
    yield i;
8
  }
9
}
10


11
void main() {
12
  countStream(5).listen(
13
    (data) => print('숫자: $data'),
14
    onError: (e) => print('오류 발생: $e'),
15
    onDone: () => print('스트림 완료'),
16
    cancelOnError: false, // 오류 발생 시 구독 유지 (기본값은 true)
17
  );
18
}
19


20
// 출력:
21
// 숫자: 1
22
// 숫자: 2
23
// 숫자: 3
24
// 오류 발생: Exception: 4는 불길한 숫자입니다!
25
// 스트림 완료
```

### 3. handleError 메서드

[Section titled “3. handleError 메서드”](#3-handleerror-메서드)

```dart
1
Stream<int> generateNumbers() async* {
2
  for (int i = 1; i <= 5; i++) {
3
    if (i == 3) throw Exception('3에서 오류 발생');
4
    yield i;
5
  }
6
}
7


8
void main() {
9
  generateNumbers()
10
      .handleError((error) => print('처리된 오류: $error'))
11
      .listen(
12
        (data) => print('데이터: $data'),
13
        onDone: () => print('완료'),
14
      );
15
}
16


17
// 출력:
18
// 데이터: 1
19
// 데이터: 2
20
// 처리된 오류: Exception: 3에서 오류 발생
21
// 완료
```

## 영역(Zone)을 사용한 예외 처리

[Section titled “영역(Zone)을 사용한 예외 처리”](#영역zone을-사용한-예외-처리)

`Zone`은 실행 컨텍스트를 제공하여 전역적으로 오류 처리를 할 수 있게 해줍니다. 특히 비동기 코드에서 캐치되지 않은 예외를 처리하는 데 유용합니다.

```dart
1
import 'dart:async';
2


3
void main() {
4
  // 사용자 정의 Zone 생성
5
  runZonedGuarded(
6
    () {
7
      // 이 영역 내에서 실행되는 모든 코드의 예외를 처리
8
      print('Zone 내에서 코드 실행 시작');
9


10
      // 동기 예외
11
      // throw Exception('동기 오류');
12


13
      // 비동기 예외
14
      Future.delayed(Duration(seconds: 1), () {
15
        throw Exception('비동기 오류');
16
      });
17


18
      // 타이머 내 예외
19
      Timer(Duration(seconds: 2), () {
20
        throw Exception('타이머 내 오류');
21
      });
22
    },
23
    (error, stack) {
24
      // 모든 예외를 여기서 처리
25
      print('Zone에서 오류 캐치: $error');
26
      print('스택 트레이스: $stack');
27
    },
28
  );
29


30
  print('main 함수의 끝 (Zone은 계속 실행됨)');
31
}
32


33
// 출력:
34
// Zone 내에서 코드 실행 시작
35
// main 함수의 끝 (Zone은 계속 실행됨)
36
// Zone에서 오류 캐치: Exception: 비동기 오류
37
// 스택 트레이스: ...
38
// Zone에서 오류 캐치: Exception: 타이머 내 오류
39
// 스택 트레이스: ...
```

## Flutter에서의 예외 처리

[Section titled “Flutter에서의 예외 처리”](#flutter에서의-예외-처리)

### 1. Flutter 앱의 전역 에러 핸들러

[Section titled “1. Flutter 앱의 전역 에러 핸들러”](#1-flutter-앱의-전역-에러-핸들러)

Flutter 앱에서는 `FlutterError.onError`를 통해 전역 에러 핸들러를 설정할 수 있습니다:

```dart
1
import 'package:flutter/foundation.dart';
2
import 'package:flutter/material.dart';
3


4
void main() {
5
  // UI 렌더링 중 발생하는 오류 처리
6
  FlutterError.onError = (FlutterErrorDetails details) {
7
    if (kReleaseMode) {
8
      // 릴리즈 모드에서는 오류 로깅 서비스로 보내기
9
      Zone.current.handleUncaughtError(details.exception, details.stack!);
10
    } else {
11
      // 개발 모드에서는 콘솔에 출력
12
      FlutterError.dumpErrorToConsole(details);
13
    }
14
  };
15


16
  // 앱 실행을 Zone으로 감싸서 모든 비동기 오류 처리
17
  runZonedGuarded(
18
    () {
19
      runApp(MyApp());
20
    },
21
    (error, stackTrace) {
22
      // 여기서 오류 로깅, 분석 서비스로 보내기 등 처리
23
      print('예기치 않은 오류: $error');
24
      print('스택 트레이스: $stackTrace');
25
    },
26
  );
27
}
```

### 2. 위젯에서의 예외 처리

[Section titled “2. 위젯에서의 예외 처리”](#2-위젯에서의-예외-처리)

Flutter 위젯에서는 `ErrorWidget`을 사용하여 예외 발생 시 UI를 관리할 수 있습니다:

```dart
1
void main() {
2
  // 개발 시에만 사용자 정의 에러 위젯 설정
3
  if (kDebugMode) {
4
    ErrorWidget.builder = (FlutterErrorDetails details) {
5
      return Container(
6
        padding: EdgeInsets.all(16),
7
        alignment: Alignment.center,
8
        color: Colors.red.withOpacity(0.3),
9
        child: Text(
10
          '위젯 빌드 오류: ${details.exception}',
11
          style: TextStyle(color: Colors.white),
12
        ),
13
      );
14
    };
15
  }
16


17
  runApp(MyApp());
18
}
```

### 3. FutureBuilder와 StreamBuilder에서의 예외 처리

[Section titled “3. FutureBuilder와 StreamBuilder에서의 예외 처리”](#3-futurebuilder와-streambuilder에서의-예외-처리)

Flutter의 `FutureBuilder`와 `StreamBuilder`는 위젯에서 비동기 데이터 처리를 쉽게 하고, 오류 상태도 처리할 수 있게 해줍니다:

```dart
1
// FutureBuilder 사용 예
2
FutureBuilder<String>(
3
  future: fetchData(), // 비동기 데이터 소스
4
  builder: (context, snapshot) {
5
    if (snapshot.connectionState == ConnectionState.waiting) {
6
      return CircularProgressIndicator();
7
    } else if (snapshot.hasError) {
8
      return Text('오류 발생: ${snapshot.error}');
9
    } else if (snapshot.hasData) {
10
      return Text('데이터: ${snapshot.data}');
11
    } else {
12
      return Text('데이터 없음');
13
    }
14
  },
15
)
16


17
// StreamBuilder 사용 예
18
StreamBuilder<int>(
19
  stream: countStream(5),
20
  builder: (context, snapshot) {
21
    if (snapshot.hasError) {
22
      return Text('스트림 오류: ${snapshot.error}');
23
    } else if (snapshot.connectionState == ConnectionState.waiting) {
24
      return CircularProgressIndicator();
25
    } else if (snapshot.hasData) {
26
      return Text('현재 값: ${snapshot.data}');
27
    } else {
28
      return Text('데이터 없음');
29
    }
30
  },
31
)
```

## 예외 처리 모범 사례

[Section titled “예외 처리 모범 사례”](#예외-처리-모범-사례)

### 1. 예외는 예외적인 상황에만 사용하기

[Section titled “1. 예외는 예외적인 상황에만 사용하기”](#1-예외는-예외적인-상황에만-사용하기)

```dart
1
// 나쁜 예: 일반적인 흐름 제어에 예외 사용
2
int findIndex(List<int> list, int value) {
3
  try {
4
    for (int i = 0; i < list.length; i++) {
5
      if (list[i] == value) {
6
        throw i; // 찾은 인덱스를 예외로 던짐
7
      }
8
    }
9
    return -1;
10
  } catch (e) {
11
    return e as int; // 예외에서 인덱스 추출
12
  }
13
}
14


15
// 좋은 예: 직접 반환
16
int findIndex(List<int> list, int value) {
17
  for (int i = 0; i < list.length; i++) {
18
    if (list[i] == value) {
19
      return i;
20
    }
21
  }
22
  return -1;
23
}
```

### 2. 적절한 예외 타입 사용하기

[Section titled “2. 적절한 예외 타입 사용하기”](#2-적절한-예외-타입-사용하기)

```dart
1
// 나쁜 예: 일반 예외 사용
2
void processAge(dynamic age) {
3
  if (age is! int) {
4
    throw Exception('나이는 정수여야 합니다.');
5
  }
6
  if (age < 0) {
7
    throw Exception('나이는 음수일 수 없습니다.');
8
  }
9
  // 처리 로직...
10
}
11


12
// 좋은 예: 구체적인 예외 사용
13
void processAge(dynamic age) {
14
  if (age is! int) {
15
    throw TypeError();
16
  }
17
  if (age < 0) {
18
    throw ArgumentError.value(age, 'age', '나이는 음수일 수 없습니다.');
19
  }
20
  // 처리 로직...
21
}
```

### 3. 모든 예외 처리하기

[Section titled “3. 모든 예외 처리하기”](#3-모든-예외-처리하기)

```dart
1
// 나쁜 예: 특정 예외만 처리
2
Future<void> loadUserData() async {
3
  try {
4
    final data = await fetchUserFromNetwork();
5
    saveToDatabase(data);
6
  } on NetworkException catch (e) {
7
    print('네트워크 오류: $e');
8
    // 데이터베이스 오류는 처리되지 않음
9
  }
10
}
11


12
// 좋은 예: 가능한 모든 예외 처리
13
Future<void> loadUserData() async {
14
  try {
15
    final data = await fetchUserFromNetwork();
16
    saveToDatabase(data);
17
  } on NetworkException catch (e) {
18
    print('네트워크 오류: $e');
19
    // 오프라인 데이터 사용
20
  } on DatabaseException catch (e) {
21
    print('데이터베이스 오류: $e');
22
    // 임시 저장
23
  } catch (e) {
24
    print('예기치 않은 오류: $e');
25
    // 기본 데이터 사용
26
  }
27
}
```

### 4. 예외 래핑 및 컨텍스트 추가하기

[Section titled “4. 예외 래핑 및 컨텍스트 추가하기”](#4-예외-래핑-및-컨텍스트-추가하기)

```dart
1
Future<User> fetchUser(String userId) async {
2
  try {
3
    final response = await http.get(Uri.parse('https://api.example.com/users/$userId'));
4


5
    if (response.statusCode == 200) {
6
      return User.fromJson(jsonDecode(response.body));
7
    } else {
8
      throw HttpException('상태 코드: ${response.statusCode}');
9
    }
10
  } catch (e) {
11
    // 원래 예외를 래핑하여 컨텍스트 추가
12
    throw UserNotFoundException(
13
      'ID가 $userId인 사용자를 찾을 수 없습니다.',
14
      cause: e,
15
    );
16
  }
17
}
18


19
class UserNotFoundException implements Exception {
20
  final String message;
21
  final Object? cause;
22


23
  UserNotFoundException(this.message, {this.cause});
24


25
  @override
26
  String toString() {
27
    if (cause != null) {
28
      return '$message (원인: $cause)';
29
    }
30
    return message;
31
  }
32
}
```

### 5. 리소스 해제 보장하기

[Section titled “5. 리소스 해제 보장하기”](#5-리소스-해제-보장하기)

```dart
1
Future<void> processFile(String path) async {
2
  File file;
3
  try {
4
    file = File(path);
5
    final content = await file.readAsString();
6
    // 콘텐츠 처리...
7
  } catch (e) {
8
    print('파일 처리 오류: $e');
9
    rethrow;
10
  } finally {
11
    // 리소스 정리 (파일 닫기 등)
12
    print('파일 처리 완료');
13
  }
14
}
```

### 6. 예외 처리 중앙화하기

[Section titled “6. 예외 처리 중앙화하기”](#6-예외-처리-중앙화하기)

```dart
1
// 중앙 에러 핸들러 정의
2
class ErrorHandler {
3
  static void logError(Object error, StackTrace stackTrace) {
4
    // 로그 파일에 기록
5
    print('ERROR: $error');
6
    print('STACK: $stackTrace');
7


8
    // 분석 서비스로 전송
9
    // _sendToAnalyticsService(error, stackTrace);
10


11
    // 개발자에게 알림
12
    if (!kReleaseMode) {
13
      print('디버그 모드에서 오류 발생!');
14
    }
15
  }
16


17
  static Future<T> guard<T>(Future<T> Function() function) async {
18
    try {
19
      return await function();
20
    } catch (error, stackTrace) {
21
      logError(error, stackTrace);
22
      rethrow;
23
    }
24
  }
25
}
26


27
// 사용 예시
28
Future<void> fetchData() async {
29
  await ErrorHandler.guard(() async {
30
    // 비즈니스 로직...
31
    if (Math.random() < 0.5) {
32
      throw Exception('랜덤 오류');
33
    }
34
    return '데이터';
35
  });
36
}
```

## 결론

[Section titled “결론”](#결론)

효과적인 예외 처리는 견고한 애플리케이션 개발의 핵심입니다. Dart는 try-catch-finally, 특정 예외 타입 잡기, 사용자 정의 예외 등 다양한 예외 처리 메커니즘을 제공합니다. 비동기 코드에서는 async-await와 함께 사용하거나 Future와 Stream의 오류 처리 메서드를 활용할 수 있습니다.

모범 사례를 따르면 더 안정적이고 유지 관리가 쉬운 코드를 작성할 수 있습니다:

1. 예외는 진짜 예외적인 상황에만 사용하세요.
2. 적절한 예외 타입을 사용하여 문제를 명확하게 전달하세요.
3. 발생할 수 있는 모든 예외를 처리하세요.
4. 필요한 경우 예외를 래핑하여 컨텍스트를 추가하세요.
5. finally 블록을 사용하여 리소스 해제를 보장하세요.
6. 일관된 예외 처리를 위해 중앙화된 접근 방식을 사용하세요.

다음 장에서는 Dart의 Extension과 Mixin에 대해 알아보겠습니다.

# Extension / Mixin

Dart는 코드 재사용과 확장성을 위한 다양한 방법을 제공합니다. 이 장에서는 두 가지 강력한 기능인 Extension과 Mixin에 대해 알아보겠습니다. 이 두 기능은 기존 클래스를 수정하지 않고도 기능을 확장하거나 여러 클래스 간에 코드를 효율적으로 공유할 수 있게 해줍니다.

## Extension(확장)

[Section titled “Extension(확장)”](#extension확장)

Extension은 기존 클래스(심지어 라이브러리 클래스나 외부 라이브러리의 클래스)에 새로운 기능을 추가할 수 있는 방법입니다. 원본 클래스의 소스 코드를 수정하거나 상속할 필요 없이 새로운 메서드, 프로퍼티, 연산자를 추가할 수 있습니다.

### 기본 구문

[Section titled “기본 구문”](#기본-구문)

```dart
1
extension <확장명> on <대상 타입> {
2
  // 메서드, 게터, 세터, 연산자 등 추가
3
}
```

확장명은 선택 사항이지만, 확장을 명시적으로 가져오거나 충돌을 해결할 때 유용합니다.

### 예제: String 확장

[Section titled “예제: String 확장”](#예제-string-확장)

```dart
1
// String 클래스에 기능 추가
2
extension StringExtension on String {
3
  // 첫 글자만 대문자로 변환
4
  String get capitalize => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
5


6
  // 문자열이 이메일인지 확인
7
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
8


9
  // 문자열을 n번 반복
10
  String repeat(int n) => List.filled(n, this).join();
11


12
  // 문자열의 모든 단어를 대문자로 시작하도록 변환
13
  String toTitleCase() {
14
    return split(' ')
15
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
16
        .join(' ');
17
  }
18
}
19


20
void main() {
21
  String name = 'john doe';
22
  print(name.capitalize); // John doe
23
  print(name.toTitleCase()); // John Doe
24
  print('hello'.repeat(3)); // hellohellohello
25
  print('test@example.com'.isValidEmail); // true
26
  print('invalid.email'.isValidEmail); // false
27
}
```

### 예제: int 확장

[Section titled “예제: int 확장”](#예제-int-확장)

```dart
1
extension IntExtension on int {
2
  // 초를 시:분:초 형식으로 변환
3
  String toTimeString() {
4
    int h = this ~/ 3600;
5
    int m = (this % 3600) ~/ 60;
6
    int s = this % 60;
7
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
8
  }
9


10
  // 숫자가 소수인지 확인
11
  bool get isPrime {
12
    if (this <= 1) return false;
13
    if (this <= 3) return true;
14
    if (this % 2 == 0 || this % 3 == 0) return false;
15
    int i = 5;
16
    while (i * i <= this) {
17
      if (this % i == 0 || this % (i + 2) == 0) return false;
18
      i += 6;
19
    }
20
    return true;
21
  }
22


23
  // 숫자의 팩토리얼 계산
24
  int get factorial {
25
    if (this < 0) throw ArgumentError('음수의 팩토리얼은 정의되지 않습니다.');
26
    if (this <= 1) return 1;
27
    return this * (this - 1).factorial;
28
  }
29
}
30


31
void main() {
32
  int seconds = 3665;
33
  print(seconds.toTimeString()); // 01:01:05
34


35
  print(7.isPrime); // true
36
  print(8.isPrime); // false
37


38
  print(5.factorial); // 120
39
}
```

### 예제: List 확장

[Section titled “예제: List 확장”](#예제-list-확장)

```dart
1
extension ListExtension<T> on List<T> {
2
  // 리스트의 첫 번째 요소 (안전하게 가져오기)
3
  T? get firstOrNull => isEmpty ? null : first;
4


5
  // 리스트의 마지막 요소 (안전하게 가져오기)
6
  T? get lastOrNull => isEmpty ? null : last;
7


8
  // 중복 제거
9
  List<T> get distinct => toSet().toList();
10


11
  // 리스트 분할
12
  List<List<T>> chunk(int size) {
13
    return List.generate(
14
      (length / size).ceil(),
15
      (i) => sublist(i * size, (i + 1) * size > length ? length : (i + 1) * size),
16
    );
17
  }
18
}
19


20
void main() {
21
  List<int> numbers = [1, 2, 3, 4, 5, 1, 2];
22
  print(numbers.distinct); // [1, 2, 3, 4, 5]
23


24
  List<String> fruits = ['사과', '바나나', '오렌지', '딸기', '포도'];
25
  print(fruits.chunk(2)); // [[사과, 바나나], [오렌지, 딸기], [포도]]
26


27
  List<int> empty = [];
28
  print(empty.firstOrNull); // null
29
  print(empty.lastOrNull); // null
30
}
```

### 확장 게터와 세터

[Section titled “확장 게터와 세터”](#확장-게터와-세터)

```dart
1
extension NumberParsing on String {
2
  int? get asIntOrNull => int.tryParse(this);
3
  double? get asDoubleOrNull => double.tryParse(this);
4


5
  bool get asBool {
6
    final lower = toLowerCase();
7
    return lower == 'true' || lower == '1' || lower == 'yes' || lower == 'y';
8
  }
9
}
10


11
void main() {
12
  print('42'.asIntOrNull); // 42
13
  print('3.14'.asDoubleOrNull); // 3.14
14
  print('abc'.asIntOrNull); // null
15
  print('true'.asBool); // true
16
  print('YES'.asBool); // true
17
}
```

### 정적 확장 멤버

[Section titled “정적 확장 멤버”](#정적-확장-멤버)

확장은 정적 메서드와 프로퍼티도 포함할 수 있습니다:

```dart
1
extension DateTimeExtension on DateTime {
2
  // 인스턴스 메서드
3
  String get formattedDate => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
4


5
  // 정적 메서드
6
  static DateTime fromFormattedString(String formattedString) {
7
    final parts = formattedString.split('-');
8
    if (parts.length != 3) {
9
      throw FormatException('잘못된 날짜 형식: $formattedString');
10
    }
11
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
12
  }
13


14
  // 정적 프로퍼티
15
  static DateTime get tomorrow => DateTime.now().add(Duration(days: 1));
16
}
17


18
void main() {
19
  final now = DateTime.now();
20
  print(now.formattedDate); // 예: 2023-11-15
21


22
  // 정적 메서드 호출
23
  final date = DateTimeExtension.fromFormattedString('2023-11-15');
24
  print(date); // 2023-11-15 00:00:00.000
25


26
  // 정적 프로퍼티 접근
27
  print(DateTimeExtension.tomorrow);
28
}
```

### 확장과 타입 매개변수

[Section titled “확장과 타입 매개변수”](#확장과-타입-매개변수)

제네릭 타입에 대한 확장도 정의할 수 있습니다:

```dart
1
extension OptionalExtension<T> on T? {
2
  // null인 경우 기본값 반환
3
  T orDefault(T defaultValue) => this ?? defaultValue;
4


5
  // null이 아닌 경우에만 변환 함수 적용
6
  R? mapIf<R>(R Function(T) mapper) => this != null ? mapper(this as T) : null;
7


8
  // 조건부 실행
9
  void ifPresent(void Function(T) action) {
10
    if (this != null) {
11
      action(this as T);
12
    }
13
  }
14
}
15


16
void main() {
17
  String? nullableString = null;
18
  print(nullableString.orDefault('기본값')); // 기본값
19


20
  int? nullableNumber = 42;
21
  print(nullableNumber.orDefault(0)); // 42
22


23
  // 변환 예제
24
  String? name = '홍길동';
25
  int? length = name.mapIf((n) => n.length); // 3
26


27
  // 조건부 실행
28
  name.ifPresent((n) => print('안녕하세요, $n님!')); // 안녕하세요, 홍길동님!
29
  nullableString.ifPresent((s) => print(s)); // 아무것도 출력되지 않음
30
}
```

### 확장 충돌 해결

[Section titled “확장 충돌 해결”](#확장-충돌-해결)

동일한 타입에 대해 동일한 이름의 메서드나 프로퍼티를 정의하는 여러 확장이 범위 내에 있는 경우, 충돌이 발생합니다. 이를 해결하기 위해서는 확장을 명시적으로 지정해야 합니다:

```dart
1
extension NumberParsing on String {
2
  int parseInt() => int.parse(this);
3
}
4


5
extension StringParsing on String {
6
  int parseInt() => int.parse(this) * 2; // 다른 구현
7
}
8


9
void main() {
10
  // 컴파일 오류: 모호한 호출
11
  // print('42'.parseInt());
12


13
  // 확장을 명시적으로 지정하여 해결
14
  print(NumberParsing('42').parseInt()); // 42
15
  print(StringParsing('42').parseInt()); // 84
16
}
```

## Mixin(믹스인)

[Section titled “Mixin(믹스인)”](#mixin믹스인)

Mixin은 여러 클래스 계층 구조 간에 코드를 재사용하는 방법입니다. 단일 상속만 지원하는 Dart에서 믹스인을 사용하면 여러 클래스의 기능을 결합할 수 있습니다.

### 기본 구문

[Section titled “기본 구문”](#기본-구문-1)

```dart
1
mixin <믹스인명> [on <상위클래스>] {
2
  // 메서드, 게터, 세터 등
3
}
4


5
class <클래스명> [extends <상위클래스>] with <믹스인1>, <믹스인2>, ... {
6
  // 클래스 정의
7
}
```

### 간단한 믹스인 예제

[Section titled “간단한 믹스인 예제”](#간단한-믹스인-예제)

```dart
1
// Logger 믹스인 정의
2
mixin Logger {
3
  void log(String message) {
4
    print('로그: $message');
5
  }
6


7
  void error(String message) {
8
    print('오류: $message');
9
  }
10


11
  void warn(String message) {
12
    print('경고: $message');
13
  }
14
}
15


16
// 유효성 검사 믹스인 정의
17
mixin Validator {
18
  bool isValid(String value) {
19
    return value.isNotEmpty;
20
  }
21


22
  void validate(String value) {
23
    if (!isValid(value)) {
24
      throw ArgumentError('유효하지 않은 값: $value');
25
    }
26
  }
27
}
28


29
// 믹스인을 사용한 클래스 정의
30
class User with Logger, Validator {
31
  String name;
32


33
  User(this.name) {
34
    validate(name);
35
    log('새 사용자 생성: $name');
36
  }
37


38
  void changeName(String newName) {
39
    try {
40
      validate(newName);
41
      name = newName;
42
      log('이름 변경됨: $name');
43
    } catch (e) {
44
      error('이름 변경 실패: $e');
45
    }
46
  }
47
}
48


49
void main() {
50
  final user = User('홍길동');
51
  user.changeName('김철수');
52


53
  // 빈 문자열은 유효성 검사에 실패
54
  user.changeName('');
55
}
56


57
// 출력:
58
// 로그: 새 사용자 생성: 홍길동
59
// 로그: 이름 변경됨: 김철수
60
// 오류: 이름 변경 실패: ArgumentError: 유효하지 않은 값:
```

### on 키워드를 사용한 믹스인 제한

[Section titled “on 키워드를 사용한 믹스인 제한”](#on-키워드를-사용한-믹스인-제한)

믹스인이 특정 클래스나 해당 하위 클래스에서만 사용될 수 있도록 제한할 수 있습니다:

```dart
1
class Animal {
2
  String name;
3
  Animal(this.name);
4


5
  void eat() {
6
    print('$name이(가) 먹고 있습니다.');
7
  }
8
}
9


10
// Animal 클래스나 그 하위 클래스에서만 사용 가능한 믹스인
11
mixin Swimmer on Animal {
12
  void swim() {
13
    print('$name이(가) 수영하고 있습니다.');
14
    // Animal의 메서드 호출 가능
15
    eat();
16
  }
17
}
18


19
class Dog extends Animal with Swimmer {
20
  Dog(String name) : super(name);
21


22
  void bark() {
23
    print('$name: 멍멍!');
24
  }
25
}
26


27
// 다음 코드는 컴파일 오류 발생
28
// class Fish with Swimmer { // 오류: Swimmer는 Animal의 하위 클래스에서만 사용 가능
29
//   String name;
30
//   Fish(this.name);
31
// }
32


33
void main() {
34
  final dog = Dog('바둑이');
35
  dog.swim(); // 바둑이이(가) 수영하고 있습니다. + 바둑이이(가) 먹고 있습니다.
36
  dog.bark(); // 바둑이: 멍멍!
37
}
```

### 믹스인에서 변수 선언

[Section titled “믹스인에서 변수 선언”](#믹스인에서-변수-선언)

믹스인에서도 변수를 선언할 수 있습니다:

```dart
1
mixin Counter {
2
  int _count = 0;
3


4
  int get count => _count;
5


6
  void increment() {
7
    _count++;
8
  }
9


10
  void reset() {
11
    _count = 0;
12
  }
13
}
14


15
class ClickCounter with Counter {
16
  String name;
17


18
  ClickCounter(this.name);
19


20
  void click() {
21
    increment();
22
    print('$name 버튼이 $count번 클릭되었습니다.');
23
  }
24
}
25


26
void main() {
27
  final button = ClickCounter('제출');
28
  button.click(); // 제출 버튼이 1번 클릭되었습니다.
29
  button.click(); // 제출 버튼이 2번 클릭되었습니다.
30
  button.reset();
31
  button.click(); // 제출 버튼이 1번 클릭되었습니다.
32
}
```

### 믹스인 충돌 해결

[Section titled “믹스인 충돌 해결”](#믹스인-충돌-해결)

여러 믹스인에서 동일한 이름의 메서드나 프로퍼티를 정의하는 경우, 충돌이 발생합니다. 이 경우 마지막으로 적용된 믹스인의 메서드가 우선합니다:

```dart
1
mixin A {
2
  void method() {
3
    print('A의 메서드');
4
  }
5
}
6


7
mixin B {
8
  void method() {
9
    print('B의 메서드');
10
  }
11
}
12


13
// 순서에 따라 결과가 달라짐
14
class MyClass1 with A, B {}
15
class MyClass2 with B, A {}
16


17
void main() {
18
  MyClass1().method(); // B의 메서드 (B가 A 이후에 적용됨)
19
  MyClass2().method(); // A의 메서드 (A가 B 이후에 적용됨)
20
}
```

충돌을 명시적으로 해결하기 위해 클래스에서 메서드를 오버라이드할 수 있습니다:

```dart
1
class MyClass with A, B {
2
  @override
3
  void method() {
4
    print('MyClass의 메서드');
5
    super.method(); // B의 메서드 호출 (마지막으로 적용된 믹스인)
6
  }
7
}
8


9
void main() {
10
  MyClass().method();
11
  // 출력:
12
  // MyClass의 메서드
13
  // B의 메서드
14
}
```

### super 호출과 믹스인 순서

[Section titled “super 호출과 믹스인 순서”](#super-호출과-믹스인-순서)

믹스인 내에서 `super` 키워드를 사용하면 믹스인 적용 순서에 따라 결정되는 상위 구현을 호출합니다:

```dart
1
mixin A {
2
  void method() {
3
    print('A의 메서드');
4
  }
5
}
6


7
mixin B {
8
  void method() {
9
    print('B의 메서드');
10
    super.method(); // 상위 구현 호출
11
  }
12
}
13


14
mixin C {
15
  void method() {
16
    print('C의 메서드');
17
    super.method(); // 상위 구현 호출
18
  }
19
}
20


21
class Base {
22
  void method() {
23
    print('Base의 메서드');
24
  }
25
}
26


27
class MyClass extends Base with A, B, C {}
28


29
void main() {
30
  MyClass().method();
31
  // 출력:
32
  // C의 메서드
33
  // B의 메서드
34
  // A의 메서드
35
  // Base의 메서드
36
}
```

위 예제에서 호출 순서는 다음과 같습니다:

1. `MyClass`에 적용된 마지막 믹스인 `C`의 `method()`
2. `C`에서 `super.method()`를 호출하면 `B`의 `method()` 호출
3. `B`에서 `super.method()`를 호출하면 `A`의 `method()` 호출
4. `A`에서 `super.method()`가 명시적으로 호출되지 않았지만, 암시적으로 `Base`의 `method()` 호출

### 클래스와 믹스인 비교

[Section titled “클래스와 믹스인 비교”](#클래스와-믹스인-비교)

클래스와 믹스인 모두 코드 재사용 메커니즘을 제공하지만, 다음과 같은 차이점이 있습니다:

1. **인스턴스화**: 클래스는 인스턴스화할 수 있지만, 믹스인은 단독으로 인스턴스화할 수 없습니다.
2. **상속**: 믹스인은 다중 상속과 유사한 기능을 제공합니다.
3. **한정**: `on` 키워드를 사용하여 믹스인을 특정 클래스에만 적용되도록 제한할 수 있습니다.

```dart
1
// 클래스로 정의
2
class Logger {
3
  void log(String message) {
4
    print('로그: $message');
5
  }
6
}
7


8
// 믹스인으로 정의
9
mixin LoggerMixin {
10
  void log(String message) {
11
    print('로그: $message');
12
  }
13
}
14


15
// 클래스 사용
16
class UserService1 {
17
  final Logger logger = Logger();
18


19
  void doSomething() {
20
    logger.log('작업 수행 중');
21
  }
22
}
23


24
// 믹스인 사용
25
class UserService2 with LoggerMixin {
26
  void doSomething() {
27
    log('작업 수행 중'); // 직접 호출 가능
28
  }
29
}
30


31
void main() {
32
  // 클래스는 인스턴스화 가능
33
  Logger().log('직접 로깅');
34


35
  // 믹스인은 인스턴스화 불가능
36
  // LoggerMixin().log('직접 로깅'); // 오류
37


38
  UserService1().doSomething();
39
  UserService2().doSomething();
40
}
```

## 실전 예제: 확장과 믹스인 결합

[Section titled “실전 예제: 확장과 믹스인 결합”](#실전-예제-확장과-믹스인-결합)

다음 예제는 확장과 믹스인을 결합하여 데이터 검증, 직렬화, 로깅 기능을 갖춘 시스템을 구현합니다:

```dart
1
// JSON 직렬화 믹스인
2
mixin JsonSerializable {
3
  Map<String, dynamic> toJson();
4


5
  String stringify() {
6
    return jsonEncode(toJson());
7
  }
8
}
9


10
// 유효성 검사 믹스인
11
mixin Validatable {
12
  bool validate();
13


14
  List<String> getValidationErrors();
15


16
  void validateOrThrow() {
17
    if (!validate()) {
18
      throw ValidationException(getValidationErrors());
19
    }
20
  }
21
}
22


23
// 로깅 믹스인
24
mixin Loggable {
25
  String get logTag => runtimeType.toString();
26


27
  void log(String message) {
28
    print('[$logTag] $message');
29
  }
30


31
  void logInfo(String message) => log('INFO: $message');
32
  void logError(String message) => log('ERROR: $message');
33
}
34


35
// 예외 클래스
36
class ValidationException implements Exception {
37
  final List<String> errors;
38


39
  ValidationException(this.errors);
40


41
  @override
42
  String toString() => 'ValidationException: ${errors.join(', ')}';
43
}
44


45
// 날짜 확장
46
extension DateTimeExtension on DateTime {
47
  String get formattedDate => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
48


49
  bool isSameDay(DateTime other) {
50
    return year == other.year && month == other.month && day == other.day;
51
  }
52
}
53


54
// User 모델 클래스
55
class User with JsonSerializable, Validatable, Loggable {
56
  final String id;
57
  final String name;
58
  final String email;
59
  final DateTime createdAt;
60


61
  User({
62
    required this.id,
63
    required this.name,
64
    required this.email,
65
    required this.createdAt,
66
  }) {
67
    logInfo('새 사용자 생성: $name');
68
  }
69


70
  @override
71
  Map<String, dynamic> toJson() {
72
    return {
73
      'id': id,
74
      'name': name,
75
      'email': email,
76
      'created_at': createdAt.formattedDate,
77
    };
78
  }
79


80
  @override
81
  bool validate() {
82
    return id.isNotEmpty &&
83
           name.isNotEmpty &&
84
           email.contains('@') &&
85
           email.contains('.');
86
  }
87


88
  @override
89
  List<String> getValidationErrors() {
90
    final errors = <String>[];
91


92
    if (id.isEmpty) errors.add('ID는 비어있을 수 없습니다.');
93
    if (name.isEmpty) errors.add('이름은 비어있을 수 없습니다.');
94
    if (!email.contains('@') || !email.contains('.')) {
95
      errors.add('유효한 이메일이 아닙니다.');
96
    }
97


98
    return errors;
99
  }
100
}
101


102
// String 확장: 이메일 검증
103
extension EmailValidation on String {
104
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
105
}
106


107
void main() {
108
  try {
109
    // 유효한 사용자
110
    final user1 = User(
111
      id: 'user123',
112
      name: '홍길동',
113
      email: 'hong@example.com',
114
      createdAt: DateTime.now(),
115
    );
116


117
    user1.validateOrThrow();
118
    user1.logInfo('사용자 유효성 검사 통과');
119
    print(user1.stringify());
120


121
    // 유효하지 않은 사용자
122
    final user2 = User(
123
      id: 'user456',
124
      name: '',
125
      email: 'invalid-email',
126
      createdAt: DateTime.now(),
127
    );
128


129
    user2.validateOrThrow(); // 예외 발생
130
  } catch (e) {
131
    print('오류 발생: $e');
132
  }
133


134
  // 확장 메서드 사용
135
  final date = DateTime.now();
136
  print('오늘 날짜: ${date.formattedDate}');
137


138
  // 이메일 유효성 검사 확장 사용
139
  print('test@example.com은 유효한 이메일인가? ${'test@example.com'.isValidEmail}');
140
  print('invalid-email은 유효한 이메일인가? ${'invalid-email'.isValidEmail}');
141
}
```

## 결론

[Section titled “결론”](#결론)

Extension과 Mixin은 Dart에서 코드를 재사용하고 확장하는 강력한 방법을 제공합니다:

1. **Extension**은 기존 클래스(자신이 작성하지 않은 클래스도 포함)에 새로운 기능을 추가할 수 있게 해주며, 원본 코드를 수정하지 않고도 기능을 확장할 수 있습니다.

2. **Mixin**은 여러 클래스 계층 구조 간에 코드를 재사용하는 방법을 제공하며, 여러 클래스의 기능을 한 클래스에 결합할 수 있습니다.

이러한 기능을 적절히 활용하면 코드의 가독성, 재사용성, 유지 관리성을 크게 향상시킬 수 있습니다. Flutter 개발에서도 위젯 확장, 공통 기능 추출 등 다양한 상황에서 이러한 패턴을 활용할 수 있습니다.

다음 파트에서는 Flutter 위젯과 기본 UI 구성 요소에 대해 알아보겠습니다.

# 레코드 & 패턴매칭

## 레코드(Records)

[Section titled “레코드(Records)”](#레코드records)

레코드는 Dart 3.0에서 도입된 새로운 컬렉션 타입으로, 여러 필드를 그룹화하여 단일 객체로 전달할 수 있게 해줍니다. 클래스와 달리 명시적인 정의가 필요 없고, 불변(immutable)이며, 구조적으로 타입이 지정됩니다.

### 레코드 기본

[Section titled “레코드 기본”](#레코드-기본)

레코드는 괄호(`()`)를 사용하여 생성하며, 쉼표로 구분된 여러 값을 담을 수 있습니다:

```dart
1
// 간단한 레코드
2
var person = ('홍길동', 30);
3
print(person);  // (홍길동, 30)
4


5
// 위치 기반 필드 접근
6
print(person.$1);  // 홍길동
7
print(person.$2);  // 30
```

### 명명된 필드가 있는 레코드

[Section titled “명명된 필드가 있는 레코드”](#명명된-필드가-있는-레코드)

레코드에 이름이 있는 필드를 포함할 수 있습니다:

```dart
1
// 명명된 필드가 있는 레코드
2
var person = (name: '홍길동', age: 30);
3


4
// 명명된 필드 접근
5
print(person.name);  // 홍길동
6
print(person.age);   // 30
7


8
// 혼합 사용
9
var data = ('홍길동', age: 30, active: true);
10
print(data.$1);      // 홍길동
11
print(data.age);     // 30
12
print(data.active);  // true
```

### 레코드 타입 지정

[Section titled “레코드 타입 지정”](#레코드-타입-지정)

레코드에 명시적인 타입을 지정할 수 있습니다:

```dart
1
// 타입이 명시된 레코드
2
(String, int) person = ('홍길동', 30);
3


4
// 명명된 필드가 있는 레코드 타입
5
({String name, int age}) person = (name: '홍길동', age: 30);
6


7
// 혼합 타입
8
(String, {int age, bool active}) data = ('홍길동', age: 30, active: true);
```

### 레코드의 유용성

[Section titled “레코드의 유용성”](#레코드의-유용성)

#### 1. 여러 값 반환

[Section titled “1. 여러 값 반환”](#1-여러-값-반환)

함수에서 여러 값을 반환할 때 유용합니다:

```dart
1
// 여러 값 반환
2
(String, int) getUserInfo() {
3
  return ('홍길동', 30);
4
}
5


6
void main() {
7
  var (name, age) = getUserInfo();
8
  print('이름: $name, 나이: $age');  // 이름: 홍길동, 나이: 30
9
}
```

#### 2. 구조 분해 할당

[Section titled “2. 구조 분해 할당”](#2-구조-분해-할당)

레코드는 구조 분해 할당을 지원합니다:

```dart
1
var person = (name: '홍길동', age: 30);
2


3
// 구조 분해
4
var (name: userName, age: userAge) = person;
5
print('이름: $userName, 나이: $userAge');  // 이름: 홍길동, 나이: 30
6


7
// 간단한 구조 분해
8
var (:name, :age) = person;
9
print('이름: $name, 나이: $age');  // 이름: 홍길동, 나이: 30
```

#### 3. 그룹화된 데이터 전달

[Section titled “3. 그룹화된 데이터 전달”](#3-그룹화된-데이터-전달)

여러 값을 그룹화하여 전달할 때 유용합니다:

```dart
1
void printPersonInfo((String, int) person) {
2
  print('이름: ${person.$1}, 나이: ${person.$2}');
3
}
4


5
void printUserDetails({String name, int age, String? address}) {
6
  print('이름: $name, 나이: $age, 주소: ${address ?? '정보 없음'}');
7
}
8


9
void main() {
10
  printPersonInfo(('홍길동', 30));  // 이름: 홍길동, 나이: 30
11


12
  var userDetails = (name: '김철수', age: 25, address: '서울시');
13
  printUserDetails(userDetails);  // 이름: 김철수, 나이: 25, 주소: 서울시
14
}
```

### 레코드 비교

[Section titled “레코드 비교”](#레코드-비교)

레코드는 값 기반 비교를 지원합니다:

```dart
1
void main() {
2
  var person1 = (name: '홍길동', age: 30);
3
  var person2 = (name: '홍길동', age: 30);
4
  var person3 = (name: '김철수', age: 25);
5


6
  print(person1 == person2);  // true (동일한 값)
7
  print(person1 == person3);  // false (다른 값)
8


9
  // 위치 기반 레코드도 같음
10
  var p1 = ('홍길동', 30);
11
  var p2 = ('홍길동', 30);
12
  print(p1 == p2);  // true
13
}
```

### 레코드 사용 예제

[Section titled “레코드 사용 예제”](#레코드-사용-예제)

#### 1. 통계 계산

[Section titled “1. 통계 계산”](#1-통계-계산)

```dart
1
(double min, double max, double average) calculateStats(List<double> values) {
2
  if (values.isEmpty) {
3
    return (0, 0, 0);
4
  }
5
  double sum = 0;
6
  double min = values[0];
7
  double max = values[0];
8


9
  for (var value in values) {
10
    sum += value;
11
    if (value < min) min = value;
12
    if (value > max) max = value;
13
  }
14


15
  return (min, max, sum / values.length);
16
}
17


18
void main() {
19
  var numbers = [10.5, 25.3, 17.2, 8.7, 30.1];
20
  var (min, max, avg) = calculateStats(numbers);
21


22
  print('최소값: $min');   // 최소값: 8.7
23
  print('최대값: $max');   // 최대값: 30.1
24
  print('평균값: $avg');   // 평균값: 18.36
25
}
```

#### 2. API 응답 처리

[Section titled “2. API 응답 처리”](#2-api-응답-처리)

```dart
1
(bool success, {String? data, String? error}) fetchUserData(String userId) {
2
  // 서버 요청 시뮬레이션
3
  if (userId == 'user123') {
4
    return (true, data: '{"name": "홍길동", "email": "hong@example.com"}', error: null);
5
  } else {
6
    return (false, data: null, error: '사용자를 찾을 수 없습니다.');
7
  }
8
}
9


10
void main() {
11
  // 성공 케이스
12
  var (success: isSuccess, data: userData, error: _) = fetchUserData('user123');
13


14
  if (isSuccess && userData != null) {
15
    print('사용자 데이터: $userData');
16
  }
17


18
  // 실패 케이스
19
  var result = fetchUserData('unknown');
20


21
  if (!result.success) {
22
    print('오류: ${result.error}');  // 오류: 사용자를 찾을 수 없습니다.
23
  }
24
}
```

## 패턴 매칭(Pattern Matching)

[Section titled “패턴 매칭(Pattern Matching)”](#패턴-매칭pattern-matching)

패턴 매칭은 Dart 3.0에서 도입된 기능으로, 데이터 구조에서 특정 패턴을 검색하고 추출하는 강력한 방법을 제공합니다.

### 패턴 매칭 기본

[Section titled “패턴 매칭 기본”](#패턴-매칭-기본)

패턴 매칭을 사용하면 복잡한 데이터 구조에서 데이터를 쉽게 추출하고 검사할 수 있습니다:

```dart
1
// 레코드 패턴 매칭
2
var person = ('홍길동', 30);
3


4
var (name, age) = person;
5
print('이름: $name, 나이: $age');  // 이름: 홍길동, 나이: 30
6


7
// 리스트 패턴 매칭
8
var numbers = [1, 2, 3];
9


10
var [first, second, third] = numbers;
11
print('$first, $second, $third');  // 1, 2, 3
12


13
// 맵 패턴 매칭
14
var user = {'name': '홍길동', 'age': 30};
15


16
var {'name': userName, 'age': userAge} = user;
17
print('이름: $userName, 나이: $userAge');  // 이름: 홍길동, 나이: 30
```

### switch 문에서의 패턴 매칭

[Section titled “switch 문에서의 패턴 매칭”](#switch-문에서의-패턴-매칭)

패턴 매칭은 `switch` 문에서 특히 강력합니다:

```dart
1
void describe(Object obj) {
2
  switch (obj) {
3
    case int i when i > 0:
4
      print('양수: $i');
5
    case int i when i < 0:
6
      print('음수: $i');
7
    case int i when i == 0:
8
      print('0');
9
    case String s when s.isEmpty:
10
      print('빈 문자열');
11
    case String s:
12
      print('문자열: $s');
13
    case List<int> list:
14
      print('정수 리스트: $list');
15
    case (String, int) pair:
16
      print('문자열-정수 쌍: ${pair.$1}, ${pair.$2}');
17
    case (String name, int age):
18
      print('이름: $name, 나이: $age');
19
    default:
20
      print('기타 객체: $obj');
21
  }
22
}
23


24
void main() {
25
  describe(42);             // 양수: 42
26
  describe(-10);            // 음수: -10
27
  describe(0);              // 0
28
  describe('');             // 빈 문자열
29
  describe('안녕하세요');      // 문자열: 안녕하세요
30
  describe([1, 2, 3]);      // 정수 리스트: [1, 2, 3]
31
  describe(('홍길동', 30));   // 이름: 홍길동, 나이: 30
32
  describe(true);           // 기타 객체: true
33
}
```

### if-case 문

[Section titled “if-case 문”](#if-case-문)

패턴 매칭은 `if-case` 문에서도 사용할 수 있습니다:

```dart
1
void processValue(Object value) {
2
  if (value case String s when s.length > 5) {
3
    print('긴 문자열: $s');
4
  } else if (value case int n when n > 10) {
5
    print('큰 정수: $n');
6
  } else if (value case (String name, int age)) {
7
    print('이름: $name, 나이: $age');
8
  } else {
9
    print('처리할 수 없는 값: $value');
10
  }
11
}
12


13
void main() {
14
  processValue('안녕하세요, 반갑습니다');  // 긴 문자열: 안녕하세요, 반갑습니다
15
  processValue(42);                  // 큰 정수: 42
16
  processValue(('홍길동', 30));        // 이름: 홍길동, 나이: 30
17
  processValue(true);                // 처리할 수 없는 값: true
18
}
```

### 논리 OR 패턴

[Section titled “논리 OR 패턴”](#논리-or-패턴)

여러 패턴을 `|` 연산자로 결합할 수 있습니다:

```dart
1
Object value = 42;
2


3
switch (value) {
4
  case String s | int i:
5
    print('문자열 또는 정수: $value');
6
  case List<dynamic> l | Map<dynamic, dynamic> m:
7
    print('리스트 또는 맵');
8
  default:
9
    print('기타 타입');
10
}
```

### 중첩 패턴 매칭

[Section titled “중첩 패턴 매칭”](#중첩-패턴-매칭)

패턴은 중첩될 수 있어 복잡한 데이터 구조에서도 사용할 수 있습니다:

```dart
1
// 복잡한 데이터 구조
2
var person = {
3
  'name': '홍길동',
4
  'age': 30,
5
  'address': {
6
    'city': '서울',
7
    'zipcode': '12345'
8
  },
9
  'hobbies': ['독서', '여행', '음악']
10
};
11


12
// 중첩 패턴 매칭
13
if (person case {'name': String name, 'address': {'city': String city}}) {
14
  print('$name은(는) $city에 살고 있습니다.');  // 홍길동은(는) 서울에 살고 있습니다.
15
}
16


17
// 리스트와 레코드의 중첩 패턴
18
var data = [('홍길동', 30), ('김철수', 25)];
19


20
if (data case [(String s, int i), var rest]) {
21
  print('첫 번째 사람: $s, $i살');  // 첫 번째 사람: 홍길동, 30살
22
  print('나머지: $rest');         // 나머지: (김철수, 25)
23
}
```

### var 패턴과 와일드카드 패턴

[Section titled “var 패턴과 와일드카드 패턴”](#var-패턴과-와일드카드-패턴)

변수에 값을 캡처하거나 값을 무시할 수 있습니다:

```dart
1
// var 패턴 (값 캡처)
2
var list = [1, 2, 3, 4, 5];
3


4
if (list case [var first, var second, ...]) {
5
  print('처음 두 값: $first, $second');  // 처음 두 값: 1, 2
6
}
7


8
// 와일드카드 패턴 (값 무시)
9
var record = ('홍길동', 30, '서울');
10


11
if (record case (String name, _, var city)) {
12
  print('$name은(는) $city에 살고 있습니다.');  // 홍길동은(는) 서울에 살고 있습니다.
13
}
```

### 일정한 리스트 패턴

[Section titled “일정한 리스트 패턴”](#일정한-리스트-패턴)

리스트의 특정 위치에 있는 값을 추출할 수 있습니다:

```dart
1
var numbers = [1, 2, 3, 4, 5];
2


3
switch (numbers) {
4
  case [var first, var second, ...var rest]:
5
    print('첫 번째: $first');   // 첫 번째: 1
6
    print('두 번째: $second');  // 두 번째: 2
7
    print('나머지: $rest');     // 나머지: [3, 4, 5]
8
  default:
9
    print('빈 리스트 또는 다른 형태');
10
}
11


12
// 특정 패턴 검색
13
var list = [1, 2, 3, 4, 5];
14


15
if (list case [_, _, 3, ..., 5]) {
16
  print('리스트가 패턴과 일치합니다.');  // 리스트가 패턴과 일치합니다.
17
}
```

### 객체 패턴

[Section titled “객체 패턴”](#객체-패턴)

클래스 인스턴스의 속성을 추출할 수도 있습니다:

```dart
1
class Person {
2
  final String name;
3
  final int age;
4


5
  Person(this.name, this.age);
6
}
7


8
void describePerson(Person person) {
9
  switch (person) {
10
    case Person(name: 'Unknown', age: var a):
11
      print('알 수 없는 사람, 나이: $a');
12
    case Person(name: var n, age: > 18):
13
      print('성인: $n');
14
    case Person(name: var n):
15
      print('미성년자: $n');
16
  }
17
}
18


19
void main() {
20
  describePerson(Person('홍길동', 30));  // 성인: 홍길동
21
  describePerson(Person('김영희', 15));  // 미성년자: 김영희
22
}
```

### 타입 패턴과 조건 패턴

[Section titled “타입 패턴과 조건 패턴”](#타입-패턴과-조건-패턴)

```dart
1
void process(dynamic value) {
2
  switch (value) {
3
    // 타입 패턴
4
    case int():
5
      print('정수: $value');
6


7
    // 타입 패턴과 조건 패턴
8
    case String() when value.length > 5:
9
      print('긴 문자열: $value');
10
    case String():
11
      print('짧은 문자열: $value');
12


13
    // 리스트 + 조건 패턴
14
    case List<int> l when l.every((e) => e > 0):
15
      print('양수 리스트: $value');
16


17
    // 레코드 + 조건 패턴
18
    case (String n, int a) when a >= 18:
19
      print('성인: $n, $a살');
20
    case (String n, int a):
21
      print('미성년자: $n, $a살');
22


23
    default:
24
      print('기타 값: $value');
25
  }
26
}
27


28
void main() {
29
  process(42);                 // 정수: 42
30
  process('Hello');            // 짧은 문자열: Hello
31
  process('안녕하세요, 반갑습니다');  // 긴 문자열: 안녕하세요, 반갑습니다
32
  process([1, 2, 3]);          // 양수 리스트: [1, 2, 3]
33
  process([-1, 2, 3]);         // 기타 값: [-1, 2, 3]
34
  process(('홍길동', 30));       // 성인: 홍길동, 30살
35
  process(('김영희', 15));       // 미성년자: 김영희, 15살
36
}
```

## 실전 예제

[Section titled “실전 예제”](#실전-예제)

### 1. REST API 응답 처리

[Section titled “1. REST API 응답 처리”](#1-rest-api-응답-처리)

```dart
1
// API 응답 시뮬레이션
2
Map<String, dynamic> fetchUserResponse() {
3
  return {
4
    'status': 'success',
5
    'data': {
6
      'user': {
7
        'id': 123,
8
        'name': '홍길동',
9
        'email': 'hong@example.com',
10
        'addresses': [
11
          {'type': 'home', 'city': '서울', 'zipcode': '12345'},
12
          {'type': 'work', 'city': '부산', 'zipcode': '67890'},
13
        ]
14
      }
15
    }
16
  };
17
}
18


19
void main() {
20
  var response = fetchUserResponse();
21


22
  // 패턴 매칭으로 응답 처리
23
  switch (response) {
24
    case {'status': 'success', 'data': {'user': var user}}:
25
      if (user case {'name': String name, 'email': String email, 'addresses': var addresses}) {
26
        print('사용자 이름: $name, 이메일: $email');
27


28
        if (addresses case List<Map<String, dynamic>> addressList) {
29
          for (var address in addressList) {
30
            if (address case {'type': 'home', 'city': String city}) {
31
              print('집 주소: $city');
32
            }
33
          }
34
        }
35
      }
36
    case {'status': 'error', 'message': String message}:
37
      print('오류: $message');
38
    default:
39
      print('알 수 없는 응답');
40
  }
41
}
```

### 2. 데이터 변환 및 검증

[Section titled “2. 데이터 변환 및 검증”](#2-데이터-변환-및-검증)

```dart
1
// 데이터 변환 및 검증
2
(bool isValid, {String? data, String? error}) validateUserData(Object input) {
3
  return switch (input) {
4
    Map<String, dynamic> map when map.containsKey('name') && map.containsKey('age') =>
5
      map['age'] is int && map['age'] > 0
6
        ? (true, data: '유효한 사용자 데이터', error: null)
7
        : (false, data: null, error: '나이는 양의 정수여야 합니다.'),
8


9
    (String name, var age) when age is int && age > 0 =>
10
      (true, data: '유효한 사용자 레코드', error: null),
11


12
    String s when RegExp(r'^[a-zA-Z0-9]+,\s*\d+$').hasMatch(s) =>
13
      (true, data: '유효한 사용자 문자열', error: null),
14


15
    _ =>
16
      (false, data: null, error: '지원하지 않는 형식')
17
  };
18
}
19


20
void main() {
21
  // 다양한 입력 형식 테스트
22
  var result1 = validateUserData({'name': '홍길동', 'age': 30});
23
  var result2 = validateUserData(('김철수', 25));
24
  var result3 = validateUserData('이영희, 20');
25
  var result4 = validateUserData({'name': '박지성', 'age': -5});
26
  var result5 = validateUserData(42);
27


28
  for (var result in [result1, result2, result3, result4, result5]) {
29
    if (result.isValid) {
30
      print('검증 성공: ${result.data}');
31
    } else {
32
      print('검증 실패: ${result.error}');
33
    }
34
  }
35
}
```

## 결론

[Section titled “결론”](#결론)

레코드와 패턴 매칭은 Dart 3에서 도입된 강력한 기능으로, 코드를 더 간결하고 표현력 있게 만들 수 있습니다. 레코드는 여러 값을 그룹화하고 반환하는 간편한 방법을 제공하며, 패턴 매칭은 복잡한 데이터 구조에서 값을 쉽게 추출하고 분석할 수 있게 해줍니다.

이러한 기능은 다음과 같은 상황에서 특히 유용합니다:

* 함수에서 여러 값 반환
* 데이터 구조에서 특정 패턴 검색
* 조건부 로직 간소화
* API 응답 처리
* 데이터 변환 및 검증

Dart의 레코드와 패턴 매칭을 활용하면 더 선언적이고 안전한 코드를 작성할 수 있으며, 이는 Flutter 애플리케이션에서도 큰 도움이 됩니다.

다음 장에서는 Dart의 비동기 프로그래밍에 대해 알아보겠습니다.

# 타입 시스템 & 제네릭

## Dart 타입 시스템 개요

[Section titled “Dart 타입 시스템 개요”](#dart-타입-시스템-개요)

Dart는 정적 타입 언어로, 컴파일 시간에 타입 검사를 수행합니다. 그러나 타입 추론을 지원하여 타입 선언을 생략할 수 있는 유연성도 제공합니다. Dart 2부터는 타입 안전성이 강화되었고, Dart 2.12부터는 null 안전성이 도입되었습니다.

## 기본 타입

[Section titled “기본 타입”](#기본-타입)

### 기본 제공 타입

[Section titled “기본 제공 타입”](#기본-제공-타입)

Dart에는 다음과 같은 기본 타입이 있습니다:

```dart
1
// 숫자 타입
2
int integer = 42;
3
double decimal = 3.14;
4
num number = 10;  // int나 double의 상위 타입
5


6
// 문자열
7
String text = '안녕하세요';
8


9
// 불리언
10
bool flag = true;
11


12
// 리스트(배열)
13
List<int> numbers = [1, 2, 3];
14


15
// 맵(딕셔너리)
16
Map<String, dynamic> person = {'name': '홍길동', 'age': 30};
17


18
// 집합
19
Set<String> uniqueNames = {'홍길동', '김철수', '이영희'};
20


21
// 심볼
22
Symbol symbol = #symbolName;
```

### 특수 타입

[Section titled “특수 타입”](#특수-타입)

Dart에는 특수한 용도의 타입도 있습니다:

```dart
1
// void: 값을 반환하지 않는 함수의 반환 타입
2
void printMessage() {
3
  print('메시지 출력');
4
}
5


6
// dynamic: 모든 타입을 허용하는 동적 타입
7
dynamic dynamicValue = '문자열';
8
dynamicValue = 42;  // 타입 변경 가능
9


10
// Object: 모든 객체의 기본 타입
11
Object objectValue = 'Hello';
12


13
// Null: null 값의 타입 (Dart 2.12 이전)
```

## 타입 추론

[Section titled “타입 추론”](#타입-추론)

Dart는 변수의 초기값을 기반으로 타입을 추론할 수 있습니다:

```dart
1
// 타입 추론
2
var name = '홍길동';      // String 타입으로 추론
3
var age = 30;           // int 타입으로 추론
4
var height = 175.5;     // double 타입으로 추론
5
var active = true;      // bool 타입으로 추론
6
var items = [1, 2, 3];  // List<int> 타입으로 추론
7


8
// 함수에서도 반환 타입 추론
9
var getName = () {
10
  return '홍길동';  // String 반환 타입으로 추론
11
};
12


13
// 컬렉션에서도 타입 추론
14
var people = [      // List<Map<String, Object>> 타입으로 추론
15
  {'name': '홍길동', 'age': 30},
16
  {'name': '김철수', 'age': 25},
17
];
```

## 타입 체크와 캐스팅

[Section titled “타입 체크와 캐스팅”](#타입-체크와-캐스팅)

### is와 is! 연산자

[Section titled “is와 is! 연산자”](#is와-is-연산자)

타입을 확인하기 위해 `is`와 `is!` 연산자를 사용합니다:

```dart
1
Object value = '문자열';
2


3
if (value is String) {
4
  // value는 이 블록 내에서 String 타입으로 취급됨 (스마트 캐스팅)
5
  print('문자열 길이: ${value.length}');
6
}
7


8
if (value is! int) {
9
  print('정수가 아닙니다');
10
}
```

### as 연산자

[Section titled “as 연산자”](#as-연산자)

타입 캐스팅을 위해 `as` 연산자를 사용합니다:

```dart
1
Object value = '문자열';
2


3
// String으로 캐스팅
4
String text = value as String;
5
print(text.toUpperCase());
6


7
// 잘못된 캐스팅은 런타임 오류 발생
8
// int number = value as int;  // 오류: String을 int로 캐스팅 불가
```

## 제네릭(Generics)

[Section titled “제네릭(Generics)”](#제네릭generics)

제네릭은 타입을 매개변수로 사용하여 코드를 재사용할 수 있게 해주는 기능입니다.

### 제네릭 클래스

[Section titled “제네릭 클래스”](#제네릭-클래스)

```dart
1
// 제네릭 클래스 정의
2
class Box<T> {
3
  T value;
4


5
  Box(this.value);
6


7
  T getValue() {
8
    return value;
9
  }
10


11
  void setValue(T newValue) {
12
    value = newValue;
13
  }
14
}
15


16
// 제네릭 클래스 사용
17
void main() {
18
  // String 타입의 Box
19
  var stringBox = Box<String>('안녕하세요');
20
  print(stringBox.getValue());  // '안녕하세요'
21


22
  // int 타입의 Box
23
  var intBox = Box<int>(42);
24
  print(intBox.getValue());  // 42
25


26
  // 타입 추론을 통한 인스턴스화
27
  var doubleBox = Box(3.14);  // Box<double>로 추론
28
}
```

### 제네릭 함수

[Section titled “제네릭 함수”](#제네릭-함수)

```dart
1
// 제네릭 함수 정의
2
T first<T>(List<T> items) {
3
  return items.first;
4
}
5


6
// 제네릭 함수 사용
7
void main() {
8
  var names = ['홍길동', '김철수', '이영희'];
9
  var firstString = first<String>(names);
10
  print(firstString);  // '홍길동'
11


12
  var numbers = [1, 2, 3, 4, 5];
13
  var firstInt = first(numbers);  // 타입 추론으로 T는 int로 결정
14
  print(firstInt);  // 1
15
}
```

### 제네릭 타입 제한

[Section titled “제네릭 타입 제한”](#제네릭-타입-제한)

특정 타입이나 상위 타입으로 제한할 수 있습니다:

```dart
1
// 상위 타입 제한
2
class NumberBox<T extends num> {
3
  T value;
4


5
  NumberBox(this.value);
6


7
  void square() {
8
    // T가 num의 하위 타입이므로 곱셈 연산 가능
9
    print(value * value);
10
  }
11
}
12


13
void main() {
14
  var intBox = NumberBox<int>(10);
15
  intBox.square();  // 100
16


17
  var doubleBox = NumberBox<double>(2.5);
18
  doubleBox.square();  // 6.25
19


20
  // var stringBox = NumberBox<String>('오류');  // 컴파일 오류: String은 num의 하위 타입이 아님
21
}
```

### 다양한 제네릭 적용

[Section titled “다양한 제네릭 적용”](#다양한-제네릭-적용)

```dart
1
// 다중 타입 매개변수
2
class Pair<K, V> {
3
  K first;
4
  V second;
5


6
  Pair(this.first, this.second);
7
}
8


9
// 제네릭 확장
10
class IntBox extends Box<int> {
11
  IntBox(int value) : super(value);
12


13
  void increment() {
14
    setValue(getValue() + 1);
15
  }
16
}
17


18
// 제네릭 타입 별칭
19
typedef StringList = List<String>;
20
typedef KeyValueMap<K, V> = Map<K, V>;
```

## 컬렉션 타입과 제네릭

[Section titled “컬렉션 타입과 제네릭”](#컬렉션-타입과-제네릭)

### List와 제네릭

[Section titled “List와 제네릭”](#list와-제네릭)

```dart
1
// 타입 지정 리스트
2
List<String> names = ['홍길동', '김철수', '이영희'];
3
List<int> scores = [90, 85, 95];
4


5
// 컬렉션 리터럴로 생성
6
var fruits = <String>['사과', '바나나', '오렌지'];
7


8
// 생성자로 생성
9
var numbers = List<int>.filled(5, 0);  // [0, 0, 0, 0, 0]
10
var evens = List<int>.generate(5, (i) => i * 2);  // [0, 2, 4, 6, 8]
11


12
// 제네릭 메서드 사용
13
var filteredNames = names.where((name) => name.length > 2).toList();
14
var mappedScores = scores.map((score) => score * 1.1).toList();
```

### Map과 제네릭

[Section titled “Map과 제네릭”](#map과-제네릭)

```dart
1
// 타입 지정 맵
2
Map<String, int> ages = {
3
  '홍길동': 30,
4
  '김철수': 25,
5
  '이영희': 28,
6
};
7


8
// 컬렉션 리터럴로 생성
9
var scores = <String, double>{
10
  '수학': 90.5,
11
  '영어': 85.0,
12
  '과학': 95.5,
13
};
14


15
// 생성자로 생성
16
var config = Map<String, dynamic>();
17
config['debug'] = true;
18
config['timeout'] = 30;
```

### Set과 제네릭

[Section titled “Set과 제네릭”](#set과-제네릭)

```dart
1
// 타입 지정 집합
2
Set<String> uniqueNames = {'홍길동', '김철수', '이영희'};
3


4
// 컬렉션 리터럴로 생성
5
var colors = <String>{'빨강', '파랑', '녹색'};
6


7
// 생성자로 생성
8
var numbers = Set<int>.from([1, 2, 3, 3, 4]);  // {1, 2, 3, 4}
```

## 타입 시스템의 고급 기능

[Section titled “타입 시스템의 고급 기능”](#타입-시스템의-고급-기능)

### typedef

[Section titled “typedef”](#typedef)

함수 타입 또는 타입 별칭을 정의할 수 있습니다:

```dart
1
// 함수 타입 정의
2
typedef IntOperation = int Function(int a, int b);
3


4
int add(int a, int b) => a + b;
5
int subtract(int a, int b) => a - b;
6


7
void calculate(IntOperation operation, int x, int y) {
8
  print('결과: ${operation(x, y)}');
9
}
10


11
void main() {
12
  calculate(add, 10, 5);      // 결과: 15
13
  calculate(subtract, 10, 5); // 결과: 5
14
}
```

Dart 2.13부터는 함수 타입뿐만 아니라 모든 타입의 별칭을 정의할 수 있습니다:

```dart
1
// 타입 별칭 정의
2
typedef StringList = List<String>;
3
typedef UserInfo = Map<String, dynamic>;
4


5
void printNames(StringList names) {
6
  for (var name in names) {
7
    print(name);
8
  }
9
}
10


11
void displayUserInfo(UserInfo user) {
12
  print('이름: ${user['name']}, 나이: ${user['age']}');
13
}
14


15
void main() {
16
  StringList names = ['홍길동', '김철수', '이영희'];
17
  printNames(names);
18


19
  UserInfo user = {'name': '홍길동', '나이': 30};
20
  displayUserInfo(user);
21
}
```

### 타입 프로모션

[Section titled “타입 프로모션”](#타입-프로모션)

Dart는 타입 검사 이후 변수의 타입을 자동으로 더 구체적인 타입으로 승격(프로모션)합니다:

```dart
1
Object value = '안녕하세요';
2


3
// 타입 검사 후 자동으로 String으로 프로모션됨
4
if (value is String) {
5
  // 이 블록 내에서는 value가 String 타입으로 취급됨
6
  print('대문자: ${value.toUpperCase()}');
7
  print('길이: ${value.length}');
8
}
9


10
// 블록 밖에서는 다시 원래 타입 (Object)
11
// print(value.length);  // 오류: Object에는 length 속성이 없음
```

### 유니온 타입 (Dart 3)

[Section titled “유니온 타입 (Dart 3)”](#유니온-타입-dart-3)

Dart 3부터는 유니온 타입을 지원합니다:

```dart
1
Object value = '문자열';
2


3
// as 대신 패턴 매칭으로 타입 처리
4
switch (value) {
5
  case String():
6
    print('문자열: $value');
7
  case int():
8
    print('정수: $value');
9
  default:
10
    print('기타 타입: $value');
11
}
```

## 실전 예제: 제네릭 활용

[Section titled “실전 예제: 제네릭 활용”](#실전-예제-제네릭-활용)

### 데이터 캐싱 클래스

[Section titled “데이터 캐싱 클래스”](#데이터-캐싱-클래스)

```dart
1
class Cache<T> {
2
  final Map<String, T> _cache = {};
3


4
  T? get(String key) {
5
    return _cache[key];
6
  }
7


8
  void set(String key, T value) {
9
    _cache[key] = value;
10
  }
11


12
  bool has(String key) {
13
    return _cache.containsKey(key);
14
  }
15


16
  void remove(String key) {
17
    _cache.remove(key);
18
  }
19


20
  void clear() {
21
    _cache.clear();
22
  }
23
}
24


25
// 사용 예
26
void main() {
27
  var stringCache = Cache<String>();
28
  stringCache.set('greeting', '안녕하세요');
29
  print(stringCache.get('greeting'));  // '안녕하세요'
30


31
  var userCache = Cache<Map<String, dynamic>>();
32
  userCache.set('user1', {'name': '홍길동', 'age': 30});
33
  var user = userCache.get('user1');
34
  print('사용자: ${user?['name']}, 나이: ${user?['age']}');
35
}
```

### Result 타입

[Section titled “Result 타입”](#result-타입)

성공 또는 실패 결과를 나타내는 제네릭 클래스:

```dart
1
abstract class Result<S, E> {
2
  Result();
3


4
  factory Result.success(S value) = Success<S, E>;
5
  factory Result.failure(E error) = Failure<S, E>;
6


7
  bool get isSuccess;
8
  bool get isFailure;
9
  S? get value;
10
  E? get error;
11


12
  void when({
13
    required void Function(S value) success,
14
    required void Function(E error) failure,
15
  });
16
}
17


18
class Success<S, E> extends Result<S, E> {
19
  final S _value;
20


21
  Success(this._value);
22


23
  @override
24
  bool get isSuccess => true;
25


26
  @override
27
  bool get isFailure => false;
28


29
  @override
30
  S get value => _value;
31


32
  @override
33
  E? get error => null;
34


35
  @override
36
  void when({
37
    required void Function(S value) success,
38
    required void Function(E error) failure,
39
  }) {
40
    success(_value);
41
  }
42
}
43


44
class Failure<S, E> extends Result<S, E> {
45
  final E _error;
46


47
  Failure(this._error);
48


49
  @override
50
  bool get isSuccess => false;
51


52
  @override
53
  bool get isFailure => true;
54


55
  @override
56
  S? get value => null;
57


58
  @override
59
  E get error => _error;
60


61
  @override
62
  void when({
63
    required void Function(S value) success,
64
    required void Function(E error) failure,
65
  }) {
66
    failure(_error);
67
  }
68
}
69


70
// 사용 예
71
Result<String, Exception> fetchData() {
72
  try {
73
    // 데이터 가져오기 로직
74
    return Result.success('데이터');
75
  } catch (e) {
76
    return Result.failure(Exception('데이터를 가져오는 중 오류 발생: $e'));
77
  }
78
}
79


80
void main() {
81
  var result = fetchData();
82


83
  result.when(
84
    success: (data) {
85
      print('성공: $data');
86
    },
87
    failure: (error) {
88
      print('실패: $error');
89
    },
90
  );
91
}
```

![fpdart code](https://raw.githubusercontent.com/SandroMaglione/fpdart/main/resources/screenshots/screenshot_fpdart.png)

[fpdart](https://pub.dev/packages/fpdart)를 이용하면 Result외에 더 다양한 함수형 프로그래밍 기능을 사용하실 수 있습니다.

## 결론

[Section titled “결론”](#결론)

Dart의 타입 시스템과 제네릭은 타입 안전성과 코드 재사용성을 동시에 얻을 수 있게 해줍니다. 정적 타입 시스템은 컴파일 시간에 많은 오류를 잡아낼 수 있으며, 제네릭은 다양한 타입에 대해 동일한 로직을 적용할 수 있게 해줍니다.

다음 장에서는 Dart의 클래스, 생성자, 팩토리 등 객체 지향 프로그래밍의 핵심 개념에 대해 알아보겠습니다.

# 주요 위젯

Flutter는 다양한 UI 요소를 구현하기 위한 풍부한 위젯 세트를 제공합니다. 이 장에서는 Flutter 앱을 구축할 때 자주 사용되는 핵심 위젯들을 살펴보겠습니다.

## 위젯 카테고리

[Section titled “위젯 카테고리”](#위젯-카테고리)

Flutter 위젯은 기능과 용도에 따라 다양한 카테고리로 분류할 수 있습니다:

이 장에서는 기본적인 디스플레이, 입력, 컨테이너 위젯을 중점적으로 살펴보겠습니다. 레이아웃 위젯은 다음 장에서 자세히 다룰 예정입니다.

## 기본 디스플레이 위젯

[Section titled “기본 디스플레이 위젯”](#기본-디스플레이-위젯)

### Text

[Section titled “Text”](#text)

`Text` 위젯은 애플리케이션에 스타일이 지정된 텍스트를 표시합니다.

```dart
1
Text(
2
  '안녕하세요, Flutter!',
3
  style: TextStyle(
4
    fontWeight: FontWeight.bold,
5
    fontSize: 20,
6
    color: Colors.blue,
7
    letterSpacing: 1.2,
8
    height: 1.4,
9
  ),
10
  textAlign: TextAlign.center,
11
  maxLines: 2,
12
  overflow: TextOverflow.ellipsis,
13
)
```

**주요 속성**:

* `style`: 텍스트의 시각적 형식 지정 (색상, 크기, 굵기 등)
* `textAlign`: 텍스트 정렬 방법
* `maxLines`: 최대 표시 줄 수
* `overflow`: 내용이 공간을 초과할 때 처리 방법
* `softWrap`: 줄 바꿈 허용 여부

### RichText

[Section titled “RichText”](#richtext)

`RichText` 위젯은 서로 다른 스타일의 텍스트를 한 줄에 표시할 수 있게 해줍니다.

```dart
1
RichText(
2
  text: TextSpan(
3
    text: '안녕하세요, ',
4
    style: TextStyle(color: Colors.black),
5
    children: [
6
      TextSpan(
7
        text: '홍길동',
8
        style: TextStyle(
9
          fontWeight: FontWeight.bold,
10
          color: Colors.blue,
11
        ),
12
      ),
13
      TextSpan(
14
        text: '님!',
15
        style: TextStyle(color: Colors.black),
16
      ),
17
    ],
18
  ),
19
)
```

### Image

[Section titled “Image”](#image)

`Image` 위젯은 다양한 소스에서 이미지를 표시합니다.

```dart
1
// 네트워크 이미지
2
Image.network(
3
  'https://flutter.dev/images/flutter-logo.png',
4
  width: 200,
5
  height: 100,
6
  fit: BoxFit.cover,
7
  loadingBuilder: (context, child, loadingProgress) {
8
    if (loadingProgress == null) return child;
9
    return CircularProgressIndicator();
10
  },
11
  errorBuilder: (context, error, stackTrace) {
12
    return Text('이미지를 불러올 수 없습니다');
13
  },
14
)
15


16
// 에셋 이미지
17
Image.asset(
18
  'assets/images/flutter_logo.png',
19
  width: 200,
20
  height: 100,
21
)
22


23
// 파일 이미지
24
Image.file(
25
  File('/path/to/image.jpg'),
26
  width: 200,
27
  height: 100,
28
)
29


30
// 메모리 이미지
31
Image.memory(
32
  Uint8List(...),
33
  width: 200,
34
  height: 100,
35
)
```

**주요 속성**:

* `width`, `height`: 이미지 크기
* `fit`: 이미지가 제공된 영역에 맞는 방식 (cover, contain, fill 등)
* `color`, `colorBlendMode`: 이미지에 적용할 색상 필터
* `alignment`: 이미지 정렬 방식
* `repeat`: 이미지 반복 방식

### Icon

[Section titled “Icon”](#icon)

`Icon` 위젯은 Material Design 아이콘이나 커스텀 아이콘 폰트의 그래픽 아이콘을 표시합니다.

```dart
1
Icon(
2
  Icons.favorite,
3
  color: Colors.red,
4
  size: 30,
5
)
```

**주요 속성**:

* `color`: 아이콘 색상
* `size`: 아이콘 크기
* `semanticLabel`: 접근성을 위한 텍스트 라벨

## 입력 위젯

[Section titled “입력 위젯”](#입력-위젯)

### Button 위젯

[Section titled “Button 위젯”](#button-위젯)

Flutter는 다양한 종류의 버튼 위젯을 제공합니다.

#### ElevatedButton

[Section titled “ElevatedButton”](#elevatedbutton)

Material Design 스타일의 돌출된 버튼입니다.

```dart
1
ElevatedButton(
2
  onPressed: () {
3
    print('버튼이 눌렸습니다!');
4
  },
5
  style: ElevatedButton.styleFrom(
6
    primary: Colors.blue,
7
    onPrimary: Colors.white,
8
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
9
    shape: RoundedRectangleBorder(
10
      borderRadius: BorderRadius.circular(8),
11
    ),
12
  ),
13
  child: Text('눌러보세요'),
14
)
```

#### TextButton

[Section titled “TextButton”](#textbutton)

텍스트만 있는 플랫 버튼입니다.

```dart
1
TextButton(
2
  onPressed: () {
3
    print('텍스트 버튼 클릭');
4
  },
5
  child: Text('자세히 보기'),
6
)
```

#### OutlinedButton

[Section titled “OutlinedButton”](#outlinedbutton)

테두리가 있는 버튼입니다.

```dart
1
OutlinedButton(
2
  onPressed: () {
3
    print('테두리 버튼 클릭');
4
  },
5
  style: OutlinedButton.styleFrom(
6
    side: BorderSide(color: Colors.blue, width: 2),
7
    shape: RoundedRectangleBorder(
8
      borderRadius: BorderRadius.circular(8),
9
    ),
10
  ),
11
  child: Text('등록하기'),
12
)
```

#### IconButton

[Section titled “IconButton”](#iconbutton)

아이콘만 있는 버튼입니다.

```dart
1
IconButton(
2
  icon: Icon(Icons.favorite),
3
  color: Colors.red,
4
  onPressed: () {
5
    print('좋아요!');
6
  },
7
)
```

### TextField

[Section titled “TextField”](#textfield)

텍스트 입력을 위한 위젯입니다.

```dart
1
TextField(
2
  decoration: InputDecoration(
3
    labelText: '이메일',
4
    hintText: 'example@email.com',
5
    prefixIcon: Icon(Icons.email),
6
    border: OutlineInputBorder(),
7
  ),
8
  keyboardType: TextInputType.emailAddress,
9
  textInputAction: TextInputAction.next,
10
  obscureText: false, // 비밀번호 필드일 경우 true
11
  onChanged: (value) {
12
    print('입력 값: $value');
13
  },
14
  onSubmitted: (value) {
15
    print('제출된 값: $value');
16
  },
17
)
```

**주요 속성**:

* `decoration`: 입력 필드의 외관 설정
* `keyboardType`: 표시할 키보드 유형
* `textInputAction`: 키보드의 실행 버튼 유형
* `obscureText`: 비밀번호 필드 여부
* `maxLines`: 여러 줄 텍스트 입력시 최대 줄 수
* `controller`: 입력 값을 관리하는 TextEditingController

### Checkbox와 Radio

[Section titled “Checkbox와 Radio”](#checkbox와-radio)

상태 선택을 위한 위젯입니다.

```dart
1
// Checkbox 예제
2
Checkbox(
3
  value: isChecked,
4
  onChanged: (bool? value) {
5
    setState(() {
6
      isChecked = value!;
7
    });
8
  },
9
  activeColor: Colors.blue,
10
)
11


12
// Radio 예제
13
Radio<String>(
14
  value: 'option1',
15
  groupValue: selectedOption,
16
  onChanged: (String? value) {
17
    setState(() {
18
      selectedOption = value!;
19
    });
20
  },
21
)
```

### Slider

[Section titled “Slider”](#slider)

범위 내에서 값을 선택하기 위한 위젯입니다.

```dart
1
Slider(
2
  value: _currentValue,
3
  min: 0,
4
  max: 100,
5
  divisions: 10,
6
  label: _currentValue.round().toString(),
7
  onChanged: (double value) {
8
    setState(() {
9
      _currentValue = value;
10
    });
11
  },
12
)
```

## 컨테이너 위젯

[Section titled “컨테이너 위젯”](#컨테이너-위젯)

### Container

[Section titled “Container”](#container)

`Container`는 Flutter에서 가장 유용한 위젯 중 하나로, 패딩, 마진, 테두리, 색상 등을 설정할 수 있는 범용 컨테이너입니다.

```dart
1
Container(
2
  width: 200,
3
  height: 150,
4
  margin: EdgeInsets.all(10),
5
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
6
  decoration: BoxDecoration(
7
    color: Colors.white,
8
    borderRadius: BorderRadius.circular(8),
9
    boxShadow: [
10
      BoxShadow(
11
        color: Colors.black26,
12
        offset: Offset(0, 2),
13
        blurRadius: 6,
14
      ),
15
    ],
16
    border: Border.all(color: Colors.grey[300]!),
17
  ),
18
  alignment: Alignment.center,
19
  child: Text('Hello, Container!'),
20
)
```

**주요 속성**:

* `width`, `height`: 컨테이너 크기
* `margin`: 외부 여백
* `padding`: 내부 여백
* `decoration`: 배경색, 테두리, 그림자 등의 장식
* `alignment`: 자식 위젯의 정렬 방식
* `transform`: 변환 행렬

### Card

[Section titled “Card”](#card)

`Card`는 약간 둥근 모서리와 그림자가 있는 Material Design 카드입니다.

```dart
1
Card(
2
  elevation: 4.0,
3
  margin: EdgeInsets.all(8),
4
  shape: RoundedRectangleBorder(
5
    borderRadius: BorderRadius.circular(8),
6
  ),
7
  child: Padding(
8
    padding: EdgeInsets.all(16.0),
9
    child: Column(
10
      crossAxisAlignment: CrossAxisAlignment.start,
11
      children: [
12
        Text(
13
          '카드 제목',
14
          style: TextStyle(
15
            fontSize: 18,
16
            fontWeight: FontWeight.bold,
17
          ),
18
        ),
19
        SizedBox(height: 8),
20
        Text('카드 내용이 들어가는 곳입니다.'),
21
      ],
22
    ),
23
  ),
24
)
```

### ListTile

[Section titled “ListTile”](#listtile)

`ListTile`은 아이콘, 텍스트, 후행 위젯을 포함하는 목록 항목입니다.

```dart
1
ListTile(
2
  leading: Icon(Icons.person),
3
  title: Text('홍길동'),
4
  subtitle: Text('개발자'),
5
  trailing: Icon(Icons.arrow_forward_ios),
6
  onTap: () {
7
    print('항목 클릭됨');
8
  },
9
)
```

### ExpansionTile

[Section titled “ExpansionTile”](#expansiontile)

`ExpansionTile`은 확장 가능한 목록 항목입니다.

```dart
1
ExpansionTile(
2
  title: Text('더 보기'),
3
  leading: Icon(Icons.info),
4
  children: [
5
    Padding(
6
      padding: EdgeInsets.all(16.0),
7
      child: Text('확장된 내용이 여기에 표시됩니다.'),
8
    ),
9
  ],
10
)
```

## 정보 표시 위젯

[Section titled “정보 표시 위젯”](#정보-표시-위젯)

### SnackBar

[Section titled “SnackBar”](#snackbar)

`SnackBar`는 화면 하단에 표시되는 간단한 메시지입니다.

```dart
1
// ScaffoldMessenger를 사용하여 SnackBar 표시
2
ScaffoldMessenger.of(context).showSnackBar(
3
  SnackBar(
4
    content: Text('저장되었습니다.'),
5
    action: SnackBarAction(
6
      label: '실행 취소',
7
      onPressed: () {
8
        // 실행 취소 작업
9
      },
10
    ),
11
    duration: Duration(seconds: 2),
12
    behavior: SnackBarBehavior.floating,
13
  ),
14
);
```

### Dialog

[Section titled “Dialog”](#dialog)

대화 상자는 사용자에게 중요한 정보를 표시하거나 결정을 요구할 때 사용합니다.

```dart
1
// AlertDialog
2
showDialog(
3
  context: context,
4
  builder: (BuildContext context) {
5
    return AlertDialog(
6
      title: Text('확인'),
7
      content: Text('정말 삭제하시겠습니까?'),
8
      actions: [
9
        TextButton(
10
          child: Text('취소'),
11
          onPressed: () {
12
            Navigator.of(context).pop();
13
          },
14
        ),
15
        TextButton(
16
          child: Text('삭제'),
17
          onPressed: () {
18
            // 삭제 작업 수행
19
            Navigator.of(context).pop();
20
          },
21
        ),
22
      ],
23
    );
24
  },
25
);
26


27
// SimpleDialog
28
showDialog(
29
  context: context,
30
  builder: (BuildContext context) {
31
    return SimpleDialog(
32
      title: Text('옵션 선택'),
33
      children: [
34
        SimpleDialogOption(
35
          onPressed: () {
36
            Navigator.pop(context, '옵션 1');
37
          },
38
          child: Text('옵션 1'),
39
        ),
40
        SimpleDialogOption(
41
          onPressed: () {
42
            Navigator.pop(context, '옵션 2');
43
          },
44
          child: Text('옵션 2'),
45
        ),
46
      ],
47
    );
48
  },
49
);
```

### ProgressIndicator

[Section titled “ProgressIndicator”](#progressindicator)

로딩 상태를 표시하는 위젯입니다.

```dart
1
// 원형 진행 표시기
2
CircularProgressIndicator(
3
  value: 0.7, // null이면 불확정 진행 표시기
4
  backgroundColor: Colors.grey[200],
5
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
6
)
7


8
// 선형 진행 표시기
9
LinearProgressIndicator(
10
  value: 0.7,
11
  backgroundColor: Colors.grey[200],
12
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
13
)
```

## 상호작용 위젯

[Section titled “상호작용 위젯”](#상호작용-위젯)

### GestureDetector

[Section titled “GestureDetector”](#gesturedetector)

여러 제스처를 감지하여 처리하는 위젯입니다.

```dart
1
GestureDetector(
2
  onTap: () {
3
    print('탭 감지됨');
4
  },
5
  onDoubleTap: () {
6
    print('더블 탭 감지됨');
7
  },
8
  onLongPress: () {
9
    print('길게 누르기 감지됨');
10
  },
11
  onPanUpdate: (details) {
12
    print('드래그: ${details.delta}');
13
  },
14
  child: Container(
15
    width: 200,
16
    height: 100,
17
    color: Colors.amber,
18
    child: Center(
19
      child: Text('여기를 터치하세요'),
20
    ),
21
  ),
22
)
```

### InkWell

[Section titled “InkWell”](#inkwell)

Material Design 스타일의 터치 효과(잉크 스플래시)가 있는 터치 영역입니다.

```dart
1
InkWell(
2
  onTap: () {
3
    print('탭 감지됨');
4
  },
5
  splashColor: Colors.blue.withOpacity(0.5),
6
  highlightColor: Colors.blue.withOpacity(0.2),
7
  child: Container(
8
    width: 200,
9
    height: 100,
10
    alignment: Alignment.center,
11
    child: Text('터치해보세요'),
12
  ),
13
)
```

## 위젯 조합 예제

[Section titled “위젯 조합 예제”](#위젯-조합-예제)

위젯은 조합하여 복잡한 UI를 구성할 수 있습니다. 다음은 프로필 카드 예제입니다:

```dart
1
Card(
2
  margin: EdgeInsets.all(16.0),
3
  elevation: 4.0,
4
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
5
  child: Padding(
6
    padding: EdgeInsets.all(16.0),
7
    child: Column(
8
      crossAxisAlignment: CrossAxisAlignment.start,
9
      children: [
10
        Row(
11
          children: [
12
            CircleAvatar(
13
              radius: 30,
14
              backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
15
            ),
16
            SizedBox(width: 16),
17
            Expanded(
18
              child: Column(
19
                crossAxisAlignment: CrossAxisAlignment.start,
20
                children: [
21
                  Text(
22
                    '홍길동',
23
                    style: TextStyle(
24
                      fontSize: 18,
25
                      fontWeight: FontWeight.bold,
26
                    ),
27
                  ),
28
                  Text(
29
                    '프론트엔드 개발자',
30
                    style: TextStyle(
31
                      color: Colors.grey[600],
32
                    ),
33
                  ),
34
                ],
35
              ),
36
            ),
37
            IconButton(
38
              icon: Icon(Icons.more_vert),
39
              onPressed: () {},
40
            ),
41
          ],
42
        ),
43
        SizedBox(height: 16),
44
        Text(
45
          '모바일 앱과 웹 개발에 관심이 많은 개발자입니다. Flutter와 React를 주로 사용합니다.',
46
        ),
47
        SizedBox(height: 16),
48
        Wrap(
49
          spacing: 8,
50
          children: [
51
            Chip(label: Text('Flutter')),
52
            Chip(label: Text('Dart')),
53
            Chip(label: Text('Firebase')),
54
          ],
55
        ),
56
        SizedBox(height: 16),
57
        Row(
58
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
59
          children: [
60
            Column(
61
              children: [
62
                Text(
63
                  '156',
64
                  style: TextStyle(fontWeight: FontWeight.bold),
65
                ),
66
                Text('게시물'),
67
              ],
68
            ),
69
            Column(
70
              children: [
71
                Text(
72
                  '572',
73
                  style: TextStyle(fontWeight: FontWeight.bold),
74
                ),
75
                Text('팔로워'),
76
              ],
77
            ),
78
            Column(
79
              children: [
80
                Text(
81
                  '128',
82
                  style: TextStyle(fontWeight: FontWeight.bold),
83
                ),
84
                Text('팔로잉'),
85
              ],
86
            ),
87
          ],
88
        ),
89
        SizedBox(height: 16),
90
        Row(
91
          children: [
92
            Expanded(
93
              child: ElevatedButton(
94
                onPressed: () {},
95
                child: Text('팔로우'),
96
              ),
97
            ),
98
            SizedBox(width: 8),
99
            OutlinedButton(
100
              onPressed: () {},
101
              child: Text('메시지'),
102
            ),
103
          ],
104
        ),
105
      ],
106
    ),
107
  ),
108
)
```

위젯 트리:

## 위젯 사용 팁

[Section titled “위젯 사용 팁”](#위젯-사용-팁)

### 1. 재사용 가능한 위젯 만들기

[Section titled “1. 재사용 가능한 위젯 만들기”](#1-재사용-가능한-위젯-만들기)

자주 사용되는 UI 패턴은 커스텀 위젯으로 만들어 재사용하세요:

```dart
1
class CustomButton extends StatelessWidget {
2
  final String text;
3
  final VoidCallback onPressed;
4
  final Color color;
5


6
  const CustomButton({
7
    Key? key,
8
    required this.text,
9
    required this.onPressed,
10
    this.color = Colors.blue,
11
  }) : super(key: key);
12


13
  @override
14
  Widget build(BuildContext context) {
15
    return ElevatedButton(
16
      onPressed: onPressed,
17
      style: ElevatedButton.styleFrom(
18
        primary: color,
19
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
20
        shape: RoundedRectangleBorder(
21
          borderRadius: BorderRadius.circular(8),
22
        ),
23
      ),
24
      child: Text(
25
        text,
26
        style: TextStyle(fontSize: 16),
27
      ),
28
    );
29
  }
30
}
31


32
// 사용 예
33
CustomButton(
34
  text: '제출하기',
35
  onPressed: () {
36
    // 처리 로직
37
  },
38
  color: Colors.green,
39
)
```

### 2. 조건부 위젯

[Section titled “2. 조건부 위젯”](#2-조건부-위젯)

조건에 따라 다른 위젯을 표시하는 방법:

```dart
1
// 삼항 연산자 사용
2
isLoading
3
    ? CircularProgressIndicator()
4
    : Text('데이터 로드됨'),
5


6
// 조건부 위젯 포함
7
Column(
8
  children: [
9
    Text('항상 표시되는 텍스트'),
10
    if (isVisible) Text('조건에 따라 표시되는 텍스트'),
11
    for (var item in items) Text(item),
12
  ],
13
)
```

### 3. const 생성자 사용

[Section titled “3. const 생성자 사용”](#3-const-생성자-사용)

가능한 경우 `const` 생성자를 사용하여 위젯 재빌드 성능을 최적화하세요:

```dart
1
// const 위젯: 빌드 시간에 생성되고 재사용됨
2
const SizedBox(height: 16),
3
const Divider(),
4
const Text('고정된 텍스트'),
5


6
// 동적 데이터가 있는 경우 const를 사용할 수 없음
7
Text(dynamicText),
```

## 결론

[Section titled “결론”](#결론)

Flutter의 기본 위젯들은 앱 UI를 구성하는 핵심 요소입니다. 이 장에서 소개한 위젯들을 조합하여 복잡한 인터페이스를 구현할 수 있습니다. 효과적인 Flutter 개발자가 되기 위해서는 각 위젯의 특성과 용도를 이해하고, 적절한 상황에 올바른 위젯을 선택하는 능력을 기르는 것이 중요합니다.

다음 장에서는 레이아웃 위젯에 대해 더 자세히 알아보겠습니다.

# 레이아웃 위젯

Flutter에서 레이아웃 위젯은 화면에 UI 요소를 배치하고 구성하는 데 사용됩니다. 이 장에서는 Flutter의 다양한 레이아웃 위젯과 그 사용법, 그리고 복잡한 레이아웃을 구성하는 방법에 대해 알아보겠습니다.

## Flutter의 레이아웃 시스템

[Section titled “Flutter의 레이아웃 시스템”](#flutter의-레이아웃-시스템)

Flutter의 레이아웃 시스템은 위젯 트리를 통해 UI를 구성하며, 부모 위젯이 자식 위젯에게 제약 조건(constraints)을 전달하고 자식 위젯이 이 제약 내에서 자신의 크기를 결정하는 방식으로 작동합니다.

Flutter의 레이아웃 프로세스:

1. 부모 위젯이 자식 위젯에게 최소/최대 너비와 높이 제약을 전달
2. 자식 위젯은 해당 제약 내에서 자신의 크기를 결정
3. 부모 위젯은 자식 위젯의 크기를 기반으로 자식 위젯의 위치를 결정

## 기본 레이아웃 위젯

[Section titled “기본 레이아웃 위젯”](#기본-레이아웃-위젯)

### Container

[Section titled “Container”](#container)

`Container`는 Flutter에서 가장 유용한 레이아웃 위젯 중 하나로, 다양한 속성을 통해 레이아웃과 스타일링을 할 수 있습니다.

```dart
1
Container(
2
  width: 200,
3
  height: 100,
4
  margin: EdgeInsets.all(10),
5
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
6
  decoration: BoxDecoration(
7
    color: Colors.blue,
8
    borderRadius: BorderRadius.circular(8),
9
    boxShadow: [
10
      BoxShadow(
11
        color: Colors.black26,
12
        offset: Offset(0, 2),
13
        blurRadius: 6,
14
      ),
15
    ],
16
    border: Border.all(color: Colors.blue.shade300),
17
  ),
18
  alignment: Alignment.center,
19
  child: Text(
20
    'Container',
21
    style: TextStyle(color: Colors.white, fontSize: 18),
22
  ),
23
)
```

**Container 동작 방식:**

* 자식이 없으면 최대한 크게 확장
* 자식이 있으면 자식의 크기에 맞춤
* 명시적인 너비/높이가 설정되면 해당 크기로 고정

### SizedBox

[Section titled “SizedBox”](#sizedbox)

`SizedBox`는 고정된 크기의 상자를 만들거나 위젯 사이에 간격을 추가하는 데 사용됩니다.

```dart
1
// 고정 크기 박스
2
SizedBox(
3
  width: 100,
4
  height: 50,
5
  child: Container(color: Colors.red),
6
)
7


8
// 간격 추가
9
Column(
10
  children: [
11
    Text('첫 번째 텍스트'),
12
    SizedBox(height: 16), // 수직 간격
13
    Text('두 번째 텍스트'),
14
  ],
15
)
16


17
// 최대 크기로 확장 (Expanded의 대안)
18
SizedBox.expand(
19
  child: Container(color: Colors.blue),
20
)
```

### Padding

[Section titled “Padding”](#padding)

`Padding`은 자식 위젯에 패딩을 추가합니다.

```dart
1
Padding(
2
  padding: EdgeInsets.all(16.0),
3
  child: Text('패딩이 있는 텍스트'),
4
)
```

## 단일 자식 레이아웃 위젯

[Section titled “단일 자식 레이아웃 위젯”](#단일-자식-레이아웃-위젯)

### Center

[Section titled “Center”](#center)

`Center`는 자식 위젯을 컨테이너의 중앙에 배치합니다.

```dart
1
Center(
2
  child: Text('중앙에 위치한 텍스트'),
3
)
```

### Align

[Section titled “Align”](#align)

`Align`은 자식 위젯을 특정 위치에 정렬합니다.

```dart
1
Align(
2
  alignment: Alignment.topRight,
3
  child: Text('우측 상단에 위치한 텍스트'),
4
)
5


6
// 사용자 정의 정렬 (각 값은 -1.0부터 1.0 사이)
7
Align(
8
  alignment: Alignment(0.5, -0.5), // x축 0.5, y축 -0.5 위치
9
  child: Text('커스텀 위치의 텍스트'),
10
)
```

### FractionallySizedBox

[Section titled “FractionallySizedBox”](#fractionallysizedbox)

`FractionallySizedBox`는 부모 위젯의 크기에 상대적인 비율로 크기를 지정합니다.

```dart
1
Container(
2
  width: 200,
3
  height: 200,
4
  color: Colors.grey,
5
  child: FractionallySizedBox(
6
    widthFactor: 0.7, // 부모 너비의 70%
7
    heightFactor: 0.5, // 부모 높이의 50%
8
    alignment: Alignment.center,
9
    child: Container(color: Colors.blue),
10
  ),
11
)
```

### AspectRatio

[Section titled “AspectRatio”](#aspectratio)

`AspectRatio`는 지정된 가로세로 비율에 맞게 자식 위젯의 크기를 조정합니다.

```dart
1
Container(
2
  width: 200,
3
  color: Colors.grey,
4
  child: AspectRatio(
5
    aspectRatio: 16 / 9, // 너비:높이 = 16:9
6
    child: Container(color: Colors.green),
7
  ),
8
)
```

## 다중 자식 레이아웃 위젯

[Section titled “다중 자식 레이아웃 위젯”](#다중-자식-레이아웃-위젯)

### Row와 Column

[Section titled “Row와 Column”](#row와-column)

`Row`와 `Column`은 Flutter에서 가장 기본적인 다중 자식 레이아웃 위젯입니다:

* `Row`: 자식 위젯을 수평으로 배치
* `Column`: 자식 위젯을 수직으로 배치

```dart
1
// 수평 배치
2
Row(
3
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
4
  crossAxisAlignment: CrossAxisAlignment.center,
5
  children: [
6
    Icon(Icons.star, size: 30),
7
    Icon(Icons.star, size: 45),
8
    Icon(Icons.star, size: 30),
9
  ],
10
)
11


12
// 수직 배치
13
Column(
14
  mainAxisAlignment: MainAxisAlignment.center,
15
  crossAxisAlignment: CrossAxisAlignment.start,
16
  children: [
17
    Text('항목 1'),
18
    Text('항목 2'),
19
    Text('항목 3'),
20
  ],
21
)
```

**주요 속성**:

* `mainAxisAlignment`: 주축(Row에서는 수평, Column에서는 수직)을 따라 자식 위젯을 정렬
* `crossAxisAlignment`: 교차축을 따라 자식 위젯을 정렬
* `mainAxisSize`: 주축 방향으로 차지할 공간 (기본값: `MainAxisSize.max`)

### Expanded와 Flexible

[Section titled “Expanded와 Flexible”](#expanded와-flexible)

`Expanded`와 `Flexible`은 자식 위젯이 Row나 Column 내에서 사용 가능한 공간을 차지하도록 합니다:

```dart
1
Row(
2
  children: [
3
    // 1/3의 공간 차지
4
    Expanded(
5
      flex: 1,
6
      child: Container(color: Colors.red),
7
    ),
8
    // 2/3의 공간 차지
9
    Expanded(
10
      flex: 2,
11
      child: Container(color: Colors.blue),
12
    ),
13
  ],
14
)
15


16
// Flexible vs Expanded
17
Row(
18
  children: [
19
    // 필요한 만큼만 공간 차지 (최소)
20
    Flexible(
21
      flex: 1,
22
      fit: FlexFit.loose, // 기본값
23
      child: Container(
24
        width: 50,
25
        color: Colors.red,
26
      ),
27
    ),
28
    // 사용 가능한 모든 공간 차지 (최대)
29
    Expanded(
30
      flex: 1,
31
      // Expanded는 fit: FlexFit.tight와 동일
32
      child: Container(color: Colors.blue),
33
    ),
34
  ],
35
)
```

**Expanded vs Flexible**:

* `Expanded`: 항상 사용 가능한 최대 공간을 차지 (`FlexFit.tight`)
* `Flexible`: 자식 위젯이 원하는 크기만큼 공간을 차지하되, 최대 지정된 공간까지 (`FlexFit.loose`)

### Spacer

[Section titled “Spacer”](#spacer)

`Spacer`는 Row나 Column 내에서 빈 공간을 만들 때 사용합니다:

```dart
1
Row(
2
  children: [
3
    Text('좌측'),
4
    Spacer(), // 가능한 모든 공간을 차지
5
    Text('우측'),
6
  ],
7
)
8


9
Row(
10
  children: [
11
    Text('좌측'),
12
    Spacer(flex: 1), // 1/3 공간
13
    Text('중앙'),
14
    Spacer(flex: 2), // 2/3 공간
15
    Text('우측'),
16
  ],
17
)
```

### Wrap

[Section titled “Wrap”](#wrap)

`Wrap`은 공간이 부족할 때 자식 위젯을 다음 행/열로 넘기는 레이아웃 위젯입니다:

```dart
1
Wrap(
2
  spacing: 8.0, // 주축 방향 간격
3
  runSpacing: 12.0, // 교차축 방향 간격
4
  alignment: WrapAlignment.center,
5
  children: [
6
    Chip(label: Text('Flutter')),
7
    Chip(label: Text('Dart')),
8
    Chip(label: Text('Firebase')),
9
    Chip(label: Text('Android')),
10
    Chip(label: Text('iOS')),
11
    Chip(label: Text('Web')),
12
  ],
13
)
```

### Stack

[Section titled “Stack”](#stack)

`Stack`은 위젯을 서로 겹쳐서 배치할 때 사용합니다:

```dart
1
Stack(
2
  alignment: Alignment.center, // 기본 정렬 (positioned가 없는 경우)
3
  children: [
4
    // 맨 아래 위젯
5
    Container(
6
      width: 300,
7
      height: 200,
8
      color: Colors.blue,
9
    ),
10
    // 중간 위젯
11
    Container(
12
      width: 250,
13
      height: 150,
14
      color: Colors.red.withOpacity(0.7),
15
    ),
16
    // 맨 위 위젯 (정확한 위치 지정)
17
    Positioned(
18
      top: 40,
19
      left: 40,
20
      child: Container(
21
        width: 150,
22
        height: 100,
23
        color: Colors.green.withOpacity(0.7),
24
      ),
25
    ),
26
    // 텍스트
27
    const Text(
28
      'Stack 예제',
29
      style: TextStyle(
30
        color: Colors.white,
31
        fontSize: 24,
32
        fontWeight: FontWeight.bold,
33
      ),
34
    ),
35
  ],
36
)
```

### Positioned

[Section titled “Positioned”](#positioned)

`Positioned` 위젯은 `Stack` 내에서 자식 위젯의 정확한 위치를 지정합니다:

```dart
1
Stack(
2
  children: [
3
    Positioned.fill( // 전체 영역 채우기
4
      child: Container(color: Colors.grey),
5
    ),
6
    Positioned( // 좌표 지정
7
      top: 20,
8
      left: 20,
9
      width: 100,
10
      height: 100,
11
      child: Container(color: Colors.red),
12
    ),
13
    Positioned(
14
      bottom: 20,
15
      right: 20,
16
      width: 100,
17
      height: 100,
18
      child: Container(color: Colors.blue),
19
    ),
20
  ],
21
)
```

다음은 Stack과 Positioned의 레이아웃 방식을 보여주는 다이어그램입니다:

## 스크롤 위젯

[Section titled “스크롤 위젯”](#스크롤-위젯)

### SingleChildScrollView

[Section titled “SingleChildScrollView”](#singlechildscrollview)

`SingleChildScrollView`는 단일 자식 위젯을 스크롤 가능하게 만듭니다:

```dart
1
SingleChildScrollView(
2
  scrollDirection: Axis.vertical, // 기본값
3
  child: Column(
4
    children: List.generate(
5
      20,
6
      (index) => Container(
7
        height: 100,
8
        margin: EdgeInsets.all(8),
9
        color: Colors.primaries[index % Colors.primaries.length],
10
        alignment: Alignment.center,
11
        child: Text('항목 $index'),
12
      ),
13
    ),
14
  ),
15
)
```

### ListView

[Section titled “ListView”](#listview)

`ListView`는 여러 항목을 스크롤 가능한 목록으로 표시합니다:

```dart
1
// 기본 ListView
2
ListView(
3
  padding: EdgeInsets.all(8),
4
  children: [
5
    ListTile(title: Text('항목 1')),
6
    ListTile(title: Text('항목 2')),
7
    ListTile(title: Text('항목 3')),
8
  ],
9
)
10


11
// 빌더 패턴 (효율적인 렌더링)
12
ListView.builder(
13
  itemCount: 100,
14
  itemBuilder: (context, index) {
15
    return ListTile(
16
      title: Text('항목 $index'),
17
    );
18
  },
19
)
20


21
// 구분선이 있는 ListView
22
ListView.separated(
23
  itemCount: 20,
24
  separatorBuilder: (context, index) => Divider(),
25
  itemBuilder: (context, index) {
26
    return ListTile(
27
      title: Text('항목 $index'),
28
    );
29
  },
30
)
```

### GridView

[Section titled “GridView”](#gridview)

`GridView`는 여러 항목을 격자 형태로 표시합니다:

```dart
1
// 기본 그리드
2
GridView.count(
3
  crossAxisCount: 3, // 열 개수
4
  mainAxisSpacing: 4.0, // 세로 간격
5
  crossAxisSpacing: 4.0, // 가로 간격
6
  padding: EdgeInsets.all(4.0),
7
  children: List.generate(
8
    30,
9
    (index) => Container(
10
      color: Colors.primaries[index % Colors.primaries.length],
11
      child: Center(
12
        child: Text('$index'),
13
      ),
14
    ),
15
  ),
16
)
17


18
// 빌더 패턴
19
GridView.builder(
20
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
21
    crossAxisCount: 2,
22
    childAspectRatio: 1.5,
23
    mainAxisSpacing: 10,
24
    crossAxisSpacing: 10,
25
  ),
26
  itemCount: 100,
27
  itemBuilder: (context, index) {
28
    return Container(
29
      color: Colors.blue[(index % 9 + 1) * 100],
30
      child: Center(
31
        child: Text('항목 $index'),
32
      ),
33
    );
34
  },
35
)
```

## 레이아웃 최적화 위젯

[Section titled “레이아웃 최적화 위젯”](#레이아웃-최적화-위젯)

### ConstrainedBox

[Section titled “ConstrainedBox”](#constrainedbox)

`ConstrainedBox`는 자식 위젯에 추가 제약 조건을 적용합니다:

```dart
1
ConstrainedBox(
2
  constraints: BoxConstraints(
3
    minWidth: 100,
4
    maxWidth: 200,
5
    minHeight: 50,
6
    maxHeight: 100,
7
  ),
8
  child: Container(
9
    color: Colors.blue,
10
    width: 150, // 100~200 사이로 제한됨
11
    height: 75, // 50~100 사이로 제한됨
12
  ),
13
)
```

### IntrinsicWidth와 IntrinsicHeight

[Section titled “IntrinsicWidth와 IntrinsicHeight”](#intrinsicwidth와-intrinsicheight)

`IntrinsicWidth`와 `IntrinsicHeight`는 자식 위젯의 내부 크기에 맞춰 너비/높이를 조정합니다:

```dart
1
// 모든 자식의 너비를 최대 너비에 맞춤
2
IntrinsicWidth(
3
  child: Column(
4
    crossAxisAlignment: CrossAxisAlignment.stretch,
5
    children: [
6
      Container(
7
        height: 50,
8
        width: 100,
9
        color: Colors.red,
10
      ),
11
      Container(
12
        height: 50,
13
        width: 150,
14
        color: Colors.blue,
15
      ),
16
      Container(
17
        height: 50,
18
        width: 75,
19
        color: Colors.green,
20
      ),
21
    ],
22
  ),
23
)
```

### LayoutBuilder

[Section titled “LayoutBuilder”](#layoutbuilder)

`LayoutBuilder`는 부모 위젯의 제약 조건에 따라 다른 레이아웃을 구성할 때 사용합니다:

```dart
1
LayoutBuilder(
2
  builder: (BuildContext context, BoxConstraints constraints) {
3
    if (constraints.maxWidth > 600) {
4
      // 넓은 화면 레이아웃
5
      return Row(
6
        children: [
7
          Expanded(
8
            flex: 1,
9
            child: Container(color: Colors.red),
10
          ),
11
          Expanded(
12
            flex: 2,
13
            child: Container(color: Colors.blue),
14
          ),
15
        ],
16
      );
17
    } else {
18
      // 좁은 화면 레이아웃
19
      return Column(
20
        children: [
21
          Container(
22
            height: 100,
23
            color: Colors.red,
24
          ),
25
          Container(
26
            height: 200,
27
            color: Colors.blue,
28
          ),
29
        ],
30
      );
31
    }
32
  },
33
)
```

## 반응형 레이아웃

[Section titled “반응형 레이아웃”](#반응형-레이아웃)

### MediaQuery

[Section titled “MediaQuery”](#mediaquery)

`MediaQuery`는 화면 크기, 기기 방향, 텍스트 배율 등 미디어 정보에 접근할 수 있게 해줍니다:

```dart
1
Widget build(BuildContext context) {
2
  final mediaQuery = MediaQuery.of(context);
3
  final screenWidth = mediaQuery.size.width;
4
  final screenHeight = mediaQuery.size.height;
5
  final orientation = mediaQuery.orientation;
6
  final padding = mediaQuery.padding;
7
  final isTablet = screenWidth > 600;
8


9
  return Scaffold(
10
    appBar: AppBar(
11
      title: Text('반응형 레이아웃'),
12
    ),
13
    body: Center(
14
      child: Column(
15
        mainAxisAlignment: MainAxisAlignment.center,
16
        children: [
17
          Text('화면 너비: $screenWidth'),
18
          Text('화면 높이: $screenHeight'),
19
          Text('방향: $orientation'),
20
          Text('상단 패딩: ${padding.top}'),
21
          Text('기기 타입: ${isTablet ? "태블릿" : "휴대폰"}'),
22


23
          SizedBox(height: 20),
24


25
          // 반응형 UI
26
          Container(
27
            width: screenWidth * 0.8, // 화면 너비의 80%
28
            height: screenHeight * 0.2, // 화면 높이의 20%
29
            color: isTablet ? Colors.blue : Colors.green,
30
            child: Center(
31
              child: Text(
32
                isTablet ? '태블릿 레이아웃' : '휴대폰 레이아웃',
33
                style: TextStyle(color: Colors.white),
34
              ),
35
            ),
36
          ),
37
        ],
38
      ),
39
    ),
40
  );
41
}
```

### OrientationBuilder

[Section titled “OrientationBuilder”](#orientationbuilder)

`OrientationBuilder`는 기기 방향에 따라 다른 레이아웃을 구성할 때 사용합니다:

```dart
1
OrientationBuilder(
2
  builder: (context, orientation) {
3
    return GridView.count(
4
      // 세로 모드일 때는 2열, 가로 모드일 때는 3열
5
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
6
      children: List.generate(
7
        12,
8
        (index) => Card(
9
          color: Colors.primaries[index % Colors.primaries.length],
10
          child: Center(
11
            child: Text('항목 $index'),
12
          ),
13
        ),
14
      ),
15
    );
16
  },
17
)
```

## 복잡한 레이아웃 예제

[Section titled “복잡한 레이아웃 예제”](#복잡한-레이아웃-예제)

다음은 복잡한 레이아웃을 구현하는 예제입니다:

```dart
1
// 프로필 화면 예제
2
Scaffold(
3
  appBar: AppBar(
4
    title: Text('프로필'),
5
    actions: [
6
      IconButton(
7
        icon: Icon(Icons.settings),
8
        onPressed: () {},
9
      ),
10
    ],
11
  ),
12
  body: SingleChildScrollView(
13
    child: Column(
14
      crossAxisAlignment: CrossAxisAlignment.start,
15
      children: [
16
        // 프로필 헤더
17
        Container(
18
          height: 200,
19
          decoration: BoxDecoration(
20
            image: DecorationImage(
21
              image: NetworkImage('https://example.com/banner.jpg'),
22
              fit: BoxFit.cover,
23
            ),
24
          ),
25
          child: Stack(
26
            children: [
27
              // 프로필 정보가 있는 바닥 패널
28
              Positioned(
29
                bottom: 0,
30
                left: 0,
31
                right: 0,
32
                child: Container(
33
                  height: 80,
34
                  color: Colors.black45,
35
                  padding: EdgeInsets.symmetric(horizontal: 16),
36
                  child: Row(
37
                    crossAxisAlignment: CrossAxisAlignment.center,
38
                    children: [
39
                      CircleAvatar(
40
                        radius: 30,
41
                        backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
42
                      ),
43
                      SizedBox(width: 16),
44
                      Expanded(
45
                        child: Column(
46
                          crossAxisAlignment: CrossAxisAlignment.start,
47
                          mainAxisAlignment: MainAxisAlignment.center,
48
                          children: [
49
                            Text(
50
                              '홍길동',
51
                              style: TextStyle(
52
                                color: Colors.white,
53
                                fontSize: 20,
54
                                fontWeight: FontWeight.bold,
55
                              ),
56
                            ),
57
                            Text(
58
                              '@hong',
59
                              style: TextStyle(
60
                                color: Colors.white70,
61
                              ),
62
                            ),
63
                          ],
64
                        ),
65
                      ),
66
                      ElevatedButton(
67
                        onPressed: () {},
68
                        child: Text('팔로우'),
69
                        style: ElevatedButton.styleFrom(
70
                          primary: Colors.blue,
71
                        ),
72
                      ),
73
                    ],
74
                  ),
75
                ),
76
              ),
77
            ],
78
          ),
79
        ),
80


81
        // 통계 섹션
82
        Padding(
83
          padding: EdgeInsets.all(16),
84
          child: Row(
85
            mainAxisAlignment: MainAxisAlignment.spaceAround,
86
            children: [
87
              _buildStatColumn('게시물', '125'),
88
              _buildStatColumn('팔로워', '1.2K'),
89
              _buildStatColumn('팔로잉', '384'),
90
            ],
91
          ),
92
        ),
93


94
        Divider(),
95


96
        // 소개 섹션
97
        Padding(
98
          padding: EdgeInsets.all(16),
99
          child: Column(
100
            crossAxisAlignment: CrossAxisAlignment.start,
101
            children: [
102
              Text(
103
                '소개',
104
                style: TextStyle(
105
                  fontSize: 18,
106
                  fontWeight: FontWeight.bold,
107
                ),
108
              ),
109
              SizedBox(height: 8),
110
              Text(
111
                '안녕하세요, Flutter 개발자 홍길동입니다. '
112
                'UI/UX 디자인과 앱 개발에 관심이 많습니다. '
113
                '함께 일하고 싶으시면 연락주세요!',
114
              ),
115
            ],
116
          ),
117
        ),
118


119
        Divider(),
120


121
        // 갤러리 섹션
122
        Padding(
123
          padding: EdgeInsets.all(16),
124
          child: Column(
125
            crossAxisAlignment: CrossAxisAlignment.start,
126
            children: [
127
              Text(
128
                '갤러리',
129
                style: TextStyle(
130
                  fontSize: 18,
131
                  fontWeight: FontWeight.bold,
132
                ),
133
              ),
134
              SizedBox(height: 12),
135
              GridView.builder(
136
                shrinkWrap: true, // SingleChildScrollView 내에서 사용하기 위해 필요
137
                physics: NeverScrollableScrollPhysics(), // 중첩 스크롤 방지
138
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
139
                  crossAxisCount: 3,
140
                  mainAxisSpacing: 4,
141
                  crossAxisSpacing: 4,
142
                ),
143
                itemCount: 9,
144
                itemBuilder: (context, index) {
145
                  return Container(
146
                    decoration: BoxDecoration(
147
                      image: DecorationImage(
148
                        image: NetworkImage('https://picsum.photos/id/${index + 10}/200'),
149
                        fit: BoxFit.cover,
150
                      ),
151
                    ),
152
                  );
153
                },
154
              ),
155
            ],
156
          ),
157
        ),
158
      ],
159
    ),
160
  ),
161
);
162


163
// 헬퍼 함수
164
Column _buildStatColumn(String label, String value) {
165
  return Column(
166
    mainAxisSize: MainAxisSize.min,
167
    children: [
168
      Text(
169
        value,
170
        style: TextStyle(
171
          fontSize: 18,
172
          fontWeight: FontWeight.bold,
173
        ),
174
      ),
175
      SizedBox(height: 4),
176
      Text(
177
        label,
178
        style: TextStyle(
179
          color: Colors.grey,
180
        ),
181
      ),
182
    ],
183
  );
184
}
```

## 레이아웃 디버깅

[Section titled “레이아웃 디버깅”](#레이아웃-디버깅)

### 문제 식별하기

[Section titled “문제 식별하기”](#문제-식별하기)

Flutter는 레이아웃 디버깅을 위한 여러 도구를 제공합니다:

1. **디버그 페인팅 옵션**: `debugPaintSizeEnabled`를 활성화하여 레이아웃 경계 시각화:

```dart
1
import 'package:flutter/rendering.dart';
2


3
void main() {
4
  debugPaintSizeEnabled = true; // 레이아웃 경계 표시
5
  runApp(MyApp());
6
}
```

2. **LayoutBuilder 사용**: 현재 제약 조건 출력하기:

```dart
1
LayoutBuilder(
2
  builder: (context, constraints) {
3
    print('Width: ${constraints.maxWidth}, Height: ${constraints.maxHeight}');
4
    return YourWidget();
5
  },
6
)
```

3. **Flutter DevTools**: 위젯 검사기(Widget Inspector)를 사용하여 위젯 트리와 속성 확인

### 공통 문제 해결

[Section titled “공통 문제 해결”](#공통-문제-해결)

#### 1. Unbounded 높이 오류

[Section titled “1. Unbounded 높이 오류”](#1-unbounded-높이-오류)

```plaintext
1
Vertical viewport was given unbounded height.
```

이 오류는 높이 제약이 없는 상태에서 ListView나 Column 등을 사용할 때 발생합니다.

해결 방법:

```dart
1
// 해결 방법 1: Container로 크기 제한
2
Container(
3
  height: 300,
4
  child: ListView(/* ... */),
5
)
6


7
// 해결 방법 2: Expanded 사용 (Column 내부에서)
8
Column(
9
  children: [
10
    // 다른 위젯들...
11
    Expanded(
12
      child: ListView(/* ... */),
13
    ),
14
  ],
15
)
16


17
// 해결 방법 3: shrinkWrap 사용 (성능에 주의)
18
ListView(
19
  shrinkWrap: true,
20
  children: [/* ... */],
21
)
```

#### 2. Column이 화면을 넘어감

[Section titled “2. Column이 화면을 넘어감”](#2-column이-화면을-넘어감)

```dart
1
// 잘못된 방법
2
Column(
3
  children: [많은 위젯들...], // 내용이 화면을 넘어가면 오류 발생
4
)
5


6
// 해결 방법
7
SingleChildScrollView(
8
  child: Column(
9
    children: [많은 위젯들...],
10
  ),
11
)
```

## 결론

[Section titled “결론”](#결론)

Flutter의 레이아웃 시스템은 유연하고 강력하여 복잡한 UI를 구현할 수 있게 해줍니다. 다양한 레이아웃 위젯을 조합하여 원하는 디자인을 실현할 수 있습니다.

레이아웃 위젯 선택 시 고려할 사항:

1. **위젯의 목적**: 단일 자식? 다중 자식? 스크롤이 필요한가?
2. **배치 방식**: 수평? 수직? 겹침? 격자?
3. **크기 조절**: 고정 크기? 유연한 크기? 비율?
4. **반응형**: 화면 크기나 방향에 따라 조정이 필요한가?

적절한 레이아웃 위젯을 선택하고 조합하면 모든 화면 크기와 방향에 최적화된 UI를 만들 수 있습니다.

다음 파트에서는 Flutter의 상태 관리에 대해 알아보겠습니다.

# Stateless / Stateful 위젯 상세

Flutter에서 위젯은 크게 Stateless 위젯과 Stateful 위젯으로 구분됩니다. 이 두 가지 위젯 유형은 UI 구성의 기본 요소이며, 각각 다른 용도와 특성을 가지고 있습니다. 이 장에서는 두 위젯의 차이점, 동작 원리, 사용 패턴에 대해 알아보겠습니다.

## Stateless 위젯 (StatelessWidget)

[Section titled “Stateless 위젯 (StatelessWidget)”](#stateless-위젯-statelesswidget)

Stateless 위젯은 내부 상태(state)를 가지지 않는 불변(immutable)의 위젯입니다. 한번 빌드되면 입력된 매개변수가 변경되지 않는 한 다시 빌드되지 않습니다. 정적인 UI 요소를 표현하는데 적합합니다.

### 특징

[Section titled “특징”](#특징)

* **불변성**: 내부 상태를 가지지 않으며, 생성 후 변경되지 않습니다.
* **성능**: 상태가 없어 효율적이고 빠르게 렌더링됩니다.
* **단순성**: 구현이 간단하고 이해하기 쉽습니다.
* **용도**: 정적인 UI, 표시 전용 컴포넌트에 적합합니다.

### 생명 주기

[Section titled “생명 주기”](#생명-주기)

Stateless 위젯의 생명 주기는 간단합니다:

1. **생성자 호출**: 위젯이 생성되고 속성이 초기화됩니다.
2. **빌드 메서드 호출**: `build()` 메서드가 호출되어 위젯 트리를 구성합니다.
3. **렌더링**: 생성된 위젯 트리가 화면에 렌더링됩니다.
4. **재빌드**: 부모 위젯이 재빌드되거나 매개변수가 변경되면 새로운 위젯 인스턴스가 생성되고 다시 빌드됩니다.

### 구현 예제

[Section titled “구현 예제”](#구현-예제)

```dart
1
class GreetingCard extends StatelessWidget {
2
  final String name;
3
  final String message;
4
  final Color backgroundColor;
5


6
  // 생성자 - 필요한 데이터를 주입받습니다
7
  const GreetingCard({
8
    Key? key,
9
    required this.name,
10
    required this.message,
11
    this.backgroundColor = Colors.white,
12
  }) : super(key: key);
13


14
  // 빌드 메서드 - UI를 정의합니다
15
  @override
16
  Widget build(BuildContext context) {
17
    return Container(
18
      padding: const EdgeInsets.all(16.0),
19
      color: backgroundColor,
20
      child: Column(
21
        crossAxisAlignment: CrossAxisAlignment.start,
22
        mainAxisSize: MainAxisSize.min,
23
        children: [
24
          Text(
25
            '안녕하세요, $name님!',
26
            style: const TextStyle(
27
              fontSize: 18,
28
              fontWeight: FontWeight.bold,
29
            ),
30
          ),
31
          const SizedBox(height: 8),
32
          Text(
33
            message,
34
            style: const TextStyle(fontSize: 14),
35
          ),
36
        ],
37
      ),
38
    );
39
  }
40
}
41


42
// 사용 예시
43
GreetingCard(
44
  name: '홍길동',
45
  message: '오늘도 좋은 하루 되세요!',
46
  backgroundColor: Colors.amber.shade100,
47
)
```

위 예제에서 `GreetingCard`는 이름, 메시지, 배경색을 입력받아 인사말 카드를 표시하는 Stateless 위젯입니다. 이 위젯은 내부 상태를 가지지 않으며, 입력된 속성에 따라 UI를 구성합니다.

## Stateful 위젯 (StatefulWidget)

[Section titled “Stateful 위젯 (StatefulWidget)”](#stateful-위젯-statefulwidget)

Stateful 위젯은 시간에 따라 변경될 수 있는 내부 상태(state)를 가진 위젯입니다. 사용자 상호작용, 데이터 변경, 애니메이션 등으로 인해 UI가 동적으로 변경되어야 할 때 사용합니다.

### 특징

[Section titled “특징”](#특징-1)

* **가변성**: 생성 후에도 상태가 변경될 수 있습니다.
* **상태 관리**: 위젯의 생명 주기 동안 상태를 유지하고 관리합니다.
* **복잡성**: Stateless 위젯보다 구현이 복잡합니다.
* **용도**: 사용자 입력, 애니메이션, 동적 데이터 표시 등에 적합합니다.

### 구조

[Section titled “구조”](#구조)

Stateful 위젯은 두 개의 클래스로 구성됩니다:

1. **StatefulWidget 클래스**: 위젯의 설정과 매개변수를 정의합니다.
2. **State 클래스**: 위젯의 상태를 관리하고 UI를 구성합니다.

### 생명 주기

[Section titled “생명 주기”](#생명-주기-1)

Stateful 위젯의 생명 주기는 Stateless 위젯보다 복잡합니다:

1. **생성자 호출**: 위젯이 생성되고 속성이 초기화됩니다.
2. **createState()**: 위젯의 State 객체를 생성합니다.
3. **initState()**: State가 초기화됩니다. 이 메서드는 State 객체가 생성된 직후 한 번만 호출됩니다.
4. **didChangeDependencies()**: State가 의존하는 객체가 변경될 때 호출됩니다.
5. **build()**: UI를 구성합니다. 이 메서드는 initState 후, 그리고 setState가 호출될 때마다 호출됩니다.
6. **setState()**: 상태 변경을 알리고 rebuild를 예약합니다.
7. **didUpdateWidget()**: 부모 위젯이 재빌드되어 위젯이 재구성될 때 호출됩니다.
8. **deactivate()**: State 객체가 위젯 트리에서 제거될 때 호출됩니다.
9. **dispose()**: State 객체가 영구적으로 제거될 때 호출됩니다. 리소스를 정리하는 데 사용됩니다.

### 구현 예제

[Section titled “구현 예제”](#구현-예제-1)

```dart
1
// 1. StatefulWidget 클래스
2
class Counter extends StatefulWidget {
3
  final int initialCount;
4


5
  const Counter({Key? key, this.initialCount = 0}) : super(key: key);
6


7
  @override
8
  _CounterState createState() => _CounterState();
9
}
10


11
// 2. State 클래스
12
class _CounterState extends State<Counter> {
13
  late int _count;
14


15
  // 초기화
16
  @override
17
  void initState() {
18
    super.initState();
19
    _count = widget.initialCount;
20
    print('Counter 위젯 초기화');
21
  }
22


23
  // 위젯이 업데이트될 때
24
  @override
25
  void didUpdateWidget(Counter oldWidget) {
26
    super.didUpdateWidget(oldWidget);
27
    if (oldWidget.initialCount != widget.initialCount) {
28
      _count = widget.initialCount;
29
      print('초기 카운트 값 변경: $_count');
30
    }
31
  }
32


33
  // 상태 변경 함수
34
  void _increment() {
35
    setState(() {
36
      _count++;
37
      print('카운트 증가: $_count');
38
    });
39
  }
40


41
  // 리소스 정리
42
  @override
43
  void dispose() {
44
    print('Counter 위젯 제거');
45
    super.dispose();
46
  }
47


48
  // UI 구성
49
  @override
50
  Widget build(BuildContext context) {
51
    return Container(
52
      padding: const EdgeInsets.all(16.0),
53
      decoration: BoxDecoration(
54
        border: Border.all(color: Colors.grey),
55
        borderRadius: BorderRadius.circular(8.0),
56
      ),
57
      child: Column(
58
        mainAxisSize: MainAxisSize.min,
59
        children: [
60
          Text(
61
            '현재 카운트: $_count',
62
            style: const TextStyle(fontSize: 18),
63
          ),
64
          const SizedBox(height: 16),
65
          ElevatedButton(
66
            onPressed: _increment,
67
            child: const Text('증가'),
68
          ),
69
        ],
70
      ),
71
    );
72
  }
73
}
74


75
// 사용 예시
76
Counter(initialCount: 5)
```

위 예제에서 `Counter`는 카운트 값을 관리하고 증가 버튼이 있는 Stateful 위젯입니다. 상태(\_count)는 `_CounterState` 클래스 내에서 관리되며, 버튼 클릭 시 `setState()`를 호출하여 UI를 업데이트합니다.

## Stateless vs Stateful 위젯 비교

[Section titled “Stateless vs Stateful 위젯 비교”](#stateless-vs-stateful-위젯-비교)

두 위젯 유형의 주요 차이점을 비교해 보겠습니다:

| 항목         | Stateless 위젯         | Stateful 위젯                            |
| ---------- | -------------------- | -------------------------------------- |
| **상태 관리**  | 내부 상태 없음             | 내부 상태 관리                               |
| **빌드 빈도**  | 부모 위젯 변경 시에만         | setState() 호출 시마다                      |
| **생명 주기**  | 간단함                  | 복잡함                                    |
| **성능**     | 일반적으로 더 효율적          | 상태 관리 오버헤드                             |
| **용도**     | 정적 UI                | 동적 UI                                  |
| **구현 복잡도** | 낮음                   | 중간-높음                                  |
| **예시**     | Text, Icon, RichText | TextField, Checkbox, AnimatedContainer |

## 언제 어떤 위젯을 사용해야 할까?

[Section titled “언제 어떤 위젯을 사용해야 할까?”](#언제-어떤-위젯을-사용해야-할까)

### Stateless 위젯 사용 사례

[Section titled “Stateless 위젯 사용 사례”](#stateless-위젯-사용-사례)

* **정적 콘텐츠 표시**: 텍스트, 이미지, 아이콘 등 변하지 않는 UI 요소
* **데이터 표시 전용 컴포넌트**: 입력 데이터만으로 UI를 구성할 때
* **재사용 가능한 UI 컴포넌트**: 여러 곳에서 동일한 모양으로 사용되는 컴포넌트
* **부모로부터 모든 데이터를 받아 표시**: 자체 상태가 필요 없는 경우

예시:

* 프로필 카드
* 제품 정보 표시
* 헤더/푸터
* 아이콘 버튼

### Stateful 위젯 사용 사례

[Section titled “Stateful 위젯 사용 사례”](#stateful-위젯-사용-사례)

* **사용자 입력 처리**: 폼, 텍스트 입력, 체크박스 등
* **애니메이션 및 변환 효과**: 상태에 따라 변하는 UI
* **데이터 로딩 및 진행 상황 표시**: 로딩 인디케이터, 진행 바
* **타이머 또는 주기적 업데이트**: 시계, 카운트다운 타이머
* **내부적으로 데이터를 관리하는 컴포넌트**: 자체 상태가 필요한 경우

예시:

* 로그인 폼
* 이미지 슬라이더
* 카운터
* 토글 버튼

## 상태 관리의 기본 원칙

[Section titled “상태 관리의 기본 원칙”](#상태-관리의-기본-원칙)

### 1. 상태의 범위 최소화

[Section titled “1. 상태의 범위 최소화”](#1-상태의-범위-최소화)

위젯 트리에서 가능한 낮은 위치에 상태를 유지하는 것이 좋습니다. 이는 불필요한 리빌드를 방지하고 성능을 향상시킵니다.

```dart
1
// 좋지 않은 예: 부모 위젯에서 불필요한 상태 관리
2
class ParentWidget extends StatefulWidget {
3
  @override
4
  _ParentWidgetState createState() => _ParentWidgetState();
5
}
6


7
class _ParentWidgetState extends State<ParentWidget> {
8
  bool _isExpanded = false;
9


10
  @override
11
  Widget build(BuildContext context) {
12
    return Column(
13
      children: [
14
        Text('제목'),
15
        SomeWidget(), // 이 위젯은 _isExpanded와 관련 없음
16
        AnotherWidget(), // 이 위젯도 _isExpanded와 관련 없음
17
        ExpandableWidget(
18
          isExpanded: _isExpanded,
19
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
20
        ),
21
      ],
22
    );
23
  }
24
}
25


26
// 좋은 예: 관련 상태를 해당 위젯 내에서 관리
27
class ExpandableWidget extends StatefulWidget {
28
  @override
29
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
30
}
31


32
class _ExpandableWidgetState extends State<ExpandableWidget> {
33
  bool _isExpanded = false;
34


35
  @override
36
  Widget build(BuildContext context) {
37
    return Column(
38
      children: [
39
        GestureDetector(
40
          onTap: () => setState(() => _isExpanded = !_isExpanded),
41
          child: Text(_isExpanded ? '접기' : '펼치기'),
42
        ),
43
        if (_isExpanded)
44
          Container(
45
            child: Text('펼쳐진 내용'),
46
          ),
47
      ],
48
    );
49
  }
50
}
```

### 2. 상태 끌어올리기

[Section titled “2. 상태 끌어올리기”](#2-상태-끌어올리기)

여러 위젯이 동일한 상태를 공유해야 하는 경우, 상태를 공통 부모 위젯으로 “끌어올립니다”.

```dart
1
// 공통 부모 위젯에서 상태 관리
2
class CounterPage extends StatefulWidget {
3
  @override
4
  _CounterPageState createState() => _CounterPageState();
5
}
6


7
class _CounterPageState extends State<CounterPage> {
8
  int _count = 0;
9


10
  void _increment() {
11
    setState(() {
12
      _count++;
13
    });
14
  }
15


16
  @override
17
  Widget build(BuildContext context) {
18
    return Column(
19
      children: [
20
        // 두 위젯이 동일한 상태(_count)를 공유
21
        CounterDisplay(count: _count),
22
        CounterControls(onIncrement: _increment),
23
      ],
24
    );
25
  }
26
}
27


28
// 표시만 담당하는 Stateless 위젯
29
class CounterDisplay extends StatelessWidget {
30
  final int count;
31


32
  const CounterDisplay({Key? key, required this.count}) : super(key: key);
33


34
  @override
35
  Widget build(BuildContext context) {
36
    return Text('현재 카운트: $count');
37
  }
38
}
39


40
// 조작만 담당하는 Stateless 위젯
41
class CounterControls extends StatelessWidget {
42
  final VoidCallback onIncrement;
43


44
  const CounterControls({Key? key, required this.onIncrement}) : super(key: key);
45


46
  @override
47
  Widget build(BuildContext context) {
48
    return ElevatedButton(
49
      onPressed: onIncrement,
50
      child: Text('증가'),
51
    );
52
  }
53
}
```

### 3. 상태를 종류별로 관리

[Section titled “3. 상태를 종류별로 관리”](#3-상태를-종류별로-관리)

상태의 종류와 범위에 따라 적절한 관리 방법을 선택합니다:

1. **UI 상태(임시 상태)**: 텍스트 필드 포커스, 애니메이션 진행 상태 등
   * Stateful 위젯 내에서 관리
2. **앱 상태(영구 상태)**: 사용자 설정, 로그인 정보, 장바구니 등
   * Provider, Riverpod, Bloc 등의 상태 관리 솔루션 사용

## 실전 예제: 위젯 타입 선택하기

[Section titled “실전 예제: 위젯 타입 선택하기”](#실전-예제-위젯-타입-선택하기)

실제 애플리케이션에서 어떤 위젯 타입을 선택해야 하는지 살펴보겠습니다:

### 예제 1: 제품 카드

[Section titled “예제 1: 제품 카드”](#예제-1-제품-카드)

```dart
1
// Stateless 위젯 사용 - 정적 데이터 표시
2
class ProductCard extends StatelessWidget {
3
  final String name;
4
  final double price;
5
  final String imageUrl;
6
  final VoidCallback? onAddToCart;
7


8
  const ProductCard({
9
    Key? key,
10
    required this.name,
11
    required this.price,
12
    required this.imageUrl,
13
    this.onAddToCart,
14
  }) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    return Card(
19
      margin: EdgeInsets.all(8.0),
20
      child: Column(
21
        crossAxisAlignment: CrossAxisAlignment.start,
22
        children: [
23
          Image.network(
24
            imageUrl,
25
            height: 120,
26
            width: double.infinity,
27
            fit: BoxFit.cover,
28
          ),
29
          Padding(
30
            padding: EdgeInsets.all(8.0),
31
            child: Column(
32
              crossAxisAlignment: CrossAxisAlignment.start,
33
              children: [
34
                Text(
35
                  name,
36
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
37
                ),
38
                SizedBox(height: 4),
39
                Text(
40
                  '₩${price.toStringAsFixed(0)}',
41
                  style: TextStyle(color: Colors.green, fontSize: 14),
42
                ),
43
                SizedBox(height: 8),
44
                ElevatedButton(
45
                  onPressed: onAddToCart,
46
                  child: Text('장바구니 추가'),
47
                ),
48
              ],
49
            ),
50
          ),
51
        ],
52
      ),
53
    );
54
  }
55
}
```

### 예제 2: 수량 선택 위젯

[Section titled “예제 2: 수량 선택 위젯”](#예제-2-수량-선택-위젯)

```dart
1
// Stateful 위젯 사용 - 내부 상태 관리
2
class QuantitySelector extends StatefulWidget {
3
  final int initialValue;
4
  final int min;
5
  final int max;
6
  final ValueChanged<int>? onChanged;
7


8
  const QuantitySelector({
9
    Key? key,
10
    this.initialValue = 1,
11
    this.min = 1,
12
    this.max = 10,
13
    this.onChanged,
14
  }) : super(key: key);
15


16
  @override
17
  _QuantitySelectorState createState() => _QuantitySelectorState();
18
}
19


20
class _QuantitySelectorState extends State<QuantitySelector> {
21
  late int _quantity;
22


23
  @override
24
  void initState() {
25
    super.initState();
26
    _quantity = widget.initialValue.clamp(widget.min, widget.max);
27
  }
28


29
  void _increment() {
30
    setState(() {
31
      if (_quantity < widget.max) {
32
        _quantity++;
33
        widget.onChanged?.call(_quantity);
34
      }
35
    });
36
  }
37


38
  void _decrement() {
39
    setState(() {
40
      if (_quantity > widget.min) {
41
        _quantity--;
42
        widget.onChanged?.call(_quantity);
43
      }
44
    });
45
  }
46


47
  @override
48
  Widget build(BuildContext context) {
49
    return Row(
50
      mainAxisSize: MainAxisSize.min,
51
      children: [
52
        IconButton(
53
          icon: Icon(Icons.remove),
54
          onPressed: _quantity > widget.min ? _decrement : null,
55
        ),
56
        Container(
57
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
58
          decoration: BoxDecoration(
59
            border: Border.all(color: Colors.grey),
60
            borderRadius: BorderRadius.circular(4),
61
          ),
62
          child: Text(
63
            _quantity.toString(),
64
            style: TextStyle(fontSize: 16),
65
          ),
66
        ),
67
        IconButton(
68
          icon: Icon(Icons.add),
69
          onPressed: _quantity < widget.max ? _increment : null,
70
        ),
71
      ],
72
    );
73
  }
74
}
```

## 고급 기법: 위젯 참조 및 통신

[Section titled “고급 기법: 위젯 참조 및 통신”](#고급-기법-위젯-참조-및-통신)

### GlobalKey를 사용한 위젯 참조

[Section titled “GlobalKey를 사용한 위젯 참조”](#globalkey를-사용한-위젯-참조)

`GlobalKey`를 사용하면 위젯의 State 객체에 직접 접근할 수 있습니다:

```dart
1
// GlobalKey 예제
2
class MyApp extends StatelessWidget {
3
  // GlobalKey 생성
4
  final formKey = GlobalKey<FormState>();
5


6
  @override
7
  Widget build(BuildContext context) {
8
    return MaterialApp(
9
      home: Scaffold(
10
        body: Form(
11
          // 위젯에 키 할당
12
          key: formKey,
13
          child: Column(
14
            children: [
15
              TextFormField(
16
                validator: (value) {
17
                  if (value == null || value.isEmpty) {
18
                    return '이 필드는 필수입니다';
19
                  }
20
                  return null;
21
                },
22
              ),
23
              ElevatedButton(
24
                onPressed: () {
25
                  // 폼 상태에 접근
26
                  if (formKey.currentState!.validate()) {
27
                    print('유효성 검사 통과');
28
                  }
29
                },
30
                child: Text('제출'),
31
              ),
32
            ],
33
          ),
34
        ),
35
      ),
36
    );
37
  }
38
}
```

### 콜백 함수를 통한 자식-부모 통신

[Section titled “콜백 함수를 통한 자식-부모 통신”](#콜백-함수를-통한-자식-부모-통신)

자식 위젯이 부모 위젯과 통신하는 일반적인 방법은 콜백 함수를 사용하는 것입니다:

```dart
1
// 부모 위젯
2
class ParentWidget extends StatefulWidget {
3
  @override
4
  _ParentWidgetState createState() => _ParentWidgetState();
5
}
6


7
class _ParentWidgetState extends State<ParentWidget> {
8
  String _selectedItem = '';
9


10
  void _handleItemSelected(String item) {
11
    setState(() {
12
      _selectedItem = item;
13
    });
14
    print('선택된 항목: $item');
15
  }
16


17
  @override
18
  Widget build(BuildContext context) {
19
    return Column(
20
      children: [
21
        Text('선택된 항목: $_selectedItem'),
22
        ChildWidget(onItemSelected: _handleItemSelected),
23
      ],
24
    );
25
  }
26
}
27


28
// 자식 위젯 (Stateless)
29
class ChildWidget extends StatelessWidget {
30
  final Function(String) onItemSelected;
31


32
  const ChildWidget({Key? key, required this.onItemSelected}) : super(key: key);
33


34
  @override
35
  Widget build(BuildContext context) {
36
    return Column(
37
      children: [
38
        ElevatedButton(
39
          onPressed: () => onItemSelected('항목 1'),
40
          child: Text('항목 1 선택'),
41
        ),
42
        ElevatedButton(
43
          onPressed: () => onItemSelected('항목 2'),
44
          child: Text('항목 2 선택'),
45
        ),
46
      ],
47
    );
48
  }
49
}
```

## 성능 최적화 팁

[Section titled “성능 최적화 팁”](#성능-최적화-팁)

### 1. const 생성자 사용

[Section titled “1. const 생성자 사용”](#1-const-생성자-사용)

가능한 경우 `const` 생성자를 사용하여 위젯을 선언하면 Flutter는 동일한 위젯 인스턴스를 재사용할 수 있습니다:

```dart
1
// 상수 위젯 예시
2
const Text('Hello') // 재사용 가능
3


4
// vs
5


6
Text('Hello') // 매번 새로운 인스턴스 생성
```

### 2. 불필요한 상태 업데이트 방지

[Section titled “2. 불필요한 상태 업데이트 방지”](#2-불필요한-상태-업데이트-방지)

`setState()`를 호출할 때는 실제로 상태가 변경되었는지 확인합니다:

```dart
1
// 좋지 않은 예
2
void _updateValue(int newValue) {
3
  setState(() {
4
    _value = newValue; // 이전 값과 같더라도 항상 setState 호출
5
  });
6
}
7


8
// 좋은 예
9
void _updateValue(int newValue) {
10
  if (_value != newValue) { // 값이 변경된 경우에만 setState 호출
11
    setState(() {
12
      _value = newValue;
13
    });
14
  }
15
}
```

### 3. 위젯 분리

[Section titled “3. 위젯 분리”](#3-위젯-분리)

큰 위젯을 작은 위젯으로 분리하여 필요한 부분만 리빌드되도록 합니다:

```dart
1
// 좋지 않은 예: 전체 위젯이 다시 빌드됨
2
class WeatherApp extends StatefulWidget {
3
  @override
4
  _WeatherAppState createState() => _WeatherAppState();
5
}
6


7
class _WeatherAppState extends State<WeatherApp> {
8
  bool _isLoading = false;
9
  WeatherData? _weatherData;
10


11
  // ... 날씨 데이터 로드 로직 ...
12


13
  @override
14
  Widget build(BuildContext context) {
15
    return Column(
16
      children: [
17
        AppHeader(), // 재빌드할 필요 없음
18
        if (_isLoading)
19
          CircularProgressIndicator()
20
        else if (_weatherData != null)
21
          Column(
22
            children: [
23
              Text('${_weatherData!.temperature}°C'),
24
              Text(_weatherData!.description),
25
              Image.network(_weatherData!.iconUrl),
26
            ],
27
          ),
28
        SearchBar(onSearch: _loadWeather), // 재빌드할 필요 없음
29
      ],
30
    );
31
  }
32
}
33


34
// 좋은 예: 필요한 위젯만 분리하여 재빌드
35
class WeatherApp extends StatefulWidget {
36
  @override
37
  _WeatherAppState createState() => _WeatherAppState();
38
}
39


40
class _WeatherAppState extends State<WeatherApp> {
41
  bool _isLoading = false;
42
  WeatherData? _weatherData;
43


44
  // ... 날씨 데이터 로드 로직 ...
45


46
  @override
47
  Widget build(BuildContext context) {
48
    return Column(
49
      children: [
50
        const AppHeader(), // const로 선언하여 재사용
51
        WeatherDisplay(
52
          isLoading: _isLoading,
53
          weatherData: _weatherData,
54
        ),
55
        SearchBar(onSearch: _loadWeather), // 검색 로직만 전달
56
      ],
57
    );
58
  }
59
}
60


61
// 분리된 날씨 표시 위젯
62
class WeatherDisplay extends StatelessWidget {
63
  final bool isLoading;
64
  final WeatherData? weatherData;
65


66
  const WeatherDisplay({
67
    Key? key,
68
    required this.isLoading,
69
    this.weatherData,
70
  }) : super(key: key);
71


72
  @override
73
  Widget build(BuildContext context) {
74
    if (isLoading) {
75
      return CircularProgressIndicator();
76
    } else if (weatherData != null) {
77
      return Column(
78
        children: [
79
          Text('${weatherData!.temperature}°C'),
80
          Text(weatherData!.description),
81
          Image.network(weatherData!.iconUrl),
82
        ],
83
      );
84
    } else {
85
      return Text('날씨 정보가 없습니다');
86
    }
87
  }
88
}
```

## 결론

[Section titled “결론”](#결론)

Stateless 위젯과 Stateful 위젯은 Flutter UI 구성의 기본 요소입니다. 각 위젯 유형의 특성과 적절한 사용 사례를 이해하면 더 효율적이고 유지 관리가 쉬운 애플리케이션을 개발할 수 있습니다.

* **Stateless 위젯**은 간단하고 효율적이며, 정적인 UI 요소에 적합합니다.
* **Stateful 위젯**은 동적인 UI와 사용자 상호작용이 필요한 경우에 사용합니다.
* **상태 관리**는 위젯의 복잡성과 성능에 직접적인 영향을 미칩니다.
* **위젯 분리와 const 생성자**는 성능 최적화에 도움이 됩니다.

다음 장에서는 위젯 트리의 구조와 작동 방식에 대해 더 자세히 알아보겠습니다.

# Widget Tree 이해

Flutter의 UI는 위젯 트리(Widget Tree)라고 불리는 계층 구조로 구성됩니다. 이 장에서는 위젯 트리의 개념, 작동 방식, 그리고 Flutter가 위젯 트리를 통해 효율적으로 UI를 렌더링하는 방법에 대해 알아보겠습니다.

## 위젯 트리란?

[Section titled “위젯 트리란?”](#위젯-트리란)

위젯 트리는 Flutter 애플리케이션의 UI를 구성하는 위젯들의 계층적 구조입니다. 모든 Flutter 앱은 루트 위젯에서 시작하여 중첩된 자식 위젯들로 이루어진 트리 형태를 가집니다.

## 위젯 트리의 중요성

[Section titled “위젯 트리의 중요성”](#위젯-트리의-중요성)

위젯 트리는 다음과 같은 이유로 Flutter에서 중요한 개념입니다:

1. **UI 구조화**: 복잡한 UI를 명확하고 체계적으로 구성할 수 있습니다.
2. **렌더링 최적화**: Flutter는 위젯 트리를 사용하여 변경된 부분만 효율적으로 다시 렌더링합니다.
3. **상태 관리**: 위젯 트리는 상태 관리 및 데이터 흐름의 기반을 제공합니다.
4. **컨텍스트 제공**: 위젯 트리는 `BuildContext`를 통해 상위 위젯과 테마, 미디어 쿼리 등에 접근할 수 있게 해줍니다.

## 세 가지 트리

[Section titled “세 가지 트리”](#세-가지-트리)

Flutter의 렌더링 과정은 세 가지 트리로 이루어집니다:

1. **위젯 트리(Widget Tree)**: 애플리케이션의 UI를 설명하는 불변(immutable) 객체의 트리
2. **요소 트리(Element Tree)**: 위젯 트리의 런타임 표현으로, 위젯과 렌더 객체를 연결하는 가변(mutable) 트리
3. **렌더 트리(Render Tree)**: 실제 화면에 그리기를 담당하는 객체들의 트리

### 1. 위젯 트리 (Widget Tree)

[Section titled “1. 위젯 트리 (Widget Tree)”](#1-위젯-트리-widget-tree)

위젯 트리는 개발자가 작성한 코드로, UI를 구성하는 위젯들의 설계도입니다. 위젯은 불변 객체이므로 상태가 변경되면 새로운 위젯 트리가 생성됩니다.

```dart
1
MaterialApp(
2
  home: Scaffold(
3
    appBar: AppBar(
4
      title: Text('위젯 트리 예제'),
5
    ),
6
    body: Center(
7
      child: Column(
8
        mainAxisAlignment: MainAxisAlignment.center,
9
        children: [
10
          Text('Hello, Flutter!'),
11
          ElevatedButton(
12
            onPressed: () {},
13
            child: Text('버튼'),
14
          ),
15
        ],
16
      ),
17
    ),
18
  ),
19
)
```

### 2. 요소 트리 (Element Tree)

[Section titled “2. 요소 트리 (Element Tree)”](#2-요소-트리-element-tree)

요소 트리는 위젯 트리의 인스턴스로, 위젯의 수명 주기를 관리하고 위젯과 렌더 객체 사이의 연결을 유지합니다. 요소는 위젯이 변경될 때 업데이트되거나 재사용됩니다.

요소의 주요 유형:

* **ComponentElement**: 다른 위젯을 빌드하는 위젯에 대응 (예: StatelessWidget, StatefulWidget)
* **RenderObjectElement**: 화면에 무언가를 그리는 위젯에 대응 (예: RenderObjectWidget)

### 3. 렌더 트리 (Render Tree)

[Section titled “3. 렌더 트리 (Render Tree)”](#3-렌더-트리-render-tree)

렌더 트리는 화면에 실제로 그리기를 담당하는 객체들의 트리입니다. 레이아웃 계산, 그리기, 히트 테스트(터치 이벤트 처리) 등을 수행합니다.

렌더 객체의 주요 유형:

* **RenderBox**: 사각형 영역을 차지하는 렌더 객체
* **RenderSliver**: 스크롤 가능한 영역의 일부를 렌더링하는 객체
* **RenderParagraph**: 텍스트를 렌더링하는 객체

## 위젯 트리의 빌드 과정

[Section titled “위젯 트리의 빌드 과정”](#위젯-트리의-빌드-과정)

Flutter가 위젯 트리를 화면에 렌더링하는 과정은 다음과 같습니다:

1. **위젯 생성**: 개발자가 작성한 코드에 따라 위젯 트리가 생성됩니다.
2. **요소 생성/업데이트**: 각 위젯에 대응하는 요소가 생성되거나 업데이트됩니다.
3. **렌더 객체 생성/업데이트**: 요소와 연결된 렌더 객체가 생성되거나 업데이트됩니다.
4. **레이아웃 계산**: 렌더 객체는 부모로부터 제약 조건을 받아 자신의 크기를 결정합니다.
5. **페인팅**: 렌더 객체가 자신의 모양을 그립니다.
6. **화면에 표시**: 최종 결과가 화면에 표시됩니다.

## BuildContext

[Section titled “BuildContext”](#buildcontext)

`BuildContext`는 위젯 트리에서 위젯의 위치를 나타내는 객체입니다. 실제로는 요소 트리의 요소(Element)를 참조합니다.

BuildContext의 주요 용도:

1. **상위 위젯 탐색**: `dependOnInheritedWidgetOfExactType()`를 사용하여 상위 위젯에 접근
2. **테마 및 미디어 쿼리 접근**: `Theme.of(context)`, `MediaQuery.of(context)`
3. **네비게이션**: `Navigator.of(context).push()`
4. **기타 서비스 접근**: `ScaffoldMessenger.of(context)`, `Form.of(context)` 등

```dart
1
ElevatedButton(
2
  onPressed: () {
3
    // BuildContext를 사용하여 스낵바 표시
4
    ScaffoldMessenger.of(context).showSnackBar(
5
      SnackBar(content: Text('안녕하세요!')),
6
    );
7


8
    // BuildContext를 사용하여 다른 화면으로 이동
9
    Navigator.of(context).push(
10
      MaterialPageRoute(builder: (context) => SecondScreen()),
11
    );
12
  },
13
  child: Text('버튼'),
14
)
```

## 위젯 트리 업데이트

[Section titled “위젯 트리 업데이트”](#위젯-트리-업데이트)

Flutter는 위젯 트리가 변경될 때 효율적으로 UI를 업데이트하기 위해 “재조정(reconciliation)” 과정을 수행합니다:

### 키워드: 동일성과 동등성

[Section titled “키워드: 동일성과 동등성”](#키워드-동일성과-동등성)

Flutter의 재조정 알고리즘은 위젯의 “동일성”(identity)이 아닌 “동등성”(equality)에 기반합니다:

1. **동일성(identity)**: 두 객체가 메모리에서 같은 인스턴스인지 (`identical(a, b)` 또는 `a === b`)
2. **동등성(equality)**: 두 객체가 같은 타입과 속성을 가지는지 (`a == b`)

Flutter는 다음 규칙을 사용하여 위젯을 비교합니다:

1. **다른 runtimeType**: 위젯이 다른 타입이면 이전 요소를 폐기하고 새 요소를 생성합니다.
2. **같은 runtimeType, 다른 key**: 이전 요소를 폐기하고 새 요소를 생성합니다.
3. **같은 runtimeType, 같은 key**: 요소를 유지하고 속성을 업데이트합니다.

## 위젯 키(Keys)

[Section titled “위젯 키(Keys)”](#위젯-키keys)

키는 Flutter가 위젯을 식별하는 데 사용되는 식별자입니다. 특히 동적 위젯(리스트, 그리드 등)에서 중요합니다.

키가 중요한 상황:

1. **리스트 항목의 순서가 변경될 때**
2. **위젯이 추가/제거될 때**
3. **상태를 유지해야 할 때**

### 키 유형

[Section titled “키 유형”](#키-유형)

1. **ValueKey**: 단일 값을 기반으로 한 키

   ```dart
   1
   ListView.builder(
   2
     itemCount: items.length,
   3
     itemBuilder: (context, index) {
   4
       return ListTile(
   5
         key: ValueKey(items[index].id),
   6
         title: Text(items[index].title),
   7
       );
   8
     },
   9
   )
   ```

2. **ObjectKey**: 객체 전체를 기반으로 한 키

   ```dart
   1
   ListTile(
   2
     key: ObjectKey(item), // 'item' 객체 전체를 키로 사용
   3
     title: Text(item.title),
   4
   )
   ```

3. **UniqueKey**: 매번 고유한 키 생성

   ```dart
   1
   // 애니메이션 중에 위젯을 강제로 재생성할 때 유용
   2
   Container(
   3
     key: UniqueKey(),
   4
     color: Colors.blue,
   5
     child: Text('새로운 인스턴스'),
   6
   )
   ```

4. **GlobalKey**: 위젯의 상태에 접근하거나 위젯의 크기/위치를 파악하는 데 사용

   ```dart
   1
   final formKey = GlobalKey<FormState>();
   2


   3
   Form(
   4
     key: formKey,
   5
     child: Column(
   6
       children: [
   7
         TextFormField(/* ... */),
   8
         ElevatedButton(
   9
           onPressed: () {
   10
             if (formKey.currentState!.validate()) {
   11
               // 폼 처리
   12
             }
   13
           },
   14
           child: Text('제출'),
   15
         ),
   16
       ],
   17
     ),
   18
   )
   ```

## 리스트 내부의 위젯 트리

[Section titled “리스트 내부의 위젯 트리”](#리스트-내부의-위젯-트리)

리스트 위젯(`ListView`, `GridView` 등)은 많은 자식 위젯을 포함할 수 있습니다. 이러한 리스트에서 항목을 추가, 제거, 재정렬할 때 키를 사용하면 Flutter가 효율적으로 요소 트리를 업데이트할 수 있습니다.

### 키 없이 리스트 항목 제거

[Section titled “키 없이 리스트 항목 제거”](#키-없이-리스트-항목-제거)

키가 없으면 Flutter는 위치 기반으로 위젯을 비교합니다. 첫 번째 위젯 A는 그대로 유지되고, 두 번째 위치에 있던 B는 C로 업데이트됩니다. 이로 인해 상태가 예상치 않게 섞일 수 있습니다.

### 키를 사용한 리스트 항목 제거

[Section titled “키를 사용한 리스트 항목 제거”](#키를-사용한-리스트-항목-제거)

키를 사용하면 Flutter는 키를 기반으로 위젯을 식별합니다. B(key:2)가 제거되고 A와 C는 키를 통해 정확히 식별되어 상태가 올바르게 유지됩니다.

## 실제 예제: 위젯 트리 구성

[Section titled “실제 예제: 위젯 트리 구성”](#실제-예제-위젯-트리-구성)

아래 예제는 복잡한 위젯 트리를 보여줍니다:

```dart
1
class ProfileScreen extends StatelessWidget {
2
  final User user;
3


4
  const ProfileScreen({
5
    Key? key,
6
    required this.user,
7
  }) : super(key: key);
8


9
  @override
10
  Widget build(BuildContext context) {
11
    return Scaffold(
12
      appBar: AppBar(
13
        title: Text('프로필'),
14
        actions: [
15
          IconButton(
16
            icon: Icon(Icons.settings),
17
            onPressed: () { /* ... */ },
18
          ),
19
        ],
20
      ),
21
      body: SingleChildScrollView(
22
        child: Column(
23
          crossAxisAlignment: CrossAxisAlignment.start,
24
          children: [
25
            // 사용자 헤더 섹션
26
            UserHeaderWidget(user: user),
27


28
            // 카운터 섹션
29
            StatsSection(
30
              followers: user.followers,
31
              following: user.following,
32
              posts: user.posts,
33
            ),
34


35
            // 포스트 그리드
36
            PostGridWidget(
37
              posts: user.recentPosts,
38
              onPostTap: (post) { /* ... */ },
39
            ),
40
          ],
41
        ),
42
      ),
43
      bottomNavigationBar: BottomNavigationBar(
44
        currentIndex: 0,
45
        items: [
46
          BottomNavigationBarItem(
47
            icon: Icon(Icons.home),
48
            label: '홈',
49
          ),
50
          BottomNavigationBarItem(
51
            icon: Icon(Icons.search),
52
            label: '검색',
53
          ),
54
          BottomNavigationBarItem(
55
            icon: Icon(Icons.person),
56
            label: '프로필',
57
          ),
58
        ],
59
        onTap: (index) { /* ... */ },
60
      ),
61
    );
62
  }
63
}
64


65
// 중첩된 자식 위젯의 예
66
class UserHeaderWidget extends StatelessWidget {
67
  final User user;
68


69
  const UserHeaderWidget({
70
    Key? key,
71
    required this.user,
72
  }) : super(key: key);
73


74
  @override
75
  Widget build(BuildContext context) {
76
    return Container(
77
      padding: EdgeInsets.all(16),
78
      child: Row(
79
        children: [
80
          CircleAvatar(
81
            radius: 40,
82
            backgroundImage: NetworkImage(user.avatarUrl),
83
          ),
84
          SizedBox(width: 16),
85
          Expanded(
86
            child: Column(
87
              crossAxisAlignment: CrossAxisAlignment.start,
88
              children: [
89
                Text(
90
                  user.name,
91
                  style: TextStyle(
92
                    fontSize: 20,
93
                    fontWeight: FontWeight.bold,
94
                  ),
95
                ),
96
                SizedBox(height: 4),
97
                Text(user.bio),
98
              ],
99
            ),
100
          ),
101
        ],
102
      ),
103
    );
104
  }
105
}
```

위 코드의 위젯 트리 구조:

## 위젯 트리 디버깅

[Section titled “위젯 트리 디버깅”](#위젯-트리-디버깅)

Flutter는 위젯 트리를 디버깅하기 위한 다양한 도구를 제공합니다:

### 1. Flutter DevTools

[Section titled “1. Flutter DevTools”](#1-flutter-devtools)

Flutter DevTools의 위젯 인스펙터를 사용하면 위젯 트리를 시각적으로 탐색하고 속성을 검사할 수 있습니다.

### 2. debugDumpApp() 메서드

[Section titled “2. debugDumpApp() 메서드”](#2-debugdumpapp-메서드)

```dart
1
// 위젯 트리를 콘솔에 출력
2
void _printWidgetTree() {
3
  debugDumpApp();
4
}
5


6
// 사용 예
7
ElevatedButton(
8
  onPressed: _printWidgetTree,
9
  child: Text('위젯 트리 출력'),
10
)
```

### 3. Widget Inspector 서비스

[Section titled “3. Widget Inspector 서비스”](#3-widget-inspector-서비스)

```dart
1
// 위젯 인스펙터 활성화
2
void main() {
3
  WidgetsFlutterBinding.ensureInitialized();
4
  if (kDebugMode) {
5
    WidgetInspectorService.instance.selection.addListener(() {
6
      // 선택한 위젯이 변경될 때 호출
7
      print('선택된 위젯: ${WidgetInspectorService.instance.selection.current}');
8
    });
9
  }
10
  runApp(MyApp());
11
}
```

## 위젯 트리의 최적화

[Section titled “위젯 트리의 최적화”](#위젯-트리의-최적화)

위젯 트리를 효율적으로 구성하면 앱의 성능을 향상시킬 수 있습니다:

### 1. 트리 깊이 최소화

[Section titled “1. 트리 깊이 최소화”](#1-트리-깊이-최소화)

과도하게 깊은 위젯 트리는 빌드 시간을 늘리고 메모리를 더 많이 사용합니다.

```dart
1
// 좋지 않은 예: 불필요하게 깊은 트리
2
Container(
3
  child: Container(
4
    child: Container(
5
      child: Text('깊은 트리'),
6
    ),
7
  ),
8
)
9


10
// 좋은 예: 간결한 트리
11
Container(
12
  padding: EdgeInsets.all(16),
13
  margin: EdgeInsets.all(8),
14
  decoration: BoxDecoration(/* ... */),
15
  child: Text('간결한 트리'),
16
)
```

### 2. const 생성자 사용

[Section titled “2. const 생성자 사용”](#2-const-생성자-사용)

`const` 생성자로 만든 위젯은 빌드 시간에 한 번만 생성되어 메모리와 성능을 개선합니다.

```dart
1
// 좋지 않은 예: 매번 새로운 위젯 인스턴스 생성
2
Container(
3
  padding: EdgeInsets.all(16),
4
  child: Text('Hello'),
5
)
6


7
// 좋은 예: 불변 위젯 재사용
8
const SizedBox(height: 16)
```

### 3. 위젯 분리 및 캐싱

[Section titled “3. 위젯 분리 및 캐싱”](#3-위젯-분리-및-캐싱)

자주 변경되지 않는 위젯을 분리하여 불필요한 재빌드를 방지합니다.

```dart
1
// 좋지 않은 예: 전체 화면이 다시 빌드됨
2
class MyScreen extends StatefulWidget {
3
  @override
4
  _MyScreenState createState() => _MyScreenState();
5
}
6


7
class _MyScreenState extends State<MyScreen> {
8
  int _count = 0;
9


10
  @override
11
  Widget build(BuildContext context) {
12
    return Scaffold(
13
      appBar: AppBar(title: Text('앱')), // 매번 재빌드됨
14
      body: Center(
15
        child: Column(
16
          children: [
17
            ComplexWidget(), // 매번 재빌드됨
18
            Text('카운트: $_count'),
19
            ElevatedButton(
20
              onPressed: () => setState(() => _count++),
21
              child: Text('증가'),
22
            ),
23
          ],
24
        ),
25
      ),
26
    );
27
  }
28
}
29


30
// 좋은 예: 변경되지 않는 위젯 분리
31
class MyScreen extends StatefulWidget {
32
  @override
33
  _MyScreenState createState() => _MyScreenState();
34
}
35


36
class _MyScreenState extends State<MyScreen> {
37
  int _count = 0;
38


39
  // 클래스 필드로 선언하여 재사용
40
  final _appBar = AppBar(title: Text('앱'));
41
  final _complexWidget = ComplexWidget();
42


43
  @override
44
  Widget build(BuildContext context) {
45
    return Scaffold(
46
      appBar: _appBar, // 재사용됨
47
      body: Center(
48
        child: Column(
49
          children: [
50
            _complexWidget, // 재사용됨
51
            Text('카운트: $_count'), // 변경됨
52
            ElevatedButton(
53
              onPressed: () => setState(() => _count++),
54
              child: const Text('증가'),
55
            ),
56
          ],
57
        ),
58
      ),
59
    );
60
  }
61
}
```

### 4. RepaintBoundary 사용

[Section titled “4. RepaintBoundary 사용”](#4-repaintboundary-사용)

`RepaintBoundary`는 자식 위젯이 다시 그려질 때 부모 위젯까지 다시 그려지는 것을 방지합니다.

```dart
1
class MyAnimatedWidget extends StatefulWidget {
2
  @override
3
  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();
4
}
5


6
class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
7
    with SingleTickerProviderStateMixin {
8
  late AnimationController _controller;
9


10
  @override
11
  void initState() {
12
    super.initState();
13
    _controller = AnimationController(
14
      vsync: this,
15
      duration: Duration(seconds: 1),
16
    )..repeat();
17
  }
18


19
  @override
20
  void dispose() {
21
    _controller.dispose();
22
    super.dispose();
23
  }
24


25
  @override
26
  Widget build(BuildContext context) {
27
    return Column(
28
      children: [
29
        Text('이 텍스트는 다시 그려지지 않습니다'),
30


31
        // RepaintBoundary로 애니메이션 위젯 격리
32
        RepaintBoundary(
33
          child: AnimatedBuilder(
34
            animation: _controller,
35
            builder: (context, child) {
36
              return Transform.rotate(
37
                angle: _controller.value * 2 * pi,
38
                child: Container(
39
                  width: 100,
40
                  height: 100,
41
                  color: Colors.blue,
42
                ),
43
              );
44
            },
45
          ),
46
        ),
47


48
        Text('이 텍스트도 다시 그려지지 않습니다'),
49
      ],
50
    );
51
  }
52
}
```

## 상속된 위젯(InheritedWidget)과 위젯 트리

[Section titled “상속된 위젯(InheritedWidget)과 위젯 트리”](#상속된-위젯inheritedwidget과-위젯-트리)

`InheritedWidget`은 위젯 트리를 통해 데이터를 효율적으로 전달하는 방법을 제공합니다. 이는 테마, 사용자 데이터 등을 하위 위젯에 전달하는 데 유용합니다.

### InheritedWidget 예제

[Section titled “InheritedWidget 예제”](#inheritedwidget-예제)

```dart
1
// 데이터 모델
2
class UserData {
3
  final String name;
4
  final String email;
5


6
  UserData({required this.name, required this.email});
7
}
8


9
// InheritedWidget 정의
10
class UserProvider extends InheritedWidget {
11
  final UserData userData;
12


13
  const UserProvider({
14
    Key? key,
15
    required this.userData,
16
    required Widget child,
17
  }) : super(key: key, child: child);
18


19
  // of 메서드로 위젯 트리에서 UserProvider 인스턴스 찾기
20
  static UserProvider of(BuildContext context) {
21
    final provider = context.dependOnInheritedWidgetOfExactType<UserProvider>();
22
    assert(provider != null, 'UserProvider가 위젯 트리에 없습니다');
23
    return provider!;
24
  }
25


26
  @override
27
  bool updateShouldNotify(UserProvider oldWidget) {
28
    return userData.name != oldWidget.userData.name ||
29
           userData.email != oldWidget.userData.email;
30
  }
31
}
32


33
// 사용 예시
34
class MyApp extends StatelessWidget {
35
  @override
36
  Widget build(BuildContext context) {
37
    return MaterialApp(
38
      home: UserProvider(
39
        userData: UserData(
40
          name: '홍길동',
41
          email: 'hong@example.com',
42
        ),
43
        child: HomeScreen(),
44
      ),
45
    );
46
  }
47
}
48


49
// 하위 위젯에서 데이터 접근
50
class ProfileSection extends StatelessWidget {
51
  @override
52
  Widget build(BuildContext context) {
53
    // UserProvider.of(context)로 데이터 접근
54
    final userData = UserProvider.of(context).userData;
55


56
    return Card(
57
      child: Column(
58
        children: [
59
          Text('이름: ${userData.name}'),
60
          Text('이메일: ${userData.email}'),
61
        ],
62
      ),
63
    );
64
  }
65
}
```

## 결론

[Section titled “결론”](#결론)

위젯 트리는 Flutter UI의 핵심 구성 요소입니다. 위젯 트리, 요소 트리, 렌더 트리의 개념을 이해하면 Flutter가 어떻게 효율적으로 UI를 구성하고 업데이트하는지 파악할 수 있습니다.

효율적인 위젯 트리 구성은 Flutter 앱의 성능과 유지 관리성에 큰 영향을 미칩니다. 적절한 위젯 키 사용, 위젯 구조 최적화, `const` 생성자 활용 등의 기법으로 더 효율적인 UI를 구축할 수 있습니다.

`InheritedWidget`과 같은 상속 메커니즘을 활용하면 위젯 트리를 통해 데이터를 효율적으로 공유하여 앱 아키텍처를 개선할 수 있습니다. 이러한 개념들은 Provider, Riverpod 등 Flutter의 상태 관리 솔루션의 기반이 됩니다.

다음 장에서는 Flutter의 기본 위젯들에 대해 더 자세히 알아보겠습니다.

# 위젯 개념과 주요 위젯

Flutter의 핵심은 위젯(Widget)입니다. Flutter 애플리케이션은 여러 위젯들로 구성되어 있으며, 위젯은 UI의 구성 요소를 나타냅니다. 이 장에서는 Flutter 위젯의 기본 개념과 위젯 시스템의 작동 방식을 알아보겠습니다.

## 위젯이란?

[Section titled “위젯이란?”](#위젯이란)

위젯(Widget)은 Flutter에서 UI를 구성하는 기본 단위입니다. 버튼, 텍스트, 이미지, 레이아웃, 스크롤 등 화면에 보이는 모든 요소는 위젯입니다. Flutter의 철학은 “모든 것이 위젯”이라는 개념에 기반하고 있습니다.

위젯은 다음과 같은 특징을 가지고 있습니다:

1. **불변성(Immutable)**: 위젯은 생성된 후 변경할 수 없습니다. UI를 변경하려면 새로운 위젯을 생성해야 합니다.
2. **계층 구조**: 위젯은 트리 구조로 조직되며, 부모 위젯은 자식 위젯을 포함할 수 있습니다.
3. **선언적 UI**: Flutter는 현재 애플리케이션 상태에 따라 UI가 어떻게 보여야 하는지 선언적으로 정의합니다.
4. **합성(Composition)**: 작은 위젯들을 조합하여 복잡한 UI를 구성합니다.

## Flutter 위젯의 주기

[Section titled “Flutter 위젯의 주기”](#flutter-위젯의-주기)

Flutter 위젯은 생성, 구성, 렌더링의 주기를 거칩니다:

1. **위젯 생성**: 위젯 클래스의 인스턴스가 생성됩니다.
2. **빌드 메서드 호출**: 위젯의 `build()` 메서드가 호출되어 위젯 트리를 구성합니다.
3. **요소 트리 생성**: 위젯 트리를 기반으로 Element 트리가 생성되거나 업데이트됩니다.
4. **RenderObject 생성**: Element 트리에 따라 RenderObject 트리가 생성되거나 업데이트됩니다.
5. **화면에 렌더링**: RenderObject 트리를 기반으로 UI가 화면에 렌더링됩니다.
6. **위젯 상태 변경**: 상태 변경 시 위젯이 다시 빌드됩니다.

## 위젯 유형

[Section titled “위젯 유형”](#위젯-유형)

Flutter 위젯은 크게 두 가지 유형으로 나눌 수 있습니다:

### 1. Stateless 위젯

[Section titled “1. Stateless 위젯”](#1-stateless-위젯)

Stateless 위젯은 내부 상태를 가지지 않는 정적인 위젯입니다. 생성 시 전달받은 속성(properties)만 사용하며, 한 번 빌드되면 변경되지 않습니다. 간단한 UI 요소나 변경이 필요 없는 화면에 적합합니다.

```dart
1
class GreetingWidget extends StatelessWidget {
2
  final String name;
3


4
  const GreetingWidget({Key? key, required this.name}) : super(key: key);
5


6
  @override
7
  Widget build(BuildContext context) {
8
    return Text('안녕하세요, $name님!');
9
  }
10
}
```

### 2. Stateful 위젯

[Section titled “2. Stateful 위젯”](#2-stateful-위젯)

Stateful 위젯은 내부 상태를 가지고 있으며, 상태가 변경되면 UI가 다시 빌드됩니다. 사용자 입력, 네트워크 응답, 시간 경과 등에 따라 변경되는 UI 요소에 적합합니다.

```dart
1
class CounterWidget extends StatefulWidget {
2
  const CounterWidget({Key? key}) : super(key: key);
3


4
  @override
5
  _CounterWidgetState createState() => _CounterWidgetState();
6
}
7


8
class _CounterWidgetState extends State<CounterWidget> {
9
  int _counter = 0;
10


11
  void _incrementCounter() {
12
    setState(() {
13
      _counter++;
14
    });
15
  }
16


17
  @override
18
  Widget build(BuildContext context) {
19
    return Column(
20
      mainAxisAlignment: MainAxisAlignment.center,
21
      children: [
22
        Text('카운터: $_counter'),
23
        ElevatedButton(
24
          onPressed: _incrementCounter,
25
          child: Text('증가'),
26
        ),
27
      ],
28
    );
29
  }
30
}
```

## 위젯 트리

[Section titled “위젯 트리”](#위젯-트리)

Flutter 애플리케이션의 UI는 위젯 트리로 표현됩니다. 모든 Flutter 앱은 루트 위젯에서 시작하여 자식 위젯들로 구성된 트리 구조를 가집니다.

위젯 트리의 특징:

1. **부모-자식 관계**: 위젯은 하나의 부모와 여러 자식을 가질 수 있습니다.
2. **단방향 데이터 흐름**: 데이터는 부모에서 자식으로 흐릅니다.
3. **렌더링 최적화**: Flutter는 변경된 위젯만 다시 빌드하여 성능을 최적화합니다.

## 위젯의 세 가지 트리

[Section titled “위젯의 세 가지 트리”](#위젯의-세-가지-트리)

Flutter는 UI 렌더링을 위해 세 가지 트리를 관리합니다:

1. **Widget 트리**: UI의 설계도로, 사용자가 작성한 위젯 클래스의 인스턴스들로 구성됩니다.
2. **Element 트리**: Widget과 RenderObject를 연결하는 중간 계층으로, 위젯의 수명 주기를 관리합니다.
3. **RenderObject 트리**: 실제 화면에 그려지는 객체들을 표현하며, 레이아웃 계산과 페인팅을 담당합니다.

## Flutter 위젯의 구성 방식

[Section titled “Flutter 위젯의 구성 방식”](#flutter-위젯의-구성-방식)

Flutter 위젯은 합성(Composition)을 통해 구성됩니다. 작은 위젯들을 조합하여 복잡한 UI를 만들 수 있습니다.

```dart
1
Scaffold(
2
  appBar: AppBar(
3
    title: Text('Flutter 앱'),
4
    actions: [
5
      IconButton(
6
        icon: Icon(Icons.settings),
7
        onPressed: () {},
8
      ),
9
    ],
10
  ),
11
  body: Center(
12
    child: Column(
13
      mainAxisAlignment: MainAxisAlignment.center,
14
      children: [
15
        Text('Hello, Flutter!'),
16
        SizedBox(height: 20),
17
        ElevatedButton(
18
          onPressed: () {},
19
          child: Text('버튼'),
20
        ),
21
      ],
22
    ),
23
  ),
24
  floatingActionButton: FloatingActionButton(
25
    onPressed: () {},
26
    child: Icon(Icons.add),
27
  ),
28
)
```

이 예제에서 `Scaffold`, `AppBar`, `Text`, `Center`, `Column` 등 여러 위젯들이 중첩되어 하나의 화면을 구성합니다.

## Flutter 기본 위젯의 분류

[Section titled “Flutter 기본 위젯의 분류”](#flutter-기본-위젯의-분류)

Flutter 위젯은 기능에 따라 여러 카테고리로 분류할 수 있습니다:

### 구조적 위젯

[Section titled “구조적 위젯”](#구조적-위젯)

애플리케이션의 구조를 정의하는 위젯입니다:

* **MaterialApp**: Material Design 앱의 진입점
* **CupertinoApp**: iOS 스타일 앱의 진입점
* **Scaffold**: 기본 앱 구조 제공 (앱바, 드로워, 바텀 시트 등)
* **AppBar**: 앱 상단의 앱 바

### 시각적 위젯

[Section titled “시각적 위젯”](#시각적-위젯)

화면에 콘텐츠를 표시하는 위젯입니다:

* **Text**: 텍스트 표시
* **Image**: 이미지 표시
* **Icon**: 아이콘 표시
* **Card**: 둥근 모서리와 그림자가 있는 카드

### 레이아웃 위젯

[Section titled “레이아웃 위젯”](#레이아웃-위젯)

위젯들을 배치하고 정렬하는 위젯입니다:

* **Container**: 패딩, 마진, 배경색, 크기 등을 설정할 수 있는 범용 컨테이너
* **Row/Column**: 위젯을 가로/세로로 배열
* **Stack**: 위젯들을 겹쳐서 배치
* **ListView**: 스크롤 가능한 목록

### 입력 위젯

[Section titled “입력 위젯”](#입력-위젯)

사용자 입력을 받는 위젯입니다:

* **TextField**: 텍스트 입력
* **Checkbox**: 체크박스
* **Radio**: 라디오 버튼
* **Slider**: 슬라이더

### 상호작용 위젯

[Section titled “상호작용 위젯”](#상호작용-위젯)

사용자 상호작용을 처리하는 위젯입니다:

* **GestureDetector**: 다양한 제스처 인식
* **InkWell**: 터치 효과가 있는 영역
* **Draggable**: 드래그 가능한 위젯

### 애니메이션 위젯

[Section titled “애니메이션 위젯”](#애니메이션-위젯)

애니메이션 효과를 제공하는 위젯입니다:

* **AnimatedContainer**: 속성 변경 시 애니메이션 효과
* **Hero**: 화면 전환 시 애니메이션 효과
* **FadeTransition**: 페이드 인/아웃 효과

## 위젯 속성 전달

[Section titled “위젯 속성 전달”](#위젯-속성-전달)

Flutter 위젯은 생성자를 통해 속성을 전달받아 UI를 구성합니다:

```dart
1
Container(
2
  width: 200,
3
  height: 100,
4
  margin: EdgeInsets.all(10),
5
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
6
  decoration: BoxDecoration(
7
    color: Colors.blue,
8
    borderRadius: BorderRadius.circular(8),
9
    boxShadow: [
10
      BoxShadow(
11
        color: Colors.black26,
12
        offset: Offset(0, 2),
13
        blurRadius: 6,
14
      ),
15
    ],
16
  ),
17
  child: Center(
18
    child: Text(
19
      'Flutter',
20
      style: TextStyle(
21
        color: Colors.white,
22
        fontSize: 24,
23
        fontWeight: FontWeight.bold,
24
      ),
25
    ),
26
  ),
27
)
```

이 예제에서 `Container`, `Center`, `Text` 위젯은 각각 다양한 속성(width, height, decoration, style 등)을 전달받아 특정한 모양과 스타일을 가진 UI를 생성합니다.

## 위젯 키(Key)

[Section titled “위젯 키(Key)”](#위젯-키key)

위젯 키는 Flutter가 위젯 트리에서 위젯을 식별하는 데 사용됩니다. 특히 동적으로 변경되는 위젯 목록에서 중요한 역할을 합니다.

```dart
1
ListView.builder(
2
  itemCount: items.length,
3
  itemBuilder: (context, index) {
4
    return ListTile(
5
      key: ValueKey(items[index].id), // 고유 ID를 키로 사용
6
      title: Text(items[index].title),
7
    );
8
  },
9
)
```

위젯 키의 주요 종류:

* **ValueKey**: 단일 값을 기반으로 한 키
* **ObjectKey**: 객체 식별자를 기반으로 한 키
* **UniqueKey**: 매번 고유한 키를 생성
* **GlobalKey**: 전역적으로 접근 가능한 키, 위젯의 상태에 접근하거나 위젯의 크기/위치를 파악하는 데 사용

## 위젯 제약 조건(Constraints)

[Section titled “위젯 제약 조건(Constraints)”](#위젯-제약-조건constraints)

Flutter의 레이아웃 시스템은 부모 위젯이 자식 위젯에게 제약 조건(constraints)을 전달하고, 자식 위젯은 이 제약 조건 내에서 자신의 크기를 결정하는 방식으로 작동합니다.

제약 조건은 최소/최대 너비와 높이로 구성되며, 자식 위젯은 이 범위 내에서 크기를 결정합니다:

```dart
1
ConstrainedBox(
2
  constraints: BoxConstraints(
3
    minWidth: 100,
4
    maxWidth: 200,
5
    minHeight: 50,
6
    maxHeight: 100,
7
  ),
8
  child: Container(
9
    color: Colors.blue,
10
    width: 150, // minWidth와 maxWidth 사이의 값
11
    height: 75, // minHeight와 maxHeight 사이의 값
12
  ),
13
)
```

## 위젯 렌더링 과정

[Section titled “위젯 렌더링 과정”](#위젯-렌더링-과정)

Flutter의 위젯 렌더링 과정은 다음과 같습니다:

1. **레이아웃 단계**: 부모 위젯이 자식 위젯에게 제약 조건을 전달하고, 자식 위젯은 자신의 크기를 결정합니다.
2. **페인팅 단계**: 위젯의 외관이 렌더링됩니다.
3. **합성 단계**: 렌더링된 레이어들이 화면에 합성됩니다.

## 결론

[Section titled “결론”](#결론)

Flutter의 위젯 시스템은 UI 구성을 위한 강력하고 유연한 방법을 제공합니다. “모든 것이 위젯”이라는 철학을 통해 일관된 방식으로 복잡한 UI를 구축할 수 있습니다. 위젯의 불변성, 선언적 특성, 합성 패턴은 Flutter가 효율적이고 예측 가능한 UI 프레임워크가 되는 데 중요한 역할을 합니다.

다음 장에서는 Stateless 위젯과 Stateful 위젯에 대해 더 자세히 알아보겠습니다.

# InheritedWidget과 Provider

이 장에서는 Flutter의 위젯 트리를 통해 상태를 공유하는 방법인 `InheritedWidget`과 이를 기반으로 한 `Provider` 패키지에 대해 알아보겠습니다. 이 방식들은 상태 관리를 위한 중요한 도구로, 위젯 트리 전체에 걸쳐 데이터를 효율적으로 공유할 수 있게 해줍니다.

## InheritedWidget 이해하기

[Section titled “InheritedWidget 이해하기”](#inheritedwidget-이해하기)

`InheritedWidget`은 Flutter 프레임워크에 내장된 위젯으로, 위젯 트리의 하위 항목들에게 데이터를 효율적으로 전달할 수 있게 합니다. 특히 위젯 트리 깊숙한 곳에 있는 위젯이 상위 위젯의 데이터에 접근해야 할 때 매우 유용합니다.

### InheritedWidget의 작동 원리

[Section titled “InheritedWidget의 작동 원리”](#inheritedwidget의-작동-원리)

1. **데이터 저장**: InheritedWidget은 공유하려는 데이터를 저장합니다.
2. **위젯 트리 전파**: 이 데이터는 위젯 트리 아래로 자동으로 전파됩니다.
3. **컨텍스트 접근**: 하위 위젯들은 BuildContext를 통해 상위의 InheritedWidget에 접근할 수 있습니다.
4. **변경 알림**: InheritedWidget이 업데이트되면, 이에 의존하는 모든 위젯들이 자동으로 재빌드됩니다.

### InheritedWidget 구현하기

[Section titled “InheritedWidget 구현하기”](#inheritedwidget-구현하기)

간단한 테마 데이터를 공유하는 InheritedWidget을 구현해 보겠습니다:

```dart
1
class ThemeData {
2
  final Color primaryColor;
3
  final Color secondaryColor;
4
  final double fontSize;
5


6
  const ThemeData({
7
    required this.primaryColor,
8
    required this.secondaryColor,
9
    required this.fontSize,
10
  });
11
}
12


13
class ThemeInherited extends InheritedWidget {
14
  final ThemeData themeData;
15


16
  const ThemeInherited({
17
    Key? key,
18
    required this.themeData,
19
    required Widget child,
20
  }) : super(key: key, child: child);
21


22
  // of 메서드: 하위 위젯에서 ThemeInherited 인스턴스를 찾는 정적 메서드
23
  static ThemeInherited of(BuildContext context) {
24
    final ThemeInherited? result =
25
        context.dependOnInheritedWidgetOfExactType<ThemeInherited>();
26
    assert(result != null, 'ThemeInherited를 찾을 수 없습니다.');
27
    return result!;
28
  }
29


30
  // 위젯이 업데이트되었을 때 하위 위젯들에게 알릴지 결정하는 메서드
31
  @override
32
  bool updateShouldNotify(ThemeInherited oldWidget) {
33
    return themeData.primaryColor != oldWidget.themeData.primaryColor ||
34
        themeData.secondaryColor != oldWidget.themeData.secondaryColor ||
35
        themeData.fontSize != oldWidget.themeData.fontSize;
36
  }
37
}
```

### InheritedWidget 사용하기

[Section titled “InheritedWidget 사용하기”](#inheritedwidget-사용하기)

위에서 만든 ThemeInherited 위젯을 사용하는 방법:

```dart
1
// 앱의 루트에 InheritedWidget 설정
2
void main() {
3
  runApp(
4
    ThemeInherited(
5
      themeData: ThemeData(
6
        primaryColor: Colors.blue,
7
        secondaryColor: Colors.green,
8
        fontSize: 16.0,
9
      ),
10
      child: MyApp(),
11
    ),
12
  );
13
}
14


15
// 하위 위젯에서 데이터 접근
16
class ThemedText extends StatelessWidget {
17
  final String text;
18


19
  const ThemedText({Key? key, required this.text}) : super(key: key);
20


21
  @override
22
  Widget build(BuildContext context) {
23
    // InheritedWidget에서 테마 데이터 가져오기
24
    final theme = ThemeInherited.of(context).themeData;
25


26
    return Text(
27
      text,
28
      style: TextStyle(
29
        color: theme.primaryColor,
30
        fontSize: theme.fontSize,
31
      ),
32
    );
33
  }
34
}
```

### InheritedWidget의 한계

[Section titled “InheritedWidget의 한계”](#inheritedwidget의-한계)

InheritedWidget은 강력하지만 몇 가지 제한사항이 있습니다:

1. **상태 변경 메커니즘 없음**: 데이터를 공유할 수 있지만, 변경할 수 있는 메커니즘은 제공하지 않습니다.
2. **복잡한 구현**: 직접 구현하려면 상용구 코드가 많이 필요합니다.
3. **변경 관리 번거로움**: 상태 변경 시 새 InheritedWidget을 생성하고 위젯 트리를 다시 빌드해야 합니다.

이러한 한계를 해결하기 위해 Provider 패키지가 개발되었습니다.

## Provider 패키지

[Section titled “Provider 패키지”](#provider-패키지)

Provider는 InheritedWidget을 기반으로 구축된 상태 관리 패키지로, 코드를 단순화하고 상태 관리를 더 쉽게 만들어줍니다.

### Provider의 주요 특징

[Section titled “Provider의 주요 특징”](#provider의-주요-특징)

1. **편리한 API**: InheritedWidget을 직접 구현하는 것보다 간단한 API 제공
2. **여러 Provider 유형**: 다양한 사용 사례에 맞는 여러 종류의 Provider 제공
3. **상태 변경 통합**: 상태 변경 메커니즘이 내장되어 있음
4. **의존성 주입**: 테스트와 재사용을 위한 의존성 주입 패턴 지원

### Provider 패키지 설치

[Section titled “Provider 패키지 설치”](#provider-패키지-설치)

pubspec.yaml 파일에 provider 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  provider: ^6.0.5 # 최신 버전을 확인하세요
```

### Provider의 종류

[Section titled “Provider의 종류”](#provider의-종류)

Provider 패키지는 다양한 종류의 Provider를 제공합니다:

1. **Provider**: 가장 기본적인 Provider로, 변경되지 않는 데이터를 제공
2. **ChangeNotifierProvider**: ChangeNotifier를 사용하여 변경 가능한 상태를 관리
3. **FutureProvider**: Future로부터 값을 제공
4. **StreamProvider**: Stream으로부터 값을 제공
5. **ProxyProvider**: 다른 Provider의 값에 의존하는 값을 제공
6. **MultiProvider**: 여러 Provider를 한 번에 제공

### 기본 Provider 사용하기

[Section titled “기본 Provider 사용하기”](#기본-provider-사용하기)

가장 간단한 Provider를 사용하는 예제:

```dart
1
// 데이터 모델
2
class User {
3
  final String name;
4
  final int age;
5


6
  const User({required this.name, required this.age});
7
}
8


9
// Provider 설정
10
void main() {
11
  runApp(
12
    Provider<User>(
13
      create: (_) => User(name: '홍길동', age: 30),
14
      child: MyApp(),
15
    ),
16
  );
17
}
18


19
// 데이터 사용
20
class UserInfoPage extends StatelessWidget {
21
  @override
22
  Widget build(BuildContext context) {
23
    // Provider에서 데이터 가져오기
24
    final user = Provider.of<User>(context);
25


26
    return Scaffold(
27
      appBar: AppBar(
28
        title: Text('Provider 예제'),
29
      ),
30
      body: Center(
31
        child: Column(
32
          mainAxisAlignment: MainAxisAlignment.center,
33
          children: [
34
            Text('이름: ${user.name}'),
35
            Text('나이: ${user.age}'),
36
          ],
37
        ),
38
      ),
39
    );
40
  }
41
}
```

### ChangeNotifierProvider로 변경 가능한 상태 관리하기

[Section titled “ChangeNotifierProvider로 변경 가능한 상태 관리하기”](#changenotifierprovider로-변경-가능한-상태-관리하기)

변경 가능한 상태를 관리하는 ChangeNotifierProvider 예제:

```dart
1
// ChangeNotifier 모델
2
class Counter with ChangeNotifier {
3
  int _count = 0;
4
  int get count => _count;
5


6
  void increment() {
7
    _count++;
8
    notifyListeners();  // 변경 사항을 구독자들에게 알림
9
  }
10
}
11


12
// Provider 설정
13
void main() {
14
  runApp(
15
    ChangeNotifierProvider(
16
      create: (context) => Counter(),
17
      child: MyApp(),
18
    ),
19
  );
20
}
21


22
// 상태 사용 및 변경
23
class CounterPage extends StatelessWidget {
24
  @override
25
  Widget build(BuildContext context) {
26
    return Scaffold(
27
      appBar: AppBar(
28
        title: Text('Counter 예제'),
29
      ),
30
      body: Center(
31
        child: Column(
32
          mainAxisAlignment: MainAxisAlignment.center,
33
          children: [
34
            // Consumer 위젯으로 상태 읽기
35
            Consumer<Counter>(
36
              builder: (context, counter, child) {
37
                return Text(
38
                  '카운트: ${counter.count}',
39
                  style: TextStyle(fontSize: 24),
40
                );
41
              },
42
            ),
43
            SizedBox(height: 20),
44
            ElevatedButton(
45
              // Provider에서 읽고 메서드 호출
46
              onPressed: () => Provider.of<Counter>(context, listen: false).increment(),
47
              child: Text('증가'),
48
            ),
49
          ],
50
        ),
51
      ),
52
    );
53
  }
54
}
```

### Provider.of vs Consumer vs context.watch

[Section titled “Provider.of vs Consumer vs context.watch”](#providerof-vs-consumer-vs-contextwatch)

Provider 패키지는 Provider에서 데이터를 읽는 여러 방법을 제공합니다:

1. **Provider.of(context)**:

   ```dart
   1
   final counter = Provider.of<Counter>(context);
   ```

   * `listen: true`(기본값)이면 데이터 변경 시 위젯 재빌드
   * `listen: false`이면 데이터만 읽고 변경 감지는 하지 않음

2. **Consumer**:

   ```dart
   1
   Consumer<Counter>(
   2
     builder: (context, counter, child) {
   3
       return Text('${counter.count}');
   4
     },
   5
   )
   ```

   * 위젯 트리의 일부만 재빌드할 때 유용
   * `child` 매개변수로 재빌드되지 않는 위젯 지정 가능

3. **context.watch()** (Dart 확장 메서드):

   ```dart
   1
   final counter = context.watch<Counter>();
   ```

   * Provider.of와 유사하지만 더 간결한 구문
   * 변경 감지를 통해 위젯 재빌드

4. **context.read()** (Dart 확장 메서드):

   ```dart
   1
   // 이벤트 핸들러 내에서 사용
   2
   onPressed: () => context.read<Counter>().increment()
   ```

   * 변경 감지 없이 현재 값만 읽음 (Provider.of(…, listen: false)와 동일)

5. **context.select\<T, R>(R Function(T) selector)**:

   ```dart
   1
   // UserModel에서 이름만 감시
   2
   final userName = context.select<UserModel, String>((user) => user.name);
   ```

   * 객체의 특정 속성만 감시하여 불필요한 재빌드 방지

### MultiProvider로 여러 Provider 결합하기

[Section titled “MultiProvider로 여러 Provider 결합하기”](#multiprovider로-여러-provider-결합하기)

여러 Provider를 함께 사용해야 할 때는 MultiProvider를 활용합니다:

```dart
1
void main() {
2
  runApp(
3
    MultiProvider(
4
      providers: [
5
        ChangeNotifierProvider(create: (_) => UserModel()),
6
        ChangeNotifierProvider(create: (_) => CartModel()),
7
        Provider(create: (_) => ApiService()),
8
        FutureProvider(create: (_) => loadInitialSettings()),
9
      ],
10
      child: MyApp(),
11
    ),
12
  );
13
}
```

### ProxyProvider로 의존성 있는 Provider 만들기

[Section titled “ProxyProvider로 의존성 있는 Provider 만들기”](#proxyprovider로-의존성-있는-provider-만들기)

한 Provider가 다른 Provider에 의존할 때 사용합니다:

```dart
1
MultiProvider(
2
  providers: [
3
    Provider<ApiService>(
4
      create: (_) => ApiService(),
5
    ),
6
    // ApiService에 의존하는 ProductRepository
7
    ProxyProvider<ApiService, ProductRepository>(
8
      update: (_, apiService, __) => ProductRepository(apiService),
9
    ),
10
    // ProductRepository에 의존하는 ProductViewModel
11
    ProxyProvider<ProductRepository, ProductViewModel>(
12
      update: (_, repository, __) => ProductViewModel(repository),
13
    ),
14
  ],
15
  child: MyApp(),
16
)
```

## 실제 예제: 장바구니 앱

[Section titled “실제 예제: 장바구니 앱”](#실제-예제-장바구니-앱)

이제 Provider를 사용하여 간단한 장바구니 앱을 구현해 보겠습니다:

### 1. 모델 클래스 정의

[Section titled “1. 모델 클래스 정의”](#1-모델-클래스-정의)

```dart
1
// 상품 모델
2
class Product {
3
  final String id;
4
  final String name;
5
  final double price;
6
  final String imageUrl;
7


8
  const Product({
9
    required this.id,
10
    required this.name,
11
    required this.price,
12
    required this.imageUrl,
13
  });
14
}
15


16
// 장바구니 모델 (ChangeNotifier를 상속)
17
class CartModel extends ChangeNotifier {
18
  final List<Product> _items = [];
19


20
  // 읽기 전용 접근자
21
  List<Product> get items => List.unmodifiable(_items);
22
  int get itemCount => _items.length;
23
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
24


25
  // 상품 추가
26
  void addProduct(Product product) {
27
    _items.add(product);
28
    notifyListeners();
29
  }
30


31
  // 상품 제거
32
  void removeProduct(Product product) {
33
    _items.remove(product);
34
    notifyListeners();
35
  }
36


37
  // 장바구니 비우기
38
  void clearCart() {
39
    _items.clear();
40
    notifyListeners();
41
  }
42
}
43


44
// 상품 저장소
45
class ProductRepository {
46
  // 상품 목록 (실제로는 API에서 가져옴)
47
  List<Product> getProducts() {
48
    return [
49
      Product(
50
        id: '1',
51
        name: '노트북',
52
        price: 1200000,
53
        imageUrl: 'assets/laptop.jpg',
54
      ),
55
      Product(
56
        id: '2',
57
        name: '스마트폰',
58
        price: 800000,
59
        imageUrl: 'assets/smartphone.jpg',
60
      ),
61
      Product(
62
        id: '3',
63
        name: '헤드폰',
64
        price: 250000,
65
        imageUrl: 'assets/headphones.jpg',
66
      ),
67
      Product(
68
        id: '4',
69
        name: '스마트워치',
70
        price: 350000,
71
        imageUrl: 'assets/smartwatch.jpg',
72
      ),
73
    ];
74
  }
75
}
```

### 2. Provider 설정

[Section titled “2. Provider 설정”](#2-provider-설정)

```dart
1
void main() {
2
  runApp(
3
    MultiProvider(
4
      providers: [
5
        // 상품 저장소 제공
6
        Provider<ProductRepository>(
7
          create: (_) => ProductRepository(),
8
        ),
9
        // 장바구니 모델 제공
10
        ChangeNotifierProvider<CartModel>(
11
          create: (_) => CartModel(),
12
        ),
13
      ],
14
      child: MyApp(),
15
    ),
16
  );
17
}
18


19
class MyApp extends StatelessWidget {
20
  @override
21
  Widget build(BuildContext context) {
22
    return MaterialApp(
23
      title: '장바구니 앱',
24
      theme: ThemeData(
25
        primarySwatch: Colors.blue,
26
      ),
27
      home: ProductListPage(),
28
    );
29
  }
30
}
```

### 3. 상품 목록 페이지

[Section titled “3. 상품 목록 페이지”](#3-상품-목록-페이지)

```dart
1
class ProductListPage extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    // 상품 저장소에서 상품 목록 가져오기
5
    final productRepository = Provider.of<ProductRepository>(context);
6
    final products = productRepository.getProducts();
7


8
    return Scaffold(
9
      appBar: AppBar(
10
        title: Text('상품 목록'),
11
        actions: [
12
          // 장바구니 아이콘과 상품 수 표시
13
          Stack(
14
            alignment: Alignment.center,
15
            children: [
16
              IconButton(
17
                icon: Icon(Icons.shopping_cart),
18
                onPressed: () {
19
                  Navigator.push(
20
                    context,
21
                    MaterialPageRoute(builder: (_) => CartPage()),
22
                  );
23
                },
24
              ),
25
              Positioned(
26
                right: 8,
27
                top: 8,
28
                child: Consumer<CartModel>(
29
                  builder: (_, cart, __) {
30
                    return cart.itemCount > 0
31
                        ? CircleAvatar(
32
                            backgroundColor: Colors.red,
33
                            radius: 8,
34
                            child: Text(
35
                              '${cart.itemCount}',
36
                              style: TextStyle(
37
                                fontSize: 10,
38
                                color: Colors.white,
39
                              ),
40
                            ),
41
                          )
42
                        : SizedBox.shrink();
43
                  },
44
                ),
45
              ),
46
            ],
47
          ),
48
        ],
49
      ),
50
      body: ListView.builder(
51
        itemCount: products.length,
52
        itemBuilder: (context, index) {
53
          final product = products[index];
54
          return Card(
55
            margin: EdgeInsets.all(8.0),
56
            child: ListTile(
57
              leading: Image.asset(
58
                product.imageUrl,
59
                width: 56,
60
                height: 56,
61
                errorBuilder: (context, error, stackTrace) {
62
                  // 이미지 로드 실패 시 대체 아이콘
63
                  return Icon(Icons.image, size: 56);
64
                },
65
              ),
66
              title: Text(product.name),
67
              subtitle: Text('₩${product.price.toStringAsFixed(0)}'),
68
              trailing: Consumer<CartModel>(
69
                builder: (_, cart, __) {
70
                  return IconButton(
71
                    icon: Icon(Icons.add_shopping_cart),
72
                    onPressed: () {
73
                      cart.addProduct(product);
74
                      ScaffoldMessenger.of(context).showSnackBar(
75
                        SnackBar(content: Text('${product.name} 추가됨')),
76
                      );
77
                    },
78
                  );
79
                },
80
              ),
81
            ),
82
          );
83
        },
84
      ),
85
    );
86
  }
87
}
```

### 4. 장바구니 페이지

[Section titled “4. 장바구니 페이지”](#4-장바구니-페이지)

```dart
1
class CartPage extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    return Scaffold(
5
      appBar: AppBar(
6
        title: Text('장바구니'),
7
      ),
8
      body: Consumer<CartModel>(
9
        builder: (context, cart, child) {
10
          if (cart.items.isEmpty) {
11
            return Center(
12
              child: Text('장바구니가 비었습니다'),
13
            );
14
          }
15


16
          return Column(
17
            children: [
18
              Expanded(
19
                child: ListView.builder(
20
                  itemCount: cart.items.length,
21
                  itemBuilder: (context, index) {
22
                    final product = cart.items[index];
23
                    return ListTile(
24
                      leading: Image.asset(
25
                        product.imageUrl,
26
                        width: 56,
27
                        height: 56,
28
                        errorBuilder: (context, error, stackTrace) {
29
                          return Icon(Icons.image, size: 56);
30
                        },
31
                      ),
32
                      title: Text(product.name),
33
                      subtitle: Text('₩${product.price.toStringAsFixed(0)}'),
34
                      trailing: IconButton(
35
                        icon: Icon(Icons.remove_circle),
36
                        onPressed: () {
37
                          cart.removeProduct(product);
38
                        },
39
                      ),
40
                    );
41
                  },
42
                ),
43
              ),
44
              Container(
45
                padding: EdgeInsets.all(16),
46
                decoration: BoxDecoration(
47
                  color: Colors.white,
48
                  boxShadow: [
49
                    BoxShadow(
50
                      color: Colors.black12,
51
                      blurRadius: 4,
52
                      offset: Offset(0, -2),
53
                    ),
54
                  ],
55
                ),
56
                child: Column(
57
                  crossAxisAlignment: CrossAxisAlignment.stretch,
58
                  children: [
59
                    Text(
60
                      '총 결제 금액: ₩${cart.totalPrice.toStringAsFixed(0)}',
61
                      style: TextStyle(
62
                        fontSize: 18,
63
                        fontWeight: FontWeight.bold,
64
                      ),
65
                    ),
66
                    SizedBox(height: 16),
67
                    ElevatedButton(
68
                      child: Text('결제하기'),
69
                      onPressed: () {
70
                        // 결제 로직 구현
71
                        showDialog(
72
                          context: context,
73
                          builder: (_) => AlertDialog(
74
                            title: Text('결제 확인'),
75
                            content: Text('결제가 완료되었습니다!'),
76
                            actions: [
77
                              TextButton(
78
                                onPressed: () {
79
                                  cart.clearCart();
80
                                  Navigator.pop(context);
81
                                  Navigator.pop(context); // 이전 화면으로 돌아가기
82
                                },
83
                                child: Text('확인'),
84
                              ),
85
                            ],
86
                          ),
87
                        );
88
                      },
89
                    ),
90
                  ],
91
                ),
92
              ),
93
            ],
94
          );
95
        },
96
      ),
97
    );
98
  }
99
}
```

## Provider 사용 시 Best Practices

[Section titled “Provider 사용 시 Best Practices”](#provider-사용-시-best-practices)

Provider를 효과적으로 사용하기 위한 몇 가지 권장사항:

### 1. 모델 캡슐화

[Section titled “1. 모델 캡슐화”](#1-모델-캡슐화)

상태 모델 내부 구현을 캡슐화하여 불변성을 유지합니다:

```dart
1
// 좋은 예시
2
class UserModel extends ChangeNotifier {
3
  String _name = '';
4
  String get name => _name;
5


6
  void updateName(String newName) {
7
    _name = newName;
8
    notifyListeners();
9
  }
10
}
11


12
// 나쁜 예시
13
class UserModel extends ChangeNotifier {
14
  String name = ''; // public 필드
15


16
  void updateName(String newName) {
17
    name = newName;
18
    notifyListeners();
19
  }
20
}
```

### 2. UI에서 비즈니스 로직 분리

[Section titled “2. UI에서 비즈니스 로직 분리”](#2-ui에서-비즈니스-로직-분리)

비즈니스 로직을 모델 클래스에 위치시킵니다:

```dart
1
// 좋은 예시 - 모델에 로직 포함
2
class CartModel extends ChangeNotifier {
3
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
4


5
  void checkout() {
6
    // 결제 처리 로직
7
    _items.clear();
8
    notifyListeners();
9
  }
10
}
11


12
// Widget 코드에서는 간단히 호출
13
ElevatedButton(
14
  onPressed: () => context.read<CartModel>().checkout(),
15
  child: Text('결제하기'),
16
)
```

### 3. 위젯 재빌드 최적화

[Section titled “3. 위젯 재빌드 최적화”](#3-위젯-재빌드-최적화)

필요한 부분만 재빌드되도록 설계합니다:

```dart
1
// 좋은 예시 - 필요한 부분만 Consumer로 감싸기
2
Scaffold(
3
  appBar: AppBar(
4
    title: Text('장바구니'),
5
    actions: [
6
      // 장바구니 아이콘만 업데이트
7
      Consumer<CartModel>(
8
        builder: (_, cart, __) {
9
          return Badge(
10
            label: Text('${cart.itemCount}'),
11
            child: IconButton(
12
              icon: Icon(Icons.shopping_cart),
13
              onPressed: () {},
14
            ),
15
          );
16
        },
17
      ),
18
    ],
19
  ),
20
  // 나머지 UI는 변경되지 않음
21
  body: ProductListView(),
22
)
```

### 4. 범위에 맞는 Provider 위치 선택

[Section titled “4. 범위에 맞는 Provider 위치 선택”](#4-범위에-맞는-provider-위치-선택)

Provider의 위치를 적절하게 선택하여 범위를 제한합니다:

```dart
1
// 앱 전체에서 필요한 Provider는 최상위에 배치
2
void main() {
3
  runApp(
4
    ChangeNotifierProvider(
5
      create: (_) => ThemeModel(),
6
      child: MyApp(),
7
    ),
8
  );
9
}
10


11
// 특정 화면에서만 필요한 Provider는 해당 화면 위젯에 배치
12
class ProductsPage extends StatelessWidget {
13
  @override
14
  Widget build(BuildContext context) {
15
    return ChangeNotifierProvider(
16
      create: (_) => ProductsViewModel(),
17
      child: ProductsContent(),
18
    );
19
  }
20
}
```

### 5. Provider 조합 패턴

[Section titled “5. Provider 조합 패턴”](#5-provider-조합-패턴)

여러 상태가 함께 작동해야 할 때 ProxyProvider를 활용합니다:

```dart
1
MultiProvider(
2
  providers: [
3
    ChangeNotifierProvider(create: (_) => AuthModel()),
4
    ChangeNotifierProvider(create: (_) => ThemeModel()),
5
    // AuthModel과 ThemeModel에 의존하는 SettingsModel
6
    ProxyProvider2<AuthModel, ThemeModel, SettingsModel>(
7
      update: (_, auth, theme, __) => SettingsModel(auth, theme),
8
    ),
9
  ],
10
  child: MyApp(),
11
)
```

## InheritedWidget vs Provider vs 기타 상태 관리 솔루션

[Section titled “InheritedWidget vs Provider vs 기타 상태 관리 솔루션”](#inheritedwidget-vs-provider-vs-기타-상태-관리-솔루션)

각 상태 관리 솔루션의 장단점을 비교해보겠습니다:

### InheritedWidget

[Section titled “InheritedWidget”](#inheritedwidget)

**장점**:

* Flutter의 기본 API - 추가 패키지 필요 없음
* 위젯 트리를 통한 효율적인 데이터 공유

**단점**:

* 상태 변경 메커니즘 부재
* 복잡한 구현
* 반복적인 코드 필요

### Provider

[Section titled “Provider”](#provider)

**장점**:

* 간단한 API
* ChangeNotifier와 통합되어 상태 변경 쉬움
* 여러 유형의 Provider 제공
* 의존성 주입 패턴

**단점**:

* 대규모 앱에서는 구조화가 필요
* ChangeNotifier의 뮤터블 상태

### Riverpod (Provider의 개선된 버전)

[Section titled “Riverpod (Provider의 개선된 버전)”](#riverpod-provider의-개선된-버전)

**장점**:

* 컴파일 시간에 안전성 확인
* Provider와 유사하지만 개선된 API
* 고정된 Provider Tree 없음
* 더 나은 테스트 가능성

**단점**:

* Provider보다 약간 더 복잡한 API
* 러닝 커브가 더 높을 수 있음

### 기타 솔루션 (Bloc, Redux, MobX 등)

[Section titled “기타 솔루션 (Bloc, Redux, MobX 등)”](#기타-솔루션-bloc-redux-mobx-등)

**Bloc/Cubit**:

* 사용 흐름(Stream)과 상태 관리를 명확히 분리
* 테스트하기 쉬움
* 비동기 작업에 강점
* 더 많은 코드가 필요

**Redux**:

* 예측 가능한 단방향 데이터 흐름
* 중앙 집중식 상태 관리
* 디버깅이 쉬움
* 구현이 더 복잡할 수 있음

**MobX**:

* 반응형 프로그래밍
* 더 적은 코드로 구현
* 자동 반응 추적
* 개념을 이해하는 데 시간이 필요

## 요약

[Section titled “요약”](#요약)

* **InheritedWidget**은 Flutter의 내장 메커니즘으로, 위젯 트리를 통해 데이터를 공유합니다.
* **Provider**는 InheritedWidget 기반의 패키지로, 더 쉬운 API와 상태 변경 메커니즘을 제공합니다.
* Provider는 다양한 종류의 Provider(ChangeNotifierProvider, FutureProvider 등)를 통해 다양한 사용 사례를 지원합니다.
* 효과적인 Provider 사용을 위해 모델 캡슐화, 비즈니스 로직 분리, 재빌드 최적화 등의 Best Practice를 적용해야 합니다.
* Provider는 중소규모 앱에서 좋은 선택이며, 대규모 앱에서는 Riverpod이나 Bloc 같은 더 구조화된 솔루션을 고려할 수 있습니다.

다음 장에서는 Provider의 다음 세대 기술인 Riverpod에 대해 살펴보겠습니다.

# Riverpod 소개 및 실습

## Riverpod이란?

[Section titled “Riverpod이란?”](#riverpod이란)

Riverpod는 “Provider”의 애너그램(글자를 재배열한 단어)으로, Provider의 제한사항을 해결하기 위해 처음부터 다시 설계된 상태 관리 라이브러리입니다. Provider가 InheritedWidget을 기반으로 하는 반면, Riverpod는 위젯 트리와 완전히 독립적으로 작동합니다.

### Riverpod vs Provider

[Section titled “Riverpod vs Provider”](#riverpod-vs-provider)

Riverpod가 Provider와 비교하여 갖는 주요 장점은 다음과 같습니다:

1. **컴파일 타임 안전성**: 존재하지 않는 Provider를 참조하면 컴파일 오류 발생
2. **위젯 트리 독립성**: BuildContext 없이도 Provider에 접근 가능
3. **Provider 결합**: 여러 Provider를 쉽게 결합 가능
4. **자동 캐싱 및 중복 제거**: 동일한 Provider에 대한 요청이 중복되지 않음
5. **강력한 비동기 지원**: Future와 Stream 처리를 위한 기본 지원
6. **테스트 용이성**: Provider의 값을 쉽게 오버라이드하여 테스트 가능

## Riverpod 설치하기

[Section titled “Riverpod 설치하기”](#riverpod-설치하기)

Riverpod를 사용하기 위해 먼저 필요한 패키지를 설치해야 합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  flutter_riverpod: ^2.6.1 # 최신 버전 확인
5
  riverpod_annotation: ^2.6.1
6


7
dev_dependencies:
8
  build_runner:
9
  riverpod_generator: ^2.6.5
```

`flutter_riverpod`는 Flutter 앱에서 Riverpod를 사용하기 위한 패키지이고, `riverpod_annotation`와 `riverpod_generator`는 코드 생성을 위한 패키지입니다.

## Riverpod 시작하기

[Section titled “Riverpod 시작하기”](#riverpod-시작하기)

### 1. ProviderScope 설정

[Section titled “1. ProviderScope 설정”](#1-providerscope-설정)

Riverpod를 사용하는 첫 번째 단계는 앱의 루트에 `ProviderScope` 위젯을 배치하는 것입니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_riverpod/flutter_riverpod.dart';
3


4
void main() {
5
  runApp(
6
    // ProviderScope는 Riverpod의 모든 Provider를 관리합니다
7
    ProviderScope(
8
      child: MyApp(),
9
    ),
10
  );
11
}
12


13
class MyApp extends StatelessWidget {
14
  @override
15
  Widget build(BuildContext context) {
16
    return MaterialApp(
17
      title: 'Riverpod Demo',
18
      theme: ThemeData(
19
        primarySwatch: Colors.blue,
20
      ),
21
      home: HomePage(),
22
    );
23
  }
24
}
```

### 2. Provider 정의

[Section titled “2. Provider 정의”](#2-provider-정의)

Riverpod에서는 여러 종류의 Provider를 제공합니다:

```dart
1
// 1. Provider - 읽기 전용 값 제공
2
final helloWorldProvider = Provider<String>((ref) => 'Hello, World!');
3


4
// 2. StateProvider - 단순한 상태 관리
5
final counterProvider = StateProvider<int>((ref) => 0);
6


7
// 3. StateNotifierProvider - 복잡한 상태 관리
8
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());
9


10
// 4. FutureProvider - 비동기 데이터 로드
11
final userProvider = FutureProvider<User>((ref) => fetchUser());
12


13
// 5. StreamProvider - 스트림 데이터 구독
14
final messagesProvider = StreamProvider<List<Message>>((ref) => fetchMessages());
```

### 3. Consumer 위젯으로 Provider 사용하기

[Section titled “3. Consumer 위젯으로 Provider 사용하기”](#3-consumer-위젯으로-provider-사용하기)

Provider의 값을 읽기 위해 `Consumer` 또는 `ConsumerWidget`을 사용할 수 있습니다:

```dart
1
// Consumer 위젯 사용
2
class CounterWidget extends StatelessWidget {
3
  @override
4
  Widget build(BuildContext context) {
5
    return Consumer(
6
      builder: (context, ref, child) {
7
        final count = ref.watch(counterProvider);
8


9
        return Text('카운트: $count');
10
      },
11
    );
12
  }
13
}
14


15
// ConsumerWidget 사용 (더 간단함)
16
class CounterWidget extends ConsumerWidget {
17
  @override
18
  Widget build(BuildContext context, WidgetRef ref) {
19
    final count = ref.watch(counterProvider);
20


21
    return Text('카운트: $count');
22
  }
23
}
```

### 4. ref 객체 사용하기

[Section titled “4. ref 객체 사용하기”](#4-ref-객체-사용하기)

`ref` 객체는 Provider와 상호 작용하는 핵심 객체로, 다음과 같은 메서드를 제공합니다:

```dart
1
// Provider 값 읽기 및 변경 감지 (UI 자동 업데이트)
2
final count = ref.watch(counterProvider);
3


4
// Provider 값 읽기 (변경 감지 없음)
5
final count = ref.read(counterProvider);
6


7
// 상태 변경을 수신하는 리스너 등록
8
ref.listen<int>(
9
  counterProvider,
10
  (previous, next) {
11
    print('카운터가 $previous에서 $next로 변경됨');
12
  },
13
);
14


15
// Provider 값 강제로 새로고침
16
ref.refresh(userProvider);
17


18
// StateProvider 값 변경
19
ref.read(counterProvider.notifier).state++;
```

## Riverpod의 주요 개념

[Section titled “Riverpod의 주요 개념”](#riverpod의-주요-개념)

### Provider와 ref

[Section titled “Provider와 ref”](#provider와-ref)

Riverpod에서는 두 가지 핵심 개념이 있습니다:

1. **Provider**: 상태를 정의하고 외부에 노출하는 객체
2. **ref**: Provider에 접근하고 상호 작용하는 객체

### Riverpod의 자동 의존성 처리

[Section titled “Riverpod의 자동 의존성 처리”](#riverpod의-자동-의존성-처리)

Riverpod의 가장 강력한 기능 중 하나는 Provider 간의 자동 의존성 처리입니다:

```dart
1
// 첫 번째 Provider
2
final cityProvider = StateProvider<String>((ref) => '서울');
3


4
// 두 번째 Provider (첫 번째에 의존)
5
final weatherProvider = FutureProvider<String>((ref) async {
6
  final city = ref.watch(cityProvider);
7
  return fetchWeather(city); // city가 변경되면 자동으로 다시 실행
8
});
```

이 예제에서 `weatherProvider`는 `cityProvider`에 의존합니다. `cityProvider`의 값이 변경되면 `weatherProvider`는 자동으로 재계산됩니다.

## Riverpod 코드 생성 기능

[Section titled “Riverpod 코드 생성 기능”](#riverpod-코드-생성-기능)

Riverpod 2.0부터는 애노테이션과 코드 생성을 사용하여 더 간결하게 Provider를 정의할 수 있습니다:

```dart
1
import 'package:riverpod_annotation/riverpod_annotation.dart';
2


3
part 'counter.g.dart';
4


5
// 코드 생성을 위한 애노테이션 사용
6
@riverpod
7
class Counter extends _$Counter {
8
  @override
9
  int build() {
10
    return 0; // 초기값
11
  }
12


13
  void increment() {
14
    state = state + 1;
15
  }
16
}
17


18
// 사용 방법 (counterProvider가 자동으로 생성됨)
19
final value = ref.watch(counterProvider);
20
ref.read(counterProvider.notifier).increment();
```

코드 생성을 실행하려면 다음 명령을 사용합니다:

```bash
1
dart run build_runner build
```

### 비동기 Provider 정의

[Section titled “비동기 Provider 정의”](#비동기-provider-정의)

비동기 데이터를 처리하는 Provider도 쉽게 정의할 수 있습니다:

```dart
1
@riverpod
2
Future<User> user(UserRef ref) async {
3
  final userId = ref.watch(userIdProvider);
4
  return await fetchUser(userId);
5
}
6


7
// 사용 방법
8
ref.watch(userProvider).when(
9
  data: (user) => Text(user.name),
10
  loading: () => CircularProgressIndicator(),
11
  error: (error, stack) => Text('에러: $error'),
12
);
```

## Riverpod 실전 사용법

[Section titled “Riverpod 실전 사용법”](#riverpod-실전-사용법)

이제 Riverpod를 사용하여 간단한 할 일 목록 앱을 구현해보겠습니다.

### 1. 모델 정의

[Section titled “1. 모델 정의”](#1-모델-정의)

todo.dart

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:flutter/foundation.dart';
3


4
part 'todo.freezed.dart';
5
part 'todo.g.dart';
6


7
@freezed
8
class Todo with _$Todo {
9
  const factory Todo({
10
    required String id,
11
    required String title,
12
    @Default(false) bool completed,
13
  }) = _Todo;
14


15
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
16
}
```

### 2. Provider 정의

[Section titled “2. Provider 정의”](#2-provider-정의-1)

todo\_provider.dart

```dart
1
import 'package:riverpod_annotation/riverpod_annotation.dart';
2
import 'package:uuid/uuid.dart';
3
import 'todo.dart';
4


5
part 'todo_provider.g.dart';
6


7
@riverpod
8
class TodoList extends _$TodoList {
9
  @override
10
  List<Todo> build() {
11
    return []; // 초기 빈 목록
12
  }
13


14
  void addTodo(String title) {
15
    final newTodo = Todo(
16
      id: const Uuid().v4(),
17
      title: title,
18
    );
19
    state = [...state, newTodo];
20
  }
21


22
  void toggleTodo(String id) {
23
    state = [
24
      for (final todo in state)
25
        if (todo.id == id)
26
          todo.copyWith(completed: !todo.completed)
27
        else
28
          todo,
29
    ];
30
  }
31


32
  void removeTodo(String id) {
33
    state = state.where((todo) => todo.id != id).toList();
34
  }
35
}
36


37
@riverpod
38
int completedTodosCount(CompletedTodosCountRef ref) {
39
  final todos = ref.watch(todoListProvider);
40
  return todos.where((todo) => todo.completed).length;
41
}
42


43
@riverpod
44
int uncompletedTodosCount(UncompletedTodosCountRef ref) {
45
  final todos = ref.watch(todoListProvider);
46
  return todos.where((todo) => !todo.completed).length;
47
}
```

### 3. UI 구현

[Section titled “3. UI 구현”](#3-ui-구현)

todo\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_riverpod/flutter_riverpod.dart';
3
import 'todo_provider.dart';
4
import 'todo.dart';
5


6
class TodoScreen extends ConsumerWidget {
7
  final TextEditingController _controller = TextEditingController();
8


9
  @override
10
  Widget build(BuildContext context, WidgetRef ref) {
11
    final todos = ref.watch(todoListProvider);
12
    final completedCount = ref.watch(completedTodosCountProvider);
13
    final uncompletedCount = ref.watch(uncompletedTodosCountProvider);
14


15
    return Scaffold(
16
      appBar: AppBar(
17
        title: const Text('Riverpod 할 일 목록'),
18
      ),
19
      body: Column(
20
        children: [
21
          Padding(
22
            padding: const EdgeInsets.all(16.0),
23
            child: Row(
24
              children: [
25
                Expanded(
26
                  child: TextField(
27
                    controller: _controller,
28
                    decoration: const InputDecoration(
29
                      labelText: '할 일 추가',
30
                      border: OutlineInputBorder(),
31
                    ),
32
                  ),
33
                ),
34
                const SizedBox(width: 16),
35
                ElevatedButton(
36
                  onPressed: () {
37
                    if (_controller.text.isNotEmpty) {
38
                      ref.read(todoListProvider.notifier).addTodo(_controller.text);
39
                      _controller.clear();
40
                    }
41
                  },
42
                  child: const Text('추가'),
43
                ),
44
              ],
45
            ),
46
          ),
47
          Padding(
48
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
49
            child: Row(
50
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
51
              children: [
52
                Text('완료: $completedCount'),
53
                Text('미완료: $uncompletedCount'),
54
              ],
55
            ),
56
          ),
57
          const Divider(),
58
          Expanded(
59
            child: ListView.builder(
60
              itemCount: todos.length,
61
              itemBuilder: (context, index) {
62
                final todo = todos[index];
63
                return ListTile(
64
                  leading: Checkbox(
65
                    value: todo.completed,
66
                    onChanged: (_) {
67
                      ref.read(todoListProvider.notifier).toggleTodo(todo.id);
68
                    },
69
                  ),
70
                  title: Text(
71
                    todo.title,
72
                    style: TextStyle(
73
                      decoration: todo.completed
74
                          ? TextDecoration.lineThrough
75
                          : TextDecoration.none,
76
                    ),
77
                  ),
78
                  trailing: IconButton(
79
                    icon: const Icon(Icons.delete),
80
                    onPressed: () {
81
                      ref.read(todoListProvider.notifier).removeTodo(todo.id);
82
                    },
83
                  ),
84
                );
85
              },
86
            ),
87
          ),
88
        ],
89
      ),
90
    );
91
  }
92
}
```

## 고급 Riverpod 기법

[Section titled “고급 Riverpod 기법”](#고급-riverpod-기법)

### 1. 비동기 데이터 처리

[Section titled “1. 비동기 데이터 처리”](#1-비동기-데이터-처리)

`AsyncValue`는 비동기 데이터의 세 가지 상태(데이터, 로딩, 오류)를 표현하는 편리한 클래스입니다:

```dart
1
@riverpod
2
class UserRepository extends _$UserRepository {
3
  @override
4
  Future<User> build(String userId) async {
5
    return fetchUser(userId);
6
  }
7
}
8


9
// UI에서 사용
10
class UserProfile extends ConsumerWidget {
11
  @override
12
  Widget build(BuildContext context, WidgetRef ref) {
13
    final userAsync = ref.watch(userRepositoryProvider('user-123'));
14


15
    return userAsync.when(
16
      data: (user) => Text('이름: ${user.name}'),
17
      loading: () => const CircularProgressIndicator(),
18
      error: (error, stackTrace) => Text('에러: $error'),
19
    );
20
  }
21
}
```

### 2. 패밀리 Provider (매개변수가 있는 Provider)

[Section titled “2. 패밀리 Provider (매개변수가 있는 Provider)”](#2-패밀리-provider-매개변수가-있는-provider)

매개변수를 받는 Provider를 정의할 수 있습니다:

```dart
1
@riverpod
2
Future<Product> product(ProductRef ref, String productId) {
3
  return fetchProduct(productId);
4
}
5


6
// UI에서 사용
7
final product = ref.watch(productProvider('product-123'));
```

### 3. Provider 캐싱 및 자동 폐기

[Section titled “3. Provider 캐싱 및 자동 폐기”](#3-provider-캐싱-및-자동-폐기)

Riverpod는 Provider 인스턴스를 자동으로 캐싱하고, 더 이상 사용되지 않을 때 정리합니다:

```dart
1
@riverpod
2
class ProductsRepository extends _$ProductsRepository {
3
  @override
4
  Future<List<Product>> build() async {
5
    // API 호출
6
    print('상품 로드 중...');
7
    return fetchProducts();
8
  }
9


10
  @override
11
  void dispose() {
12
    print('ProductsRepository 폐기됨');
13
    super.dispose();
14
  }
15
}
```

### 4. 상태 동기화

[Section titled “4. 상태 동기화”](#4-상태-동기화)

여러 Provider 간에 상태를 동기화하는 것이 쉽습니다:

```dart
1
@riverpod
2
class AuthState extends _$AuthState {
3
  @override
4
  User? build() => null;
5


6
  Future<void> login(String username, String password) async {
7
    state = await authService.login(username, password);
8
  }
9


10
  void logout() {
11
    state = null;
12
  }
13
}
14


15
@riverpod
16
class CartRepository extends _$CartRepository {
17
  @override
18
  List<CartItem> build() {
19
    final user = ref.watch(authStateProvider);
20


21
    // 사용자가 로그아웃하면 자동으로 장바구니 비우기
22
    if (user == null) {
23
      return [];
24
    }
25


26
    // 사용자에 따라 장바구니 데이터 로드
27
    return loadCartItems(user.id);
28
  }
29
}
```

## Riverpod의 주요 사용 패턴

[Section titled “Riverpod의 주요 사용 패턴”](#riverpod의-주요-사용-패턴)

### 1. 데이터 로직 분리 패턴

[Section titled “1. 데이터 로직 분리 패턴”](#1-데이터-로직-분리-패턴)

데이터 로직을 UI에서 분리하는 패턴을 사용합니다:

```dart
1
// Repository - 데이터 액세스 로직
2
@riverpod
3
class ProductsRepository extends _$ProductsRepository {
4
  @override
5
  Future<List<Product>> build() async {
6
    return api.fetchProducts();
7
  }
8
}
9


10
// Notifier - 비즈니스 로직
11
@riverpod
12
class ProductsFilter extends _$ProductsFilter {
13
  @override
14
  FilterCriteria build() {
15
    return FilterCriteria();
16
  }
17


18
  void setCategory(String category) {
19
    state = state.copyWith(category: category);
20
  }
21


22
  void setPriceRange(double min, double max) {
23
    state = state.copyWith(minPrice: min, maxPrice: max);
24
  }
25
}
26


27
// ViewModel - 화면에 표시할 데이터 준비
28
@riverpod
29
Future<List<ProductViewModel>> filteredProducts(FilteredProductsRef ref) async {
30
  final products = await ref.watch(productsRepositoryProvider.future);
31
  final filter = ref.watch(productsFilterProvider);
32


33
  return products
34
    .where((p) => p.category == filter.category)
35
    .where((p) => p.price >= filter.minPrice && p.price <= filter.maxPrice)
36
    .map((p) => ProductViewModel.fromProduct(p))
37
    .toList();
38
}
```

### 2. 자동 새로고침 패턴

[Section titled “2. 자동 새로고침 패턴”](#2-자동-새로고침-패턴)

Provider가 의존하는 다른 Provider가 업데이트되면 자동으로 새로고침됩니다:

```dart
1
@riverpod
2
class SearchQuery extends _$SearchQuery {
3
  @override
4
  String build() => '';
5


6
  void setQuery(String query) {
7
    state = query;
8
  }
9
}
10


11
@riverpod
12
Future<List<SearchResult>> searchResults(SearchResultsRef ref) async {
13
  final query = ref.watch(searchQueryProvider);
14


15
  // 검색어가 없으면 빈 결과 반환
16
  if (query.isEmpty) {
17
    return [];
18
  }
19


20
  // 검색어가 변경될 때마다 자동으로 새 검색 수행
21
  return searchApi.search(query);
22
}
```

### 3. 오버라이드 패턴

[Section titled “3. 오버라이드 패턴”](#3-오버라이드-패턴)

테스트나 개발 환경에서 Provider 값을 오버라이드할 수 있습니다:

```dart
1
void main() {
2
  runApp(
3
    ProviderScope(
4
      overrides: [
5
        // 실제 API 대신 목업 API 사용
6
        apiProvider.overrideWithValue(MockApi()),
7
        // 초기 상태 설정
8
        authStateProvider.overrideWith(
9
          (ref) => AuthState()..state = User(id: 'test-user', name: '테스트 사용자'),
10
        ),
11
      ],
12
      child: MyApp(),
13
    ),
14
  );
15
}
```

## Riverpod의 성능 최적화

[Section titled “Riverpod의 성능 최적화”](#riverpod의-성능-최적화)

### 1. 세분화된 Provider 설계

[Section titled “1. 세분화된 Provider 설계”](#1-세분화된-provider-설계)

Provider를 세분화하여 불필요한 리빌드를 방지합니다:

```dart
1
// 나쁜 예시 - 하나의 거대한 Provider
2
@riverpod
3
class AppState extends _$AppState {
4
  @override
5
  AppStateModel build() {
6
    return AppStateModel(
7
      user: User(),
8
      products: [],
9
      cart: Cart(),
10
      // 기타 많은 상태들...
11
    );
12
  }
13
}
14


15
// 좋은 예시 - 세분화된 Provider
16
@riverpod
17
class UserState extends _$UserState {
18
  @override
19
  User build() => User();
20
}
21


22
@riverpod
23
class ProductsState extends _$ProductsState {
24
  @override
25
  List<Product> build() => [];
26
}
27


28
@riverpod
29
class CartState extends _$CartState {
30
  @override
31
  Cart build() => Cart();
32
}
```

### 2. select 메서드 사용

[Section titled “2. select 메서드 사용”](#2-select-메서드-사용)

객체의 특정 속성만 감시하여 불필요한 리빌드를 방지합니다:

```dart
1
// 전체 사용자 객체 변경 시 리빌드
2
final user = ref.watch(userProvider);
3
final name = user.name;
4


5
// 이름이 변경될 때만 리빌드
6
final name = ref.watch(userProvider.select((user) => user.name));
```

### 3. autoDispose 수정자 사용

[Section titled “3. autoDispose 수정자 사용”](#3-autodispose-수정자-사용)

Provider가 더 이상 사용되지 않을 때 자동으로 폐기하려면 `autoDispose` 수정자를 사용합니다:

```dart
1
@riverpod
2
class SearchResults extends _$SearchResults {
3
  @override
4
  Future<List<Result>> build() async {
5
    // 화면이 닫히면 이 Provider는 자동으로 폐기됨
6
    return api.search();
7
  }
8
}
```

## Riverpod와 Flutter Hooks 사용하기

[Section titled “Riverpod와 Flutter Hooks 사용하기”](#riverpod와-flutter-hooks-사용하기)

Flutter Hooks와 Riverpod를 함께 사용하면 더욱 간결한 코드를 작성할 수 있습니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_hooks/flutter_hooks.dart';
3
import 'package:hooks_riverpod/hooks_riverpod.dart';
4


5
// hooks_riverpod 패키지 추가 필요
6
class TodoForm extends HookConsumerWidget {
7
  @override
8
  Widget build(BuildContext context, WidgetRef ref) {
9
    // Flutter Hook을 사용하여 상태 관리
10
    final textController = useTextEditingController();
11
    final isFocused = useState(false);
12


13
    // Riverpod Provider 사용
14
    final todos = ref.watch(todoListProvider);
15


16
    return Column(
17
      children: [
18
        TextField(
19
          controller: textController,
20
          onFocusChange: (focus) => isFocused.value = focus,
21
          decoration: InputDecoration(
22
            labelText: '할 일 추가',
23
            border: OutlineInputBorder(),
24
          ),
25
        ),
26
        ElevatedButton(
27
          onPressed: () {
28
            if (textController.text.isNotEmpty) {
29
              ref.read(todoListProvider.notifier).addTodo(textController.text);
30
              textController.clear();
31
            }
32
          },
33
          child: Text('추가'),
34
        ),
35
      ],
36
    );
37
  }
38
}
```

## 요약

[Section titled “요약”](#요약)

* **Riverpod**는 Provider의 제한사항을 해결하기 위해 개발된 현대적인 상태 관리 라이브러리입니다.
* **컴파일 타임 안전성**, **위젯 트리 독립성**, **자동 의존성 처리** 등의 장점을 제공합니다.
* **코드 생성**을 통해 더 간결한 코드를 작성할 수 있습니다.
* **AsyncValue**를 통해 비동기 데이터를 쉽게 처리할 수 있습니다.
* **Provider 세분화**, **select 메서드**, **autoDispose** 등을 통해 성능을 최적화할 수 있습니다.

Riverpod는 Provider의 장점을 유지하면서 몇 가지 핵심적인 문제점을 해결한 강력한 상태 관리 솔루션입니다. 특히 중대형 앱의 개발에서 코드 유지보수성, 테스트 용이성, 성능 최적화에 큰 도움을 줄 수 있습니다. 다음 장에서는 실제 TodoList 앱을 개선하면서 Riverpod의 실전 사용법을 자세히 알아보겠습니다.

# setState와 ValueNotifier

Flutter에서 기본적으로 제공하는 상태 관리 메커니즘인 `setState`와 `ValueNotifier`에 대해 자세히 알아보겠습니다. 이들은 외부 패키지 없이 Flutter 코어 내에서 사용할 수 있는 상태 관리 방법으로, 간단한 앱에서는 이 도구들만으로도 효과적인 상태 관리가 가능합니다.

## setState()

[Section titled “setState()”](#setstate)

`setState()`는 Flutter의 `StatefulWidget`에서 상태를 관리하는 가장 기본적인 메커니즘입니다. 이 메서드는 상태 변경을 Flutter 프레임워크에 알려 위젯을 다시 빌드하도록 합니다.

### 기본 사용법

[Section titled “기본 사용법”](#기본-사용법)

```dart
1
class CounterPage extends StatefulWidget {
2
  const CounterPage({Key? key}) : super(key: key);
3


4
  @override
5
  _CounterPageState createState() => _CounterPageState();
6
}
7


8
class _CounterPageState extends State<CounterPage> {
9
  int _counter = 0;
10


11
  void _incrementCounter() {
12
    setState(() {
13
      _counter++;
14
    });
15
  }
16


17
  @override
18
  Widget build(BuildContext context) {
19
    return Scaffold(
20
      appBar: AppBar(
21
        title: const Text('setState 예제'),
22
      ),
23
      body: Center(
24
        child: Column(
25
          mainAxisAlignment: MainAxisAlignment.center,
26
          children: <Widget>[
27
            const Text(
28
              '버튼을 누른 횟수:',
29
            ),
30
            Text(
31
              '$_counter',
32
              style: Theme.of(context).textTheme.headlineMedium,
33
            ),
34
          ],
35
        ),
36
      ),
37
      floatingActionButton: FloatingActionButton(
38
        onPressed: _incrementCounter,
39
        tooltip: '증가',
40
        child: const Icon(Icons.add),
41
      ),
42
    );
43
  }
44
}
```

### setState의 주요 특징

[Section titled “setState의 주요 특징”](#setstate의-주요-특징)

1. **간단함**: 사용하기 쉽고 이해하기 직관적
2. **지역성**: 해당 위젯의 상태만 관리
3. **위젯 재빌드**: `setState()` 호출 시 위젯의 `build()` 메서드가 다시 호출됨
4. **동기적 작동**: Flutter의 다음 프레임에서 UI 업데이트가 발생

### setState 사용 시 주의사항

[Section titled “setState 사용 시 주의사항”](#setstate-사용-시-주의사항)

1. **적절한 위치에서 호출**: 위젯의 라이프사이클 메서드에서 적절히 호출해야 함

   ```dart
   1
   // 잘못된 사용: initState에서 직접 호출
   2
   @override
   3
   void initState() {
   4
     super.initState();
   5
     setState(() { /* ... */ }); // 오류 발생 가능
   6
   }
   7


   8
   // 올바른 사용: 비동기 작업 후 호출
   9
   @override
   10
   void initState() {
   11
     super.initState();
   12
     Future.delayed(Duration.zero, () {
   13
       if (mounted) { // 위젯이 여전히 트리에 있는지 확인
   14
         setState(() { /* ... */ });
   15
       }
   16
     });
   17
   }
   ```

2. **빌드 중 호출 금지**: `build()` 메서드 내에서 `setState()`를 호출하면 무한 루프 발생

   ```dart
   1
   // 잘못된 사용: build 메서드 내 호출
   2
   @override
   3
   Widget build(BuildContext context) {
   4
     setState(() { /* ... */ }); // 무한 루프 발생
   5
     return Container();
   6
   }
   ```

3. **최적화**: 필요한 상태 변경만 수행하여 불필요한 재빌드 방지

   ```dart
   1
   // 비효율적인 방법
   2
   setState(() {
   3
     _counter++; // 실제로 변경될 때나 변경되지 않을 때나 항상 호출
   4
   });
   5


   6
   // 최적화된 방법
   7
   if (_shouldUpdate) {
   8
     setState(() {
   9
       _counter++;
   10
     });
   11
   }
   ```

### setState의 한계

[Section titled “setState의 한계”](#setstate의-한계)

1. **위젯 트리에서의 전파**: 부모-자식 관계가 깊어질수록 상태 전달이 번거로움 (prop drilling)
2. **상태 공유**: 서로 다른 위젯 간에 상태를 공유하기 어려움
3. **비즈니스 로직 분리**: UI와 비즈니스 로직을 명확히 분리하기 어려움
4. **코드 중복**: 유사한 상태 로직이 여러 위젯에 중복될 수 있음

## ValueNotifier와 ValueListenableBuilder

[Section titled “ValueNotifier와 ValueListenableBuilder”](#valuenotifier와-valuelistenablebuilder)

`ValueNotifier`는 값의 변경을 감지하고 리스너에게 알릴 수 있는 Flutter의 내장 클래스입니다. `setState()`보다 좀 더 유연한 상태 관리를 제공하며, `StatelessWidget` 내에서도 사용할 수 있습니다.

### 기본 사용법

[Section titled “기본 사용법”](#기본-사용법-1)

```dart
1
// ValueNotifier 정의
2
final ValueNotifier<int> _counter = ValueNotifier<int>(0);
3


4
// ValueNotifier 업데이트
5
void _incrementCounter() {
6
  _counter.value++;
7
}
8


9
// ValueListenableBuilder를 사용하여 UI에 반영
10
ValueListenableBuilder<int>(
11
  valueListenable: _counter,
12
  builder: (context, value, child) {
13
    return Text('카운트: $value');
14
  },
15
)
```

### 전체 예제

[Section titled “전체 예제”](#전체-예제)

```dart
1
class ValueNotifierExample extends StatelessWidget {
2
  ValueNotifierExample({Key? key}) : super(key: key);
3


4
  // ValueNotifier 선언
5
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
6
  final ValueNotifier<bool> _isActive = ValueNotifier<bool>(false);
7


8
  void _incrementCounter() {
9
    _counter.value++;
10
  }
11


12
  void _toggleActive() {
13
    _isActive.value = !_isActive.value;
14
  }
15


16
  @override
17
  Widget build(BuildContext context) {
18
    return Scaffold(
19
      appBar: AppBar(
20
        title: const Text('ValueNotifier 예제'),
21
      ),
22
      body: Center(
23
        child: Column(
24
          mainAxisAlignment: MainAxisAlignment.center,
25
          children: <Widget>[
26
            // 첫 번째 ValueListenableBuilder
27
            ValueListenableBuilder<int>(
28
              valueListenable: _counter,
29
              builder: (context, value, child) {
30
                return Text(
31
                  '카운트: $value',
32
                  style: Theme.of(context).textTheme.headlineMedium,
33
                );
34
              },
35
            ),
36
            const SizedBox(height: 20),
37


38
            // 두 번째 ValueListenableBuilder
39
            ValueListenableBuilder<bool>(
40
              valueListenable: _isActive,
41
              builder: (context, isActive, child) {
42
                return Switch(
43
                  value: isActive,
44
                  onChanged: (value) => _toggleActive(),
45
                );
46
              },
47
            ),
48


49
            // 두 상태를 모두 사용하는 Builder
50
            Builder(
51
              builder: (context) {
52
                // 일반적인 방법으로 값에 접근 (변경 감지 안 됨)
53
                // ValueListenableBuilder를 사용해야 변경 감지됨
54
                return Text(
55
                  '현재 상태: ${_isActive.value ? "활성" : "비활성"}, 카운트: ${_counter.value}',
56
                  style: TextStyle(
57
                    color: _isActive.value ? Colors.green : Colors.red,
58
                  ),
59
                );
60
              },
61
            ),
62
          ],
63
        ),
64
      ),
65
      floatingActionButton: FloatingActionButton(
66
        onPressed: _incrementCounter,
67
        tooltip: '증가',
68
        child: const Icon(Icons.add),
69
      ),
70
    );
71
  }
72
}
```

### ValueNotifier의 주요 특징

[Section titled “ValueNotifier의 주요 특징”](#valuenotifier의-주요-특징)

1. **위젯 독립성**: `StatelessWidget`에서도 사용 가능
2. **세분화된 업데이트**: 전체 위젯이 아닌 필요한 부분만 업데이트
3. **명시적 구독**: `ValueListenableBuilder`를 통해 변경 사항을 명시적으로 구독
4. **단일 값 관리**: 각 `ValueNotifier`는 단일 값을 관리

### 복합 상태 관리

[Section titled “복합 상태 관리”](#복합-상태-관리)

여러 값을 효율적으로 관리하려면 클래스로 모델링하고 `ChangeNotifier`를 사용할 수 있습니다:

```dart
1
class UserModel extends ChangeNotifier {
2
  String _name = '';
3
  int _age = 0;
4
  bool _isActive = false;
5


6
  String get name => _name;
7
  int get age => _age;
8
  bool get isActive => _isActive;
9


10
  void updateName(String newName) {
11
    _name = newName;
12
    notifyListeners(); // 변경 사항을 리스너들에게 알림
13
  }
14


15
  void updateAge(int newAge) {
16
    _age = newAge;
17
    notifyListeners();
18
  }
19


20
  void toggleActive() {
21
    _isActive = !_isActive;
22
    notifyListeners();
23
  }
24
}
25


26
// 사용 예시
27
class MyWidget extends StatefulWidget {
28
  @override
29
  _MyWidgetState createState() => _MyWidgetState();
30
}
31


32
class _MyWidgetState extends State<MyWidget> {
33
  final _userModel = UserModel();
34


35
  @override
36
  void dispose() {
37
    _userModel.dispose(); // 리소스 해제
38
    super.dispose();
39
  }
40


41
  @override
42
  Widget build(BuildContext context) {
43
    return AnimatedBuilder(
44
      animation: _userModel, // ChangeNotifier 구독
45
      builder: (context, child) {
46
        return Column(
47
          children: [
48
            Text('이름: ${_userModel.name}'),
49
            Text('나이: ${_userModel.age}'),
50
            Text('활성 상태: ${_userModel.isActive ? "활성" : "비활성"}'),
51
            ElevatedButton(
52
              onPressed: () => _userModel.updateName('홍길동'),
53
              child: Text('이름 변경'),
54
            ),
55
            ElevatedButton(
56
              onPressed: () => _userModel.updateAge(30),
57
              child: Text('나이 변경'),
58
            ),
59
            ElevatedButton(
60
              onPressed: () => _userModel.toggleActive(),
61
              child: Text('상태 토글'),
62
            ),
63
          ],
64
        );
65
      },
66
    );
67
  }
68
}
```

## setState vs ValueNotifier: 언제 무엇을 사용해야 할까?

[Section titled “setState vs ValueNotifier: 언제 무엇을 사용해야 할까?”](#setstate-vs-valuenotifier-언제-무엇을-사용해야-할까)

두 방식의 장단점을 비교해보겠습니다:

### setState 사용이 적합한 경우

[Section titled “setState 사용이 적합한 경우”](#setstate-사용이-적합한-경우)

1. **단순한 UI 상태**: 간단한 위젯 내부 상태(토글, 카운터 등)
2. **지역적 상태**: 단일 위젯 내에서만 사용되는 상태
3. **일회성 상태**: 위젯의 생명주기와 함께하는 일시적인 상태
4. **Flutter 입문자**: 기본 개념을 익히는 단계

### ValueNotifier 사용이 적합한 경우

[Section titled “ValueNotifier 사용이 적합한 경우”](#valuenotifier-사용이-적합한-경우)

1. **위젯 간 상태 공유**: 여러 위젯이 공통 상태에 접근해야 할 때
2. **세분화된 UI 업데이트**: 위젯의 특정 부분만 업데이트하고 싶을 때
3. **StatelessWidget 내 상태**: 상태를 가진 StatelessWidget을 구현할 때
4. **복잡한 상태 로직**: 상태 로직을 UI 코드에서 분리하고 싶을 때

## 실제 예제: 할 일 목록 앱

[Section titled “실제 예제: 할 일 목록 앱”](#실제-예제-할-일-목록-앱)

이제 두 가지 상태 관리 방식을 활용하여 간단한 할 일 목록 앱을 구현해보겠습니다.

### 1. setState를 사용한 구현

[Section titled “1. setState를 사용한 구현”](#1-setstate를-사용한-구현)

```dart
1
class TodoListWithSetState extends StatefulWidget {
2
  const TodoListWithSetState({Key? key}) : super(key: key);
3


4
  @override
5
  _TodoListWithSetStateState createState() => _TodoListWithSetStateState();
6
}
7


8
class Todo {
9
  String title;
10
  bool completed;
11


12
  Todo({required this.title, this.completed = false});
13
}
14


15
class _TodoListWithSetStateState extends State<TodoListWithSetState> {
16
  final List<Todo> _todos = [];
17
  final TextEditingController _controller = TextEditingController();
18


19
  void _addTodo() {
20
    if (_controller.text.isNotEmpty) {
21
      setState(() {
22
        _todos.add(Todo(title: _controller.text));
23
        _controller.clear();
24
      });
25
    }
26
  }
27


28
  void _toggleTodo(int index) {
29
    setState(() {
30
      _todos[index].completed = !_todos[index].completed;
31
    });
32
  }
33


34
  void _removeTodo(int index) {
35
    setState(() {
36
      _todos.removeAt(index);
37
    });
38
  }
39


40
  @override
41
  void dispose() {
42
    _controller.dispose();
43
    super.dispose();
44
  }
45


46
  @override
47
  Widget build(BuildContext context) {
48
    return Scaffold(
49
      appBar: AppBar(
50
        title: const Text('할 일 목록 (setState)'),
51
      ),
52
      body: Column(
53
        children: [
54
          Padding(
55
            padding: const EdgeInsets.all(16.0),
56
            child: Row(
57
              children: [
58
                Expanded(
59
                  child: TextField(
60
                    controller: _controller,
61
                    decoration: const InputDecoration(
62
                      labelText: '할 일 추가',
63
                      border: OutlineInputBorder(),
64
                    ),
65
                  ),
66
                ),
67
                const SizedBox(width: 16),
68
                ElevatedButton(
69
                  onPressed: _addTodo,
70
                  child: const Text('추가'),
71
                ),
72
              ],
73
            ),
74
          ),
75
          Expanded(
76
            child: ListView.builder(
77
              itemCount: _todos.length,
78
              itemBuilder: (context, index) {
79
                final todo = _todos[index];
80
                return ListTile(
81
                  leading: Checkbox(
82
                    value: todo.completed,
83
                    onChanged: (_) => _toggleTodo(index),
84
                  ),
85
                  title: Text(
86
                    todo.title,
87
                    style: TextStyle(
88
                      decoration: todo.completed
89
                          ? TextDecoration.lineThrough
90
                          : TextDecoration.none,
91
                    ),
92
                  ),
93
                  trailing: IconButton(
94
                    icon: const Icon(Icons.delete),
95
                    onPressed: () => _removeTodo(index),
96
                  ),
97
                );
98
              },
99
            ),
100
          ),
101
        ],
102
      ),
103
    );
104
  }
105
}
```

### 2. ValueNotifier를 사용한 구현

[Section titled “2. ValueNotifier를 사용한 구현”](#2-valuenotifier를-사용한-구현)

```dart
1
class Todo {
2
  String title;
3
  bool completed;
4


5
  Todo({required this.title, this.completed = false});
6
}
7


8
class TodoListModel extends ChangeNotifier {
9
  final List<Todo> _todos = [];
10


11
  List<Todo> get todos => List.unmodifiable(_todos);
12


13
  void addTodo(String title) {
14
    if (title.isNotEmpty) {
15
      _todos.add(Todo(title: title));
16
      notifyListeners();
17
    }
18
  }
19


20
  void toggleTodo(int index) {
21
    if (index >= 0 && index < _todos.length) {
22
      _todos[index].completed = !_todos[index].completed;
23
      notifyListeners();
24
    }
25
  }
26


27
  void removeTodo(int index) {
28
    if (index >= 0 && index < _todos.length) {
29
      _todos.removeAt(index);
30
      notifyListeners();
31
    }
32
  }
33
}
34


35
class TodoListWithValueNotifier extends StatefulWidget {
36
  const TodoListWithValueNotifier({Key? key}) : super(key: key);
37


38
  @override
39
  _TodoListWithValueNotifierState createState() => _TodoListWithValueNotifierState();
40
}
41


42
class _TodoListWithValueNotifierState extends State<TodoListWithValueNotifier> {
43
  final TodoListModel _model = TodoListModel();
44
  final TextEditingController _controller = TextEditingController();
45


46
  void _addTodo() {
47
    _model.addTodo(_controller.text);
48
    _controller.clear();
49
  }
50


51
  @override
52
  void dispose() {
53
    _controller.dispose();
54
    _model.dispose();
55
    super.dispose();
56
  }
57


58
  @override
59
  Widget build(BuildContext context) {
60
    return Scaffold(
61
      appBar: AppBar(
62
        title: const Text('할 일 목록 (ValueNotifier)'),
63
      ),
64
      body: Column(
65
        children: [
66
          Padding(
67
            padding: const EdgeInsets.all(16.0),
68
            child: Row(
69
              children: [
70
                Expanded(
71
                  child: TextField(
72
                    controller: _controller,
73
                    decoration: const InputDecoration(
74
                      labelText: '할 일 추가',
75
                      border: OutlineInputBorder(),
76
                    ),
77
                  ),
78
                ),
79
                const SizedBox(width: 16),
80
                ElevatedButton(
81
                  onPressed: _addTodo,
82
                  child: const Text('추가'),
83
                ),
84
              ],
85
            ),
86
          ),
87
          Expanded(
88
            child: AnimatedBuilder(
89
              animation: _model,
90
              builder: (context, child) {
91
                return ListView.builder(
92
                  itemCount: _model.todos.length,
93
                  itemBuilder: (context, index) {
94
                    final todo = _model.todos[index];
95
                    return ListTile(
96
                      leading: Checkbox(
97
                        value: todo.completed,
98
                        onChanged: (_) => _model.toggleTodo(index),
99
                      ),
100
                      title: Text(
101
                        todo.title,
102
                        style: TextStyle(
103
                          decoration: todo.completed
104
                              ? TextDecoration.lineThrough
105
                              : TextDecoration.none,
106
                        ),
107
                      ),
108
                      trailing: IconButton(
109
                        icon: const Icon(Icons.delete),
110
                        onPressed: () => _model.removeTodo(index),
111
                      ),
112
                    );
113
                  },
114
                );
115
              },
116
            ),
117
          ),
118
        ],
119
      ),
120
    );
121
  }
122
}
```

## 성능 고려사항

[Section titled “성능 고려사항”](#성능-고려사항)

상태 관리 방식을 선택할 때는 성능도 중요한 고려사항입니다:

### setState의 성능 특징

[Section titled “setState의 성능 특징”](#setstate의-성능-특징)

* **위젯 전체 재빌드**: `setState()`가 호출되면 해당 `StatefulWidget`의 `build()` 메서드 전체가 다시 실행됨
* **필요한 최적화**: `const` 생성자 사용, 위젯 분리 등을 통해 재빌드 범위 최소화 필요

### ValueNotifier의 성능 특징

[Section titled “ValueNotifier의 성능 특징”](#valuenotifier의-성능-특징)

* **부분 업데이트**: `ValueListenableBuilder`를 사용하면 UI의 필요한 부분만 업데이트됨
* **세밀한 제어**: 여러 상태를 각각의 `ValueNotifier`로 분리하여 독립적으로 관리 가능

### 성능 최적화 팁

[Section titled “성능 최적화 팁”](#성능-최적화-팁)

1. **적절한 곳에 setState 호출**: 필요한 상태 변경만 수행
2. **작은 위젯으로 분리**: 상태 변경이 필요한 부분만 `StatefulWidget`으로 분리
3. **const 위젯 활용**: 변경되지 않는 위젯은 `const` 생성자 사용
4. **ValueNotifier 세분화**: 관련 상태끼리 그룹화하되, 너무 큰 객체는 피함

## 요약

[Section titled “요약”](#요약)

* **setState**는 Flutter의 가장 기본적인 상태 관리 메커니즘으로, 단순하고 직관적이지만 위젯 트리 깊은 곳으로 상태 전달이 어려움
* **ValueNotifier**는 좀 더 유연한 상태 관리를 제공하며, 위젯 간 상태 공유와 세분화된 UI 업데이트에 적합
* 간단한 앱에서는 이 두 가지 메커니즘만으로도 효과적인 상태 관리가 가능
* 앱이 복잡해질수록 Provider, Riverpod 등의 고급 상태 관리 솔루션 도입 고려

다음 섹션에서는 위젯 트리를 통한 상태 공유를 위한 `InheritedWidget`과 이를 기반으로 한 `Provider` 패턴에 대해 알아보겠습니다.

# 상태 관리 입문

Flutter 앱을 개발하면서 가장 중요한 개념 중 하나는 ‘상태 관리(State Management)‘입니다. 이 장에서는 Flutter에서의 상태 관리 개념과 다양한 상태 관리 방법에 대해 알아보겠습니다.

## 상태(State)란 무엇인가?

[Section titled “상태(State)란 무엇인가?”](#상태state란-무엇인가)

상태는 앱의 동작 중에 변할 수 있는 데이터를 의미합니다. 사용자 입력, 네트워크 응답, 시간 경과 등에 따라 앱의 UI가 변경되어야 할 때, 이러한 변경사항을 관리하는 데이터를 ‘상태’라고 합니다.

Flutter에서 상태는 크게 다음과 같이 분류할 수 있습니다:

### 1. 임시 상태(Ephemeral State)

[Section titled “1. 임시 상태(Ephemeral State)”](#1-임시-상태ephemeral-state)

* 단일 위젯 내에서만 사용되는 간단한 상태
* UI의 일시적인 변화를 관리 (예: 버튼 눌림 상태, 입력 필드 포커스 등)
* `StatefulWidget`과 `setState()`로 쉽게 관리 가능

### 2. 앱 상태(App State)

[Section titled “2. 앱 상태(App State)”](#2-앱-상태app-state)

* 앱의 여러 부분에서 공유되는 데이터
* 장기적으로 유지되어야 하는 정보 (예: 사용자 설정, 인증 토큰, 쇼핑 카트 내용)
* 전역적으로 접근 가능해야 하며, 효율적인 관리가 필요
* 상태 관리 라이브러리(Provider, Riverpod, Bloc 등)를 활용하여 관리

## 상태 관리가 중요한 이유

[Section titled “상태 관리가 중요한 이유”](#상태-관리가-중요한-이유)

상태 관리는 다음과 같은 이유로 중요합니다:

1. **UI 일관성**: 상태 변화에 따라 UI가 일관되게 업데이트되어야 함
2. **코드 구조화**: 앱의 상태 로직과 UI 로직을 분리하여 유지보수성 향상
3. **성능 최적화**: 필요한 부분만 효율적으로 다시 빌드하여 성능 개선
4. **확장성**: 앱의 규모가 커져도 상태를 효과적으로 관리할 수 있는 구조 필요

## 상태 관리 방식의 진화

[Section titled “상태 관리 방식의 진화”](#상태-관리-방식의-진화)

Flutter에서의 상태 관리는 다음과 같이 진화해 왔습니다:

### 1. StatefulWidget과 setState()

[Section titled “1. StatefulWidget과 setState()”](#1-statefulwidget과-setstate)

Flutter의 기본적인 상태 관리 메커니즘입니다. 간단한 상태를 위젯 내부에서 관리합니다.

```dart
1
class CounterWidget extends StatefulWidget {
2
  @override
3
  _CounterWidgetState createState() => _CounterWidgetState();
4
}
5


6
class _CounterWidgetState extends State<CounterWidget> {
7
  int _count = 0;
8


9
  void _incrementCount() {
10
    setState(() {
11
      _count++;
12
    });
13
  }
14


15
  @override
16
  Widget build(BuildContext context) {
17
    return Column(
18
      children: [
19
        Text('카운트: $_count'),
20
        ElevatedButton(
21
          onPressed: _incrementCount,
22
          child: Text('증가'),
23
        ),
24
      ],
25
    );
26
  }
27
}
```

특징:

* 장점: 간단하고 직관적
* 단점: 깊은 위젯 트리에서 상태 전달이 어려움(Prop drilling)

### 2. InheritedWidget

[Section titled “2. InheritedWidget”](#2-inheritedwidget)

Flutter의 내장 메커니즘으로, 위젯 트리 아래로 데이터를 효율적으로 전달합니다.

```dart
1
class CounterInheritedWidget extends InheritedWidget {
2
  final int count;
3
  final Function incrementCount;
4


5
  CounterInheritedWidget({
6
    required this.count,
7
    required this.incrementCount,
8
    required Widget child,
9
  }) : super(child: child);
10


11
  @override
12
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
13
    return count != oldWidget.count;
14
  }
15


16
  static CounterInheritedWidget of(BuildContext context) {
17
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
18
  }
19
}
```

특징:

* 장점: 위젯 트리를 통한 데이터 전파
* 단점: 직접 구현하기 복잡함

### 3. Provider 패턴

[Section titled “3. Provider 패턴”](#3-provider-패턴)

InheritedWidget을 래핑한 패키지로, 더 사용하기 쉬운 API를 제공합니다.

```dart
1
// 상태 클래스
2
class CounterModel with ChangeNotifier {
3
  int _count = 0;
4
  int get count => _count;
5


6
  void increment() {
7
    _count++;
8
    notifyListeners();
9
  }
10
}
11


12
// Provider 설정
13
ChangeNotifierProvider(
14
  create: (context) => CounterModel(),
15
  child: MyApp(),
16
),
17


18
// 데이터 사용
19
Consumer<CounterModel>(
20
  builder: (context, counter, child) {
21
    return Text('카운트: ${counter.count}');
22
  },
23
)
```

특징:

* 장점: 사용하기 쉽고 직관적
* 단점: 복잡한 상태 관리에는 한계가 있음

### 4. 현대적 상태 관리 솔루션

[Section titled “4. 현대적 상태 관리 솔루션”](#4-현대적-상태-관리-솔루션)

현재는 다양한 상태 관리 라이브러리가 존재합니다:

* **Riverpod**: Provider의 개선 버전으로, 컴파일 타임 안전성 및 테스트 용이성 강화
* **Bloc/Cubit**: 비즈니스 로직을 명확하게 분리하는 패턴
* **MobX**: 반응형 프로그래밍 기반의 상태 관리
* **Redux**: 예측 가능한 상태 컨테이너

## 상태 관리 선택 가이드

[Section titled “상태 관리 선택 가이드”](#상태-관리-선택-가이드)

어떤 상태 관리 솔루션을 선택해야 할까요? 다음 요소를 고려하세요:

1. **앱 복잡도**: 단순한 앱은 setState()나 Provider로도 충분할 수 있음
2. **팀 경험**: 팀이 이미 익숙한 솔루션이 있다면 고려
3. **학습 곡선**: 일부 솔루션은 배우기 어려울 수 있음
4. **성능 요구사항**: 대규모 앱의 경우 성능 최적화된 솔루션 필요
5. **테스트 용이성**: 상태 로직의 테스트 용이성도 중요한 고려사항

## 이 장의 다음 섹션들

[Section titled “이 장의 다음 섹션들”](#이-장의-다음-섹션들)

이 장의 나머지 부분에서는 Flutter의 다양한 상태 관리 방법을 자세히 다룰 것입니다:

1. **setState와 ValueNotifier**: Flutter의 기본 상태 관리 메커니즘
2. **InheritedWidget과 Provider**: 위젯 트리를 통한 상태 공유
3. **Riverpod**: 현대적인 상태 관리 솔루션
4. **TodoList 실습**: 실제 애플리케이션에 상태 관리 적용하기

## 요약

[Section titled “요약”](#요약)

* 상태 관리는 Flutter 애플리케이션 개발에서 핵심 개념
* 상태는 임시 상태와 앱 상태로 분류됨
* 다양한 상태 관리 솔루션이 존재하며, 앱의 복잡도와 요구사항에 따라 선택
* 효과적인 상태 관리는 유지보수성, 성능, 확장성을 향상시킴

다음 섹션에서는 Flutter의 기본 상태 관리 메커니즘인 `setState()`와 `ValueNotifier`에 대해 자세히 알아보겠습니다.

# 라우트 가드, ShellRoute, DeepLink

이 장에서는 go\_router를 활용한 고급 라우팅 기법에 대해 알아보겠습니다. 라우트 가드를 통한 접근 제어, ShellRoute를 이용한 중첩 네비게이션, 그리고 딥 링크를 통한 앱 외부에서의 접근 방법을 살펴보겠습니다.

## 라우트 가드 (Route Guards)

[Section titled “라우트 가드 (Route Guards)”](#라우트-가드-route-guards)

라우트 가드는 특정 경로에 대한 접근을 제어하는 메커니즘으로, 사용자 인증이나 권한 검사 등에 활용됩니다.

### redirect를 활용한 기본 라우트 가드

[Section titled “redirect를 활용한 기본 라우트 가드”](#redirect를-활용한-기본-라우트-가드)

go\_router의 `redirect` 기능을 사용하여 라우트 가드를 구현할 수 있습니다:

```dart
1
final GoRouter router = GoRouter(
2
  routes: [...],
3


4
  // 전역 리다이렉트 (모든 라우트에 적용)
5
  redirect: (context, state) {
6
    // 현재 인증 상태 확인
7
    final isLoggedIn = AuthService.isLoggedIn;
8


9
    // 로그인이 필요한 경로 목록
10
    final protectedRoutes = ['/profile', '/settings', '/cart'];
11
    final isProtectedRoute = protectedRoutes.any(
12
      (route) => state.matchedLocation.startsWith(route),
13
    );
14


15
    // 로그인 페이지 여부 확인
16
    final isLoginRoute = state.matchedLocation == '/login';
17


18
    // 로그인 되지 않았고 보호된 경로로 접근 시도
19
    if (!isLoggedIn && isProtectedRoute) {
20
      return '/login?redirect=${state.matchedLocation}';
21
    }
22


23
    // 이미 로그인된 상태에서 로그인 페이지 접근 시도
24
    if (isLoggedIn && isLoginRoute) {
25
      return '/';
26
    }
27


28
    // 조건에 해당하지 않으면 리다이렉트 없음 (원래 경로 유지)
29
    return null;
30
  },
31
);
```

### 특정 라우트에 대한 가드

[Section titled “특정 라우트에 대한 가드”](#특정-라우트에-대한-가드)

개별 라우트에 대해서도 리다이렉트를 설정할 수 있습니다:

```dart
1
GoRoute(
2
  path: '/admin',
3
  redirect: (context, state) {
4
    final user = AuthService.currentUser;
5


6
    // 관리자 권한 확인
7
    if (user == null || !user.hasAdminRole) {
8
      return '/access-denied';
9
    }
10


11
    // 권한이 있으면 원래 경로로 진행
12
    return null;
13
  },
14
  builder: (context, state) => AdminDashboard(),
15
),
```

### 상태 변화에 따른 리다이렉트 갱신

[Section titled “상태 변화에 따른 리다이렉트 갱신”](#상태-변화에-따른-리다이렉트-갱신)

인증 상태가 변경될 때 라우트를 재평가하기 위해 `refreshListenable`을 사용합니다:

```dart
1
// 인증 상태 관리를 위한 ChangeNotifier
2
class AuthNotifier extends ChangeNotifier {
3
  bool _isLoggedIn = false;
4


5
  bool get isLoggedIn => _isLoggedIn;
6


7
  Future<void> login() async {
8
    _isLoggedIn = true;
9
    notifyListeners(); // 상태 변경 알림 (라우터가 이를 감지)
10
  }
11


12
  Future<void> logout() async {
13
    _isLoggedIn = false;
14
    notifyListeners();
15
  }
16
}
17


18
// 인증 상태 변경을 감지하는 라우터
19
final GoRouter router = GoRouter(
20
  refreshListenable: authNotifier, // 인증 상태 변경 감지
21
  redirect: (context, state) {
22
    // 리다이렉트 로직...
23
  },
24
  routes: [...],
25
);
```

## ShellRoute를 이용한 네비게이션

[Section titled “ShellRoute를 이용한 네비게이션”](#shellroute를-이용한-네비게이션)

ShellRoute는 중첩 네비게이션을 구현하는 데 사용되며, 특히 바텀 네비게이션 바나 탭 바와 같은 영구적인 UI 요소가 있는 앱에 유용합니다.

### StatefulShellRoute 기본 개념

[Section titled “StatefulShellRoute 기본 개념”](#statefulshellroute-기본-개념)

StatefulShellRoute는 여러 브랜치(branch)를 관리하는 라우트로, 각 브랜치는 자체 네비게이션 상태와 히스토리를 가집니다:

### 바텀 네비게이션 바 구현

[Section titled “바텀 네비게이션 바 구현”](#바텀-네비게이션-바-구현)

StatefulShellRoute를 사용하여 바텀 네비게이션 바를 구현해 보겠습니다:

```dart
1
final GoRouter router = GoRouter(
2
  initialLocation: '/',
3
  routes: [
4
    // StatefulShellRoute 정의 (indexedStack 방식 사용)
5
    StatefulShellRoute.indexedStack(
6
      // 쉘 UI 구성
7
      builder: (context, state, navigationShell) {
8
        return ScaffoldWithNavBar(navigationShell: navigationShell);
9
      },
10
      // 브랜치 정의
11
      branches: [
12
        // 홈 탭
13
        StatefulShellBranch(
14
          routes: [
15
            GoRoute(
16
              path: '/',
17
              builder: (context, state) => HomeScreen(),
18
              routes: [
19
                // 홈 탭 내부의 중첩 라우트
20
                GoRoute(
21
                  path: 'details/:id',
22
                  builder: (context, state) {
23
                    final id = state.pathParameters['id']!;
24
                    return DetailsScreen(id: id);
25
                  },
26
                ),
27
              ],
28
            ),
29
          ],
30
        ),
31


32
        // 검색 탭
33
        StatefulShellBranch(
34
          routes: [
35
            GoRoute(
36
              path: '/search',
37
              builder: (context, state) => SearchScreen(),
38
            ),
39
          ],
40
        ),
41


42
        // 프로필 탭
43
        StatefulShellBranch(
44
          routes: [
45
            GoRoute(
46
              path: '/profile',
47
              builder: (context, state) => ProfileScreen(),
48
            ),
49
          ],
50
        ),
51
      ],
52
    ),
53
  ],
54
);
55


56
// 바텀 네비게이션 바가 있는 스캐폴드
57
class ScaffoldWithNavBar extends StatelessWidget {
58
  final StatefulNavigationShell navigationShell;
59


60
  const ScaffoldWithNavBar({required this.navigationShell});
61


62
  @override
63
  Widget build(BuildContext context) {
64
    return Scaffold(
65
      body: navigationShell, // 현재 브랜치의 화면 표시
66
      bottomNavigationBar: BottomNavigationBar(
67
        currentIndex: navigationShell.currentIndex,
68
        items: const [
69
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
70
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
71
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
72
        ],
73
        onTap: (index) {
74
          // 탭 인덱스에 해당하는 브랜치로 이동
75
          navigationShell.goBranch(index);
76
        },
77
      ),
78
    );
79
  }
80
}
```

### 브랜치 간 이동과 상태 유지

[Section titled “브랜치 간 이동과 상태 유지”](#브랜치-간-이동과-상태-유지)

StatefulShellRoute의 강점은 각 브랜치 내의 네비게이션 상태가 유지된다는 점입니다:

```dart
1
// 검색 화면에서 사용자가 검색 결과로 이동한 후
2
// 다른 탭으로 이동했다가 다시 검색 탭으로 돌아오면
3
// 검색 결과 화면이 그대로 유지됩니다.
4


5
// 홈 탭에서 상세 화면으로 이동
6
context.go('/details/123');
7


8
// 프로필 탭으로 이동 (홈 탭의 상태는 유지됨)
9
context.go('/profile');
10


11
// 다시 홈 탭으로 이동하면 상세 화면이 표시됨
12
context.go('/');
```

## 딥 링크 (Deep Linking)

[Section titled “딥 링크 (Deep Linking)”](#딥-링크-deep-linking)

딥 링크는 앱의 특정 화면으로 직접 접근할 수 있는 외부 링크로, 웹 URL, 푸시 알림 등에서 활용됩니다.

### 안드로이드 딥 링크 설정

[Section titled “안드로이드 딥 링크 설정”](#안드로이드-딥-링크-설정)

1. **AndroidManifest.xml 설정**:

```xml
1
<manifest ...>
2
  <application ...>
3
    <activity ...>
4
      <!-- 기존 인텐트 필터 -->
5
      <intent-filter>
6
        <action android:name="android.intent.action.MAIN"/>
7
        <category android:name="android.intent.category.LAUNCHER"/>
8
      </intent-filter>
9


10
      <!-- 딥 링크 인텐트 필터 추가 -->
11
      <intent-filter android:autoVerify="true">
12
        <action android:name="android.intent.action.VIEW" />
13
        <category android:name="android.intent.category.DEFAULT" />
14
        <category android:name="android.intent.category.BROWSABLE" />
15


16
        <!-- 딥 링크 스킴 및 호스트 설정 -->
17
        <data
18
          android:scheme="https"
19
          android:host="example.com" />
20
      </intent-filter>
21
    </activity>
22
  </application>
23
</manifest>
```

### iOS 딥 링크 설정

[Section titled “iOS 딥 링크 설정”](#ios-딥-링크-설정)

1. **Info.plist 설정**:

```xml
1
<key>CFBundleURLTypes</key>
2
<array>
3
  <dict>
4
    <key>CFBundleTypeRole</key>
5
    <string>Editor</string>
6
    <key>CFBundleURLName</key>
7
    <string>com.example.app</string>
8
    <key>CFBundleURLSchemes</key>
9
    <array>
10
      <string>myapp</string>
11
    </array>
12
  </dict>
13
</array>
14


15
<!-- Universal Links 설정 -->
16
<key>com.apple.developer.associated-domains</key>
17
<array>
18
  <string>applinks:example.com</string>
19
</array>
```

### Flutter에서 딥 링크 처리

[Section titled “Flutter에서 딥 링크 처리”](#flutter에서-딥-링크-처리)

go\_router를 사용하면 딥 링크 처리가 매우 간단합니다:

```dart
1
// 딥 링크를 자동으로 처리하는 설정
2
void main() {
3
  // 앱 초기화
4
  WidgetsFlutterBinding.ensureInitialized();
5


6
  // 라우터 설정
7
  final router = GoRouter(
8
    // 라우트 설정
9
    routes: [...],
10
  );
11


12
  runApp(MyApp(router: router));
13
}
14


15
class MyApp extends StatelessWidget {
16
  final GoRouter router;
17


18
  const MyApp({required this.router});
19


20
  @override
21
  Widget build(BuildContext context) {
22
    return MaterialApp.router(
23
      routerConfig: router,
24
      title: '딥 링크 예제',
25
      // ...
26
    );
27
  }
28
}
```

### 딥 링크 테스트

[Section titled “딥 링크 테스트”](#딥-링크-테스트)

딥 링크를 테스트하기 위해 터미널에서 다음 명령어를 실행할 수 있습니다:

**안드로이드**:

```bash
1
adb shell am start -a android.intent.action.VIEW -d "https://example.com/product/123" com.example.app
```

**iOS 시뮬레이터**:

```bash
1
xcrun simctl openurl booted "https://example.com/product/123"
```

### 푸시 알림에서 딥 링크 처리

[Section titled “푸시 알림에서 딥 링크 처리”](#푸시-알림에서-딥-링크-처리)

푸시 알림을 통한 딥 링크를 처리하는 방법:

```dart
1
// firebase_messaging 패키지 사용 예제
2
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
3
  final deepLink = message.data['deepLink'] as String?;
4
  if (deepLink != null) {
5
    // 앱이 실행 중일 때 푸시 알림을 탭하면 해당 경로로 이동
6
    router.go(deepLink);
7
  }
8
});
9


10
// 앱이 종료된 상태에서 푸시 알림을 탭한 경우
11
Future<void> setupInteractedMessage() async {
12
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
13


14
  if (initialMessage != null) {
15
    final deepLink = initialMessage.data['deepLink'] as String?;
16
    if (deepLink != null) {
17
      // 딥 링크로 이동
18
      router.go(deepLink);
19
    }
20
  }
21
}
```

## 고급 라우팅 테크닉

[Section titled “고급 라우팅 테크닉”](#고급-라우팅-테크닉)

### 1. 동적 라우트 생성

[Section titled “1. 동적 라우트 생성”](#1-동적-라우트-생성)

API에서 가져온 데이터를 기반으로 동적으로 라우트를 생성할 수 있습니다:

```dart
1
// 동적 라우트 생성 예제
2
Future<List<GoRoute>> buildDynamicRoutes() async {
3
  // API에서 카테고리 목록 가져오기
4
  final categories = await apiService.getCategories();
5


6
  // 각 카테고리에 대한 라우트 생성
7
  return categories.map((category) {
8
    return GoRoute(
9
      path: '/category/${category.slug}',
10
      builder: (context, state) => CategoryScreen(category: category),
11
    );
12
  }).toList();
13
}
```

### 2. 라우트 전환 애니메이션 커스터마이징

[Section titled “2. 라우트 전환 애니메이션 커스터마이징”](#2-라우트-전환-애니메이션-커스터마이징)

라우트 간 전환 애니메이션을 세밀하게 제어할 수 있습니다:

```dart
1
GoRoute(
2
  path: '/details/:id',
3
  pageBuilder: (context, state) {
4
    final id = state.pathParameters['id']!;
5


6
    // 히어로 애니메이션을 위한 전환 페이지
7
    return CustomTransitionPage(
8
      key: state.pageKey,
9
      child: ProductDetailsScreen(id: id),
10
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
11
        // 페이드 트랜지션
12
        return FadeTransition(
13
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
14
          child: child,
15
        );
16
      },
17
    );
18
  },
19
),
```

## 요약

[Section titled “요약”](#요약)

* **라우트 가드**를 사용하여 인증 상태에 따라 접근을 제어할 수 있습니다.
* **StatefulShellRoute**는 바텀 네비게이션 바와 같은 중첩 네비게이션을 효과적으로 구현할 수 있게 해줍니다.
* **딥 링크**를 통해 앱 외부에서 특정 화면으로 직접 접근할 수 있습니다.
* **안드로이드와 iOS** 모두에서 딥 링크를 설정하는 방법이 다릅니다.
* **푸시 알림**에서 딥 링크를 처리하여 특정 화면으로 이동할 수 있습니다.
* **동적 라우트 생성**, **커스텀 전환 애니메이션** 등 고급 라우팅 기법을 활용할 수 있습니다.

다음 섹션에서는 이러한 고급 라우팅 기법을 실제 앱에 적용하는 복수 화면 전환 실습을 진행하겠습니다.

# go_router 사용법

go\_router는 Flutter 팀이 공식적으로 지원하는 라우팅 패키지로, Navigator 2.0의 기능을 더 쉽게 사용할 수 있게 해줍니다. 복잡한 라우팅 시나리오를 처리하면서도 간결한 API를 제공하여 개발자 경험을 크게 향상시킵니다.

## go\_router의 소개

[Section titled “go\_router의 소개”](#go_router의-소개)

go\_router는 다음과 같은 목표로 개발되었습니다:

1. **간결한 API**: Navigator 2.0의 복잡성을 줄이고 더 직관적인 API 제공
2. **선언적 라우팅**: 앱의 모든 라우트를 한 곳에서 선언적으로 정의
3. **딥 링크 지원**: 모바일 앱의 딥 링크와 웹 URL 지원
4. **중첩 라우팅**: 중첩된 네비게이션 시나리오 지원
5. **페이지 전환 애니메이션**: 커스텀 페이지 전환 효과 지원

## go\_router 설치하기

[Section titled “go\_router 설치하기”](#go_router-설치하기)

pubspec.yaml 파일에 go\_router 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  go_router: ^15.1.2 # 최신 버전을 확인하세요
```

그리고 패키지를 설치합니다:

```bash
1
flutter pub get
```

## go\_router의 기본 개념

[Section titled “go\_router의 기본 개념”](#go_router의-기본-개념)

### 1. GoRouter 설정

[Section titled “1. GoRouter 설정”](#1-gorouter-설정)

앱의 라우팅을 설정하는 GoRouter 인스턴스를 생성합니다:

```dart
1
final GoRouter _router = GoRouter(
2
  initialLocation: '/',
3
  routes: [
4
    GoRoute(
5
      path: '/',
6
      builder: (context, state) => HomeScreen(),
7
    ),
8
    GoRoute(
9
      path: '/details/:id',
10
      builder: (context, state) => DetailsScreen(
11
        id: state.pathParameters['id']!,
12
      ),
13
    ),
14
  ],
15
);
16


17
// 앱에 라우터 적용
18
class MyApp extends StatelessWidget {
19
  @override
20
  Widget build(BuildContext context) {
21
    return MaterialApp.router(
22
      routerConfig: _router,
23
      title: 'GoRouter Example',
24
    );
25
  }
26
}
```

### 2. 경로 정의와 매개변수

[Section titled “2. 경로 정의와 매개변수”](#2-경로-정의와-매개변수)

go\_router에서는 URL 경로에 매개변수를 포함할 수 있습니다:

* **경로 매개변수**: `/user/:id`와 같이 콜론으로 시작하는 세그먼트
* **쿼리 매개변수**: `/search?query=flutter`와 같이 URL에 추가되는 키-값 쌍

```dart
1
GoRoute(
2
  path: '/user/:userId/post/:postId',
3
  builder: (context, state) {
4
    // 경로 매개변수 추출
5
    final userId = state.pathParameters['userId']!;
6
    final postId = state.pathParameters['postId']!;
7


8
    // 쿼리 매개변수 추출
9
    final filter = state.queryParameters['filter'];
10


11
    return PostScreen(userId: userId, postId: postId, filter: filter);
12
  },
13
),
```

### 3. 화면 이동

[Section titled “3. 화면 이동”](#3-화면-이동)

go\_router는 다양한 방법으로 화면 간 이동을 지원합니다:

```dart
1
// 명시적 경로로 이동
2
context.go('/details/123');
3


4
// 현재 스택에 새 화면 추가
5
context.push('/details/123');
6


7
// 스택을 모두 비우고 새 화면으로 대체
8
context.pushReplacement('/details/123');
9


10
// 해당 경로까지 모든 화면 제거 후 새 화면 추가
11
context.pushAndRemoveUntil('/details/123', predicate);
12


13
// 이전 화면으로 돌아가기
14
context.pop();
```

## go\_router 고급 기능

[Section titled “go\_router 고급 기능”](#go_router-고급-기능)

### 1. 중첩 라우팅

[Section titled “1. 중첩 라우팅”](#1-중첩-라우팅)

go\_router는 StatefulShellRoute를 통해 중첩 라우팅을 지원합니다:

```dart
1
final GoRouter _router = GoRouter(
2
  routes: [
3
    StatefulShellRoute.indexedStack(
4
      builder: (context, state, navigationShell) {
5
        // 바텀 네비게이션 바 또는 탭 컨트롤러와 함께 사용
6
        return ScaffoldWithNavBar(navigationShell: navigationShell);
7
      },
8
      branches: [
9
        // 첫 번째 탭 (Home)
10
        StatefulShellBranch(
11
          routes: [
12
            GoRoute(
13
              path: '/',
14
              builder: (context, state) => HomeScreen(),
15
              routes: [
16
                GoRoute(
17
                  path: 'details/:id',
18
                  builder: (context, state) => DetailsScreen(
19
                    id: state.pathParameters['id']!,
20
                  ),
21
                ),
22
              ],
23
            ),
24
          ],
25
        ),
26
        // 두 번째 탭 (Profile)
27
        StatefulShellBranch(
28
          routes: [
29
            GoRoute(
30
              path: '/profile',
31
              builder: (context, state) => ProfileScreen(),
32
              routes: [
33
                GoRoute(
34
                  path: 'edit',
35
                  builder: (context, state) => EditProfileScreen(),
36
                ),
37
              ],
38
            ),
39
          ],
40
        ),
41
        // 세 번째 탭 (Settings)
42
        StatefulShellBranch(
43
          routes: [
44
            GoRoute(
45
              path: '/settings',
46
              builder: (context, state) => SettingsScreen(),
47
            ),
48
          ],
49
        ),
50
      ],
51
    ),
52
  ],
53
);
54


55
// 바텀 네비게이션 바 위젯
56
class ScaffoldWithNavBar extends StatelessWidget {
57
  final StatefulNavigationShell navigationShell;
58


59
  const ScaffoldWithNavBar({required this.navigationShell});
60


61
  @override
62
  Widget build(BuildContext context) {
63
    return Scaffold(
64
      body: navigationShell,
65
      bottomNavigationBar: BottomNavigationBar(
66
        currentIndex: navigationShell.currentIndex,
67
        items: const [
68
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
69
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
70
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
71
        ],
72
        onTap: (index) => navigationShell.goBranch(index),
73
      ),
74
    );
75
  }
76
}
```

### 2. 리다이렉트

[Section titled “2. 리다이렉트”](#2-리다이렉트)

리다이렉트를 사용하여 인증이 필요한 페이지나 다른 경로로 자동 리다이렉션할 수 있습니다:

```dart
1
final GoRouter _router = GoRouter(
2
  initialLocation: '/',
3
  routes: [...],
4


5
  // 전역 리다이렉트 (모든 라우트에 적용)
6
  redirect: (context, state) {
7
    final isLoggedIn = AuthService.isLoggedIn;
8
    final isGoingToLogin = state.matchedLocation == '/login';
9


10
    // 로그인되지 않았고 로그인 페이지로 가는 중이 아니면 로그인 페이지로 리다이렉트
11
    if (!isLoggedIn && !isGoingToLogin) {
12
      return '/login?redirect=${state.matchedLocation}';
13
    }
14


15
    // 이미 로그인되었고 로그인 페이지로 가려고 한다면 홈으로 리다이렉트
16
    if (isLoggedIn && isGoingToLogin) {
17
      return '/';
18
    }
19


20
    // 리다이렉트 없음
21
    return null;
22
  },
23
);
24


25
// 특정 라우트에 대한 리다이렉트
26
GoRoute(
27
  path: '/admin',
28
  redirect: (context, state) {
29
    final isAdmin = AuthService.hasAdminRole;
30
    if (!isAdmin) {
31
      return '/access-denied';
32
    }
33
    return null;
34
  },
35
  builder: (context, state) => AdminPanel(),
36
),
```

### 3. 오류 처리

[Section titled “3. 오류 처리”](#3-오류-처리)

go\_router는 존재하지 않는 경로에 대한 오류 처리를 지원합니다:

```dart
1
final GoRouter _router = GoRouter(
2
  initialLocation: '/',
3
  routes: [...],
4


5
  // 경로가 매치되지 않을 때 표시할 화면
6
  errorBuilder: (context, state) => NotFoundScreen(),
7
);
```

### 4. 페이지 전환 애니메이션

[Section titled “4. 페이지 전환 애니메이션”](#4-페이지-전환-애니메이션)

go\_router를 사용하여 화면 전환 애니메이션을 커스터마이징할 수 있습니다:

```dart
1
GoRoute(
2
  path: '/details/:id',
3
  pageBuilder: (context, state) {
4
    return CustomTransitionPage(
5
      key: state.pageKey,
6
      child: DetailsScreen(id: state.pathParameters['id']!),
7
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
8
        const begin = Offset(1.0, 0.0);
9
        const end = Offset.zero;
10
        const curve = Curves.easeInOut;
11


12
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
13
        var offsetAnimation = animation.drive(tween);
14


15
        return SlideTransition(
16
          position: offsetAnimation,
17
          child: child,
18
        );
19
      },
20
    );
21
  },
22
),
```

## go\_router 활용 예제

[Section titled “go\_router 활용 예제”](#go_router-활용-예제)

다음은 go\_router를 활용한 전체 샘플 앱입니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:go_router/go_router.dart';
3


4
void main() {
5
  runApp(MyApp());
6
}
7


8
// 앱 상태 (인증 상태)
9
class AppState extends ChangeNotifier {
10
  bool _isLoggedIn = false;
11


12
  bool get isLoggedIn => _isLoggedIn;
13


14
  void login() {
15
    _isLoggedIn = true;
16
    notifyListeners();
17
  }
18


19
  void logout() {
20
    _isLoggedIn = false;
21
    notifyListeners();
22
  }
23
}
24


25
// 라우터 설정
26
final appState = AppState();
27


28
final GoRouter _router = GoRouter(
29
  initialLocation: '/',
30
  refreshListenable: appState, // 인증 상태가 변경될 때 라우터 갱신
31
  redirect: (context, state) {
32
    // 인증이 필요한 경로 목록
33
    final protectedRoutes = ['/profile', '/settings'];
34


35
    // 현재 경로가 보호된 경로인지 확인
36
    final isProtectedRoute = protectedRoutes.any(
37
      (route) => state.matchedLocation.startsWith(route),
38
    );
39


40
    // 로그인 되지 않았지만 보호된 경로로 접근하려고 할 때
41
    if (!appState.isLoggedIn && isProtectedRoute) {
42
      return '/login?redirect=${state.matchedLocation}';
43
    }
44


45
    // 로그인 되어 있고 로그인 페이지로 가려고 할 때
46
    if (appState.isLoggedIn && state.matchedLocation == '/login') {
47
      return '/';
48
    }
49


50
    // 리다이렉트 없음
51
    return null;
52
  },
53
  routes: [
54
    // 홈 화면
55
    GoRoute(
56
      path: '/',
57
      builder: (context, state) => HomeScreen(),
58
    ),
59


60
    // 로그인 화면
61
    GoRoute(
62
      path: '/login',
63
      builder: (context, state) {
64
        // 로그인 후 리다이렉트할 경로
65
        final redirectUrl = state.queryParameters['redirect'] ?? '/';
66
        return LoginScreen(redirectUrl: redirectUrl);
67
      },
68
    ),
69


70
    // 상품 상세 화면
71
    GoRoute(
72
      path: '/product/:id',
73
      builder: (context, state) {
74
        final productId = state.pathParameters['id']!;
75
        return ProductDetailScreen(productId: productId);
76
      },
77
    ),
78


79
    // 프로필 섹션 (중첩 라우트)
80
    GoRoute(
81
      path: '/profile',
82
      builder: (context, state) => ProfileScreen(),
83
      routes: [
84
        GoRoute(
85
          path: 'edit',
86
          builder: (context, state) => EditProfileScreen(),
87
        ),
88
        GoRoute(
89
          path: 'orders',
90
          builder: (context, state) => OrderHistoryScreen(),
91
        ),
92
      ],
93
    ),
94


95
    // 설정 화면
96
    GoRoute(
97
      path: '/settings',
98
      builder: (context, state) => SettingsScreen(),
99
    ),
100
  ],
101


102
  // 경로를 찾을 수 없을 때의 오류 화면
103
  errorBuilder: (context, state) => NotFoundScreen(),
104
);
105


106
// 메인 앱
107
class MyApp extends StatelessWidget {
108
  @override
109
  Widget build(BuildContext context) {
110
    return MaterialApp.router(
111
      title: 'GoRouter Example',
112
      theme: ThemeData(
113
        primarySwatch: Colors.blue,
114
      ),
115
      routerConfig: _router,
116
    );
117
  }
118
}
119


120
// 홈 화면
121
class HomeScreen extends StatelessWidget {
122
  @override
123
  Widget build(BuildContext context) {
124
    return Scaffold(
125
      appBar: AppBar(title: Text('홈')),
126
      body: Center(
127
        child: Column(
128
          mainAxisAlignment: MainAxisAlignment.center,
129
          children: [
130
            Text('홈 화면'),
131
            SizedBox(height: 20),
132


133
            // 상품 목록
134
            Expanded(
135
              child: ListView.builder(
136
                itemCount: 10,
137
                itemBuilder: (context, index) {
138
                  final productId = index + 1;
139
                  return ListTile(
140
                    title: Text('상품 $productId'),
141
                    onTap: () => context.go('/product/$productId'),
142
                  );
143
                },
144
              ),
145
            ),
146
          ],
147
        ),
148
      ),
149
      drawer: AppDrawer(),
150
    );
151
  }
152
}
153


154
// 앱 드로어
155
class AppDrawer extends StatelessWidget {
156
  @override
157
  Widget build(BuildContext context) {
158
    return Drawer(
159
      child: ListView(
160
        padding: EdgeInsets.zero,
161
        children: [
162
          DrawerHeader(
163
            decoration: BoxDecoration(color: Colors.blue),
164
            child: Text(
165
              'GoRouter 예제',
166
              style: TextStyle(color: Colors.white, fontSize: 24),
167
            ),
168
          ),
169
          ListTile(
170
            leading: Icon(Icons.home),
171
            title: Text('홈'),
172
            onTap: () {
173
              context.go('/');
174
              Navigator.pop(context); // 드로어 닫기
175
            },
176
          ),
177
          ListTile(
178
            leading: Icon(Icons.person),
179
            title: Text('프로필'),
180
            onTap: () {
181
              context.go('/profile');
182
              Navigator.pop(context);
183
            },
184
          ),
185
          ListTile(
186
            leading: Icon(Icons.settings),
187
            title: Text('설정'),
188
            onTap: () {
189
              context.go('/settings');
190
              Navigator.pop(context);
191
            },
192
          ),
193
          Divider(),
194
          if (appState.isLoggedIn)
195
            ListTile(
196
              leading: Icon(Icons.logout),
197
              title: Text('로그아웃'),
198
              onTap: () {
199
                appState.logout();
200
                Navigator.pop(context);
201
              },
202
            )
203
          else
204
            ListTile(
205
              leading: Icon(Icons.login),
206
              title: Text('로그인'),
207
              onTap: () {
208
                context.go('/login');
209
                Navigator.pop(context);
210
              },
211
            ),
212
        ],
213
      ),
214
    );
215
  }
216
}
217


218
// 로그인 화면
219
class LoginScreen extends StatelessWidget {
220
  final String redirectUrl;
221


222
  LoginScreen({required this.redirectUrl});
223


224
  @override
225
  Widget build(BuildContext context) {
226
    return Scaffold(
227
      appBar: AppBar(title: Text('로그인')),
228
      body: Center(
229
        child: Column(
230
          mainAxisAlignment: MainAxisAlignment.center,
231
          children: [
232
            Text('로그인 화면'),
233
            SizedBox(height: 20),
234
            ElevatedButton(
235
              onPressed: () {
236
                appState.login();
237
                context.go(redirectUrl);
238
              },
239
              child: Text('로그인'),
240
            ),
241
          ],
242
        ),
243
      ),
244
    );
245
  }
246
}
247


248
// 상품 상세 화면
249
class ProductDetailScreen extends StatelessWidget {
250
  final String productId;
251


252
  ProductDetailScreen({required this.productId});
253


254
  @override
255
  Widget build(BuildContext context) {
256
    return Scaffold(
257
      appBar: AppBar(title: Text('상품 상세')),
258
      body: Center(
259
        child: Column(
260
          mainAxisAlignment: MainAxisAlignment.center,
261
          children: [
262
            Text('상품 ID: $productId의 상세 정보'),
263
            SizedBox(height: 20),
264
            ElevatedButton(
265
              onPressed: () => context.go('/'),
266
              child: Text('홈으로 돌아가기'),
267
            ),
268
          ],
269
        ),
270
      ),
271
    );
272
  }
273
}
274


275
// 프로필 화면
276
class ProfileScreen extends StatelessWidget {
277
  @override
278
  Widget build(BuildContext context) {
279
    return Scaffold(
280
      appBar: AppBar(title: Text('프로필')),
281
      body: Center(
282
        child: Column(
283
          mainAxisAlignment: MainAxisAlignment.center,
284
          children: [
285
            Text('프로필 화면'),
286
            SizedBox(height: 20),
287
            ElevatedButton(
288
              onPressed: () => context.go('/profile/edit'),
289
              child: Text('프로필 수정'),
290
            ),
291
            SizedBox(height: 10),
292
            ElevatedButton(
293
              onPressed: () => context.go('/profile/orders'),
294
              child: Text('주문 내역'),
295
            ),
296
          ],
297
        ),
298
      ),
299
    );
300
  }
301
}
302


303
// 프로필 수정 화면
304
class EditProfileScreen extends StatelessWidget {
305
  @override
306
  Widget build(BuildContext context) {
307
    return Scaffold(
308
      appBar: AppBar(title: Text('프로필 수정')),
309
      body: Center(
310
        child: Column(
311
          mainAxisAlignment: MainAxisAlignment.center,
312
          children: [
313
            Text('프로필 수정 화면'),
314
            SizedBox(height: 20),
315
            ElevatedButton(
316
              onPressed: () => context.pop(),
317
              child: Text('뒤로 가기'),
318
            ),
319
          ],
320
        ),
321
      ),
322
    );
323
  }
324
}
325


326
// 주문 내역 화면
327
class OrderHistoryScreen extends StatelessWidget {
328
  @override
329
  Widget build(BuildContext context) {
330
    return Scaffold(
331
      appBar: AppBar(title: Text('주문 내역')),
332
      body: Center(
333
        child: Column(
334
          mainAxisAlignment: MainAxisAlignment.center,
335
          children: [
336
            Text('주문 내역 화면'),
337
            SizedBox(height: 20),
338
            ElevatedButton(
339
              onPressed: () => context.pop(),
340
              child: Text('뒤로 가기'),
341
            ),
342
          ],
343
        ),
344
      ),
345
    );
346
  }
347
}
348


349
// 설정 화면
350
class SettingsScreen extends StatelessWidget {
351
  @override
352
  Widget build(BuildContext context) {
353
    return Scaffold(
354
      appBar: AppBar(title: Text('설정')),
355
      body: Center(
356
        child: Column(
357
          mainAxisAlignment: MainAxisAlignment.center,
358
          children: [
359
            Text('설정 화면'),
360
            SizedBox(height: 20),
361
            ElevatedButton(
362
              onPressed: () => context.go('/'),
363
              child: Text('홈으로 돌아가기'),
364
            ),
365
          ],
366
        ),
367
      ),
368
    );
369
  }
370
}
371


372
// 404 화면
373
class NotFoundScreen extends StatelessWidget {
374
  @override
375
  Widget build(BuildContext context) {
376
    return Scaffold(
377
      appBar: AppBar(title: Text('페이지를 찾을 수 없음')),
378
      body: Center(
379
        child: Column(
380
          mainAxisAlignment: MainAxisAlignment.center,
381
          children: [
382
            Text('404 - 페이지를 찾을 수 없습니다'),
383
            SizedBox(height: 20),
384
            ElevatedButton(
385
              onPressed: () => context.go('/'),
386
              child: Text('홈으로 돌아가기'),
387
            ),
388
          ],
389
        ),
390
      ),
391
    );
392
  }
393
}
```

## go\_router 베스트 프랙티스

[Section titled “go\_router 베스트 프랙티스”](#go_router-베스트-프랙티스)

### 1. 라우터 설정 분리

[Section titled “1. 라우터 설정 분리”](#1-라우터-설정-분리)

라우터 설정을 별도의 파일로 분리하여 코드를 구조화하세요:

router\_config.dart

```dart
1
final GoRouter router = GoRouter(
2
  routes: [
3
    // 라우트 정의
4
  ],
5
);
6


7
// main.dart
8
import 'router_config.dart';
9


10
class MyApp extends StatelessWidget {
11
  @override
12
  Widget build(BuildContext context) {
13
    return MaterialApp.router(
14
      routerConfig: router,
15
      // ...
16
    );
17
  }
18
}
```

### 2. 경로 상수 사용

[Section titled “2. 경로 상수 사용”](#2-경로-상수-사용)

문자열 경로 대신 상수를 사용하여 오타를 방지하세요:

route\_paths.dart

```dart
1
abstract class RoutePaths {
2
  static const home = '/';
3
  static const login = '/login';
4
  static const product = '/product/:id';
5
  static const productDetails = '/product/';
6
  static const profile = '/profile';
7
  static const settings = '/settings';
8
}
9


10
// 사용 예시
11
context.go(RoutePaths.productDetails + productId);
```

### 3. 매개변수 타입 검증

[Section titled “3. 매개변수 타입 검증”](#3-매개변수-타입-검증)

경로 매개변수의 타입을 검증하여 잘못된 데이터로 인한 오류를 방지하세요:

```dart
1
GoRoute(
2
  path: '/product/:id',
3
  builder: (context, state) {
4
    // 숫자 ID 검증
5
    final idStr = state.pathParameters['id']!;
6
    final id = int.tryParse(idStr);
7


8
    if (id == null) {
9
      // 잘못된 ID 형식
10
      return InvalidProductScreen(id: idStr);
11
    }
12


13
    return ProductDetailScreen(id: id);
14
  },
15
),
```

### 4. 로깅 및 디버깅

[Section titled “4. 로깅 및 디버깅”](#4-로깅-및-디버깅)

go\_router의 디버그 모드를 활성화하여 라우팅 문제를 디버깅하세요:

```dart
1
final GoRouter _router = GoRouter(
2
  debugLogDiagnostics: true, // 라우팅 디버그 로그 활성화
3
  routes: [...],
4
);
```

## go\_router vs 다른 라우팅 라이브러리

[Section titled “go\_router vs 다른 라우팅 라이브러리”](#go_router-vs-다른-라우팅-라이브러리)

go\_router는 다른 Flutter 라우팅 라이브러리에 비해 몇 가지 장점이 있습니다:

### 1. go\_router vs Navigator 2.0 직접 사용

[Section titled “1. go\_router vs Navigator 2.0 직접 사용”](#1-go_router-vs-navigator-20-직접-사용)

* **go\_router**: 간결한 API, 적은 보일러플레이트 코드, 더 직관적인 사용법
* **Navigator 2.0**: 더 많은 유연성, 더 많은 보일러플레이트 코드 필요

### 2. go\_router vs auto\_route

[Section titled “2. go\_router vs auto\_route”](#2-go_router-vs-auto_route)

* **go\_router**: 공식 지원, 간단한 설정, 코드 생성 불필요
* **auto\_route**: 코드 생성 기반, 타입 안전성, 더 많은 설정 필요

## 요약

[Section titled “요약”](#요약)

* **go\_router**는 Flutter 팀이 공식 지원하는 네비게이션 라이브러리로, Navigator 2.0의 기능을 더 쉽게 사용할 수 있게 해줍니다.
* **선언적 라우팅**을 통해 앱의 모든 경로를 한 곳에서 정의할 수 있습니다.
* **중첩 라우팅**, **리다이렉트**, **오류 처리**, **애니메이션** 등 고급 기능을 제공합니다.
* **경로 매개변수**와 **쿼리 매개변수**를 통해 데이터를 쉽게 전달할 수 있습니다.
* **context.go()**, **context.push()** 등의 직관적인 메서드로 화면 간 이동이 가능합니다.
* **StatefulShellRoute**를 사용하여 바텀 네비게이션 바와 같은 탭 기반 UI를 쉽게 구현할 수 있습니다.

go\_router는 대부분의 Flutter 앱에서 권장되는 라우팅 솔루션으로, 간단한 앱부터 복잡한 앱까지 효과적으로 네비게이션 관리를 할 수 있게 해줍니다. 다음 섹션에서는 go\_router의 고급 기능인 라우트 가드, ShellRoute, 딥 링크 처리에 대해 더 자세히 알아보겠습니다.

# 실습. 복수 화면 전환

이 장에서는 go\_router를 사용하여 복수 화면 전환을 구현하는 실습을 진행하겠습니다. 구체적으로는 할 일 관리 앱(Todo App)을 만들면서, 여러 화면 간의 네비게이션과 데이터 전달 방법을 익혀보겠습니다.

## 실습 개요

[Section titled “실습 개요”](#실습-개요)

우리가 만들 할 일 관리 앱은 다음과 같은 화면들로 구성됩니다:

1. **홈 화면**: 할 일 목록 표시 및 카테고리별 필터링
2. **할 일 상세 화면**: 선택한 할 일의 세부 정보 표시
3. **할 일 추가/편집 화면**: 새 할 일 추가 또는 기존 할 일 편집
4. **프로필 화면**: 사용자 정보 및 설정
5. **통계 화면**: 할 일 완료율 등 통계 정보

## 1. 프로젝트 설정

[Section titled “1. 프로젝트 설정”](#1-프로젝트-설정)

먼저 새 Flutter 프로젝트를 생성하고 필요한 패키지를 추가합니다:

```bash
1
flutter create todo_app
2
cd todo_app
```

`pubspec.yaml` 파일에 필요한 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  go_router: ^15.1.2
5
  provider: ^6.0.5
6
  uuid: ^3.0.7
```

패키지를 설치합니다:

```bash
1
flutter pub get
```

## 2. 모델 정의

[Section titled “2. 모델 정의”](#2-모델-정의)

할 일 항목을 표현하는 모델 클래스를 정의합니다:

lib/models/todo.dart

```dart
1
import 'package:uuid/uuid.dart';
2


3
class Todo {
4
  final String id;
5
  final String title;
6
  final String description;
7
  final bool isCompleted;
8
  final DateTime createdAt;
9
  final String category;
10


11
  Todo({
12
    String? id,
13
    required this.title,
14
    this.description = '',
15
    this.isCompleted = false,
16
    DateTime? createdAt,
17
    this.category = 'general',
18
  })  : id = id ?? const Uuid().v4(),
19
        createdAt = createdAt ?? DateTime.now();
20


21
  Todo copyWith({
22
    String? title,
23
    String? description,
24
    bool? isCompleted,
25
    String? category,
26
  }) {
27
    return Todo(
28
      id: id,
29
      title: title ?? this.title,
30
      description: description ?? this.description,
31
      isCompleted: isCompleted ?? this.isCompleted,
32
      createdAt: createdAt,
33
      category: category ?? this.category,
34
    );
35
  }
36
}
```

## 3. 상태 관리

[Section titled “3. 상태 관리”](#3-상태-관리)

Provider를 사용하여 할 일 목록 상태를 관리합니다:

lib/providers/todo\_provider.dart

```dart
1
import 'package:flutter/foundation.dart';
2
import '../models/todo.dart';
3


4
class TodoProvider extends ChangeNotifier {
5
  final List<Todo> _todos = [];
6
  String _filter = 'all';
7
  final List<String> _categories = ['general', 'work', 'personal', 'shopping'];
8


9
  // 게터
10
  List<Todo> get todos => _filter == 'all'
11
      ? _todos
12
      : _filter == 'completed'
13
          ? _todos.where((todo) => todo.isCompleted).toList()
14
          : _filter == 'active'
15
              ? _todos.where((todo) => !todo.isCompleted).toList()
16
              : _todos
17
                  .where((todo) => todo.category == _filter)
18
                  .toList();
19


20
  List<String> get categories => _categories;
21
  String get filter => _filter;
22


23
  // 필터 설정
24
  void setFilter(String filter) {
25
    _filter = filter;
26
    notifyListeners();
27
  }
28


29
  // 할 일 추가
30
  void addTodo(Todo todo) {
31
    _todos.add(todo);
32
    notifyListeners();
33
  }
34


35
  // 할 일 업데이트
36
  void updateTodo(Todo todo) {
37
    final index = _todos.indexWhere((t) => t.id == todo.id);
38
    if (index >= 0) {
39
      _todos[index] = todo;
40
      notifyListeners();
41
    }
42
  }
43


44
  // 할 일 삭제
45
  void deleteTodo(String id) {
46
    _todos.removeWhere((todo) => todo.id == id);
47
    notifyListeners();
48
  }
49


50
  // 할 일 토글 (완료/미완료)
51
  void toggleTodo(String id) {
52
    final index = _todos.indexWhere((todo) => todo.id == id);
53
    if (index >= 0) {
54
      final todo = _todos[index];
55
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
56
      notifyListeners();
57
    }
58
  }
59


60
  // ID로 할 일 찾기
61
  Todo? getTodoById(String id) {
62
    try {
63
      return _todos.firstWhere((todo) => todo.id == id);
64
    } catch (e) {
65
      return null;
66
    }
67
  }
68
}
```

## 4. 라우터 설정

[Section titled “4. 라우터 설정”](#4-라우터-설정)

go\_router를 사용하여 앱의 라우팅을 설정합니다:

lib/router/app\_router.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:go_router/go_router.dart';
3
import 'package:provider/provider.dart';
4


5
import '../providers/todo_provider.dart';
6
import '../screens/home_screen.dart';
7
import '../screens/todo_detail_screen.dart';
8
import '../screens/todo_edit_screen.dart';
9
import '../screens/profile_screen.dart';
10
import '../screens/stats_screen.dart';
11


12
class AppRouter {
13
  final TodoProvider todoProvider;
14


15
  AppRouter(this.todoProvider);
16


17
  late final GoRouter router = GoRouter(
18
    initialLocation: '/',
19
    debugLogDiagnostics: true,
20
    routes: [
21
      // 메인 쉘 라우트 (바텀 네비게이션 바 포함)
22
      StatefulShellRoute.indexedStack(
23
        builder: (context, state, navigationShell) {
24
          return ScaffoldWithNavBar(navigationShell: navigationShell);
25
        },
26
        branches: [
27
          // 홈 탭
28
          StatefulShellBranch(
29
            routes: [
30
              GoRoute(
31
                path: '/',
32
                builder: (context, state) => const HomeScreen(),
33
                routes: [
34
                  // 할 일 상세 화면 (홈 탭 내 중첩 라우트)
35
                  GoRoute(
36
                    path: 'todo/:id',
37
                    builder: (context, state) {
38
                      final id = state.pathParameters['id']!;
39
                      return TodoDetailScreen(todoId: id);
40
                    },
41
                  ),
42
                  // 할 일 추가 화면
43
                  GoRoute(
44
                    path: 'add',
45
                    builder: (context, state) => const TodoEditScreen(),
46
                  ),
47
                  // 할 일 편집 화면
48
                  GoRoute(
49
                    path: 'edit/:id',
50
                    builder: (context, state) {
51
                      final id = state.pathParameters['id']!;
52
                      final todo = todoProvider.getTodoById(id);
53
                      return TodoEditScreen(todo: todo);
54
                    },
55
                  ),
56
                ],
57
              ),
58
            ],
59
          ),
60
          // 통계 탭
61
          StatefulShellBranch(
62
            routes: [
63
              GoRoute(
64
                path: '/stats',
65
                builder: (context, state) => const StatsScreen(),
66
              ),
67
            ],
68
          ),
69
          // 프로필 탭
70
          StatefulShellBranch(
71
            routes: [
72
              GoRoute(
73
                path: '/profile',
74
                builder: (context, state) => const ProfileScreen(),
75
              ),
76
            ],
77
          ),
78
        ],
79
      ),
80
    ],
81
    errorBuilder: (context, state) => Scaffold(
82
      appBar: AppBar(title: const Text('페이지를 찾을 수 없음')),
83
      body: Center(
84
        child: Column(
85
          mainAxisAlignment: MainAxisAlignment.center,
86
          children: [
87
            const Text('요청한 페이지를 찾을 수 없습니다.'),
88
            const SizedBox(height: 20),
89
            ElevatedButton(
90
              onPressed: () => context.go('/'),
91
              child: const Text('홈으로 돌아가기'),
92
            ),
93
          ],
94
        ),
95
      ),
96
    ),
97
  );
98
}
99


100
// 바텀 네비게이션 바가 있는 스캐폴드
101
class ScaffoldWithNavBar extends StatelessWidget {
102
  final StatefulNavigationShell navigationShell;
103


104
  const ScaffoldWithNavBar({
105
    Key? key,
106
    required this.navigationShell,
107
  }) : super(key: key);
108


109
  @override
110
  Widget build(BuildContext context) {
111
    return Scaffold(
112
      body: navigationShell,
113
      bottomNavigationBar: BottomNavigationBar(
114
        currentIndex: navigationShell.currentIndex,
115
        items: const [
116
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
117
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
118
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
119
        ],
120
        onTap: (index) => navigationShell.goBranch(index),
121
      ),
122
    );
123
  }
124
}
```

## 5. 화면 구현

[Section titled “5. 화면 구현”](#5-화면-구현)

이제 각 화면을 구현해 보겠습니다:

### 5.1 홈 화면

[Section titled “5.1 홈 화면”](#51-홈-화면)

lib/screens/home\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:go_router/go_router.dart';
3
import 'package:provider/provider.dart';
4


5
import '../providers/todo_provider.dart';
6
import '../widgets/todo_item.dart';
7


8
class HomeScreen extends StatelessWidget {
9
  const HomeScreen({Key? key}) : super(key: key);
10


11
  @override
12
  Widget build(BuildContext context) {
13
    final todoProvider = Provider.of<TodoProvider>(context);
14
    final todos = todoProvider.todos;
15
    final categories = todoProvider.categories;
16


17
    return Scaffold(
18
      appBar: AppBar(
19
        title: const Text('할 일 목록'),
20
        actions: [
21
          // 필터 메뉴
22
          PopupMenuButton<String>(
23
            icon: const Icon(Icons.filter_list),
24
            onSelected: (value) {
25
              todoProvider.setFilter(value);
26
            },
27
            itemBuilder: (context) => [
28
              const PopupMenuItem(
29
                value: 'all',
30
                child: Text('모든 할 일'),
31
              ),
32
              const PopupMenuItem(
33
                value: 'completed',
34
                child: Text('완료된 할 일'),
35
              ),
36
              const PopupMenuItem(
37
                value: 'active',
38
                child: Text('미완료 할 일'),
39
              ),
40
              const PopupMenuItem(
41
                value: 'general',
42
                child: Text('일반'),
43
              ),
44
              const PopupMenuItem(
45
                value: 'work',
46
                child: Text('업무'),
47
              ),
48
              const PopupMenuItem(
49
                value: 'personal',
50
                child: Text('개인'),
51
              ),
52
              const PopupMenuItem(
53
                value: 'shopping',
54
                child: Text('쇼핑'),
55
              ),
56
            ],
57
          ),
58
        ],
59
      ),
60
      body: todos.isEmpty
61
          ? const Center(
62
              child: Text('할 일이 없습니다. 새 할 일을 추가해보세요!'),
63
            )
64
          : ListView.builder(
65
              itemCount: todos.length,
66
              itemBuilder: (context, index) {
67
                final todo = todos[index];
68
                return TodoItem(
69
                  todo: todo,
70
                  onTap: () => context.go('/todo/${todo.id}'),
71
                  onToggle: () => todoProvider.toggleTodo(todo.id),
72
                );
73
              },
74
            ),
75
      floatingActionButton: FloatingActionButton(
76
        onPressed: () => context.go('/add'),
77
        child: const Icon(Icons.add),
78
      ),
79
    );
80
  }
81
}
```

### 5.2 할 일 항목 위젯

[Section titled “5.2 할 일 항목 위젯”](#52-할-일-항목-위젯)

lib/widgets/todo\_item.dart

```dart
1
import 'package:flutter/material.dart';
2
import '../models/todo.dart';
3


4
class TodoItem extends StatelessWidget {
5
  final Todo todo;
6
  final VoidCallback onTap;
7
  final VoidCallback onToggle;
8


9
  const TodoItem({
10
    Key? key,
11
    required this.todo,
12
    required this.onTap,
13
    required this.onToggle,
14
  }) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    return ListTile(
19
      title: Text(
20
        todo.title,
21
        style: TextStyle(
22
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
23
          color: todo.isCompleted ? Colors.grey : null,
24
        ),
25
      ),
26
      subtitle: Text(
27
        '카테고리: ${todo.category}',
28
        style: TextStyle(
29
          color: todo.isCompleted ? Colors.grey : Colors.black54,
30
        ),
31
      ),
32
      leading: Checkbox(
33
        value: todo.isCompleted,
34
        onChanged: (_) => onToggle(),
35
      ),
36
      trailing: const Icon(Icons.chevron_right),
37
      onTap: onTap,
38
    );
39
  }
40
}
```

### 5.3 할 일 상세 화면

[Section titled “5.3 할 일 상세 화면”](#53-할-일-상세-화면)

lib/screens/todo\_detail\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:go_router/go_router.dart';
3
import 'package:provider/provider.dart';
4


5
import '../providers/todo_provider.dart';
6
import '../models/todo.dart';
7


8
class TodoDetailScreen extends StatelessWidget {
9
  final String todoId;
10


11
  const TodoDetailScreen({
12
    Key? key,
13
    required this.todoId,
14
  }) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    final todoProvider = Provider.of<TodoProvider>(context);
19
    final todo = todoProvider.getTodoById(todoId);
20


21
    if (todo == null) {
22
      return Scaffold(
23
        appBar: AppBar(title: const Text('할 일 없음')),
24
        body: Center(
25
          child: Column(
26
            mainAxisAlignment: MainAxisAlignment.center,
27
            children: [
28
              const Text('요청한 할 일을 찾을 수 없습니다.'),
29
              const SizedBox(height: 20),
30
              ElevatedButton(
31
                onPressed: () => context.go('/'),
32
                child: const Text('홈으로 돌아가기'),
33
              ),
34
            ],
35
          ),
36
        ),
37
      );
38
    }
39


40
    return Scaffold(
41
      appBar: AppBar(
42
        title: const Text('할 일 상세'),
43
        actions: [
44
          // 편집 버튼
45
          IconButton(
46
            icon: const Icon(Icons.edit),
47
            onPressed: () => context.go('/edit/${todo.id}'),
48
          ),
49
          // 삭제 버튼
50
          IconButton(
51
            icon: const Icon(Icons.delete),
52
            onPressed: () {
53
              todoProvider.deleteTodo(todo.id);
54
              context.go('/');
55
            },
56
          ),
57
        ],
58
      ),
59
      body: SingleChildScrollView(
60
        padding: const EdgeInsets.all(16.0),
61
        child: Column(
62
          crossAxisAlignment: CrossAxisAlignment.start,
63
          children: [
64
            // 제목
65
            Text(
66
              todo.title,
67
              style: Theme.of(context).textTheme.headlineSmall,
68
            ),
69
            const SizedBox(height: 8),
70


71
            // 카테고리
72
            Chip(
73
              label: Text(todo.category),
74
              backgroundColor: Colors.blue.shade100,
75
            ),
76
            const SizedBox(height: 16),
77


78
            // 생성 날짜
79
            Text(
80
              '생성일: ${_formatDate(todo.createdAt)}',
81
              style: Theme.of(context).textTheme.bodySmall,
82
            ),
83
            const SizedBox(height: 16),
84


85
            // 상태
86
            Row(
87
              children: [
88
                const Text('상태: '),
89
                Checkbox(
90
                  value: todo.isCompleted,
91
                  onChanged: (_) {
92
                    todoProvider.toggleTodo(todo.id);
93
                  },
94
                ),
95
                Text(todo.isCompleted ? '완료' : '미완료'),
96
              ],
97
            ),
98
            const SizedBox(height: 16),
99


100
            // 설명
101
            const Text(
102
              '설명:',
103
              style: TextStyle(fontWeight: FontWeight.bold),
104
            ),
105
            const SizedBox(height: 8),
106
            Container(
107
              width: double.infinity,
108
              padding: const EdgeInsets.all(16),
109
              decoration: BoxDecoration(
110
                border: Border.all(color: Colors.grey.shade300),
111
                borderRadius: BorderRadius.circular(8),
112
              ),
113
              child: Text(
114
                todo.description.isEmpty ? '(설명 없음)' : todo.description,
115
              ),
116
            ),
117
          ],
118
        ),
119
      ),
120
    );
121
  }
122


123
  String _formatDate(DateTime date) {
124
    return '${date.year}년 ${date.month}월 ${date.day}일';
125
  }
126
}
```

### 5.4 할 일 추가/편집 화면

[Section titled “5.4 할 일 추가/편집 화면”](#54-할-일-추가편집-화면)

lib/screens/todo\_edit\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:go_router/go_router.dart';
3
import 'package:provider/provider.dart';
4


5
import '../models/todo.dart';
6
import '../providers/todo_provider.dart';
7


8
class TodoEditScreen extends StatefulWidget {
9
  final Todo? todo;
10


11
  const TodoEditScreen({Key? key, this.todo}) : super(key: key);
12


13
  @override
14
  _TodoEditScreenState createState() => _TodoEditScreenState();
15
}
16


17
class _TodoEditScreenState extends State<TodoEditScreen> {
18
  final _formKey = GlobalKey<FormState>();
19
  late TextEditingController _titleController;
20
  late TextEditingController _descriptionController;
21
  String _category = 'general';
22
  bool _isCompleted = false;
23


24
  @override
25
  void initState() {
26
    super.initState();
27
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
28
    _descriptionController = TextEditingController(text: widget.todo?.description ?? '');
29
    _category = widget.todo?.category ?? 'general';
30
    _isCompleted = widget.todo?.isCompleted ?? false;
31
  }
32


33
  @override
34
  void dispose() {
35
    _titleController.dispose();
36
    _descriptionController.dispose();
37
    super.dispose();
38
  }
39


40
  void _saveTodo() {
41
    if (_formKey.currentState!.validate()) {
42
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
43


44
      if (widget.todo == null) {
45
        // 새 할 일 추가
46
        final newTodo = Todo(
47
          title: _titleController.text,
48
          description: _descriptionController.text,
49
          category: _category,
50
          isCompleted: _isCompleted,
51
        );
52
        todoProvider.addTodo(newTodo);
53
      } else {
54
        // 기존 할 일 수정
55
        final updatedTodo = Todo(
56
          id: widget.todo!.id,
57
          title: _titleController.text,
58
          description: _descriptionController.text,
59
          category: _category,
60
          isCompleted: _isCompleted,
61
          createdAt: widget.todo!.createdAt,
62
        );
63
        todoProvider.updateTodo(updatedTodo);
64
      }
65


66
      context.go('/');
67
    }
68
  }
69


70
  @override
71
  Widget build(BuildContext context) {
72
    final todoProvider = Provider.of<TodoProvider>(context);
73
    final categories = todoProvider.categories;
74


75
    return Scaffold(
76
      appBar: AppBar(
77
        title: Text(widget.todo == null ? '할 일 추가' : '할 일 편집'),
78
      ),
79
      body: Form(
80
        key: _formKey,
81
        child: SingleChildScrollView(
82
          padding: const EdgeInsets.all(16.0),
83
          child: Column(
84
            crossAxisAlignment: CrossAxisAlignment.start,
85
            children: [
86
              // 제목 입력
87
              TextFormField(
88
                controller: _titleController,
89
                decoration: const InputDecoration(
90
                  labelText: '제목',
91
                  border: OutlineInputBorder(),
92
                ),
93
                validator: (value) {
94
                  if (value == null || value.isEmpty) {
95
                    return '제목을 입력해주세요';
96
                  }
97
                  return null;
98
                },
99
              ),
100
              const SizedBox(height: 16),
101


102
              // 설명 입력
103
              TextFormField(
104
                controller: _descriptionController,
105
                decoration: const InputDecoration(
106
                  labelText: '설명',
107
                  border: OutlineInputBorder(),
108
                ),
109
                maxLines: 3,
110
              ),
111
              const SizedBox(height: 16),
112


113
              // 카테고리 선택
114
              DropdownButtonFormField<String>(
115
                value: _category,
116
                decoration: const InputDecoration(
117
                  labelText: '카테고리',
118
                  border: OutlineInputBorder(),
119
                ),
120
                items: categories.map((category) {
121
                  return DropdownMenuItem(
122
                    value: category,
123
                    child: Text(category),
124
                  );
125
                }).toList(),
126
                onChanged: (value) {
127
                  setState(() {
128
                    _category = value!;
129
                  });
130
                },
131
              ),
132
              const SizedBox(height: 16),
133


134
              // 완료 상태 토글
135
              CheckboxListTile(
136
                title: const Text('완료 상태'),
137
                value: _isCompleted,
138
                onChanged: (value) {
139
                  setState(() {
140
                    _isCompleted = value!;
141
                  });
142
                },
143
                controlAffinity: ListTileControlAffinity.leading,
144
              ),
145
              const SizedBox(height: 32),
146


147
              // 저장 버튼
148
              SizedBox(
149
                width: double.infinity,
150
                child: ElevatedButton(
151
                  onPressed: _saveTodo,
152
                  style: ElevatedButton.styleFrom(
153
                    padding: const EdgeInsets.symmetric(vertical: 16),
154
                  ),
155
                  child: Text(
156
                    widget.todo == null ? '추가하기' : '수정하기',
157
                    style: const TextStyle(fontSize: 16),
158
                  ),
159
                ),
160
              ),
161
            ],
162
          ),
163
        ),
164
      ),
165
    );
166
  }
167
}
```

### 5.5 통계 화면

[Section titled “5.5 통계 화면”](#55-통계-화면)

lib/screens/stats\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:provider/provider.dart';
3


4
import '../providers/todo_provider.dart';
5


6
class StatsScreen extends StatelessWidget {
7
  const StatsScreen({Key? key}) : super(key: key);
8


9
  @override
10
  Widget build(BuildContext context) {
11
    final todoProvider = Provider.of<TodoProvider>(context);
12
    final todos = todoProvider.todos;
13
    final completedTodos = todos.where((todo) => todo.isCompleted).toList();
14


15
    final completionRate = todos.isEmpty
16
        ? 0.0
17
        : (completedTodos.length / todos.length) * 100;
18


19
    // 카테고리별 할 일 수
20
    final categoryStats = <String, int>{};
21
    for (final category in todoProvider.categories) {
22
      categoryStats[category] = todos
23
          .where((todo) => todo.category == category)
24
          .length;
25
    }
26


27
    return Scaffold(
28
      appBar: AppBar(title: const Text('통계')),
29
      body: Padding(
30
        padding: const EdgeInsets.all(16.0),
31
        child: Column(
32
          crossAxisAlignment: CrossAxisAlignment.start,
33
          children: [
34
            // 총계
35
            Card(
36
              child: Padding(
37
                padding: const EdgeInsets.all(16.0),
38
                child: Column(
39
                  crossAxisAlignment: CrossAxisAlignment.start,
40
                  children: [
41
                    Text(
42
                      '전체 요약',
43
                      style: Theme.of(context).textTheme.titleLarge,
44
                    ),
45
                    const Divider(),
46
                    _buildStatItem('전체 할 일', todos.length.toString()),
47
                    _buildStatItem('완료된 할 일', completedTodos.length.toString()),
48
                    _buildStatItem('진행 중인 할 일',
49
                        (todos.length - completedTodos.length).toString()),
50
                    _buildStatItem('완료율', '${completionRate.toStringAsFixed(1)}%'),
51
                  ],
52
                ),
53
              ),
54
            ),
55
            const SizedBox(height: 20),
56


57
            // 카테고리별 통계
58
            Text(
59
              '카테고리별 통계',
60
              style: Theme.of(context).textTheme.titleLarge,
61
            ),
62
            const SizedBox(height: 8),
63
            Expanded(
64
              child: ListView.builder(
65
                itemCount: categoryStats.length,
66
                itemBuilder: (context, index) {
67
                  final category = todoProvider.categories[index];
68
                  final count = categoryStats[category] ?? 0;
69
                  return Card(
70
                    child: ListTile(
71
                      title: Text(category),
72
                      trailing: Text(
73
                        count.toString(),
74
                        style: Theme.of(context).textTheme.titleMedium,
75
                      ),
76
                    ),
77
                  );
78
                },
79
              ),
80
            ),
81
          ],
82
        ),
83
      ),
84
    );
85
  }
86


87
  Widget _buildStatItem(String label, String value) {
88
    return Padding(
89
      padding: const EdgeInsets.symmetric(vertical: 8.0),
90
      child: Row(
91
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
92
        children: [
93
          Text(label),
94
          Text(
95
            value,
96
            style: const TextStyle(fontWeight: FontWeight.bold),
97
          ),
98
        ],
99
      ),
100
    );
101
  }
102
}
```

### 5.6 프로필 화면

[Section titled “5.6 프로필 화면”](#56-프로필-화면)

lib/screens/profile\_screen.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:provider/provider.dart';
3


4
import '../providers/todo_provider.dart';
5


6
class ProfileScreen extends StatelessWidget {
7
  const ProfileScreen({Key? key}) : super(key: key);
8


9
  @override
10
  Widget build(BuildContext context) {
11
    final todoProvider = Provider.of<TodoProvider>(context);
12


13
    return Scaffold(
14
      appBar: AppBar(title: const Text('프로필')),
15
      body: Padding(
16
        padding: const EdgeInsets.all(16.0),
17
        child: Column(
18
          crossAxisAlignment: CrossAxisAlignment.center,
19
          children: [
20
            const CircleAvatar(
21
              radius: 50,
22
              child: Icon(Icons.person, size: 50),
23
            ),
24
            const SizedBox(height: 16),
25
            const Text(
26
              '사용자',
27
              style: TextStyle(
28
                fontSize: 24,
29
                fontWeight: FontWeight.bold,
30
              ),
31
            ),
32
            const SizedBox(height: 8),
33
            const Text('user@example.com'),
34
            const SizedBox(height: 32),
35


36
            // 사용 통계
37
            const Text(
38
              '사용 통계',
39
              style: TextStyle(
40
                fontSize: 18,
41
                fontWeight: FontWeight.bold,
42
              ),
43
            ),
44
            const SizedBox(height: 16),
45
            _buildStatItem(context, '총 할 일 수',
46
                todoProvider.todos.length.toString()),
47
            _buildStatItem(context, '완료한 할 일',
48
                todoProvider.todos.where((todo) => todo.isCompleted).length.toString()),
49


50
            const SizedBox(height: 32),
51


52
            // 설정 섹션
53
            const Text(
54
              '설정',
55
              style: TextStyle(
56
                fontSize: 18,
57
                fontWeight: FontWeight.bold,
58
              ),
59
            ),
60
            const SizedBox(height: 16),
61
            _buildSettingItem(
62
              context,
63
              Icons.notifications,
64
              '알림 설정',
65
              () => _showNotImplementedSnackBar(context),
66
            ),
67
            _buildSettingItem(
68
              context,
69
              Icons.color_lens,
70
              '테마 설정',
71
              () => _showNotImplementedSnackBar(context),
72
            ),
73
            _buildSettingItem(
74
              context,
75
              Icons.language,
76
              '언어 설정',
77
              () => _showNotImplementedSnackBar(context),
78
            ),
79
            _buildSettingItem(
80
              context,
81
              Icons.info,
82
              '앱 정보',
83
              () => _showNotImplementedSnackBar(context),
84
            ),
85
          ],
86
        ),
87
      ),
88
    );
89
  }
90


91
  Widget _buildStatItem(BuildContext context, String label, String value) {
92
    return Padding(
93
      padding: const EdgeInsets.symmetric(vertical: 8.0),
94
      child: Row(
95
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
96
        children: [
97
          Text(label),
98
          Text(
99
            value,
100
            style: const TextStyle(fontWeight: FontWeight.bold),
101
          ),
102
        ],
103
      ),
104
    );
105
  }
106


107
  Widget _buildSettingItem(
108
    BuildContext context,
109
    IconData icon,
110
    String label,
111
    VoidCallback onTap,
112
  ) {
113
    return ListTile(
114
      leading: Icon(icon),
115
      title: Text(label),
116
      trailing: const Icon(Icons.chevron_right),
117
      onTap: onTap,
118
    );
119
  }
120


121
  void _showNotImplementedSnackBar(BuildContext context) {
122
    ScaffoldMessenger.of(context).showSnackBar(
123
      const SnackBar(
124
        content: Text('이 기능은 아직 구현되지 않았습니다.'),
125
        duration: Duration(seconds: 2),
126
      ),
127
    );
128
  }
129
}
```

## 6. 메인 앱 통합

[Section titled “6. 메인 앱 통합”](#6-메인-앱-통합)

마지막으로 모든 구성 요소를 메인 앱에 통합합니다:

lib/main.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:provider/provider.dart';
3


4
import 'providers/todo_provider.dart';
5
import 'router/app_router.dart';
6


7
void main() {
8
  runApp(const MyApp());
9
}
10


11
class MyApp extends StatelessWidget {
12
  const MyApp({Key? key}) : super(key: key);
13


14
  @override
15
  Widget build(BuildContext context) {
16
    return ChangeNotifierProvider(
17
      create: (_) => TodoProvider(),
18
      child: Builder(
19
        builder: (context) {
20
          final todoProvider = Provider.of<TodoProvider>(context);
21
          final appRouter = AppRouter(todoProvider);
22


23
          return MaterialApp.router(
24
            title: '할 일 관리 앱',
25
            theme: ThemeData(
26
              primarySwatch: Colors.blue,
27
              useMaterial3: true,
28
            ),
29
            routerConfig: appRouter.router,
30
          );
31
        },
32
      ),
33
    );
34
  }
35
}
```

## 7. 실행 및 테스트

[Section titled “7. 실행 및 테스트”](#7-실행-및-테스트)

이제 앱을 실행하고 다양한 화면 전환 시나리오를 테스트해 봅시다:

1. 홈 화면에서 할 일 목록 확인
2. 새 할 일 추가
3. 할 일 상세 정보 확인
4. 할 일 편집
5. 할 일 삭제
6. 카테고리별 필터링
7. 바텀 네비게이션 바를 통한 화면 전환
8. 통계 화면에서 완료율 확인
9. 프로필 화면 확인

## 요약

[Section titled “요약”](#요약)

이 실습을 통해 우리는 다음과 같은 개념을 학습했습니다:

1. **go\_router를 사용한 라우팅 설정**: 다양한 경로와 매개변수를 정의하고 관리하는 방법
2. **StatefulShellRoute를 활용한 바텀 네비게이션 바**: 탭 기반 UI에서 네비게이션 상태를 유지하는 방법
3. **화면 간 데이터 전달**: 경로 매개변수와 상태 관리를 통한 데이터 전달 방법
4. **중첩 라우트**: 탭 내부에서 다른 화면으로 이동하는 방법
5. **Provider와 함께 사용**: 상태 관리와 라우팅을 통합하는 방법

이러한 기술을 활용하면 복잡한 네비게이션 패턴을 가진 앱도 효과적으로 구현할 수 있습니다. 다음 섹션에서는 Drawer, BottomNavigationBar, TabBar와 같은 다양한 네비게이션 위젯에 대해 알아보겠습니다.

# Drawer, BottomNavigationBar, TabBar

Flutter에서는 사용자 경험을 개선하기 위한 다양한 네비게이션 위젯을 제공합니다. 이 장에서는 가장 널리 사용되는 세 가지 네비게이션 패턴인 Drawer, BottomNavigationBar, TabBar에 대해 자세히 알아보고, go\_router와 함께 이들을 효과적으로 구현하는 방법을 살펴보겠습니다.

## Drawer (내비게이션 서랍)

[Section titled “Drawer (내비게이션 서랍)”](#drawer-내비게이션-서랍)

Drawer는 화면 측면에서 슬라이드하여 나타나는 패널로, 앱의 주요 네비게이션 옵션을 제공합니다. 일반적으로 햄버거 메뉴 아이콘(☰)을 탭하여 열 수 있습니다.

### 기본 Drawer 구현

[Section titled “기본 Drawer 구현”](#기본-drawer-구현)

```dart
1
Scaffold(
2
  appBar: AppBar(
3
    title: Text('Drawer 예제'),
4
  ),
5
  drawer: Drawer(
6
    child: ListView(
7
      padding: EdgeInsets.zero,
8
      children: [
9
        // 드로어 헤더
10
        DrawerHeader(
11
          decoration: BoxDecoration(
12
            color: Colors.blue,
13
          ),
14
          child: Text(
15
            '앱 메뉴',
16
            style: TextStyle(
17
              color: Colors.white,
18
              fontSize: 24,
19
            ),
20
          ),
21
        ),
22
        // 드로어 항목들
23
        ListTile(
24
          leading: Icon(Icons.home),
25
          title: Text('홈'),
26
          onTap: () {
27
            // 드로어 닫기
28
            Navigator.pop(context);
29
            // 홈 화면으로 이동
30
            context.go('/');
31
          },
32
        ),
33
        ListTile(
34
          leading: Icon(Icons.category),
35
          title: Text('카테고리'),
36
          onTap: () {
37
            Navigator.pop(context);
38
            context.go('/categories');
39
          },
40
        ),
41
        ListTile(
42
          leading: Icon(Icons.favorite),
43
          title: Text('즐겨찾기'),
44
          onTap: () {
45
            Navigator.pop(context);
46
            context.go('/favorites');
47
          },
48
        ),
49
        Divider(),
50
        ListTile(
51
          leading: Icon(Icons.settings),
52
          title: Text('설정'),
53
          onTap: () {
54
            Navigator.pop(context);
55
            context.go('/settings');
56
          },
57
        ),
58
      ],
59
    ),
60
  ),
61
  body: Center(
62
    child: Text('Drawer를 보려면 화면 왼쪽 가장자리에서 스와이프하세요'),
63
  ),
64
)
```

### UserAccountsDrawerHeader 사용하기

[Section titled “UserAccountsDrawerHeader 사용하기”](#useraccountsdrawerheader-사용하기)

사용자 정보를 표시하기 위한 더 풍부한 드로어 헤더를 만들 수 있습니다:

```dart
1
UserAccountsDrawerHeader(
2
  accountName: Text('홍길동'),
3
  accountEmail: Text('hong@example.com'),
4
  currentAccountPicture: CircleAvatar(
5
    backgroundImage: NetworkImage('https://example.com/profile.jpg'),
6
    onBackgroundImageError: (_, __) {
7
      // 이미지 로드 오류 시 처리
8
    },
9
  ),
10
  otherAccountsPictures: [
11
    CircleAvatar(
12
      backgroundImage: NetworkImage('https://example.com/profile2.jpg'),
13
    ),
14
  ],
15
  decoration: BoxDecoration(
16
    color: Colors.blue,
17
    image: DecorationImage(
18
      image: AssetImage('assets/drawer_header_bg.jpg'),
19
      fit: BoxFit.cover,
20
    ),
21
  ),
22
)
```

### endDrawer 사용하기

[Section titled “endDrawer 사용하기”](#enddrawer-사용하기)

화면 오른쪽에서 나타나는 드로어를 사용할 수도 있습니다:

```dart
1
Scaffold(
2
  appBar: AppBar(
3
    title: Text('End Drawer 예제'),
4
    // 자동으로 endDrawer 아이콘 추가
5
  ),
6
  endDrawer: Drawer(
7
    child: // 드로어 내용...
8
  ),
9
  body: // 화면 내용...
10
)
```

### 다중 계층 Drawer 메뉴

[Section titled “다중 계층 Drawer 메뉴”](#다중-계층-drawer-메뉴)

중첩된 메뉴를 구현하기 위해 확장 가능한 드로어 항목을 만들 수 있습니다:

```dart
1
// 확장 가능한 드로어 항목
2
class ExpandableDrawerItem extends StatefulWidget {
3
  final IconData icon;
4
  final String title;
5
  final List<DrawerSubItem> subItems;
6


7
  const ExpandableDrawerItem({
8
    Key? key,
9
    required this.icon,
10
    required this.title,
11
    required this.subItems,
12
  }) : super(key: key);
13


14
  @override
15
  _ExpandableDrawerItemState createState() => _ExpandableDrawerItemState();
16
}
17


18
class _ExpandableDrawerItemState extends State<ExpandableDrawerItem> {
19
  bool _isExpanded = false;
20


21
  @override
22
  Widget build(BuildContext context) {
23
    return Column(
24
      children: [
25
        ListTile(
26
          leading: Icon(widget.icon),
27
          title: Text(widget.title),
28
          trailing: Icon(
29
            _isExpanded ? Icons.expand_less : Icons.expand_more,
30
          ),
31
          onTap: () {
32
            setState(() {
33
              _isExpanded = !_isExpanded;
34
            });
35
          },
36
        ),
37
        if (_isExpanded)
38
          ...widget.subItems.map((item) => item.build(context)).toList(),
39
      ],
40
    );
41
  }
42
}
43


44
// 서브 아이템
45
class DrawerSubItem {
46
  final IconData icon;
47
  final String title;
48
  final VoidCallback onTap;
49


50
  DrawerSubItem({
51
    required this.icon,
52
    required this.title,
53
    required this.onTap,
54
  });
55


56
  Widget build(BuildContext context) {
57
    return Padding(
58
      padding: EdgeInsets.only(left: 16.0),
59
      child: ListTile(
60
        leading: Icon(icon),
61
        title: Text(title),
62
        onTap: onTap,
63
      ),
64
    );
65
  }
66
}
```

### Drawer와 go\_router 통합

[Section titled “Drawer와 go\_router 통합”](#drawer와-go_router-통합)

go\_router에서 현재 라우트를 기반으로 활성 드로어 항목을 하이라이트할 수 있습니다:

```dart
1
// 동적으로 활성 상태를 설정하는 드로어 항목
2
class ActiveDrawerItem extends StatelessWidget {
3
  final IconData icon;
4
  final String title;
5
  final String routePath;
6
  final bool? isActive;
7


8
  const ActiveDrawerItem({
9
    Key? key,
10
    required this.icon,
11
    required this.title,
12
    required this.routePath,
13
    this.isActive,
14
  }) : super(key: key);
15


16
  @override
17
  Widget build(BuildContext context) {
18
    // 현재 라우트 경로 가져오기
19
    final currentRoute = GoRouterState.of(context).matchedLocation;
20


21
    // 현재 경로가 이 항목의 경로와 일치하는지 확인
22
    final isSelected = isActive ?? currentRoute.startsWith(routePath);
23


24
    return ListTile(
25
      leading: Icon(
26
        icon,
27
        color: isSelected ? Theme.of(context).primaryColor : null,
28
      ),
29
      title: Text(
30
        title,
31
        style: TextStyle(
32
          color: isSelected ? Theme.of(context).primaryColor : null,
33
          fontWeight: isSelected ? FontWeight.bold : null,
34
        ),
35
      ),
36
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
37
      onTap: () {
38
        Navigator.pop(context);
39
        if (!isSelected) {
40
          context.go(routePath);
41
        }
42
      },
43
    );
44
  }
45
}
```

## BottomNavigationBar (하단 내비게이션 바)

[Section titled “BottomNavigationBar (하단 내비게이션 바)”](#bottomnavigationbar-하단-내비게이션-바)

하단 내비게이션 바는 화면 하단에 고정된 메뉴를 제공하며, 앱의 주요 섹션 간 전환을 위해 사용됩니다.

### 기본 BottomNavigationBar 구현

[Section titled “기본 BottomNavigationBar 구현”](#기본-bottomnavigationbar-구현)

```dart
1
class BottomNavExample extends StatefulWidget {
2
  @override
3
  _BottomNavExampleState createState() => _BottomNavExampleState();
4
}
5


6
class _BottomNavExampleState extends State<BottomNavExample> {
7
  int _selectedIndex = 0;
8


9
  // 화면 목록
10
  static final List<Widget> _screens = [
11
    HomeScreen(),
12
    SearchScreen(),
13
    NotificationsScreen(),
14
    ProfileScreen(),
15
  ];
16


17
  void _onItemTapped(int index) {
18
    setState(() {
19
      _selectedIndex = index;
20
    });
21
  }
22


23
  @override
24
  Widget build(BuildContext context) {
25
    return Scaffold(
26
      appBar: AppBar(
27
        title: Text('Bottom Navigation 예제'),
28
      ),
29
      body: _screens[_selectedIndex],
30
      bottomNavigationBar: BottomNavigationBar(
31
        type: BottomNavigationBarType.fixed, // 4개 이상 항목에 필요
32
        currentIndex: _selectedIndex,
33
        onTap: _onItemTapped,
34
        items: const [
35
          BottomNavigationBarItem(
36
            icon: Icon(Icons.home),
37
            label: '홈',
38
          ),
39
          BottomNavigationBarItem(
40
            icon: Icon(Icons.search),
41
            label: '검색',
42
          ),
43
          BottomNavigationBarItem(
44
            icon: Icon(Icons.notifications),
45
            label: '알림',
46
          ),
47
          BottomNavigationBarItem(
48
            icon: Icon(Icons.person),
49
            label: '프로필',
50
          ),
51
        ],
52
      ),
53
    );
54
  }
55
}
```

### 배지가 있는 BottomNavigationBar

[Section titled “배지가 있는 BottomNavigationBar”](#배지가-있는-bottomnavigationbar)

알림 수와 같은 배지를 BottomNavigationBar 항목에 추가할 수 있습니다:

```dart
1
BottomNavigationBar(
2
  currentIndex: _selectedIndex,
3
  onTap: _onItemTapped,
4
  items: [
5
    BottomNavigationBarItem(
6
      icon: Icon(Icons.home),
7
      label: '홈',
8
    ),
9
    BottomNavigationBarItem(
10
      icon: Icon(Icons.search),
11
      label: '검색',
12
    ),
13
    BottomNavigationBarItem(
14
      icon: Badge(
15
        label: Text('3'),
16
        isLabelVisible: _notificationCount > 0,
17
        child: Icon(Icons.notifications),
18
      ),
19
      label: '알림',
20
    ),
21
    BottomNavigationBarItem(
22
      icon: Icon(Icons.person),
23
      label: '프로필',
24
    ),
25
  ],
26
)
```

### 커스텀 스타일 적용

[Section titled “커스텀 스타일 적용”](#커스텀-스타일-적용)

BottomNavigationBar의 스타일을 커스터마이징할 수 있습니다:

```dart
1
BottomNavigationBar(
2
  currentIndex: _selectedIndex,
3
  onTap: _onItemTapped,
4
  // 고정 타입 (모든 항목이 항상 표시됨)
5
  type: BottomNavigationBarType.fixed,
6
  // 선택된 항목의 색상
7
  selectedItemColor: Colors.blue,
8
  // 선택되지 않은 항목의 색상
9
  unselectedItemColor: Colors.grey,
10
  // 선택된 항목의 아이콘 크기
11
  selectedIconTheme: IconThemeData(size: 30),
12
  // 선택되지 않은 항목의 아이콘 크기
13
  unselectedIconTheme: IconThemeData(size: 24),
14
  // 선택된 항목의 레이블 스타일
15
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
16
  // 선택되지 않은 항목의 레이블 스타일
17
  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
18
  // 배경색
19
  backgroundColor: Colors.white,
20
  // 높이
21
  elevation: 8,
22
  items: // 내비게이션 항목 정의...
23
)
```

### BottomNavigationBar 대안: NavigationBar

[Section titled “BottomNavigationBar 대안: NavigationBar”](#bottomnavigationbar-대안-navigationbar)

Material 3 디자인을 사용하는 앱에서는 `NavigationBar`를 사용할 수 있습니다:

```dart
1
NavigationBar(
2
  selectedIndex: _selectedIndex,
3
  onDestinationSelected: _onItemTapped,
4
  destinations: const [
5
    NavigationDestination(
6
      icon: Icon(Icons.home_outlined),
7
      selectedIcon: Icon(Icons.home),
8
      label: '홈',
9
    ),
10
    NavigationDestination(
11
      icon: Icon(Icons.search_outlined),
12
      selectedIcon: Icon(Icons.search),
13
      label: '검색',
14
    ),
15
    NavigationDestination(
16
      icon: Icon(Icons.notifications_outlined),
17
      selectedIcon: Icon(Icons.notifications),
18
      label: '알림',
19
    ),
20
    NavigationDestination(
21
      icon: Icon(Icons.person_outline),
22
      selectedIcon: Icon(Icons.person),
23
      label: '프로필',
24
    ),
25
  ],
26
)
```

### BottomNavigationBar와 go\_router 통합

[Section titled “BottomNavigationBar와 go\_router 통합”](#bottomnavigationbar와-go_router-통합)

앞서 살펴본 StatefulShellRoute를 사용하여 BottomNavigationBar를 go\_router와 통합할 수 있습니다:

```dart
1
final GoRouter router = GoRouter(
2
  initialLocation: '/',
3
  routes: [
4
    StatefulShellRoute.indexedStack(
5
      builder: (context, state, navigationShell) {
6
        return ScaffoldWithNavBar(navigationShell: navigationShell);
7
      },
8
      branches: [
9
        // 각 탭에 대한 브랜치 정의
10
        StatefulShellBranch(routes: [GoRoute(path: '/', ...)]),
11
        StatefulShellBranch(routes: [GoRoute(path: '/search', ...)]),
12
        StatefulShellBranch(routes: [GoRoute(path: '/notifications', ...)]),
13
        StatefulShellBranch(routes: [GoRoute(path: '/profile', ...)]),
14
      ],
15
    ),
16
  ],
17
);
18


19
class ScaffoldWithNavBar extends StatelessWidget {
20
  final StatefulNavigationShell navigationShell;
21


22
  const ScaffoldWithNavBar({required this.navigationShell});
23


24
  @override
25
  Widget build(BuildContext context) {
26
    return Scaffold(
27
      body: navigationShell,
28
      bottomNavigationBar: BottomNavigationBar(
29
        currentIndex: navigationShell.currentIndex,
30
        items: const [
31
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
32
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
33
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
34
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
35
        ],
36
        onTap: (index) => navigationShell.goBranch(index),
37
      ),
38
    );
39
  }
40
}
```

## TabBar (탭 바)

[Section titled “TabBar (탭 바)”](#tabbar-탭-바)

TabBar는 일반적으로 AppBar 내부나 화면 상단에 위치하며, 관련된 콘텐츠 간에 빠르게 전환할 수 있게 해줍니다.

### 기본 TabBar 구현

[Section titled “기본 TabBar 구현”](#기본-tabbar-구현)

TabController를 사용한 기본 탭 구현:

```dart
1
class TabBarExample extends StatefulWidget {
2
  @override
3
  _TabBarExampleState createState() => _TabBarExampleState();
4
}
5


6
class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin {
7
  late TabController _tabController;
8


9
  @override
10
  void initState() {
11
    super.initState();
12
    _tabController = TabController(length: 3, vsync: this);
13
  }
14


15
  @override
16
  void dispose() {
17
    _tabController.dispose();
18
    super.dispose();
19
  }
20


21
  @override
22
  Widget build(BuildContext context) {
23
    return Scaffold(
24
      appBar: AppBar(
25
        title: Text('TabBar 예제'),
26
        bottom: TabBar(
27
          controller: _tabController,
28
          tabs: const [
29
            Tab(icon: Icon(Icons.directions_car), text: '자동차'),
30
            Tab(icon: Icon(Icons.directions_transit), text: '대중교통'),
31
            Tab(icon: Icon(Icons.directions_bike), text: '자전거'),
32
          ],
33
        ),
34
      ),
35
      body: TabBarView(
36
        controller: _tabController,
37
        children: const [
38
          Center(child: Text('자동차 탭 내용')),
39
          Center(child: Text('대중교통 탭 내용')),
40
          Center(child: Text('자전거 탭 내용')),
41
        ],
42
      ),
43
    );
44
  }
45
}
```

### DefaultTabController 사용하기

[Section titled “DefaultTabController 사용하기”](#defaulttabcontroller-사용하기)

더 간단한 TabBar 구현을 위해 DefaultTabController를 사용할 수 있습니다:

```dart
1
DefaultTabController(
2
  length: 3,
3
  child: Scaffold(
4
    appBar: AppBar(
5
      title: Text('DefaultTabController 예제'),
6
      bottom: TabBar(
7
        tabs: const [
8
          Tab(text: '최신'),
9
          Tab(text: '인기'),
10
          Tab(text: '즐겨찾기'),
11
        ],
12
      ),
13
    ),
14
    body: TabBarView(
15
      children: const [
16
        NewestContentTab(),
17
        PopularContentTab(),
18
        FavoritesContentTab(),
19
      ],
20
    ),
21
  ),
22
)
```

### 스크롤 가능한 TabBar

[Section titled “스크롤 가능한 TabBar”](#스크롤-가능한-tabbar)

많은 탭이 있을 경우 스크롤 가능한 TabBar를 사용할 수 있습니다:

```dart
1
DefaultTabController(
2
  length: 8,
3
  child: Scaffold(
4
    appBar: AppBar(
5
      title: Text('스크롤 가능한 TabBar'),
6
      bottom: TabBar(
7
        isScrollable: true, // 스크롤 가능하게 설정
8
        tabs: const [
9
          Tab(text: '패션'),
10
          Tab(text: '액세서리'),
11
          Tab(text: '신발'),
12
          Tab(text: '전자제품'),
13
          Tab(text: '스포츠'),
14
          Tab(text: '도서'),
15
          Tab(text: '취미'),
16
          Tab(text: '게임'),
17
        ],
18
      ),
19
    ),
20
    body: TabBarView(
21
      children: // 탭 콘텐츠 정의...
22
    ),
23
  ),
24
)
```

### 커스텀 TabBar 스타일

[Section titled “커스텀 TabBar 스타일”](#커스텀-tabbar-스타일)

TabBar의 스타일을 커스터마이징할 수 있습니다:

```dart
1
TabBar(
2
  // 선택된 탭의 색상
3
  labelColor: Colors.blue,
4
  // 선택되지 않은 탭의 색상
5
  unselectedLabelColor: Colors.grey,
6
  // 선택된 탭의 스타일
7
  labelStyle: TextStyle(fontWeight: FontWeight.bold),
8
  // 선택되지 않은 탭의 스타일
9
  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
10
  // 인디케이터 색상
11
  indicatorColor: Colors.blue,
12
  // 인디케이터 두께
13
  indicatorWeight: 3,
14
  // 인디케이터 패딩
15
  indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
16
  // 탭 패딩
17
  padding: EdgeInsets.symmetric(horizontal: 8),
18
  // 탭 간 간격
19
  labelPadding: EdgeInsets.symmetric(horizontal: 16),
20
  // 인디케이터 크기
21
  indicatorSize: TabBarIndicatorSize.label, // .tab도 가능
22
  // 인디케이터 모양
23
  indicator: BoxDecoration(
24
    borderRadius: BorderRadius.circular(8),
25
    color: Colors.blue.withOpacity(0.2),
26
  ),
27
  // 배경 색상
28
  // Material 3 사용 시 TabBar.secondary 사용 가능
29
  tabs: // 탭 정의...
30
)
```

### TabBar와 go\_router 통합

[Section titled “TabBar와 go\_router 통합”](#tabbar와-go_router-통합)

TabBar가 있는 화면을 go\_router와 통합하는 방법:

```dart
1
// go_router 설정
2
final GoRouter router = GoRouter(
3
  initialLocation: '/categories/popular',
4
  routes: [
5
    GoRoute(
6
      path: '/categories/:tab',
7
      builder: (context, state) {
8
        // URL에서 활성 탭 매개변수 추출
9
        final tab = state.pathParameters['tab'] ?? 'popular';
10
        return CategoryTabScreen(initialTab: tab);
11
      },
12
    ),
13
  ],
14
);
15


16
// 탭 화면
17
class CategoryTabScreen extends StatefulWidget {
18
  final String initialTab;
19


20
  const CategoryTabScreen({Key? key, required this.initialTab}) : super(key: key);
21


22
  @override
23
  _CategoryTabScreenState createState() => _CategoryTabScreenState();
24
}
25


26
class _CategoryTabScreenState extends State<CategoryTabScreen> with SingleTickerProviderStateMixin {
27
  late TabController _tabController;
28
  final List<String> _tabs = ['popular', 'newest', 'trending'];
29


30
  @override
31
  void initState() {
32
    super.initState();
33
    // 초기 탭 인덱스 계산
34
    final initialIndex = _tabs.indexOf(widget.initialTab);
35
    _tabController = TabController(
36
      length: _tabs.length,
37
      vsync: this,
38
      initialIndex: initialIndex >= 0 ? initialIndex : 0,
39
    );
40


41
    // 탭 변경 감지
42
    _tabController.addListener(_handleTabChange);
43
  }
44


45
  void _handleTabChange() {
46
    if (!_tabController.indexIsChanging) {
47
      // URL 업데이트
48
      context.go('/categories/${_tabs[_tabController.index]}');
49
    }
50
  }
51


52
  @override
53
  void dispose() {
54
    _tabController.removeListener(_handleTabChange);
55
    _tabController.dispose();
56
    super.dispose();
57
  }
58


59
  @override
60
  Widget build(BuildContext context) {
61
    return Scaffold(
62
      appBar: AppBar(
63
        title: Text('카테고리'),
64
        bottom: TabBar(
65
          controller: _tabController,
66
          tabs: const [
67
            Tab(text: '인기'),
68
            Tab(text: '최신'),
69
            Tab(text: '트렌딩'),
70
          ],
71
        ),
72
      ),
73
      body: TabBarView(
74
        controller: _tabController,
75
        children: const [
76
          PopularCategoryTab(),
77
          NewestCategoryTab(),
78
          TrendingCategoryTab(),
79
        ],
80
      ),
81
    );
82
  }
83
}
```

## 복합 네비게이션 패턴

[Section titled “복합 네비게이션 패턴”](#복합-네비게이션-패턴)

실제 앱에서는 여러 네비게이션 패턴을 함께 사용하는 경우가 많습니다. 다음은 Drawer, BottomNavigationBar, TabBar를 모두 사용하는 복합 네비게이션 예제입니다:

```dart
1
class ComplexNavigationApp extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    return MaterialApp.router(
5
      routerConfig: _router,
6
      // 앱 설정...
7
    );
8
  }
9
}
10


11
final GoRouter _router = GoRouter(
12
  initialLocation: '/',
13
  routes: [
14
    StatefulShellRoute.indexedStack(
15
      builder: (context, state, navigationShell) {
16
        return ScaffoldWithNavBar(navigationShell: navigationShell);
17
      },
18
      branches: [
19
        // 홈 탭
20
        StatefulShellBranch(
21
          routes: [
22
            GoRoute(
23
              path: '/',
24
              builder: (context, state) => HomeScreen(),
25
            ),
26
          ],
27
        ),
28
        // 카테고리 탭 (내부에 TabBar 포함)
29
        StatefulShellBranch(
30
          routes: [
31
            GoRoute(
32
              path: '/categories/:tab',
33
              builder: (context, state) {
34
                final tab = state.pathParameters['tab'] ?? 'popular';
35
                return CategoryTabScreen(initialTab: tab);
36
              },
37
            ),
38
          ],
39
        ),
40
        // 프로필 탭
41
        StatefulShellBranch(
42
          routes: [
43
            GoRoute(
44
              path: '/profile',
45
              builder: (context, state) => ProfileScreen(),
46
            ),
47
          ],
48
        ),
49
      ],
50
    ),
51
    // 기타 독립적인 라우트
52
    GoRoute(
53
      path: '/settings',
54
      builder: (context, state) => SettingsScreen(),
55
    ),
56
  ],
57
);
58


59
// 바텀 네비게이션 바와 드로어가 있는 스캐폴드
60
class ScaffoldWithNavBar extends StatelessWidget {
61
  final StatefulNavigationShell navigationShell;
62


63
  const ScaffoldWithNavBar({required this.navigationShell});
64


65
  @override
66
  Widget build(BuildContext context) {
67
    return Scaffold(
68
      appBar: AppBar(
69
        title: _getTitle(navigationShell.currentIndex),
70
      ),
71
      drawer: AppDrawer(currentIndex: navigationShell.currentIndex),
72
      body: navigationShell,
73
      bottomNavigationBar: BottomNavigationBar(
74
        currentIndex: navigationShell.currentIndex,
75
        items: const [
76
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
77
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '카테고리'),
78
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
79
        ],
80
        onTap: (index) => navigationShell.goBranch(index),
81
      ),
82
    );
83
  }
84


85
  // 현재 탭에 따라 제목 반환
86
  Widget _getTitle(int index) {
87
    switch (index) {
88
      case 0: return Text('홈');
89
      case 1: return Text('카테고리');
90
      case 2: return Text('프로필');
91
      default: return Text('앱');
92
    }
93
  }
94
}
```

## 요약

[Section titled “요약”](#요약)

이 장에서는 Flutter의 세 가지 주요 네비게이션 위젯에 대해 살펴보았습니다:

* **Drawer**: 측면에서 슬라이드하여 나타나는 패널로, 주요 네비게이션 항목을 제공합니다. UserAccountsDrawerHeader를 통해 사용자 정보를 표시할 수 있으며, 계층적 메뉴를 구현할 수 있습니다.

* **BottomNavigationBar**: 화면 하단에 고정된 메뉴로, 앱의 주요 섹션 간을 빠르게 전환할 수 있습니다. Material 3 디자인에서는 NavigationBar라는 대안도 있습니다.

* **TabBar**: AppBar 내부나 화면 상단에 위치하며, 관련된 콘텐츠 간에 빠르게 전환할 수 있게 해줍니다. DefaultTabController를 통해 간편하게 구현할 수 있습니다.

또한 이러한 네비게이션 위젯들을 go\_router와 통합하는 방법도 알아보았습니다. 실제 앱에서는 사용자 경험을 개선하기 위해 여러 네비게이션 패턴을 함께 사용하는 경우가 많습니다.

네비게이션은 사용자가 앱 내에서 원하는 정보를 찾고 다양한 기능에 접근하는 핵심 요소입니다. 직관적이고 일관된 네비게이션 경험을 제공하는 것이 성공적인 앱 디자인의 핵심입니다.

# Navigator 1.0

Flutter의 기본적인 화면 전환 방식인 Navigator 1.0에 대해 알아보겠습니다. 이 방식은 명령형(imperative) 스타일로 화면 전환을 구현하며, 스택 기반의 네비게이션을 제공합니다.

## Navigator의 개념

[Section titled “Navigator의 개념”](#navigator의-개념)

Navigator는 앱의 화면들을 스택(stack) 형태로 관리하는 위젯입니다. 우리가 사용하는 대부분의 앱에서는 사용자가 새 화면으로 이동하면 이전 화면 위에 새 화면이 쌓이고, 뒤로 가기를 하면 가장 위에 있는 화면이 제거되는 구조입니다.

Flutter의 `Navigator` 위젯은 다음과 같은 주요 메서드를 제공합니다:

* **push**: 새 화면을 스택의 맨 위에 추가
* **pop**: 스택의 맨 위에 있는 화면 제거
* **pushReplacement**: 현재 화면을 새 화면으로 교체
* **popUntil**: 특정 조건이 만족될 때까지 화면들을 제거
* **pushNamedAndRemoveUntil**: 이름으로 새 화면을 추가하고 특정 조건이 만족될 때까지 이전 화면들을 제거

## 기본 사용법

[Section titled “기본 사용법”](#기본-사용법)

### 1. 직접 라우팅 (익명 라우팅)

[Section titled “1. 직접 라우팅 (익명 라우팅)”](#1-직접-라우팅-익명-라우팅)

가장 기본적인 화면 전환 방법은 `Navigator.push`와 `Navigator.pop`을 사용하는 것입니다.

```dart
1
// 다음 화면으로 이동
2
ElevatedButton(
3
  onPressed: () {
4
    Navigator.push(
5
      context,
6
      MaterialPageRoute(builder: (context) => SecondScreen()),
7
    );
8
  },
9
  child: Text('두 번째 화면으로 이동'),
10
);
11


12
// 이전 화면으로 돌아가기
13
ElevatedButton(
14
  onPressed: () {
15
    Navigator.pop(context);
16
  },
17
  child: Text('이전 화면으로 돌아가기'),
18
);
```

### 2. 명명된 라우팅 (Named Routes)

[Section titled “2. 명명된 라우팅 (Named Routes)”](#2-명명된-라우팅-named-routes)

더 체계적인 방법으로는 앱 시작 시 라우트 맵을 정의하고 이름으로 화면 전환을 하는 방식이 있습니다.

```dart
1
// main.dart에서 라우트 맵 정의
2
MaterialApp(
3
  initialRoute: '/',
4
  routes: {
5
    '/': (context) => HomeScreen(),
6
    '/second': (context) => SecondScreen(),
7
    '/third': (context) => ThirdScreen(),
8
  },
9
);
10


11
// 다음 화면으로 이동
12
ElevatedButton(
13
  onPressed: () {
14
    Navigator.pushNamed(context, '/second');
15
  },
16
  child: Text('두 번째 화면으로 이동'),
17
);
18


19
// 이전 화면으로 돌아가기
20
ElevatedButton(
21
  onPressed: () {
22
    Navigator.pop(context);
23
  },
24
  child: Text('이전 화면으로 돌아가기'),
25
);
```

## 라우트 전환 시 데이터 전달

[Section titled “라우트 전환 시 데이터 전달”](#라우트-전환-시-데이터-전달)

### 1. 생성자를 통한 데이터 전달

[Section titled “1. 생성자를 통한 데이터 전달”](#1-생성자를-통한-데이터-전달)

```dart
1
// 데이터 전달하며 화면 전환
2
ElevatedButton(
3
  onPressed: () {
4
    Navigator.push(
5
      context,
6
      MaterialPageRoute(
7
        builder: (context) => DetailScreen(item: item),
8
      ),
9
    );
10
  },
11
  child: Text('상세 화면으로 이동'),
12
);
13


14
// 데이터를 받는 화면
15
class DetailScreen extends StatelessWidget {
16
  final Item item;
17


18
  DetailScreen({required this.item});
19


20
  @override
21
  Widget build(BuildContext context) {
22
    return Scaffold(
23
      appBar: AppBar(title: Text(item.title)),
24
      body: Center(
25
        child: Text(item.description),
26
      ),
27
    );
28
  }
29
}
```

### 2. 명명된 라우트에 인수 전달

[Section titled “2. 명명된 라우트에 인수 전달”](#2-명명된-라우트에-인수-전달)

```dart
1
// 인수 전달하며 명명된 라우트로 이동
2
Navigator.pushNamed(
3
  context,
4
  '/detail',
5
  arguments: {'id': 123, 'title': '상품 제목'},
6
);
7


8
// 인수를 받는 화면
9
class DetailScreen extends StatelessWidget {
10
  @override
11
  Widget build(BuildContext context) {
12
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
13
    final id = args['id'];
14
    final title = args['title'];
15


16
    return Scaffold(
17
      appBar: AppBar(title: Text(title)),
18
      body: Center(
19
        child: Text('ID: $id'),
20
      ),
21
    );
22
  }
23
}
```

### 3. 결과를 반환받기

[Section titled “3. 결과를 반환받기”](#3-결과를-반환받기)

화면 전환 후 이전 화면으로 결과 값을 반환받을 수도 있습니다:

```dart
1
// 결과를 받기 위해 비동기로 화면 전환
2
ElevatedButton(
3
  onPressed: () async {
4
    final result = await Navigator.push(
5
      context,
6
      MaterialPageRoute(builder: (context) => SelectionScreen()),
7
    );
8
    // 결과 처리
9
    if (result != null) {
10
      ScaffoldMessenger.of(context).showSnackBar(
11
        SnackBar(content: Text('선택된 항목: $result')),
12
      );
13
    }
14
  },
15
  child: Text('항목 선택하기'),
16
);
17


18
// 결과를 반환하는 화면
19
class SelectionScreen extends StatelessWidget {
20
  @override
21
  Widget build(BuildContext context) {
22
    return Scaffold(
23
      appBar: AppBar(title: Text('항목 선택')),
24
      body: ListView(
25
        children: [
26
          ListTile(
27
            title: Text('항목 1'),
28
            onTap: () {
29
              Navigator.pop(context, '항목 1');
30
            },
31
          ),
32
          ListTile(
33
            title: Text('항목 2'),
34
            onTap: () {
35
              Navigator.pop(context, '항목 2');
36
            },
37
          ),
38
        ],
39
      ),
40
    );
41
  }
42
}
```

## 화면 전환 애니메이션 커스터마이징

[Section titled “화면 전환 애니메이션 커스터마이징”](#화면-전환-애니메이션-커스터마이징)

### 1. 내장 애니메이션 사용

[Section titled “1. 내장 애니메이션 사용”](#1-내장-애니메이션-사용)

Flutter는 기본적으로 여러 종류의 화면 전환 애니메이션을 제공합니다:

```dart
1
// 오른쪽에서 왼쪽으로 슬라이드 (기본)
2
Navigator.push(
3
  context,
4
  MaterialPageRoute(builder: (context) => SecondScreen()),
5
);
6


7
// 아래에서 위로 슬라이드
8
Navigator.push(
9
  context,
10
  MaterialPageRoute(
11
    builder: (context) => SecondScreen(),
12
    fullscreenDialog: true, // 다이얼로그 스타일 전환
13
  ),
14
);
15


16
// 페이드 인/아웃 효과
17
Navigator.push(
18
  context,
19
  PageRouteBuilder(
20
    pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
21
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
22
      return FadeTransition(opacity: animation, child: child);
23
    },
24
  ),
25
);
```

### 2. 커스텀 애니메이션 생성

[Section titled “2. 커스텀 애니메이션 생성”](#2-커스텀-애니메이션-생성)

원하는 전환 효과가 없다면 직접 만들 수도 있습니다:

```dart
1
// 스케일 애니메이션 (확대/축소 효과)
2
Navigator.push(
3
  context,
4
  PageRouteBuilder(
5
    pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
6
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
7
      return ScaleTransition(
8
        scale: animation,
9
        child: child,
10
      );
11
    },
12
    transitionDuration: Duration(milliseconds: 500),
13
  ),
14
);
15


16
// 회전 애니메이션
17
Navigator.push(
18
  context,
19
  PageRouteBuilder(
20
    pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
21
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
22
      return RotationTransition(
23
        turns: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
24
        child: child,
25
      );
26
    },
27
    transitionDuration: Duration(seconds: 1),
28
  ),
29
);
30


31
// 여러 애니메이션 조합
32
Navigator.push(
33
  context,
34
  PageRouteBuilder(
35
    pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
36
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
37
      // 페이드 효과와 슬라이드 효과 결합
38
      return FadeTransition(
39
        opacity: animation,
40
        child: SlideTransition(
41
          position: Tween<Offset>(
42
            begin: const Offset(1.0, 0.0), // 오른쪽에서
43
            end: Offset.zero, // 중앙으로
44
          ).animate(animation),
45
          child: child,
46
        ),
47
      );
48
    },
49
    transitionDuration: Duration(milliseconds: 500),
50
  ),
51
);
```

### 3. Hero 애니메이션

[Section titled “3. Hero 애니메이션”](#3-hero-애니메이션)

두 화면 간에 동일한 위젯이 있을 때, 그 위젯이 한 화면에서 다른 화면으로 자연스럽게 움직이는 효과를 구현할 수 있습니다:

```dart
1
// 첫 번째 화면
2
Hero(
3
  tag: 'imageHero', // 반드시 고유한 태그 필요
4
  child: Image.network('https://example.com/image.jpg'),
5
);
6


7
// 두 번째 화면 (상세 화면)
8
Hero(
9
  tag: 'imageHero', // 첫 번째 화면과 동일한 태그
10
  child: Image.network('https://example.com/image.jpg'),
11
);
```

## 중첩 네비게이션 (Nested Navigation)

[Section titled “중첩 네비게이션 (Nested Navigation)”](#중첩-네비게이션-nested-navigation)

앱의 일부 영역에서만 별도의 네비게이션 스택을 관리하고 싶을 때 사용합니다:

```dart
1
class MyHomePage extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    return Scaffold(
5
      appBar: AppBar(title: Text('중첩 네비게이션')),
6
      body: Row(
7
        children: [
8
          // 사이드바
9
          Container(
10
            width: 200,
11
            color: Colors.grey[200],
12
            child: ListView(
13
              children: [
14
                ListTile(
15
                  title: Text('항목 1'),
16
                  onTap: () {
17
                    // 중첩 네비게이터 접근
18
                    Navigator.of(context, rootNavigator: false)
19
                        .pushReplacementNamed('/item1');
20
                  },
21
                ),
22
                ListTile(
23
                  title: Text('항목 2'),
24
                  onTap: () {
25
                    Navigator.of(context, rootNavigator: false)
26
                        .pushReplacementNamed('/item2');
27
                  },
28
                ),
29
              ],
30
            ),
31
          ),
32
          // 메인 콘텐츠 영역 (중첩 네비게이터)
33
          Expanded(
34
            child: Navigator(
35
              initialRoute: '/item1',
36
              onGenerateRoute: (settings) {
37
                Widget page;
38
                switch (settings.name) {
39
                  case '/item1':
40
                    page = Item1Screen();
41
                    break;
42
                  case '/item2':
43
                    page = Item2Screen();
44
                    break;
45
                  default:
46
                    page = Item1Screen();
47
                }
48
                return MaterialPageRoute(builder: (_) => page);
49
              },
50
            ),
51
          ),
52
        ],
53
      ),
54
    );
55
  }
56
}
```

## Navigator 1.0의 한계

[Section titled “Navigator 1.0의 한계”](#navigator-10의-한계)

Navigator 1.0은 간단한 앱에서는 잘 동작하지만, 복잡한 앱에서는 몇 가지 한계점이 있습니다:

1. **딥 링크 처리의 어려움**: 앱 외부에서 특정 화면으로 직접 접근하는 딥 링크를 처리하기 어렵습니다.
2. **웹 통합의 제한**: 웹 기반 애플리케이션에서 URL과 Navigator의 상태를 동기화하는 데 어려움이 있습니다.
3. **상태 관리의 복잡성**: 여러 계층의 네비게이션 스택이 있는 경우 상태 관리가 복잡해집니다.
4. **선언적 스타일 부재**: Flutter의 대부분은 선언적 스타일이지만, Navigator 1.0은 명령형 API를 사용합니다.

이러한 한계를 극복하기 위해 Flutter 팀은 Navigator 2.0을 도입했으며, 이는 다음 장에서 자세히 다루겠습니다.

## 실제 예제: 쇼핑 앱 구현

[Section titled “실제 예제: 쇼핑 앱 구현”](#실제-예제-쇼핑-앱-구현)

쇼핑 앱을 예로 들어 Navigator 1.0의 활용 방법을 살펴보겠습니다:

main.dart

```dart
1
void main() {
2
  runApp(MyApp());
3
}
4


5
class MyApp extends StatelessWidget {
6
  @override
7
  Widget build(BuildContext context) {
8
    return MaterialApp(
9
      title: '쇼핑 앱',
10
      initialRoute: '/',
11
      routes: {
12
        '/': (context) => HomeScreen(),
13
        '/categories': (context) => CategoriesScreen(),
14
        '/cart': (context) => CartScreen(),
15
        '/profile': (context) => ProfileScreen(),
16
      },
17
      onGenerateRoute: (settings) {
18
        // 동적 라우트 처리
19
        if (settings.name!.startsWith('/product/')) {
20
          // /product/123 형식의 URL에서 ID 추출
21
          final productId = settings.name!.split('/')[2];
22
          return MaterialPageRoute(
23
            builder: (context) => ProductDetailScreen(productId: productId),
24
          );
25
        }
26
        // 정의되지 않은 라우트는 홈 화면으로 리다이렉트
27
        return MaterialPageRoute(builder: (context) => HomeScreen());
28
      },
29
    );
30
  }
31
}
32


33
// 홈 화면
34
class HomeScreen extends StatelessWidget {
35
  @override
36
  Widget build(BuildContext context) {
37
    return Scaffold(
38
      appBar: AppBar(title: Text('홈')),
39
      drawer: AppDrawer(),
40
      body: ListView(
41
        children: [
42
          // 배너 슬라이더
43
          CarouselSlider(/* ... */),
44


45
          // 카테고리 그리드
46
          GridView.builder(
47
            shrinkWrap: true,
48
            physics: NeverScrollableScrollPhysics(),
49
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
50
              crossAxisCount: 2,
51
              childAspectRatio: 1.5,
52
            ),
53
            itemCount: categories.length,
54
            itemBuilder: (context, index) {
55
              return CategoryCard(
56
                category: categories[index],
57
                onTap: () {
58
                  Navigator.pushNamed(
59
                    context,
60
                    '/categories',
61
                    arguments: {'categoryId': categories[index].id},
62
                  );
63
                },
64
              );
65
            },
66
          ),
67


68
          // 추천 상품 목록
69
          Text('추천 상품', style: Theme.of(context).textTheme.headline6),
70
          SizedBox(height: 8),
71
          SizedBox(
72
            height: 200,
73
            child: ListView.builder(
74
              scrollDirection: Axis.horizontal,
75
              itemCount: recommendedProducts.length,
76
              itemBuilder: (context, index) {
77
                final product = recommendedProducts[index];
78
                return ProductCard(
79
                  product: product,
80
                  onTap: () {
81
                    Navigator.pushNamed(
82
                      context,
83
                      '/product/${product.id}',
84
                    );
85
                  },
86
                );
87
              },
88
            ),
89
          ),
90
        ],
91
      ),
92
      bottomNavigationBar: AppBottomNavBar(currentIndex: 0),
93
    );
94
  }
95
}
96


97
// 상품 상세 화면
98
class ProductDetailScreen extends StatelessWidget {
99
  final String productId;
100


101
  ProductDetailScreen({required this.productId});
102


103
  @override
104
  Widget build(BuildContext context) {
105
    // productId를 사용하여 상품 데이터 가져오기
106
    final product = getProductById(productId);
107


108
    return Scaffold(
109
      appBar: AppBar(title: Text(product.name)),
110
      body: SingleChildScrollView(
111
        child: Column(
112
          crossAxisAlignment: CrossAxisAlignment.start,
113
          children: [
114
            // 상품 이미지 슬라이더
115
            Hero(
116
              tag: 'product-${product.id}',
117
              child: CarouselSlider(
118
                items: product.images.map((url) {
119
                  return Image.network(url);
120
                }).toList(),
121
                options: CarouselOptions(
122
                  height: 300,
123
                  viewportFraction: 1.0,
124
                  enlargeCenterPage: false,
125
                ),
126
              ),
127
            ),
128


129
            Padding(
130
              padding: const EdgeInsets.all(16.0),
131
              child: Column(
132
                crossAxisAlignment: CrossAxisAlignment.start,
133
                children: [
134
                  // 상품명
135
                  Text(
136
                    product.name,
137
                    style: Theme.of(context).textTheme.headline5,
138
                  ),
139
                  SizedBox(height: 8),
140


141
                  // 가격
142
                  Text(
143
                    '₩${product.price.toStringAsFixed(0)}',
144
                    style: TextStyle(
145
                      fontSize: 18,
146
                      fontWeight: FontWeight.bold,
147
                      color: Theme.of(context).primaryColor,
148
                    ),
149
                  ),
150
                  SizedBox(height: 16),
151


152
                  // 설명
153
                  Text(
154
                    product.description,
155
                    style: Theme.of(context).textTheme.bodyText2,
156
                  ),
157
                ],
158
              ),
159
            ),
160
          ],
161
        ),
162
      ),
163
      bottomNavigationBar: BottomAppBar(
164
        child: Padding(
165
          padding: const EdgeInsets.all(8.0),
166
          child: Row(
167
            children: [
168
              Expanded(
169
                child: ElevatedButton(
170
                  onPressed: () {
171
                    // 장바구니에 추가
172
                    addToCart(product);
173
                    ScaffoldMessenger.of(context).showSnackBar(
174
                      SnackBar(content: Text('장바구니에 추가되었습니다')),
175
                    );
176
                  },
177
                  child: Text('장바구니에 추가'),
178
                ),
179
              ),
180
              SizedBox(width: 8),
181
              Expanded(
182
                child: ElevatedButton(
183
                  onPressed: () {
184
                    // 장바구니에 추가하고 장바구니 화면으로 이동
185
                    addToCart(product);
186
                    Navigator.pushNamed(context, '/cart');
187
                  },
188
                  style: ElevatedButton.styleFrom(
189
                    primary: Colors.orange,
190
                  ),
191
                  child: Text('바로 구매'),
192
                ),
193
              ),
194
            ],
195
          ),
196
        ),
197
      ),
198
    );
199
  }
200
}
```

## 요약

[Section titled “요약”](#요약)

* **Navigator 1.0**은 Flutter의 기본적인 화면 전환 메커니즘으로, 스택 기반의 네비게이션을 제공합니다.
* **주요 메서드**로는 push(), pop(), pushReplacement(), popUntil() 등이 있습니다.
* **익명 라우팅**(직접 라우팅)과 **명명된 라우팅**(Named Routes)을 모두 지원합니다.
* **데이터 전달** 방법으로는 생성자를 통한 전달, 명명된 라우트의 arguments, 결과 반환 등이 있습니다.
* **애니메이션**을 커스터마이징하여 다양한 화면 전환 효과를 구현할 수 있습니다.
* **Hero 애니메이션**을 사용하여 두 화면 간의 요소를 자연스럽게 연결할 수 있습니다.
* **중첩 네비게이션**을 통해 앱 일부에서 별도의 네비게이션 스택을 관리할 수 있습니다.
* 다만, 딥 링크 처리, 웹 통합, 복잡한 라우팅 시나리오 등에서는 **한계점**이 있습니다.

다음 장에서는 이러한 한계를 극복하기 위해 도입된 Navigator 2.0에 대해 알아보겠습니다.

# Navigator 2.0

Flutter 1.22 버전에서 도입된 Navigator 2.0은 이전의 명령형(imperative) 스타일의 Navigator 1.0을 보완하는 선언적(declarative) 접근 방식의 네비게이션 API입니다. 이 새로운 API는 복잡한 라우팅 시나리오와 웹 애플리케이션에서의 딥 링크 처리를 더 효과적으로 관리할 수 있도록 설계되었습니다.

## Navigator 2.0의 등장 배경

[Section titled “Navigator 2.0의 등장 배경”](#navigator-20의-등장-배경)

Navigator 1.0은 간단한 앱에서는 충분했지만, 복잡한 네비게이션 시나리오나 웹 애플리케이션에서는 한계가 있었습니다:

1. **앱 상태와 URL 동기화 어려움**: 웹에서 URL을 기반으로 화면을 관리하기 어려움
2. **딥 링크 처리의 복잡성**: 특정 화면으로 직접 이동하는 딥 링크 구현이 복잡함
3. **선언적 UI와의 불일치**: Flutter의 나머지 부분은 선언적인데 네비게이션만 명령형
4. **전체 라우팅 상태 관리 부재**: 앱의 전체 네비게이션 상태를 한 곳에서 관리하기 어려움

이러한 문제를 해결하기 위해 Navigator 2.0이 도입되었습니다.

## Navigator 2.0의 핵심 컴포넌트

[Section titled “Navigator 2.0의 핵심 컴포넌트”](#navigator-20의-핵심-컴포넌트)

Navigator 2.0은 다음과 같은 세 가지 핵심 컴포넌트로 구성됩니다:

### 1. Router

[Section titled “1. Router”](#1-router)

`Router` 위젯은 Navigator 2.0의 최상위 위젯으로, 라우팅 정보를 처리하고 적절한 화면을 표시합니다. 주로 `MaterialApp.router` 생성자를 통해 사용됩니다.

```dart
1
MaterialApp.router(
2
  routeInformationParser: MyRouteInformationParser(),
3
  routerDelegate: MyRouterDelegate(),
4
);
```

### 2. RouteInformationParser

[Section titled “2. RouteInformationParser”](#2-routeinformationparser)

`RouteInformationParser`는 URL 경로와 같은 라우트 정보를 앱의 상태 객체로 변환하는 역할을 합니다. 예를 들어, ‘/users/123’이라는 URL을 `UserDetailsState(userId: 123)`와 같은 앱 상태 객체로 변환합니다.

```dart
1
class MyRouteInformationParser extends RouteInformationParser<AppState> {
2
  @override
3
  Future<AppState> parseRouteInformation(RouteInformation routeInformation) async {
4
    final uri = Uri.parse(routeInformation.location!);
5


6
    // 홈 화면
7
    if (uri.pathSegments.isEmpty) {
8
      return HomeState();
9
    }
10


11
    // 사용자 세부 정보 화면
12
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'users') {
13
      return UserDetailsState(userId: uri.pathSegments[1]);
14
    }
15


16
    // 알 수 없는 경로는 Not Found 상태로 처리
17
    return NotFoundState();
18
  }
19


20
  @override
21
  RouteInformation? restoreRouteInformation(AppState state) {
22
    if (state is HomeState) {
23
      return RouteInformation(location: '/');
24
    }
25


26
    if (state is UserDetailsState) {
27
      return RouteInformation(location: '/users/${state.userId}');
28
    }
29


30
    if (state is NotFoundState) {
31
      return RouteInformation(location: '/not-found');
32
    }
33


34
    return null;
35
  }
36
}
```

### 3. RouterDelegate

[Section titled “3. RouterDelegate”](#3-routerdelegate)

`RouterDelegate`는 앱의 상태를 기반으로 `Navigator` 위젯과 그 안의 페이지 스택을 구성합니다. 앱의 상태가 변경되면 이를 감지하고 화면을 업데이트합니다.

```dart
1
class MyRouterDelegate extends RouterDelegate<AppState>
2
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
3


4
  @override
5
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
6


7
  AppState _appState = HomeState();
8


9
  AppState get appState => _appState;
10


11
  set appState(AppState value) {
12
    if (_appState == value) return;
13
    _appState = value;
14
    notifyListeners();
15
  }
16


17
  @override
18
  AppState? get currentConfiguration => _appState;
19


20
  @override
21
  Widget build(BuildContext context) {
22
    List<Page> pages = [];
23


24
    // 앱 상태에 따라 페이지 스택 구성
25
    if (_appState is HomeState) {
26
      pages.add(MaterialPage(
27
        key: ValueKey('home'),
28
        child: HomeScreen(
29
          onUserTap: (String userId) {
30
            appState = UserDetailsState(userId: userId);
31
          },
32
        ),
33
      ));
34
    }
35


36
    if (_appState is UserDetailsState) {
37
      final userState = _appState as UserDetailsState;
38
      pages.add(MaterialPage(
39
        key: ValueKey('home'),
40
        child: HomeScreen(
41
          onUserTap: (String userId) {
42
            appState = UserDetailsState(userId: userId);
43
          },
44
        ),
45
      ));
46


47
      pages.add(MaterialPage(
48
        key: ValueKey('user-${userState.userId}'),
49
        child: UserDetailsScreen(
50
          userId: userState.userId,
51
          onBack: () {
52
            appState = HomeState();
53
          },
54
        ),
55
      ));
56
    }
57


58
    if (_appState is NotFoundState) {
59
      pages.add(MaterialPage(
60
        key: ValueKey('not-found'),
61
        child: NotFoundScreen(
62
          onBack: () {
63
            appState = HomeState();
64
          },
65
        ),
66
      ));
67
    }
68


69
    return Navigator(
70
      key: navigatorKey,
71
      pages: pages,
72
      onPopPage: (route, result) {
73
        if (!route.didPop(result)) {
74
          return false;
75
        }
76


77
        // 뒤로 가기 처리
78
        if (pages.length > 1) {
79
          appState = HomeState();
80
        }
81


82
        return true;
83
      },
84
    );
85
  }
86


87
  @override
88
  Future<void> setNewRoutePath(AppState configuration) async {
89
    appState = configuration;
90
  }
91
}
```

## Navigator 2.0의 핵심 개념

[Section titled “Navigator 2.0의 핵심 개념”](#navigator-20의-핵심-개념)

### 1. Page 위젯

[Section titled “1. Page 위젯”](#1-page-위젯)

Navigator 2.0에서는 화면을 `Page` 위젯으로 표현합니다. `Page`는 화면에 표시될 내용과 전환 애니메이션을 정의하는 불변(immutable) 객체입니다.

```dart
1
Navigator(
2
  pages: [
3
    MaterialPage(
4
      key: ValueKey('home'),
5
      child: HomeScreen(),
6
    ),
7
    MaterialPage(
8
      key: ValueKey('details'),
9
      child: DetailsScreen(),
10
    ),
11
  ],
12
  onPopPage: (route, result) {
13
    // 뒤로 가기 처리
14
    return route.didPop(result);
15
  },
16
);
```

주요 `Page` 구현체로는 다음과 같은 것들이 있습니다:

* **MaterialPage**: Material Design 스타일의 화면 전환
* **CupertinoPage**: iOS 스타일의 화면 전환
* **CustomPage**: 커스텀 애니메이션을 정의한 화면 전환

### 2. 선언적 방식의 페이지 스택 관리

[Section titled “2. 선언적 방식의 페이지 스택 관리”](#2-선언적-방식의-페이지-스택-관리)

Navigator 2.0의 가장 큰 특징은 페이지 스택을 선언적으로 관리한다는 점입니다. 화면의 추가/제거를 명령형 메서드(push, pop)로 처리하는 대신, 전체 페이지 스택을 한 번에 정의합니다.

```dart
1
// 명령형 방식 (Navigator 1.0)
2
Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen()));
3


4
// 선언적 방식 (Navigator 2.0)
5
// 페이지 스택 전체를 다시 정의
6
Navigator(
7
  pages: [
8
    MaterialPage(child: HomeScreen()),
9
    if (showDetails) MaterialPage(child: DetailsScreen()),
10
  ],
11
  onPopPage: (route, result) => route.didPop(result),
12
);
```

선언적 방식의 장점은 앱의 상태와 UI가 항상 동기화된다는 점입니다. 라우팅 상태가 변경되면 전체 페이지 스택이 자동으로 업데이트됩니다.

### 3. 히스토리 스택 관리

[Section titled “3. 히스토리 스택 관리”](#3-히스토리-스택-관리)

Navigator 2.0은 브라우저의 히스토리 스택과도 통합됩니다. 이는 웹 앱에서 특히 중요하며, 사용자가 브라우저의 뒤로 가기/앞으로 가기 버튼을 사용할 때 앱의 상태가 적절히 변경되도록 합니다.

```dart
1
// RouterDelegate 내부에서 페이지 스택 관리
2
@override
3
Widget build(BuildContext context) {
4
  return Navigator(
5
    key: navigatorKey,
6
    pages: [
7
      MaterialPage(child: HomeScreen()),
8
      if (_showUserList) MaterialPage(child: UserListScreen()),
9
      if (_selectedUserId != null) MaterialPage(
10
        child: UserDetailsScreen(userId: _selectedUserId!),
11
      ),
12
    ],
13
    onPopPage: (route, result) {
14
      if (!route.didPop(result)) return false;
15


16
      // 뒤로 가기 로직
17
      if (_selectedUserId != null) {
18
        _selectedUserId = null;
19
        return true;
20
      }
21


22
      if (_showUserList) {
23
        _showUserList = false;
24
        return true;
25
      }
26


27
      return false;
28
    },
29
  );
30
}
```

## 실제 예제: 쇼핑 앱 구현

[Section titled “실제 예제: 쇼핑 앱 구현”](#실제-예제-쇼핑-앱-구현)

Navigator 2.0을 사용한 쇼핑 앱의 구현 예제를 살펴보겠습니다:

```dart
1
// 앱 상태 정의
2
abstract class AppState {}
3


4
class HomeState extends AppState {}
5


6
class CategoryState extends AppState {
7
  final String categoryId;
8
  CategoryState({required this.categoryId});
9
}
10


11
class ProductDetailsState extends AppState {
12
  final String productId;
13
  ProductDetailsState({required this.productId});
14
}
15


16
class CartState extends AppState {}
17


18
class CheckoutState extends AppState {}
19


20
// RouteInformationParser 구현
21
class ShopRouteInformationParser extends RouteInformationParser<AppState> {
22
  @override
23
  Future<AppState> parseRouteInformation(RouteInformation routeInformation) async {
24
    final uri = Uri.parse(routeInformation.location!);
25


26
    // 홈 화면
27
    if (uri.pathSegments.isEmpty) {
28
      return HomeState();
29
    }
30


31
    // 카테고리 화면
32
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'category') {
33
      return CategoryState(categoryId: uri.pathSegments[1]);
34
    }
35


36
    // 상품 상세 화면
37
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'product') {
38
      return ProductDetailsState(productId: uri.pathSegments[1]);
39
    }
40


41
    // 장바구니 화면
42
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'cart') {
43
      return CartState();
44
    }
45


46
    // 결제 화면
47
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'checkout') {
48
      return CheckoutState();
49
    }
50


51
    // 알 수 없는 경로는 홈으로
52
    return HomeState();
53
  }
54


55
  @override
56
  RouteInformation? restoreRouteInformation(AppState state) {
57
    if (state is HomeState) {
58
      return RouteInformation(location: '/');
59
    }
60


61
    if (state is CategoryState) {
62
      return RouteInformation(location: '/category/${state.categoryId}');
63
    }
64


65
    if (state is ProductDetailsState) {
66
      return RouteInformation(location: '/product/${state.productId}');
67
    }
68


69
    if (state is CartState) {
70
      return RouteInformation(location: '/cart');
71
    }
72


73
    if (state is CheckoutState) {
74
      return RouteInformation(location: '/checkout');
75
    }
76


77
    return null;
78
  }
79
}
80


81
// RouterDelegate 구현
82
class ShopRouterDelegate extends RouterDelegate<AppState>
83
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
84


85
  @override
86
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
87


88
  AppState _appState = HomeState();
89
  List<AppState> _history = [HomeState()];
90


91
  AppState get appState => _appState;
92


93
  void navigateTo(AppState state) {
94
    _appState = state;
95
    _history.add(state);
96
    notifyListeners();
97
  }
98


99
  bool goBack() {
100
    if (_history.length > 1) {
101
      _history.removeLast();
102
      _appState = _history.last;
103
      notifyListeners();
104
      return true;
105
    }
106
    return false;
107
  }
108


109
  @override
110
  AppState? get currentConfiguration => _appState;
111


112
  @override
113
  Widget build(BuildContext context) {
114
    return Navigator(
115
      key: navigatorKey,
116
      pages: [
117
        MaterialPage(
118
          key: ValueKey('home'),
119
          child: HomeScreen(
120
            onCategorySelected: (categoryId) {
121
              navigateTo(CategoryState(categoryId: categoryId));
122
            },
123
            onProductSelected: (productId) {
124
              navigateTo(ProductDetailsState(productId: productId));
125
            },
126
            onCartTap: () {
127
              navigateTo(CartState());
128
            },
129
          ),
130
        ),
131
        if (_appState is CategoryState)
132
          MaterialPage(
133
            key: ValueKey('category-${(_appState as CategoryState).categoryId}'),
134
            child: CategoryScreen(
135
              categoryId: (_appState as CategoryState).categoryId,
136
              onProductSelected: (productId) {
137
                navigateTo(ProductDetailsState(productId: productId));
138
              },
139
            ),
140
          ),
141
        if (_appState is ProductDetailsState)
142
          MaterialPage(
143
            key: ValueKey('product-${(_appState as ProductDetailsState).productId}'),
144
            child: ProductDetailsScreen(
145
              productId: (_appState as ProductDetailsState).productId,
146
              onAddToCart: () {
147
                // 장바구니에 추가 로직
148
              },
149
              onBuyNow: () {
150
                navigateTo(CheckoutState());
151
              },
152
            ),
153
          ),
154
        if (_appState is CartState)
155
          MaterialPage(
156
            key: ValueKey('cart'),
157
            child: CartScreen(
158
              onCheckout: () {
159
                navigateTo(CheckoutState());
160
              },
161
            ),
162
          ),
163
        if (_appState is CheckoutState)
164
          MaterialPage(
165
            key: ValueKey('checkout'),
166
            child: CheckoutScreen(
167
              onOrderComplete: () {
168
                // 주문 완료 로직
169
                navigateTo(HomeState());
170
              },
171
            ),
172
          ),
173
      ],
174
      onPopPage: (route, result) {
175
        if (!route.didPop(result)) {
176
          return false;
177
        }
178


179
        goBack();
180
        return true;
181
      },
182
    );
183
  }
184


185
  @override
186
  Future<void> setNewRoutePath(AppState configuration) async {
187
    _appState = configuration;
188
    _history = [..._history, configuration];
189
  }
190
}
191


192
// MaterialApp에 Router 통합
193
class MyApp extends StatelessWidget {
194
  @override
195
  Widget build(BuildContext context) {
196
    return MaterialApp.router(
197
      title: '쇼핑 앱',
198
      theme: ThemeData(primarySwatch: Colors.blue),
199
      routerDelegate: ShopRouterDelegate(),
200
      routeInformationParser: ShopRouteInformationParser(),
201
    );
202
  }
203
}
```

## Navigator 2.0과 상태 관리 통합

[Section titled “Navigator 2.0과 상태 관리 통합”](#navigator-20과-상태-관리-통합)

Navigator 2.0은 앱의 상태 관리 시스템과 통합하기 쉽습니다. 예를 들어, Provider나 Riverpod와 같은 상태 관리 라이브러리와 함께 사용할 수 있습니다:

```dart
1
// 라우팅 상태 관리를 위한 ChangeNotifier
2
class AppRouterState extends ChangeNotifier {
3
  AppState _currentState = HomeState();
4


5
  AppState get currentState => _currentState;
6


7
  void navigateTo(AppState state) {
8
    _currentState = state;
9
    notifyListeners();
10
  }
11
}
12


13
// Provider와 RouterDelegate 통합
14
class MyRouterDelegate extends RouterDelegate<AppState>
15
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
16


17
  final AppRouterState appRouterState;
18


19
  MyRouterDelegate(this.appRouterState) {
20
    appRouterState.addListener(notifyListeners);
21
  }
22


23
  @override
24
  void dispose() {
25
    appRouterState.removeListener(notifyListeners);
26
    super.dispose();
27
  }
28


29
  @override
30
  AppState? get currentConfiguration => appRouterState.currentState;
31


32
  @override
33
  Widget build(BuildContext context) {
34
    // 앱 상태에 따라 페이지 스택 구성
35
    // ...
36
  }
37


38
  @override
39
  Future<void> setNewRoutePath(AppState configuration) async {
40
    appRouterState.navigateTo(configuration);
41
  }
42
}
43


44
// 메인 앱에서 Provider 사용
45
void main() {
46
  runApp(
47
    ChangeNotifierProvider(
48
      create: (_) => AppRouterState(),
49
      child: Builder(
50
        builder: (context) {
51
          final appRouterState = Provider.of<AppRouterState>(context);
52


53
          return MaterialApp.router(
54
            routerDelegate: MyRouterDelegate(appRouterState),
55
            routeInformationParser: MyRouteInformationParser(),
56
          );
57
        },
58
      ),
59
    ),
60
  );
61
}
```

## Navigator 2.0의 장단점

[Section titled “Navigator 2.0의 장단점”](#navigator-20의-장단점)

### 장점

[Section titled “장점”](#장점)

1. **선언적 API**: 앱의 상태와 UI가 항상 동기화됨
2. **딥 링크 지원 개선**: 복잡한 딥 링크 시나리오를 더 쉽게 처리할 수 있음
3. **웹 통합**: 브라우저 히스토리와 URL을 앱 상태와 쉽게 동기화할 수 있음
4. **상태 기반 라우팅**: 전체 앱 상태를 기반으로 라우팅을 관리할 수 있음
5. **테스트 용이성**: 선언적 API는 테스트하기 더 쉬움

### 단점

[Section titled “단점”](#단점)

1. **복잡성**: Navigator 1.0보다 구현이 더 복잡함
2. **학습 곡선**: 새로운 개념을 학습해야 함
3. **코드량 증가**: 간단한 앱에서는 오히려 코드가 더 복잡해질 수 있음
4. **라이브러리 성숙도**: 아직 관련 생태계가 Navigator 1.0만큼 성숙하지 않음

## Navigator 2.0 사용 시 고려사항

[Section titled “Navigator 2.0 사용 시 고려사항”](#navigator-20-사용-시-고려사항)

### 언제 Navigator 2.0을 사용해야 할까?

[Section titled “언제 Navigator 2.0을 사용해야 할까?”](#언제-navigator-20을-사용해야-할까)

다음과 같은 경우에 Navigator 2.0을 고려해볼 만합니다:

1. **웹 지원 필요**: Flutter 웹 앱에서 URL 관리가 중요한 경우
2. **복잡한 딥 링크**: 다양한 딥 링크 시나리오를 처리해야 하는 경우
3. **상태 기반 라우팅**: 앱 상태와 라우팅이 밀접하게 연결된 경우
4. **중첩 네비게이션**: 복잡한 중첩 네비게이션 구조가 필요한 경우

단순한 앱에서는 Navigator 1.0이 더 적합할 수 있습니다.

### go\_router: Navigator 2.0의 대안

[Section titled “go\_router: Navigator 2.0의 대안”](#go_router-navigator-20의-대안)

Navigator 2.0의 복잡성을 줄이기 위해 Flutter 팀은 `go_router` 패키지를 개발했습니다. `go_router`는 Navigator 2.0의 기능을 활용하면서도 더 간단한 API를 제공합니다:

```dart
1
// go_router 사용 예제
2
final _router = GoRouter(
3
  routes: [
4
    GoRoute(
5
      path: '/',
6
      builder: (context, state) => HomeScreen(),
7
    ),
8
    GoRoute(
9
      path: '/category/:id',
10
      builder: (context, state) {
11
        final categoryId = state.pathParameters['id'];
12
        return CategoryScreen(categoryId: categoryId!);
13
      },
14
    ),
15
    GoRoute(
16
      path: '/product/:id',
17
      builder: (context, state) {
18
        final productId = state.pathParameters['id'];
19
        return ProductDetailsScreen(productId: productId!);
20
      },
21
    ),
22
  ],
23
);
24


25
// 메인 앱에서 사용
26
MaterialApp.router(
27
  routerConfig: _router,
28
);
29


30
// 화면 전환
31
context.go('/category/electronics');
```

`go_router`는 다음 장에서 더 자세히 다루겠습니다.

## 요약

[Section titled “요약”](#요약)

* **Navigator 2.0**은 Flutter의 선언적 네비게이션 API로, 복잡한 라우팅 시나리오와 웹 애플리케이션에 적합합니다.
* **주요 구성 요소**로는 `Router`, `RouteInformationParser`, `RouterDelegate`가 있습니다.
* **Page 위젯**을 사용하여 화면을 정의하고, 전체 페이지 스택을 선언적으로 관리합니다.
* **앱 상태와 라우팅**이 밀접하게 통합되어, 상태 변경 시 UI가 자동으로 업데이트됩니다.
* **브라우저 히스토리**와 쉽게 통합되어 웹 애플리케이션에서 URL 관리가 용이합니다.
* 복잡성을 줄이기 위해 **go\_router** 같은 고수준 패키지를 사용할 수 있습니다.

Navigator 2.0은 복잡한 네비게이션 요구사항을 가진 앱에서 강력한 도구이지만, 모든 앱에 필요한 것은 아닙니다. 다음 장에서는 Navigator 2.0의 기능을 더 간단하게 사용할 수 있는 go\_router 패키지에 대해 자세히 알아보겠습니다.

# Dio를 통한 API 통신

Flutter에서 네트워크 통신은 앱 개발에서 필수적인 요소입니다. 이 장에서는 Flutter에서 가장 널리 사용되는 HTTP 클라이언트 라이브러리인 Dio를 활용하여 API 통신하는 방법을 살펴보겠습니다.

## Dio 소개

[Section titled “Dio 소개”](#dio-소개)

Dio는 Flutter와 Dart를 위한 강력한 HTTP 클라이언트로, 다음과 같은 특징을 가지고 있습니다:

* 요청 취소
* 파일 다운로드/업로드
* FormData 지원
* 인터셉터 기능
* 타임아웃 설정
* 글로벌 설정 및 단일 요청 설정
* 자동 쿠키 관리
* 편리한 에러 핸들링

## 시작하기

[Section titled “시작하기”](#시작하기)

먼저 pubspec.yaml 파일에 Dio 패키지를 추가합니다:

```yaml
1
dependencies:
2
  flutter:
3
    sdk: flutter
4
  dio: ^5.3.2 # 최신 버전 확인
```

패키지를 설치합니다:

```bash
1
flutter pub get
```

## 기본 사용법

[Section titled “기본 사용법”](#기본-사용법)

### 1. Dio 인스턴스 생성

[Section titled “1. Dio 인스턴스 생성”](#1-dio-인스턴스-생성)

```dart
1
import 'package:dio/dio.dart';
2


3
final dio = Dio();
```

### 2. 기본 HTTP 요청하기

[Section titled “2. 기본 HTTP 요청하기”](#2-기본-http-요청하기)

```dart
1
// GET 요청
2
Future<void> getRequest() async {
3
  try {
4
    final response = await dio.get('https://api.example.com/data');
5
    print('응답 데이터: ${response.data}');
6
  } catch (e) {
7
    print('에러: $e');
8
  }
9
}
10


11
// POST 요청
12
Future<void> postRequest() async {
13
  try {
14
    final response = await dio.post(
15
      'https://api.example.com/create',
16
      data: {'name': '홍길동', 'email': 'hong@example.com'},
17
    );
18
    print('응답 데이터: ${response.data}');
19
  } catch (e) {
20
    print('에러: $e');
21
  }
22
}
23


24
// PUT 요청
25
Future<void> putRequest() async {
26
  try {
27
    final response = await dio.put(
28
      'https://api.example.com/update/1',
29
      data: {'name': '김철수', 'email': 'kim@example.com'},
30
    );
31
    print('응답 데이터: ${response.data}');
32
  } catch (e) {
33
    print('에러: $e');
34
  }
35
}
36


37
// DELETE 요청
38
Future<void> deleteRequest() async {
39
  try {
40
    final response = await dio.delete('https://api.example.com/delete/1');
41
    print('응답 데이터: ${response.data}');
42
  } catch (e) {
43
    print('에러: $e');
44
  }
45
}
```

### 3. 쿼리 파라미터 사용하기

[Section titled “3. 쿼리 파라미터 사용하기”](#3-쿼리-파라미터-사용하기)

```dart
1
Future<void> getWithQueryParams() async {
2
  try {
3
    final response = await dio.get(
4
      'https://api.example.com/search',
5
      queryParameters: {
6
        'keyword': '플러터',
7
        'page': 1,
8
        'limit': 20,
9
      },
10
    );
11
    print('응답 데이터: ${response.data}');
12
  } catch (e) {
13
    print('에러: $e');
14
  }
15
}
```

### 4. 헤더 추가하기

[Section titled “4. 헤더 추가하기”](#4-헤더-추가하기)

```dart
1
Future<void> requestWithHeaders() async {
2
  try {
3
    final response = await dio.get(
4
      'https://api.example.com/secure-data',
5
      options: Options(
6
        headers: {
7
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
8
          'Content-Type': 'application/json',
9
          'Accept': 'application/json',
10
        },
11
      ),
12
    );
13
    print('응답 데이터: ${response.data}');
14
  } catch (e) {
15
    print('에러: $e');
16
  }
17
}
```

## Dio 고급 기능

[Section titled “Dio 고급 기능”](#dio-고급-기능)

### 1. BaseOptions 설정

[Section titled “1. BaseOptions 설정”](#1-baseoptions-설정)

모든 요청에 공통으로 적용될 기본 설정을 구성할 수 있습니다:

```dart
1
final dio = Dio(
2
  BaseOptions(
3
    baseUrl: 'https://api.example.com/v1',
4
    connectTimeout: const Duration(seconds: 5),
5
    receiveTimeout: const Duration(seconds: 3),
6
    headers: {
7
      'Content-Type': 'application/json',
8
      'Accept': 'application/json',
9
    },
10
    responseType: ResponseType.json,
11
  ),
12
);
```

이제 상대 경로만으로 요청할 수 있습니다:

```dart
1
// baseUrl + '/users' = 'https://api.example.com/v1/users'
2
final response = await dio.get('/users');
```

### 2. 인터셉터(Interceptor)

[Section titled “2. 인터셉터(Interceptor)”](#2-인터셉터interceptor)

인터셉터는 요청, 응답, 에러를 가로채어 처리할 수 있게 해줍니다:

```dart
1
class ApiInterceptor extends Interceptor {
2
  @override
3
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
4
    // 요청이 전송되기 전에 처리
5
    print('요청: ${options.method} ${options.path}');
6


7
    // 모든 요청에 자동으로 헤더 추가
8
    options.headers['Authorization'] = 'Bearer ${getToken()}';
9


10
    // 요청 계속 진행
11
    handler.next(options);
12


13
    // 또는 요청 중단 및 에러 반환
14
    // handler.reject(DioException(...))
15
  }
16


17
  @override
18
  void onResponse(Response response, ResponseInterceptorHandler handler) {
19
    // 응답 데이터 처리
20
    print('응답: ${response.statusCode}');
21


22
    // 특정 상태 코드에 대한 처리
23
    if (response.statusCode == 401) {
24
      // 토큰 갱신 등의 작업
25
    }
26


27
    // 응답 계속 전달
28
    handler.next(response);
29
  }
30


31
  @override
32
  void onError(DioException err, ErrorInterceptorHandler handler) {
33
    // 에러 처리
34
    print('에러: ${err.message}');
35


36
    // 네트워크 에러 처리
37
    if (err.type == DioExceptionType.connectionTimeout) {
38
      // 타임아웃 에러 처리
39
    }
40


41
    // 에러 계속 전파
42
    handler.next(err);
43


44
    // 또는 에러 회복 및 응답 대체
45
    // handler.resolve(Response(...))
46
  }
47
}
48


49
// 인터셉터 등록
50
dio.interceptors.add(ApiInterceptor());
```

#### 로깅 인터셉터 사용

[Section titled “로깅 인터셉터 사용”](#로깅-인터셉터-사용)

Dio는 기본적으로 로깅 인터셉터를 제공합니다:

```dart
1
dio.interceptors.add(LogInterceptor(
2
  requestBody: true,
3
  responseBody: true,
4
));
```

### 3. 파일 업로드

[Section titled “3. 파일 업로드”](#3-파일-업로드)

Dio를 사용하여 파일을 업로드하는 방법:

```dart
1
Future<void> uploadFile() async {
2
  try {
3
    final formData = FormData.fromMap({
4
      'name': '내 문서',
5
      'file': await MultipartFile.fromFile(
6
        '/path/to/file.pdf',
7
        filename: 'document.pdf',
8
      ),
9
      // 여러 파일 업로드
10
      'images': [
11
        await MultipartFile.fromFile('/path/to/image1.jpg'),
12
        await MultipartFile.fromFile('/path/to/image2.jpg'),
13
      ],
14
    });
15


16
    final response = await dio.post(
17
      'https://api.example.com/upload',
18
      data: formData,
19
      onSendProgress: (sent, total) {
20
        final progress = (sent / total * 100).toStringAsFixed(2);
21
        print('업로드 진행률: $progress%');
22
      },
23
    );
24


25
    print('업로드 완료: ${response.data}');
26
  } catch (e) {
27
    print('업로드 에러: $e');
28
  }
29
}
```

### 4. 파일 다운로드

[Section titled “4. 파일 다운로드”](#4-파일-다운로드)

Dio를 사용하여 파일을 다운로드하는 방법:

```dart
1
Future<void> downloadFile() async {
2
  try {
3
    final savePath = '/path/to/save/file.pdf';
4


5
    await dio.download(
6
      'https://example.com/files/document.pdf',
7
      savePath,
8
      onReceiveProgress: (received, total) {
9
        if (total != -1) {
10
          final progress = (received / total * 100).toStringAsFixed(2);
11
          print('다운로드 진행률: $progress%');
12
        }
13
      },
14
    );
15


16
    print('다운로드 완료: $savePath');
17
  } catch (e) {
18
    print('다운로드 에러: $e');
19
  }
20
}
```

### 5. 요청 취소

[Section titled “5. 요청 취소”](#5-요청-취소)

Dio는 요청을 취소할 수 있는 기능을 제공합니다:

```dart
1
// CancelToken 생성
2
final cancelToken = CancelToken();
3


4
// 요청에 CancelToken 적용
5
void makeRequest() async {
6
  try {
7
    final response = await dio.get(
8
      'https://api.example.com/data',
9
      cancelToken: cancelToken,
10
    );
11
    print('응답: ${response.data}');
12
  } catch (e) {
13
    if (CancelToken.isCancel(e)) {
14
      print('요청 취소됨: ${e.message}');
15
    } else {
16
      print('에러: $e');
17
    }
18
  }
19
}
20


21
// 요청 취소
22
void cancelRequest() {
23
  cancelToken.cancel('사용자에 의해 요청이 취소되었습니다.');
24
}
```

### 6. 동시 요청

[Section titled “6. 동시 요청”](#6-동시-요청)

Dio를 사용하여 여러 요청을 동시에 처리할 수 있습니다:

```dart
1
Future<void> multipleRequests() async {
2
  try {
3
    final responses = await Future.wait([
4
      dio.get('https://api.example.com/users'),
5
      dio.get('https://api.example.com/products'),
6
      dio.get('https://api.example.com/orders'),
7
    ]);
8


9
    final users = responses[0].data;
10
    final products = responses[1].data;
11
    final orders = responses[2].data;
12


13
    print('사용자: $users');
14
    print('상품: $products');
15
    print('주문: $orders');
16
  } catch (e) {
17
    print('에러: $e');
18
  }
19
}
```

## 에러 처리

[Section titled “에러 처리”](#에러-처리)

Dio에서 발생하는 예외는 `DioException` 타입으로, 다음과 같은 정보를 포함합니다:

```dart
1
Future<void> handleErrors() async {
2
  try {
3
    final response = await dio.get('https://api.example.com/nonexistent');
4
    print('응답: ${response.data}');
5
  } on DioException catch (e) {
6
    // 에러 유형 확인
7
    switch (e.type) {
8
      case DioExceptionType.connectionTimeout:
9
        print('연결 시간 초과');
10
        break;
11
      case DioExceptionType.sendTimeout:
12
        print('요청 전송 시간 초과');
13
        break;
14
      case DioExceptionType.receiveTimeout:
15
        print('응답 수신 시간 초과');
16
        break;
17
      case DioExceptionType.badResponse:
18
        // HTTP 상태 코드로 에러 처리
19
        switch (e.response?.statusCode) {
20
          case 400:
21
            print('잘못된 요청: ${e.response?.data}');
22
            break;
23
          case 401:
24
            print('인증 실패: ${e.response?.data}');
25
            break;
26
          case 404:
27
            print('리소스를 찾을 수 없음: ${e.response?.data}');
28
            break;
29
          case 500:
30
            print('서버 오류: ${e.response?.data}');
31
            break;
32
          default:
33
            print('알 수 없는 오류: ${e.response?.statusCode}');
34
            break;
35
        }
36
        break;
37
      case DioExceptionType.cancel:
38
        print('요청이 취소됨');
39
        break;
40
      default:
41
        print('네트워크 오류: ${e.message}');
42
        break;
43
    }
44


45
    // 요청 정보
46
    print('URL: ${e.requestOptions.uri}');
47
    print('Method: ${e.requestOptions.method}');
48
    print('Headers: ${e.requestOptions.headers}');
49


50
    // 응답 정보 (있는 경우)
51
    if (e.response != null) {
52
      print('응답 데이터: ${e.response?.data}');
53
      print('응답 헤더: ${e.response?.headers}');
54
    }
55
  } catch (e) {
56
    print('일반 오류: $e');
57
  }
58
}
```

## Dio 클라이언트 구조화

[Section titled “Dio 클라이언트 구조화”](#dio-클라이언트-구조화)

실제 앱에서는 Dio 클라이언트를 구조화하여 사용하는 것이 좋습니다:

api\_client.dart

```dart
1
class ApiClient {
2
  static final ApiClient _instance = ApiClient._internal();
3
  late final Dio dio;
4


5
  factory ApiClient() {
6
    return _instance;
7
  }
8


9
  ApiClient._internal() {
10
    dio = Dio(
11
      BaseOptions(
12
        baseUrl: 'https://api.example.com/v1',
13
        connectTimeout: const Duration(seconds: 5),
14
        receiveTimeout: const Duration(seconds: 3),
15
        headers: {
16
          'Content-Type': 'application/json',
17
          'Accept': 'application/json',
18
        },
19
      ),
20
    );
21


22
    // 인터셉터 추가
23
    dio.interceptors.add(LogInterceptor(
24
      requestBody: true,
25
      responseBody: true,
26
    ));
27


28
    dio.interceptors.add(CustomInterceptor());
29
  }
30


31
  // 사용자 API
32
  Future<List<User>> getUsers() async {
33
    try {
34
      final response = await dio.get('/users');
35
      return (response.data as List)
36
          .map((json) => User.fromJson(json))
37
          .toList();
38
    } on DioException catch (e) {
39
      throw _handleError(e);
40
    }
41
  }
42


43
  Future<User> getUserById(String id) async {
44
    try {
45
      final response = await dio.get('/users/$id');
46
      return User.fromJson(response.data);
47
    } on DioException catch (e) {
48
      throw _handleError(e);
49
    }
50
  }
51


52
  Future<User> createUser(UserCreateDto dto) async {
53
    try {
54
      final response = await dio.post(
55
        '/users',
56
        data: dto.toJson(),
57
      );
58
      return User.fromJson(response.data);
59
    } on DioException catch (e) {
60
      throw _handleError(e);
61
    }
62
  }
63


64
  // 상품 API
65
  Future<List<Product>> getProducts() async {
66
    try {
67
      final response = await dio.get('/products');
68
      return (response.data as List)
69
          .map((json) => Product.fromJson(json))
70
          .toList();
71
    } on DioException catch (e) {
72
      throw _handleError(e);
73
    }
74
  }
75


76
  // 공통 에러 처리
77
  Exception _handleError(DioException e) {
78
    switch (e.type) {
79
      case DioExceptionType.connectionTimeout:
80
      case DioExceptionType.sendTimeout:
81
      case DioExceptionType.receiveTimeout:
82
        return TimeoutException('네트워크 시간 초과');
83


84
      case DioExceptionType.badResponse:
85
        switch (e.response?.statusCode) {
86
          case 400:
87
            return BadRequestException(e.response?.data['message']);
88
          case 401:
89
            return UnauthorizedException(e.response?.data['message']);
90
          case 404:
91
            return NotFoundException(e.response?.data['message']);
92
          case 500:
93
            return ServerException(e.response?.data['message']);
94
          default:
95
            return ApiException('알 수 없는 에러: ${e.response?.statusCode}');
96
        }
97


98
      case DioExceptionType.cancel:
99
        return RequestCanceledException('요청이 취소됨');
100


101
      default:
102
        return NetworkException('네트워크 오류: ${e.message}');
103
    }
104
  }
105
}
106


107
// 사용자 정의 예외 클래스
108
class ApiException implements Exception {
109
  final String message;
110
  ApiException(this.message);
111
}
112


113
class TimeoutException extends ApiException {
114
  TimeoutException(String message) : super(message);
115
}
116


117
class BadRequestException extends ApiException {
118
  BadRequestException(String message) : super(message);
119
}
120


121
class UnauthorizedException extends ApiException {
122
  UnauthorizedException(String message) : super(message);
123
}
124


125
class NotFoundException extends ApiException {
126
  NotFoundException(String message) : super(message);
127
}
128


129
class ServerException extends ApiException {
130
  ServerException(String message) : super(message);
131
}
132


133
class RequestCanceledException extends ApiException {
134
  RequestCanceledException(String message) : super(message);
135
}
136


137
class NetworkException extends ApiException {
138
  NetworkException(String message) : super(message);
139
}
140


141
// 사용자 정의 인터셉터
142
class CustomInterceptor extends Interceptor {
143
  @override
144
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
145
    // 인증 토큰 추가
146
    final token = TokenManager.getToken();
147
    if (token != null) {
148
      options.headers['Authorization'] = 'Bearer $token';
149
    }
150
    handler.next(options);
151
  }
152


153
  @override
154
  void onError(DioException err, ErrorInterceptorHandler handler) async {
155
    // 401 에러 시 토큰 갱신 시도
156
    if (err.response?.statusCode == 401) {
157
      try {
158
        final isSuccess = await TokenManager.refreshToken();
159
        if (isSuccess) {
160
          // 토큰 갱신 성공 시 원래 요청 재시도
161
          final options = err.requestOptions;
162
          final token = TokenManager.getToken();
163
          options.headers['Authorization'] = 'Bearer $token';
164


165
          // 원래 요청 재시도
166
          final response = await Dio().fetch(options);
167
          return handler.resolve(response);
168
        }
169
      } catch (e) {
170
        // 토큰 갱신 실패 시 로그아웃
171
        AuthManager.logout();
172
      }
173
    }
174


175
    handler.next(err);
176
  }
177
}
```

## 실제 예제: 날씨 앱 API 통신

[Section titled “실제 예제: 날씨 앱 API 통신”](#실제-예제-날씨-앱-api-통신)

간단한 날씨 앱의 API 통신 예제를 살펴보겠습니다:

weather\_service.dart

```dart
1
class WeatherService {
2
  final Dio _dio;
3


4
  WeatherService() : _dio = Dio(
5
    BaseOptions(
6
      baseUrl: 'https://api.openweathermap.org/data/2.5',
7
      queryParameters: {
8
        'appid': 'YOUR_API_KEY',
9
        'units': 'metric',
10
        'lang': 'kr',
11
      },
12
    ),
13
  ) {
14
    _dio.interceptors.add(LogInterceptor(
15
      requestHeader: true,
16
      requestBody: true,
17
      responseBody: true,
18
      responseHeader: false,
19
      error: true,
20
    ));
21
  }
22


23
  Future<Weather> getCurrentWeather(String city) async {
24
    try {
25
      final response = await _dio.get(
26
        '/weather',
27
        queryParameters: {'q': city},
28
      );
29
      return Weather.fromJson(response.data);
30
    } on DioException catch (e) {
31
      if (e.response?.statusCode == 404) {
32
        throw CityNotFoundException('도시를 찾을 수 없습니다: $city');
33
      }
34
      throw WeatherServiceException('날씨 정보를 가져오는 중 오류 발생: ${e.message}');
35
    }
36
  }
37


38
  Future<Forecast> getForecast(String city) async {
39
    try {
40
      final response = await _dio.get(
41
        '/forecast',
42
        queryParameters: {'q': city},
43
      );
44
      return Forecast.fromJson(response.data);
45
    } on DioException catch (e) {
46
      if (e.response?.statusCode == 404) {
47
        throw CityNotFoundException('도시를 찾을 수 없습니다: $city');
48
      }
49
      throw WeatherServiceException('날씨 예보를 가져오는 중 오류 발생: ${e.message}');
50
    }
51
  }
52


53
  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
54
    try {
55
      final response = await _dio.get(
56
        '/weather',
57
        queryParameters: {
58
          'lat': lat.toString(),
59
          'lon': lon.toString(),
60
        },
61
      );
62
      return Weather.fromJson(response.data);
63
    } on DioException catch (e) {
64
      throw WeatherServiceException('날씨 정보를 가져오는 중 오류 발생: ${e.message}');
65
    }
66
  }
67
}
68


69
// 예외 클래스
70
class WeatherServiceException implements Exception {
71
  final String message;
72
  WeatherServiceException(this.message);
73


74
  @override
75
  String toString() => message;
76
}
77


78
class CityNotFoundException extends WeatherServiceException {
79
  CityNotFoundException(String message) : super(message);
80
}
81


82
// 위젯에서 사용 예
83
class WeatherScreen extends StatefulWidget {
84
  @override
85
  _WeatherScreenState createState() => _WeatherScreenState();
86
}
87


88
class _WeatherScreenState extends State<WeatherScreen> {
89
  final WeatherService _weatherService = WeatherService();
90
  Weather? _weather;
91
  bool _isLoading = false;
92
  String? _error;
93


94
  @override
95
  void initState() {
96
    super.initState();
97
    _fetchWeather();
98
  }
99


100
  Future<void> _fetchWeather() async {
101
    setState(() {
102
      _isLoading = true;
103
      _error = null;
104
    });
105


106
    try {
107
      final weather = await _weatherService.getCurrentWeather('Seoul');
108
      setState(() {
109
        _weather = weather;
110
        _isLoading = false;
111
      });
112
    } on CityNotFoundException catch (e) {
113
      setState(() {
114
        _error = e.toString();
115
        _isLoading = false;
116
      });
117
    } on WeatherServiceException catch (e) {
118
      setState(() {
119
        _error = e.toString();
120
        _isLoading = false;
121
      });
122
    } catch (e) {
123
      setState(() {
124
        _error = '알 수 없는 오류가 발생했습니다: $e';
125
        _isLoading = false;
126
      });
127
    }
128
  }
129


130
  @override
131
  Widget build(BuildContext context) {
132
    return Scaffold(
133
      appBar: AppBar(
134
        title: Text('날씨 앱'),
135
        actions: [
136
          IconButton(
137
            icon: Icon(Icons.refresh),
138
            onPressed: _fetchWeather,
139
          ),
140
        ],
141
      ),
142
      body: Center(
143
        child: _isLoading
144
            ? CircularProgressIndicator()
145
            : _error != null
146
                ? Text(_error!, style: TextStyle(color: Colors.red))
147
                : _buildWeatherInfo(),
148
      ),
149
    );
150
  }
151


152
  Widget _buildWeatherInfo() {
153
    if (_weather == null) {
154
      return Text('날씨 정보가 없습니다');
155
    }
156


157
    return Column(
158
      mainAxisAlignment: MainAxisAlignment.center,
159
      children: [
160
        Text(
161
          _weather!.cityName,
162
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
163
        ),
164
        SizedBox(height: 16),
165
        Row(
166
          mainAxisAlignment: MainAxisAlignment.center,
167
          children: [
168
            Image.network(
169
              'https://openweathermap.org/img/wn/${_weather!.iconCode}@2x.png',
170
              errorBuilder: (context, error, stackTrace) {
171
                return Icon(Icons.image_not_supported, size: 50);
172
              },
173
            ),
174
            Text(
175
              '${_weather!.temperature.toStringAsFixed(1)}°C',
176
              style: TextStyle(fontSize: 32),
177
            ),
178
          ],
179
        ),
180
        SizedBox(height: 16),
181
        Text(
182
          _weather!.description,
183
          style: TextStyle(fontSize: 16),
184
        ),
185
        SizedBox(height: 24),
186
        Row(
187
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
188
          children: [
189
            _buildWeatherDetail('습도', '${_weather!.humidity}%'),
190
            _buildWeatherDetail('풍속', '${_weather!.windSpeed} m/s'),
191
            _buildWeatherDetail('기압', '${_weather!.pressure} hPa'),
192
          ],
193
        ),
194
      ],
195
    );
196
  }
197


198
  Widget _buildWeatherDetail(String label, String value) {
199
    return Column(
200
      children: [
201
        Text(
202
          label,
203
          style: TextStyle(fontSize: 14, color: Colors.grey),
204
        ),
205
        SizedBox(height: 4),
206
        Text(
207
          value,
208
          style: TextStyle(fontSize: 16),
209
        ),
210
      ],
211
    );
212
  }
213
}
```

## 요약

[Section titled “요약”](#요약)

* **Dio**는 Flutter에서 HTTP 통신을 위한 강력하고 유연한 라이브러리입니다.
* **기본 기능**으로 GET, POST, PUT, DELETE 등의 HTTP 요청을 쉽게 만들 수 있습니다.
* **고급 기능**으로는 BaseOptions 설정, 인터셉터, 파일 업로드/다운로드, 요청 취소, 동시 요청 등이 있습니다.
* **에러 처리**는 `DioException`을 통해 세분화된 오류 정보를 얻을 수 있습니다.
* **구조화**된 API 클라이언트를 만들어 재사용성과 유지보수성을 높일 수 있습니다.

다음 장에서는 Dio를 통해 받은 JSON 데이터를 Dart 객체로 변환하는 JSON 직렬화(`json_serializable`, `freezed`) 방법에 대해 알아보겠습니다.

# JSON 직렬화 (freezed, json_serializable)

REST API와 통신할 때 JSON 형식의 데이터를 주고받는 경우가 많습니다. Flutter/Dart에서는 이러한 JSON 데이터를 Dart 객체로 변환하고, 반대로 Dart 객체를 JSON으로 직렬화하는 과정이 필요합니다. 이 장에서는 `json_serializable`과 `freezed` 패키지를 활용한 JSON 직렬화 방법을 살펴보겠습니다.

## JSON 직렬화의 필요성

[Section titled “JSON 직렬화의 필요성”](#json-직렬화의-필요성)

외부 API에서 데이터를 가져오면 보통 JSON 형태로 제공됩니다. 이를 그대로 사용하면 다음과 같은 문제가 발생합니다:

1. **타입 안전성 부재**: JSON은 동적 타입이므로 컴파일 시점에 오류를 발견하기 어렵습니다.
2. **코드 자동 완성 불가**: IDE에서 속성 이름을 자동 완성할 수 없습니다.
3. **리팩토링 어려움**: 속성 이름이 변경될 때 모든 참조를 업데이트하기 어렵습니다.
4. **문서화 부족**: 속성의 의미와 타입이 명확하게 정의되지 않습니다.

이러한 문제를 해결하기 위해 JSON을 Dart 클래스로 변환하는 과정이 필요합니다.

## 수동 JSON 직렬화

[Section titled “수동 JSON 직렬화”](#수동-json-직렬화)

가장 기본적인 방법은 JSON 변환 코드를 직접 작성하는 것입니다:

```dart
1
class User {
2
  final int id;
3
  final String name;
4
  final String email;
5
  final DateTime createdAt;
6


7
  User({
8
    required this.id,
9
    required this.name,
10
    required this.email,
11
    required this.createdAt,
12
  });
13


14
  // JSON에서 User 객체로 변환
15
  factory User.fromJson(Map<String, dynamic> json) {
16
    return User(
17
      id: json['id'] as int,
18
      name: json['name'] as String,
19
      email: json['email'] as String,
20
      createdAt: DateTime.parse(json['created_at'] as String),
21
    );
22
  }
23


24
  // User 객체에서 JSON으로 변환
25
  Map<String, dynamic> toJson() {
26
    return {
27
      'id': id,
28
      'name': name,
29
      'email': email,
30
      'created_at': createdAt.toIso8601String(),
31
    };
32
  }
33
}
```

이 방법은 간단한 모델에는 잘 작동하지만, 다음과 같은 단점이 있습니다:

1. **반복적인 코드**: 비슷한 코드를 여러 모델마다 작성해야 합니다.
2. **오류 가능성**: 수동으로 작성하다 보면 타입 캐스팅이나 누락된 필드 등의 오류가 발생할 수 있습니다.
3. **유지보수 어려움**: 모델이 변경될 때마다 JSON 변환 코드도 수정해야 합니다.

## json\_serializable 사용하기

[Section titled “json\_serializable 사용하기”](#json_serializable-사용하기)

`json_serializable` 패키지는 코드 생성을 통해 JSON 직렬화 코드를 자동으로 생성해 줍니다.

### 1. 패키지 설치

[Section titled “1. 패키지 설치”](#1-패키지-설치)

`pubspec.yaml` 파일에 필요한 패키지를 추가합니다:

```yaml
1
dependencies:
2
  json_annotation: ^4.9.0
3


4
dev_dependencies:
5
  build_runner:
6
  json_serializable: ^6.9.5
```

### 2. 모델 클래스 정의

[Section titled “2. 모델 클래스 정의”](#2-모델-클래스-정의)

```dart
1
import 'package:json_annotation/json_annotation.dart';
2


3
// 생성될 코드의 파일명을 지정합니다
4
part 'user.g.dart';
5


6
// 클래스에 어노테이션을 추가합니다
7
@JsonSerializable()
8
class User {
9
  final int id;
10
  final String name;
11
  final String email;
12


13
  // JSON 필드명이 Dart 속성명과 다른 경우 매핑
14
  @JsonKey(name: 'created_at')
15
  final DateTime createdAt;
16


17
  User({
18
    required this.id,
19
    required this.name,
20
    required this.email,
21
    required this.createdAt,
22
  });
23


24
  // 팩토리 메서드는 생성된 코드를 호출합니다
25
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
26


27
  // toJson 메서드도 생성된 코드를 호출합니다
28
  Map<String, dynamic> toJson() => _$UserToJson(this);
29
}
```

### 3. 코드 생성 실행

[Section titled “3. 코드 생성 실행”](#3-코드-생성-실행)

다음 명령어로 코드를 생성합니다:

```bash
1
dart run build_runner build
```

변경 사항을 감시하면서 지속적으로 코드를 생성하려면:

```bash
1
flutter pub run build_runner watch
```

기존 생성 파일과 충돌이 있을 경우:

```bash
1
dart run build_runner build --delete-conflicting-outputs
```

### 4. json\_serializable 고급 기능

[Section titled “4. json\_serializable 고급 기능”](#4-json_serializable-고급-기능)

#### 커스텀 변환기 사용

[Section titled “커스텀 변환기 사용”](#커스텀-변환기-사용)

```dart
1
@JsonSerializable()
2
class Product {
3
  final int id;
4
  final String name;
5


6
  // 커스텀 변환기 사용
7
  @JsonKey(
8
    fromJson: _colorFromJson,
9
    toJson: _colorToJson,
10
  )
11
  final Color color;
12


13
  Product({
14
    required this.id,
15
    required this.name,
16
    required this.color,
17
  });
18


19
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
20
  Map<String, dynamic> toJson() => _$ProductToJson(this);
21


22
  // 커스텀 변환 함수
23
  static Color _colorFromJson(String hex) => Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
24
  static String _colorToJson(Color color) => '#${color.value.toRadixString(16).substring(2)}';
25
}
```

Tip

[freezed\_annotation](https://pub.dev/packages/freezed_annotation)의 JSONConverter를 이용하면 조금 더 쉽게 JSON 직렬화를 하실 수 있습니다.

```sh
1
dart pub add freezed_annotation
```

color\_converter.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:freezed_annotation/freezed_annotation.dart';
3


4
/// Color 객체와 String(HEX) 간의 변환을 처리하는 JSONConverter
5
class ColorConverter implements JsonConverter<Color, String> {
6
  const ColorConverter();
7


8
  @override
9
  Color fromJson(String json) {
10
    // '#RRGGBB' 형태의 HEX 문자열을 Color 객체로 변환
11
    return Color(int.parse(json.substring(1), radix: 16) + 0xFF000000);
12
  }
13


14
  @override
15
  String toJson(Color object) {
16
    // Color 객체를 '#RRGGBB' 형태의 HEX 문자열로 변환
17
    return '#${object.value.toRadixString(16).substring(2)}';
18
  }
19
}
```

product.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:freezed_annotation/freezed_annotation.dart';
3


4
part 'product.g.dart';
5
part 'product.freezed.dart';
6


7
/// 객체 생성
8
/// final Product product = Product(
9
///   id: 1,
10
///   name: '빨간 상품',
11
///   color: Colors.red,
12
/// );
13
///
14
/// JSON으로 변환 - color는 자동으로 '#ff0000' 같은 문자열로 변환됨
15
/// final Map<String, dynamic> json = product.toJson();
16
/// print(json); // {id: 1, name: 빨간 상품, color: #ff0000}
17
///
18
/// JSON에서 객체로 변환 - '#ff0000' 같은 문자열은 자동으로 Color 객체로 변환됨
19
/// final Product loadedProduct = Product.fromJson(json);
20
/// print(loadedProduct.color); // Color(0xFFFF0000)
21
@freezed
22
class Product with _$Product {
23
  factory Product({
24
    required int id,
25
    required String name,
26
    @ColorConverter() required Color color,  // JSONConverter 적용
27
  }) = _Product;
28


29
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
30
}
```

#### 중첩 객체 처리

[Section titled “중첩 객체 처리”](#중첩-객체-처리)

```dart
1
@JsonSerializable(explicitToJson: true)
2
class Order {
3
  final int id;
4
  final DateTime orderDate;
5
  final User customer; // 중첩 객체
6
  final List<OrderItem> items; // 중첩 객체 리스트
7


8
  Order({
9
    required this.id,
10
    required this.orderDate,
11
    required this.customer,
12
    required this.items,
13
  });
14


15
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
16
  Map<String, dynamic> toJson() => _$OrderToJson(this);
17
}
18


19
@JsonSerializable()
20
class OrderItem {
21
  final int id;
22
  final String productName;
23
  final int quantity;
24
  final double price;
25


26
  OrderItem({
27
    required this.id,
28
    required this.productName,
29
    required this.quantity,
30
    required this.price,
31
  });
32


33
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
34
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
35
}
```

#### 필드 포함/제외 설정

[Section titled “필드 포함/제외 설정”](#필드-포함제외-설정)

```dart
1
@JsonSerializable()
2
class User {
3
  final int id;
4
  final String name;
5
  final String email;
6


7
  // API에서는 받지만 JSON으로 변환할 때는 제외
8
  @JsonKey(includeToJson: false)
9
  final String? authToken;
10


11
  // JSON으로 변환할 때만 포함
12
  @JsonKey(includeFromJson: false)
13
  final bool isLoggedIn;
14


15
  User({
16
    required this.id,
17
    required this.name,
18
    required this.email,
19
    this.authToken,
20
    this.isLoggedIn = false,
21
  });
22


23
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
24
  Map<String, dynamic> toJson() => _$UserToJson(this);
25
}
```

#### 기본값 설정

[Section titled “기본값 설정”](#기본값-설정)

```dart
1
@JsonSerializable()
2
class Settings {
3
  // 기본값 설정
4
  @JsonKey(defaultValue: 'light')
5
  final String theme;
6


7
  @JsonKey(defaultValue: true)
8
  final bool notifications;
9


10
  Settings({
11
    required this.theme,
12
    required this.notifications,
13
  });
14


15
  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
16
  Map<String, dynamic> toJson() => _$SettingsToJson(this);
17
}
```

#### null 안전성 처리

[Section titled “null 안전성 처리”](#null-안전성-처리)

```dart
1
@JsonSerializable(includeIfNull: false) // null 값은 JSON에 포함하지 않음
2
class Profile {
3
  final int id;
4
  final String name;
5


6
  // null일 수 있는 필드
7
  final String? bio;
8
  final String? avatarUrl;
9


10
  // null일 경우 기본값 설정
11
  @JsonKey(defaultValue: 0)
12
  final int followersCount;
13


14
  Profile({
15
    required this.id,
16
    required this.name,
17
    this.bio,
18
    this.avatarUrl,
19
    required this.followersCount,
20
  });
21


22
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
23
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
24
}
```

## freezed 패키지 소개

[Section titled “freezed 패키지 소개”](#freezed-패키지-소개)

`freezed`는 불변(immutable) 모델 클래스를 위한 코드 생성 패키지로, 다음과 같은 기능을 제공합니다:

1. **불변성**: 객체가 생성된 후 변경할 수 없도록 합니다.
2. **copyWith**: 기존 객체를 기반으로 일부 속성만 변경한 새 객체를 쉽게 생성합니다.
3. **동등성 비교**: `==` 연산자와 `hashCode`를 자동으로 구현합니다.
4. **직렬화**: `json_serializable`과 통합되어 JSON 직렬화를 지원합니다.
5. **패턴 매칭**: 다양한 타입의 데이터를 안전하게 처리할 수 있습니다.
6. **공용체(union types)**: 여러 타입을 하나의 타입으로 그룹화할 수 있습니다.

### 1. 패키지 설치

[Section titled “1. 패키지 설치”](#1-패키지-설치-1)

`pubspec.yaml`에 다음 패키지를 추가합니다:

```yaml
1
dependencies:
2
  freezed_annotation: ^2.4.1
3
  json_annotation: ^4.9.0
4


5
dev_dependencies:
6
  build_runner:
7
  freezed: ^2.4.5
8
  json_serializable: ^6.9.5
```

### 2. freezed 기본 모델 정의

[Section titled “2. freezed 기본 모델 정의”](#2-freezed-기본-모델-정의)

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
// 생성될 코드 파일명 지정
5
part 'user.freezed.dart';
6
part 'user.g.dart';
7


8
@freezed
9
class User with _$User {
10
  const factory User({
11
    required int id,
12
    required String name,
13
    required String email,
14
    @JsonKey(name: 'created_at') required DateTime createdAt,
15
  }) = _User;
16


17
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
18
}
```

### 3. 코드 생성 실행

[Section titled “3. 코드 생성 실행”](#3-코드-생성-실행-1)

```bash
1
dart run build_runner build --delete-conflicting-outputs
```

### 4. freezed 활용

[Section titled “4. freezed 활용”](#4-freezed-활용)

#### copyWith 사용

[Section titled “copyWith 사용”](#copywith-사용)

```dart
1
final user = User(
2
  id: 1,
3
  name: '홍길동',
4
  email: 'hong@example.com',
5
  createdAt: DateTime.now(),
6
);
7


8
// 이름만 변경한 새 객체 생성
9
final updatedUser = user.copyWith(name: '김철수');
10


11
print(user.name);      // '홍길동'
12
print(updatedUser.name); // '김철수'
```

#### 동등성 비교

[Section titled “동등성 비교”](#동등성-비교)

```dart
1
final user1 = User(
2
  id: 1,
3
  name: '홍길동',
4
  email: 'hong@example.com',
5
  createdAt: DateTime.now(),
6
);
7


8
// 같은 값을 가진 새 객체
9
final user2 = User(
10
  id: 1,
11
  name: '홍길동',
12
  email: 'hong@example.com',
13
  createdAt: user1.createdAt,
14
);
15


16
print(user1 == user2); // true
```

### 5. Union Types (대수적 데이터 타입)

[Section titled “5. Union Types (대수적 데이터 타입)”](#5-union-types-대수적-데이터-타입)

`freezed`의 강력한 기능 중 하나는 Union Types입니다. 이를 통해 여러 가능한 상태나 변형을 한 클래스로 표현할 수 있습니다.

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
part 'api_result.freezed.dart';
5
part 'api_result.g.dart';
6


7
@freezed
8
class ApiResult<T> with _$ApiResult<T> {
9
  // 성공 상태
10
  const factory ApiResult.success({
11
    required T data,
12
  }) = Success<T>;
13


14
  // 에러 상태
15
  const factory ApiResult.error({
16
    required String message,
17
    @Default(400) int statusCode,
18
  }) = Error<T>;
19


20
  // 로딩 상태
21
  const factory ApiResult.loading() = Loading<T>;
22


23
  factory ApiResult.fromJson(Map<String, dynamic> json) =>
24
      _$ApiResultFromJson(json);
25
}
```

#### Union Types 사용 예

[Section titled “Union Types 사용 예”](#union-types-사용-예)

```dart
1
Future<ApiResult<User>> fetchUser(int id) async {
2
  try {
3
    // 로딩 상태 반환
4
    ApiResult<User> loadingResult = ApiResult.loading();
5


6
    // API 호출
7
    final response = await dio.get('/users/$id');
8


9
    // 성공 상태 반환
10
    return ApiResult.success(data: User.fromJson(response.data));
11
  } catch (e) {
12
    // 에러 상태 반환
13
    return ApiResult.error(message: '사용자 정보를 가져오는 데 실패했습니다');
14
  }
15
}
16


17
// 위젯에서 사용
18
Widget build(BuildContext context) {
19
  return FutureBuilder<ApiResult<User>>(
20
    future: fetchUser(1),
21
    builder: (context, snapshot) {
22
      if (!snapshot.hasData) {
23
        return CircularProgressIndicator();
24
      }
25


26
      // when 메서드로 패턴 매칭
27
      return snapshot.data!.when(
28
        success: (user) => UserInfoWidget(user: user),
29
        error: (message, statusCode) => ErrorWidget(message: message),
30
        loading: () => LoadingWidget(),
31
      );
32
    },
33
  );
34
}
```

### 6. freezed의 고급 기능

[Section titled “6. freezed의 고급 기능”](#6-freezed의-고급-기능)

#### Default Values

[Section titled “Default Values”](#default-values)

```dart
1
@freezed
2
class Settings with _$Settings {
3
  const factory Settings({
4
    @Default('light') String theme,
5
    @Default(true) bool notifications,
6
    @Default([]) List<String> favorites,
7
  }) = _Settings;
8


9
  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
10
}
```

#### 커스텀 직렬화

[Section titled “커스텀 직렬화”](#커스텀-직렬화)

```dart
1
@freezed
2
class Product with _$Product {
3
  const factory Product({
4
    required int id,
5
    required String name,
6
    @JsonKey(
7
      fromJson: _colorFromJson,
8
      toJson: _colorToJson,
9
    )
10
    required Color color,
11
  }) = _Product;
12


13
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
14


15
  // 정적 메서드는 클래스 바디에 정의
16
  static Color _colorFromJson(String hex) => Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
17
  static String _colorToJson(Color color) => '#${color.value.toRadixString(16).substring(2)}';
18
}
```

#### 중첩 freezed 모델

[Section titled “중첩 freezed 모델”](#중첩-freezed-모델)

```dart
1
@freezed
2
class Order with _$Order {
3
  const factory Order({
4
    required int id,
5
    required DateTime orderDate,
6
    required User customer,
7
    required List<OrderItem> items,
8
  }) = _Order;
9


10
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
11
}
12


13
@freezed
14
class OrderItem with _$OrderItem {
15
  const factory OrderItem({
16
    required int id,
17
    required String productName,
18
    required int quantity,
19
    required double price,
20
  }) = _OrderItem;
21


22
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
23
}
```

#### 생성자 매개변수 검증

[Section titled “생성자 매개변수 검증”](#생성자-매개변수-검증)

```dart
1
@freezed
2
class User with _$User {
3
  // 프라이빗 생성자로 검증 로직 추가
4
  const factory User({
5
    required int id,
6
    required String name,
7
    required String email,
8
  }) = _User;
9


10
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
11


12
  // named 생성자를 통해 팩토리 패턴 구현
13
  factory User.create({
14
    required int id,
15
    required String name,
16
    required String email,
17
  }) {
18
    // 이메일 유효성 검사
19
    if (!_isValidEmail(email)) {
20
      throw ArgumentError('Invalid email format');
21
    }
22


23
    return User(id: id, name: name, email: email);
24
  }
25


26
  // 프라이빗 헬퍼 메서드
27
  static bool _isValidEmail(String email) {
28
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
29
  }
30
}
```

## freezed와 json\_serializable의 통합 활용

[Section titled “freezed와 json\_serializable의 통합 활용”](#freezed와-json_serializable의-통합-활용)

실제 앱에서는 freezed와 json\_serializable을 함께 사용하여 강력한 모델 클래스를 만들 수 있습니다. 다음은 일반적인 사용 패턴입니다:

### 1. API 응답 모델 정의

[Section titled “1. API 응답 모델 정의”](#1-api-응답-모델-정의)

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
part 'api_response.freezed.dart';
5
part 'api_response.g.dart';
6


7
@Freezed(genericArgumentFactories: true)
8
class ApiResponse<T> with _$ApiResponse<T> {
9
  const factory ApiResponse({
10
    required bool success,
11
    String? message,
12
    T? data,
13
    @Default([]) List<String> errors,
14
  }) = _ApiResponse<T>;
15


16
  factory ApiResponse.fromJson(
17
    Map<String, dynamic> json,
18
    T Function(Object? json) fromJsonT,
19
  ) =>
20
      _$ApiResponseFromJson(json, fromJsonT);
21
}
```

### 2. 도메인별 모델 정의

[Section titled “2. 도메인별 모델 정의”](#2-도메인별-모델-정의)

```dart
1
@freezed
2
class User with _$User {
3
  const factory User({
4
    required int id,
5
    required String name,
6
    required String email,
7
    @JsonKey(name: 'created_at') required DateTime createdAt,
8
    @Default([]) List<String> roles,
9
    String? avatarUrl,
10
  }) = _User;
11


12
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
13
}
14


15
@freezed
16
class Product with _$Product {
17
  const factory Product({
18
    required int id,
19
    required String name,
20
    required double price,
21
    @Default(0) int stock,
22
    String? description,
23
    @Default([]) List<String> categories,
24
    @Default(false) bool isFeatured,
25
  }) = _Product;
26


27
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
28
}
```

### 3. API 서비스에서 활용

[Section titled “3. API 서비스에서 활용”](#3-api-서비스에서-활용)

```dart
1
class ApiService {
2
  final Dio _dio;
3


4
  ApiService(this._dio);
5


6
  Future<ApiResponse<List<User>>> getUsers() async {
7
    try {
8
      final response = await _dio.get('/users');
9
      return ApiResponse.fromJson(
10
        response.data,
11
        (json) => (json as List)
12
            .map((item) => User.fromJson(item as Map<String, dynamic>))
13
            .toList(),
14
      );
15
    } catch (e) {
16
      return ApiResponse(
17
        success: false,
18
        message: '사용자 목록을 가져오는데 실패했습니다',
19
        errors: [e.toString()],
20
      );
21
    }
22
  }
23


24
  Future<ApiResponse<User>> getUserById(int id) async {
25
    try {
26
      final response = await _dio.get('/users/$id');
27
      return ApiResponse.fromJson(
28
        response.data,
29
        (json) => User.fromJson(json as Map<String, dynamic>),
30
      );
31
    } catch (e) {
32
      return ApiResponse(
33
        success: false,
34
        message: '사용자 정보를 가져오는데 실패했습니다',
35
        errors: [e.toString()],
36
      );
37
    }
38
  }
39
}
```

### 4. 뷰 모델에서 활용

[Section titled “4. 뷰 모델에서 활용”](#4-뷰-모델에서-활용)

```dart
1
class UserViewModel extends ChangeNotifier {
2
  final ApiService _apiService;
3


4
  UserViewModel(this._apiService);
5


6
  ApiResult<List<User>> _users = ApiResult.loading();
7
  ApiResult<List<User>> get users => _users;
8


9
  Future<void> fetchUsers() async {
10
    _users = ApiResult.loading();
11
    notifyListeners();
12


13
    try {
14
      final response = await _apiService.getUsers();
15


16
      if (response.success && response.data != null) {
17
        _users = ApiResult.success(data: response.data!);
18
      } else {
19
        _users = ApiResult.error(
20
          message: response.message ?? '알 수 없는 오류가 발생했습니다',
21
        );
22
      }
23
    } catch (e) {
24
      _users = ApiResult.error(message: e.toString());
25
    }
26


27
    notifyListeners();
28
  }
29
}
```

### 5. UI에서 활용

[Section titled “5. UI에서 활용”](#5-ui에서-활용)

```dart
1
class UsersScreen extends StatelessWidget {
2
  @override
3
  Widget build(BuildContext context) {
4
    final viewModel = Provider.of<UserViewModel>(context);
5


6
    return Scaffold(
7
      appBar: AppBar(title: Text('사용자 목록')),
8
      body: viewModel.users.when(
9
        loading: () => Center(child: CircularProgressIndicator()),
10
        success: (users) => ListView.builder(
11
          itemCount: users.length,
12
          itemBuilder: (context, index) {
13
            final user = users[index];
14
            return ListTile(
15
              title: Text(user.name),
16
              subtitle: Text(user.email),
17
              trailing: Icon(Icons.arrow_forward_ios),
18
              onTap: () => Navigator.pushNamed(
19
                context,
20
                '/user-details',
21
                arguments: user.id,
22
              ),
23
            );
24
          },
25
        ),
26
        error: (message, _) => Center(
27
          child: Column(
28
            mainAxisAlignment: MainAxisAlignment.center,
29
            children: [
30
              Text('오류: $message', style: TextStyle(color: Colors.red)),
31
              SizedBox(height: 16),
32
              ElevatedButton(
33
                onPressed: () => viewModel.fetchUsers(),
34
                child: Text('다시 시도'),
35
              ),
36
            ],
37
          ),
38
        ),
39
      ),
40
      floatingActionButton: FloatingActionButton(
41
        onPressed: () => viewModel.fetchUsers(),
42
        child: Icon(Icons.refresh),
43
      ),
44
    );
45
  }
46
}
```

## 실제 예제: Todo 앱 모델

[Section titled “실제 예제: Todo 앱 모델”](#실제-예제-todo-앱-모델)

Todo 앱을 위한 데이터 모델을 `freezed`와 `json_serializable`을 사용하여 구현해 보겠습니다:

todo.dart

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
part 'todo.freezed.dart';
5
part 'todo.g.dart';
6


7
@freezed
8
class Todo with _$Todo {
9
  const factory Todo({
10
    required String id,
11
    required String title,
12
    @Default('') String description,
13
    @Default(false) bool completed,
14
    @JsonKey(name: 'created_at') required DateTime createdAt,
15
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
16
    @Default('normal') String priority,
17
    @Default([]) List<String> tags,
18
  }) = _Todo;
19


20
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
21


22
  // 추가 팩토리 메서드
23
  factory Todo.create({
24
    required String title,
25
    String description = '',
26
    String priority = 'normal',
27
    List<String> tags = const [],
28
  }) {
29
    return Todo(
30
      id: DateTime.now().millisecondsSinceEpoch.toString(),
31
      title: title,
32
      description: description,
33
      createdAt: DateTime.now(),
34
      priority: priority,
35
      tags: tags,
36
    );
37
  }
38
}
39


40
// todo_status.dart
41
@freezed
42
class TodoStatus with _$TodoStatus {
43
  const factory TodoStatus.initial() = _Initial;
44
  const factory TodoStatus.loading() = _Loading;
45
  const factory TodoStatus.loaded({required List<Todo> todos}) = _Loaded;
46
  const factory TodoStatus.error({required String message}) = _Error;
47
}
48


49
// todo_repository.dart
50
class TodoRepository {
51
  final Dio _dio;
52


53
  TodoRepository(this._dio);
54


55
  Future<List<Todo>> getTodos() async {
56
    try {
57
      final response = await _dio.get('/todos');
58
      return (response.data as List)
59
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
60
          .toList();
61
    } catch (e) {
62
      throw Exception('할 일 목록을 가져오는데 실패했습니다: $e');
63
    }
64
  }
65


66
  Future<Todo> createTodo(Todo todo) async {
67
    try {
68
      final response = await _dio.post(
69
        '/todos',
70
        data: todo.toJson(),
71
      );
72
      return Todo.fromJson(response.data as Map<String, dynamic>);
73
    } catch (e) {
74
      throw Exception('할 일을 생성하는데 실패했습니다: $e');
75
    }
76
  }
77


78
  Future<Todo> updateTodo(Todo todo) async {
79
    try {
80
      final response = await _dio.put(
81
        '/todos/${todo.id}',
82
        data: todo.toJson(),
83
      );
84
      return Todo.fromJson(response.data as Map<String, dynamic>);
85
    } catch (e) {
86
      throw Exception('할 일을 업데이트하는데 실패했습니다: $e');
87
    }
88
  }
89


90
  Future<void> deleteTodo(String id) async {
91
    try {
92
      await _dio.delete('/todos/$id');
93
    } catch (e) {
94
      throw Exception('할 일을 삭제하는데 실패했습니다: $e');
95
    }
96
  }
97
}
98


99
// todo_view_model.dart
100
class TodoViewModel extends ChangeNotifier {
101
  final TodoRepository _repository;
102


103
  TodoViewModel(this._repository);
104


105
  TodoStatus _status = TodoStatus.initial();
106
  TodoStatus get status => _status;
107


108
  Future<void> fetchTodos() async {
109
    _status = TodoStatus.loading();
110
    notifyListeners();
111


112
    try {
113
      final todos = await _repository.getTodos();
114
      _status = TodoStatus.loaded(todos: todos);
115
    } catch (e) {
116
      _status = TodoStatus.error(message: e.toString());
117
    }
118


119
    notifyListeners();
120
  }
121


122
  Future<void> createTodo(String title, String description) async {
123
    try {
124
      final newTodo = Todo.create(
125
        title: title,
126
        description: description,
127
      );
128


129
      await _repository.createTodo(newTodo);
130
      await fetchTodos(); // 목록 새로고침
131
    } catch (e) {
132
      _status = TodoStatus.error(message: '할 일을 생성하는데 실패했습니다: ${e.toString()}');
133
      notifyListeners();
134
    }
135
  }
136


137
  Future<void> toggleTodoCompleted(Todo todo) async {
138
    try {
139
      final updatedTodo = todo.copyWith(
140
        completed: !todo.completed,
141
        updatedAt: DateTime.now(),
142
      );
143


144
      await _repository.updateTodo(updatedTodo);
145
      await fetchTodos(); // 목록 새로고침
146
    } catch (e) {
147
      _status = TodoStatus.error(message: '할 일 상태를 변경하는데 실패했습니다: ${e.toString()}');
148
      notifyListeners();
149
    }
150
  }
151


152
  Future<void> deleteTodo(String id) async {
153
    try {
154
      await _repository.deleteTodo(id);
155
      await fetchTodos(); // 목록 새로고침
156
    } catch (e) {
157
      _status = TodoStatus.error(message: '할 일을 삭제하는데 실패했습니다: ${e.toString()}');
158
      notifyListeners();
159
    }
160
  }
161
}
162


163
// todo_screen.dart
164
class TodoScreen extends StatelessWidget {
165
  @override
166
  Widget build(BuildContext context) {
167
    final viewModel = Provider.of<TodoViewModel>(context);
168


169
    return Scaffold(
170
      appBar: AppBar(title: Text('할 일 목록')),
171
      body: viewModel.status.when(
172
        initial: () {
173
          // 초기 데이터 로드
174
          WidgetsBinding.instance.addPostFrameCallback((_) {
175
            viewModel.fetchTodos();
176
          });
177
          return Center(child: Text('데이터를 로드합니다...'));
178
        },
179
        loading: () => Center(child: CircularProgressIndicator()),
180
        loaded: (todos) => todos.isEmpty
181
            ? Center(child: Text('할 일이 없습니다.'))
182
            : ListView.builder(
183
                itemCount: todos.length,
184
                itemBuilder: (context, index) {
185
                  final todo = todos[index];
186
                  return TodoItem(
187
                    todo: todo,
188
                    onToggle: () => viewModel.toggleTodoCompleted(todo),
189
                    onDelete: () => viewModel.deleteTodo(todo.id),
190
                  );
191
                },
192
              ),
193
        error: (message) => Center(
194
          child: Column(
195
            mainAxisAlignment: MainAxisAlignment.center,
196
            children: [
197
              Text('오류: $message', style: TextStyle(color: Colors.red)),
198
              SizedBox(height: 16),
199
              ElevatedButton(
200
                onPressed: () => viewModel.fetchTodos(),
201
                child: Text('다시 시도'),
202
              ),
203
            ],
204
          ),
205
        ),
206
      ),
207
      floatingActionButton: FloatingActionButton(
208
        onPressed: () => _showAddTodoDialog(context, viewModel),
209
        child: Icon(Icons.add),
210
      ),
211
    );
212
  }
213


214
  void _showAddTodoDialog(BuildContext context, TodoViewModel viewModel) {
215
    final titleController = TextEditingController();
216
    final descriptionController = TextEditingController();
217


218
    showDialog(
219
      context: context,
220
      builder: (context) => AlertDialog(
221
        title: Text('새 할 일 추가'),
222
        content: Column(
223
          mainAxisSize: MainAxisSize.min,
224
          children: [
225
            TextField(
226
              controller: titleController,
227
              decoration: InputDecoration(labelText: '제목'),
228
            ),
229
            TextField(
230
              controller: descriptionController,
231
              decoration: InputDecoration(labelText: '설명'),
232
              maxLines: 3,
233
            ),
234
          ],
235
        ),
236
        actions: [
237
          TextButton(
238
            onPressed: () => Navigator.pop(context),
239
            child: Text('취소'),
240
          ),
241
          ElevatedButton(
242
            onPressed: () {
243
              final title = titleController.text.trim();
244
              final description = descriptionController.text.trim();
245


246
              if (title.isNotEmpty) {
247
                viewModel.createTodo(title, description);
248
                Navigator.pop(context);
249
              }
250
            },
251
            child: Text('추가'),
252
          ),
253
        ],
254
      ),
255
    );
256
  }
257
}
258


259
// todo_item.dart
260
class TodoItem extends StatelessWidget {
261
  final Todo todo;
262
  final VoidCallback onToggle;
263
  final VoidCallback onDelete;
264


265
  const TodoItem({
266
    Key? key,
267
    required this.todo,
268
    required this.onToggle,
269
    required this.onDelete,
270
  }) : super(key: key);
271


272
  @override
273
  Widget build(BuildContext context) {
274
    return Dismissible(
275
      key: Key(todo.id),
276
      background: Container(
277
        color: Colors.red,
278
        alignment: Alignment.centerRight,
279
        padding: EdgeInsets.symmetric(horizontal: 16),
280
        child: Icon(Icons.delete, color: Colors.white),
281
      ),
282
      direction: DismissDirection.endToStart,
283
      onDismissed: (_) => onDelete(),
284
      child: ListTile(
285
        title: Text(
286
          todo.title,
287
          style: TextStyle(
288
            decoration: todo.completed ? TextDecoration.lineThrough : null,
289
            color: todo.completed ? Colors.grey : null,
290
          ),
291
        ),
292
        subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
293
        leading: Checkbox(
294
          value: todo.completed,
295
          onChanged: (_) => onToggle(),
296
        ),
297
        trailing: Row(
298
          mainAxisSize: MainAxisSize.min,
299
          children: [
300
            if (todo.priority == 'high')
301
              Icon(Icons.priority_high, color: Colors.red),
302
            Text(
303
              DateFormat.yMMMd().format(todo.createdAt),
304
              style: TextStyle(fontSize: 12),
305
            ),
306
          ],
307
        ),
308
      ),
309
    );
310
  }
311
}
```

## 요약

[Section titled “요약”](#요약)

* **JSON 직렬화**는 외부 API와 통신하는 Flutter 앱에서 필수적인 기능입니다.
* **수동 직렬화**는 간단한 모델에는 적합하지만, 모델이 복잡해질수록 코드 중복과 오류 가능성이 증가합니다.
* **json\_serializable** 패키지는 코드 생성을 통해 JSON 직렬화 코드를 자동으로 생성해 줍니다.
* **freezed** 패키지는 불변성, 복사본 생성, 동등성 비교, JSON 직렬화, 유니온 타입 등 강력한 기능을 제공합니다.
* **freezed와 json\_serializable의 통합**을 통해 타입 안전하고 유지보수하기 쉬운 모델 클래스를 만들 수 있습니다.

이 장에서 배운 기술을 활용하면 API 통신 코드의 안정성과 유지보수성을 크게 향상시킬 수 있습니다. 특히 복잡한 데이터 구조를 다루는 대규모 앱에서는 이러한 코드 생성 도구가 필수적입니다.

# 통합 테스트

통합 테스트(Integration Test)는 앱의 다양한 부분들이 함께 작동하는 방식을 검증하는 테스트입니다. 단위 테스트가 작은 코드 조각을, 위젯 테스트가 UI 컴포넌트를 검증한다면, 통합 테스트는 실제 디바이스나 에뮬레이터에서 앱 전체의 동작을 확인합니다.

## 통합 테스트의 필요성

[Section titled “통합 테스트의 필요성”](#통합-테스트의-필요성)

통합 테스트는 다음과 같은 이유로 중요합니다:

1. **실제 환경 검증**: 실제 디바이스나 에뮬레이터에서 앱의 동작을 테스트합니다.
2. **전체 기능 흐름 검증**: 사용자 시나리오에 따른 앱의 기능 흐름을 종합적으로 테스트합니다.
3. **성능 이슈 발견**: 실제 환경에서 발생할 수 있는 성능 문제를 조기에 발견합니다.
4. **기기별 호환성 검증**: 다양한 화면 크기와 OS 버전에서의 동작을 검증합니다.
5. **백엔드 연동 검증**: 실제 또는 테스트용 백엔드와의 통합 작동을 검증합니다.

## 테스트 종류별 특징

[Section titled “테스트 종류별 특징”](#테스트-종류별-특징)

## 통합 테스트 설정

[Section titled “통합 테스트 설정”](#통합-테스트-설정)

Flutter에서 통합 테스트를 수행하려면 `integration_test` 패키지를 사용합니다:

### 1. 패키지 추가

[Section titled “1. 패키지 추가”](#1-패키지-추가)

`pubspec.yaml` 파일에 다음 의존성을 추가합니다:

```yaml
1
dev_dependencies:
2
  integration_test:
3
    sdk: flutter
4
  flutter_test:
5
    sdk: flutter
```

### 2. 프로젝트 구조 설정

[Section titled “2. 프로젝트 구조 설정”](#2-프로젝트-구조-설정)

통합 테스트는 프로젝트 루트의 `integration_test` 디렉토리에 작성합니다:

```plaintext
1
my_app/
2
  ├── lib/
3
  ├── test/                 # 단위 및 위젯 테스트
4
  ├── integration_test/     # 통합 테스트
5
  │    └── app_test.dart
6
  └── pubspec.yaml
```

## 기본 통합 테스트 작성하기

[Section titled “기본 통합 테스트 작성하기”](#기본-통합-테스트-작성하기)

간단한 카운터 앱의 통합 테스트 예제를 살펴보겠습니다:

integration\_test/app\_test.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_test/flutter_test.dart';
3
import 'package:integration_test/integration_test.dart';
4
import 'package:my_app/main.dart' as app;
5


6
void main() {
7
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
8


9
  group('통합 테스트', () {
10
    testWidgets('카운터 증가 테스트', (WidgetTester tester) async {
11
      // 앱 실행
12
      app.main();
13
      await tester.pumpAndSettle();
14


15
      // 초기 상태 확인 - 카운터가 0인지
16
      expect(find.text('0'), findsOneWidget);
17


18
      // FloatingActionButton 찾기
19
      final Finder fab = find.byType(FloatingActionButton);
20


21
      // 버튼 탭하기
22
      await tester.tap(fab);
23
      await tester.pumpAndSettle();
24


25
      // 탭 후 카운터가 1로 증가했는지 확인
26
      expect(find.text('1'), findsOneWidget);
27


28
      // 한 번 더 탭하기
29
      await tester.tap(fab);
30
      await tester.pumpAndSettle();
31


32
      // 카운터가 2로 증가했는지 확인
33
      expect(find.text('2'), findsOneWidget);
34
    });
35
  });
36
}
```

### 주요 단계 설명

[Section titled “주요 단계 설명”](#주요-단계-설명)

1. **초기화**: `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`로 통합 테스트 환경을 초기화합니다.
2. **앱 실행**: `app.main()`으로 앱을 시작합니다.
3. **UI 안정화**: `tester.pumpAndSettle()`로 모든 애니메이션이 완료될 때까지 기다립니다.
4. **위젯 찾기**: `find`를 사용하여 상호작용할 위젯을 찾습니다.
5. **상호작용**: `tester.tap()`으로 위젯과 상호작용합니다.
6. **검증**: `expect`로 예상 결과를 확인합니다.

## 통합 테스트 실행하기

[Section titled “통합 테스트 실행하기”](#통합-테스트-실행하기)

통합 테스트를 실행하는 방법은 여러 가지가 있습니다:

### 1. 명령줄에서 실행

[Section titled “1. 명령줄에서 실행”](#1-명령줄에서-실행)

```bash
1
flutter test integration_test/app_test.dart
```

### 2. 여러 디바이스에서 실행

[Section titled “2. 여러 디바이스에서 실행”](#2-여러-디바이스에서-실행)

```bash
1
flutter test integration_test --device-id=all
```

### 3. Firebase Test Lab에서 실행

[Section titled “3. Firebase Test Lab에서 실행”](#3-firebase-test-lab에서-실행)

통합 테스트를 Firebase Test Lab에서 실행하면 다양한 기기에서 테스트할 수 있습니다.

#### Android의 경우:

[Section titled “Android의 경우:”](#android의-경우)

먼저 테스트 APK 파일들을 빌드합니다:

```bash
1
flutter build apk --profile
2
flutter build apk --profile --target=integration_test/app_test.dart
```

그런 다음 Firebase Test Lab으로 업로드하여 실행합니다:

```bash
1
gcloud firebase test android run \
2
  --type instrumentation \
3
  --app build/app/outputs/apk/profile/app-profile.apk \
4
  --test build/app/outputs/apk/androidTest/profile/app-profile-androidTest.apk \
5
  --device model=Pixel2,version=28
```

#### iOS의 경우:

[Section titled “iOS의 경우:”](#ios의-경우)

XCUITest 파일을 빌드하고 Firebase Test Lab으로 업로드합니다:

```bash
1
flutter build ios --profile --no-codesign
2
pushd ios
3
xcodebuild build-for-testing \
4
  -workspace Runner.xcworkspace \
5
  -scheme Runner \
6
  -configuration Debug \
7
  -derivedDataPath ../build/ios_integ
8
popd
9


10
gcloud firebase test ios run \
11
  --xcode-version=10.0 \
12
  --test build/ios_integ/Build/Products/Runner_iphoneos14.5-arm64.xctestrun
```

## 고급 통합 테스트 기법

[Section titled “고급 통합 테스트 기법”](#고급-통합-테스트-기법)

### 1. 스크린샷 캡처하기

[Section titled “1. 스크린샷 캡처하기”](#1-스크린샷-캡처하기)

테스트 과정에서 스크린샷을 캡처하여 UI 상태를 기록할 수 있습니다:

```dart
1
testWidgets('스크린샷 캡처 테스트', (WidgetTester tester) async {
2
  app.main();
3
  await tester.pumpAndSettle();
4


5
  // 초기 화면 스크린샷
6
  await takeScreenshot(tester, 'initial_screen');
7


8
  // 버튼 탭
9
  await tester.tap(find.byType(FloatingActionButton));
10
  await tester.pumpAndSettle();
11


12
  // 탭 후 화면 스크린샷
13
  await takeScreenshot(tester, 'after_tap');
14
});
15


16
Future<void> takeScreenshot(WidgetTester tester, String name) async {
17
  final Directory dir = Directory('screenshots');
18
  if (!dir.existsSync()) {
19
    dir.createSync();
20
  }
21


22
  final ByteData bytes = await tester.takeScreenshot();
23
  final File file = File('${dir.path}/$name.png');
24
  file.writeAsBytesSync(bytes.buffer.asUint8List());
25
}
```

### 2. 성능 프로파일링

[Section titled “2. 성능 프로파일링”](#2-성능-프로파일링)

테스트 중 앱의 성능을 측정할 수 있습니다:

```dart
1
testWidgets('성능 테스트', (WidgetTester tester) async {
2
  app.main();
3
  await tester.pumpAndSettle();
4


5
  final Stopwatch stopwatch = Stopwatch()..start();
6


7
  // 성능 테스트할 동작 수행
8
  for (int i = 0; i < 10; i++) {
9
    await tester.tap(find.byType(FloatingActionButton));
10
    await tester.pumpAndSettle();
11
  }
12


13
  stopwatch.stop();
14
  print('10회 탭 수행 시간: ${stopwatch.elapsedMilliseconds}ms');
15


16
  // 성능 기준 검증
17
  expect(stopwatch.elapsedMilliseconds, lessThan(2000)); // 2초 이내여야 함
18
});
```

### 3. 네트워크 요청 모킹

[Section titled “3. 네트워크 요청 모킹”](#3-네트워크-요청-모킹)

통합 테스트에서 실제 네트워크 요청을 모킹하려면, 앱을 실행하기 전에 `HttpOverrides`를 설정합니다:

```dart
1
import 'dart:io';
2


3
class MockHttpClient implements HttpClient {
4
  // HttpClient 메서드 구현...
5
}
6


7
class MockHttpOverrides extends HttpOverrides {
8
  @override
9
  HttpClient createHttpClient(SecurityContext? context) {
10
    return MockHttpClient();
11
  }
12
}
13


14
void main() {
15
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
16


17
  setUp(() {
18
    HttpOverrides.global = MockHttpOverrides();
19
  });
20


21
  testWidgets('네트워크 요청 모킹 테스트', (WidgetTester tester) async {
22
    app.main();
23
    await tester.pumpAndSettle();
24


25
    // 네트워크 요청이 포함된 동작 테스트
26
    await tester.tap(find.byType(ElevatedButton));
27
    await tester.pumpAndSettle();
28


29
    // 모킹된 응답에 따른 UI 상태 검증
30
    expect(find.text('모킹된 데이터'), findsOneWidget);
31
  });
32
}
```

### 4. 실제 사용자 흐름 테스트

[Section titled “4. 실제 사용자 흐름 테스트”](#4-실제-사용자-흐름-테스트)

실제 사용자 흐름을 시뮬레이션하는 종합적인 테스트를 작성할 수 있습니다:

```dart
1
testWidgets('사용자 로그인 및 데이터 조회 흐름', (WidgetTester tester) async {
2
  app.main();
3
  await tester.pumpAndSettle();
4


5
  // 로그인 화면에서 이메일 필드 찾기
6
  expect(find.byKey(const Key('email_field')), findsOneWidget);
7


8
  // 이메일 입력
9
  await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
10
  await tester.pumpAndSettle();
11


12
  // 비밀번호 입력
13
  await tester.enterText(find.byKey(const Key('password_field')), 'password123');
14
  await tester.pumpAndSettle();
15


16
  // 로그인 버튼 탭
17
  await tester.tap(find.byKey(const Key('login_button')));
18
  await tester.pumpAndSettle();
19


20
  // 로그인 후 홈 화면으로 이동했는지 확인
21
  expect(find.text('홈 화면'), findsOneWidget);
22


23
  // 데이터 조회 버튼 탭
24
  await tester.tap(find.byKey(const Key('fetch_data_button')));
25
  await tester.pumpAndSettle();
26


27
  // 로딩 인디케이터 표시 확인
28
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
29


30
  // 데이터 로딩 완료 대기 (최대 10초)
31
  await tester.pumpAndSettle(const Duration(seconds: 10));
32


33
  // 데이터가 정상적으로 표시되었는지 확인
34
  expect(find.byType(ListView), findsOneWidget);
35
  expect(find.byType(ListTile), findsWidgets);
36
});
```

## 테스트 실행 구조

[Section titled “테스트 실행 구조”](#테스트-실행-구조)

통합 테스트가 실행되는 방식을 이해하면 디버깅에 도움이 됩니다:

## 통합 테스트 모범 사례

[Section titled “통합 테스트 모범 사례”](#통합-테스트-모범-사례)

### 1. 주요 사용자 경로 테스트하기

[Section titled “1. 주요 사용자 경로 테스트하기”](#1-주요-사용자-경로-테스트하기)

모든 기능을 통합 테스트하는 것은 비효율적입니다. 대신, 다음과 같은 주요 사용자 경로(Critical User Paths)에 집중하세요:

* 사용자 등록 및 로그인
* 주요 데이터 조회 및 생성
* 결제 프로세스
* 앱의 핵심 기능

### 2. 테스트 분리 및 구성

[Section titled “2. 테스트 분리 및 구성”](#2-테스트-분리-및-구성)

복잡한 통합 테스트는 논리적인 단계로 분리하세요:

```dart
1
void main() {
2
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
3


4
  group('사용자 계정 테스트', () {
5
    testWidgets('회원가입', signUpTest);
6
    testWidgets('로그인', loginTest);
7
    testWidgets('프로필 수정', editProfileTest);
8
  });
9


10
  group('콘텐츠 관리 테스트', () {
11
    testWidgets('콘텐츠 조회', viewContentTest);
12
    testWidgets('콘텐츠 생성', createContentTest);
13
    testWidgets('콘텐츠 편집', editContentTest);
14
  });
15
}
16


17
// 각 테스트 함수 구현
18
Future<void> signUpTest(WidgetTester tester) async {
19
  // 회원가입 테스트 로직
20
}
21


22
Future<void> loginTest(WidgetTester tester) async {
23
  // 로그인 테스트 로직
24
}
25


26
// 기타 테스트 함수...
```

### 3. 공통 기능 추출

[Section titled “3. 공통 기능 추출”](#3-공통-기능-추출)

여러 테스트에서 반복되는 로직은 헬퍼 함수로 추출하세요:

```dart
1
// 로그인 헬퍼 함수
2
Future<void> loginToApp(WidgetTester tester, {String email = 'test@example.com', String password = 'password123'}) async {
3
  await tester.enterText(find.byKey(const Key('email_field')), email);
4
  await tester.pumpAndSettle();
5


6
  await tester.enterText(find.byKey(const Key('password_field')), password);
7
  await tester.pumpAndSettle();
8


9
  await tester.tap(find.byKey(const Key('login_button')));
10
  await tester.pumpAndSettle();
11


12
  // 로그인 성공 확인
13
  expect(find.text('홈 화면'), findsOneWidget);
14
}
15


16
// 테스트에서 사용
17
testWidgets('데이터 조회 테스트', (WidgetTester tester) async {
18
  app.main();
19
  await tester.pumpAndSettle();
20


21
  // 로그인 헬퍼 함수 사용
22
  await loginToApp(tester);
23


24
  // 추가 테스트 로직...
25
});
```

### 4. 테스트 환경 설정

[Section titled “4. 테스트 환경 설정”](#4-테스트-환경-설정)

테스트별로 앱 상태를 초기화하여 테스트간 독립성을 유지하세요:

```dart
1
setUp(() async {
2
  // 선택적: 앱 상태 초기화 (예: SharedPreferences 초기화)
3
  SharedPreferences.setMockInitialValues({});
4


5
  // 선택적: 네트워크 요청 모킹
6
  HttpOverrides.global = MockHttpOverrides();
7
});
8


9
tearDown(() async {
10
  // 테스트 후 정리 작업
11
  HttpOverrides.global = null;
12
});
```

### 5. 테스트 안정성 개선

[Section titled “5. 테스트 안정성 개선”](#5-테스트-안정성-개선)

통합 테스트는 불안정할 수 있으므로, 테스트 안정성을 높이는 방법을 적용하세요:

```dart
1
// 요소가 나타날 때까지 기다리기
2
Future<void> waitForElement(WidgetTester tester, Finder finder, {Duration timeout = const Duration(seconds: 10)}) async {
3
  final end = DateTime.now().add(timeout);
4
  while (DateTime.now().isBefore(end)) {
5
    if (finder.evaluate().isNotEmpty) {
6
      return;
7
    }
8
    await tester.pump(const Duration(milliseconds: 100));
9
  }
10


11
  // 시간 초과시 오류
12
  throw TimeoutException('요소를 찾을 수 없습니다: $finder', timeout);
13
}
14


15
// 사용 예
16
testWidgets('비동기 데이터 로딩 테스트', (WidgetTester tester) async {
17
  app.main();
18
  await tester.pumpAndSettle();
19


20
  await tester.tap(find.byType(ElevatedButton));
21
  await tester.pump(); // 첫 프레임만 업데이트
22


23
  // 로딩 인디케이터 확인
24
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
25


26
  // 데이터가 로드될 때까지 기다림
27
  await waitForElement(tester, find.byType(ListView));
28


29
  // 데이터 검증
30
  expect(find.byType(ListTile), findsWidgets);
31
});
```

## CI/CD 통합

[Section titled “CI/CD 통합”](#cicd-통합)

통합 테스트를 CI/CD 파이프라인에 통합하면 코드 품질을 지속적으로 검증할 수 있습니다:

### GitHub Actions 예제

[Section titled “GitHub Actions 예제”](#github-actions-예제)

```yaml
1
name: Flutter Integration Tests
2


3
on:
4
  push:
5
    branches: [main]
6
  pull_request:
7
    branches: [main]
8


9
jobs:
10
  test:
11
    runs-on: macos-latest
12
    steps:
13
      - uses: actions/checkout@v3
14
      - uses: subosito/flutter-action@v2
15
        with:
16
          flutter-version: "3.10.0"
17
          channel: "stable"
18


19
      - name: Install dependencies
20
        run: flutter pub get
21


22
      - name: Run integration tests
23
        run: flutter test integration_test/app_test.dart
24


25
      # 선택적: 실제 기기에서 테스트 (Android)
26
      - name: Build and run Android integration tests
27
        uses: reactivecircus/android-emulator-runner@v2
28
        with:
29
          api-level: 29
30
          arch: x86_64
31
          profile: Nexus 6
32
          script: flutter test integration_test/app_test.dart -d `flutter devices | grep emulator | cut -d" " -f1`
```

## Codemagic 예제

[Section titled “Codemagic 예제”](#codemagic-예제)

```yaml
1
workflows:
2
  integration-test:
3
    name: Integration Tests
4
    instance_type: mac_mini_m1
5
    environment:
6
      flutter: stable
7
    scripts:
8
      - name: Get dependencies
9
        script: flutter pub get
10
      - name: Run integration tests on iOS Simulator
11
        script: |
12
          xcrun simctl create Flutter-iPhone com.apple.CoreSimulator.SimDeviceType.iPhone-11 com.apple.CoreSimulator.SimRuntime.iOS-14-4
13
          xcrun simctl boot Flutter-iPhone
14
          flutter test integration_test/app_test.dart -d Flutter-iPhone
```

## 결론

[Section titled “결론”](#결론)

통합 테스트는 Flutter 앱의 최종 품질을 보장하는 데 중요한 단계입니다. 단위 테스트와 위젯 테스트가 앱의 개별 부분을 검증한다면, 통합 테스트는 전체 앱이 실제 사용자 시나리오에서 올바르게 작동하는지 확인합니다.

통합 테스트는 시간과 리소스가 많이 소요되므로, 모든 기능을 테스트하기보다는 주요 사용자 경로와 비즈니스 크리티컬한 기능에 집중하는 것이 좋습니다. 테스트를 구조화하고 공통 기능을 추출하여 유지보수성을 높이세요.

다음 장에서는 테스팅 도구에 대해 더 자세히 알아보겠습니다. Mockito, golden test, coverage 등의 도구를 활용하여 Flutter 앱 테스트를 더욱 효과적으로 수행하는 방법을 살펴볼 것입니다.

# 단위 테스트

소프트웨어 개발에서 테스트는 코드의 정확성을 검증하고 결함을 조기에 발견하는 데 핵심적인 역할을 합니다. 이 장에서는 Flutter 애플리케이션의 단위 테스트에 대해 다루겠습니다. 단위 테스트는 코드의 가장 작은 단위(일반적으로 함수나 메서드)가 예상대로 작동하는지 확인하는 테스트입니다.

## 단위 테스트의 중요성

[Section titled “단위 테스트의 중요성”](#단위-테스트의-중요성)

단위 테스트는 다음과 같은 여러 이유로 중요합니다:

1. **버그 조기 발견**: 코드 변경이 기존 기능을 손상시키지 않는지 확인할 수 있습니다.
2. **리팩토링 신뢰성**: 코드를 변경하더라도 동작이 여전히 올바른지 확인할 수 있습니다.
3. **문서화**: 테스트는 코드가 어떻게 동작해야 하는지 보여주는 생생한 문서 역할을 합니다.
4. **설계 개선**: 테스트를 작성하면 종종 더 나은 코드 설계로 이어집니다.
5. **개발 속도 향상**: 장기적으로 디버깅 시간이 줄어들어 개발 속도가 빨라집니다.

## Flutter에서 단위 테스트 설정하기

[Section titled “Flutter에서 단위 테스트 설정하기”](#flutter에서-단위-테스트-설정하기)

### 1. 의존성 추가

[Section titled “1. 의존성 추가”](#1-의존성-추가)

Flutter 프로젝트에서 단위 테스트를 시작하려면 `pubspec.yaml` 파일에 필요한 패키지를 추가해야 합니다:

```yaml
1
dev_dependencies:
2
  flutter_test:
3
    sdk: flutter
4
  test: ^1.24.1
```

`flutter_test`는 Flutter SDK의 일부로, Flutter 위젯을 테스트하는 데 필요한 도구를 제공합니다. `test` 패키지는 일반 Dart 코드를 테스트하는 데 사용됩니다.

### 2. 테스트 파일 구성

[Section titled “2. 테스트 파일 구성”](#2-테스트-파일-구성)

테스트 파일은 일반적으로 프로젝트의 `test` 디렉토리에 위치합니다. 테스트 파일 이름은 관례적으로 `{파일명}_test.dart` 형식을 따릅니다:

```plaintext
1
my_app/
2
  ├── lib/
3
  │    ├── models/
4
  │    │    └── user.dart
5
  │    └── utils/
6
  │         └── validator.dart
7
  └── test/
8
       ├── models/
9
       │    └── user_test.dart
10
       └── utils/
11
            └── validator_test.dart
```

## 기본 단위 테스트 작성하기

[Section titled “기본 단위 테스트 작성하기”](#기본-단위-테스트-작성하기)

### 1. 간단한 유틸리티 함수 테스트

[Section titled “1. 간단한 유틸리티 함수 테스트”](#1-간단한-유틸리티-함수-테스트)

먼저 테스트할 간단한 유틸리티 함수를 살펴보겠습니다:

lib/utils/calculator.dart

```dart
1
class Calculator {
2
  int add(int a, int b) => a + b;
3
  int subtract(int a, int b) => a - b;
4
  int multiply(int a, int b) => a * b;
5
  double divide(int a, int b) {
6
    if (b == 0) {
7
      throw ArgumentError('Cannot divide by zero');
8
    }
9
    return a / b;
10
  }
11
}
```

이제 이 `Calculator` 클래스의 단위 테스트를 작성해 보겠습니다:

test/utils/calculator\_test.dart

```dart
1
import 'package:flutter_test/flutter_test.dart';
2
import 'package:my_app/utils/calculator.dart';
3


4
void main() {
5
  late Calculator calculator;
6


7
  setUp(() {
8
    calculator = Calculator();
9
  });
10


11
  group('Calculator', () {
12
    test('add returns the sum of two numbers', () {
13
      // Arrange & Act
14
      final result = calculator.add(2, 3);
15


16
      // Assert
17
      expect(result, 5);
18
    });
19


20
    test('subtract returns the difference of two numbers', () {
21
      expect(calculator.subtract(5, 2), 3);
22
    });
23


24
    test('multiply returns the product of two numbers', () {
25
      expect(calculator.multiply(3, 4), 12);
26
    });
27


28
    test('divide returns the quotient of two numbers', () {
29
      expect(calculator.divide(10, 2), 5.0);
30
    });
31


32
    test('divide throws ArgumentError when dividing by zero', () {
33
      expect(
34
        () => calculator.divide(10, 0),
35
        throwsA(isA<ArgumentError>()),
36
      );
37
    });
38
  });
39
}
```

### 2. 테스트 실행하기

[Section titled “2. 테스트 실행하기”](#2-테스트-실행하기)

테스트를 실행하는 방법은 여러 가지가 있습니다:

**명령줄에서 실행:**

```bash
1
flutter test
```

특정 테스트 파일만 실행:

```bash
1
flutter test test/utils/calculator_test.dart
```

**IDE에서 실행:**

대부분의 IDE(예: VS Code, Android Studio)는 테스트 파일 옆에 실행 버튼을 제공하여 쉽게 테스트를 실행할 수 있습니다.

## 모델 클래스 테스트

[Section titled “모델 클래스 테스트”](#모델-클래스-테스트)

모델 클래스의 테스트는 특히 JSON 변환과 관련된 코드를 검증하는 데 유용합니다:

lib/models/user.dart

```dart
1
class User {
2
  final int id;
3
  final String name;
4
  final String email;
5


6
  User({
7
    required this.id,
8
    required this.name,
9
    required this.email,
10
  });
11


12
  factory User.fromJson(Map<String, dynamic> json) {
13
    return User(
14
      id: json['id'] as int,
15
      name: json['name'] as String,
16
      email: json['email'] as String,
17
    );
18
  }
19


20
  Map<String, dynamic> toJson() {
21
    return {
22
      'id': id,
23
      'name': name,
24
      'email': email,
25
    };
26
  }
27


28
  @override
29
  bool operator ==(Object other) {
30
    if (identical(this, other)) return true;
31
    return other is User &&
32
        other.id == id &&
33
        other.name == name &&
34
        other.email == email;
35
  }
36


37
  @override
38
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
39
}
```

이 `User` 클래스에 대한 테스트:

test/models/user\_test.dart

```dart
1
import 'package:flutter_test/flutter_test.dart';
2
import 'package:my_app/models/user.dart';
3


4
void main() {
5
  group('User', () {
6
    test('fromJson creates a User instance correctly', () {
7
      // Arrange
8
      final json = {
9
        'id': 1,
10
        'name': '홍길동',
11
        'email': 'hong@example.com',
12
      };
13


14
      // Act
15
      final user = User.fromJson(json);
16


17
      // Assert
18
      expect(user.id, 1);
19
      expect(user.name, '홍길동');
20
      expect(user.email, 'hong@example.com');
21
    });
22


23
    test('toJson returns correct map', () {
24
      // Arrange
25
      final user = User(
26
        id: 1,
27
        name: '홍길동',
28
        email: 'hong@example.com',
29
      );
30


31
      // Act
32
      final json = user.toJson();
33


34
      // Assert
35
      expect(json, {
36
        'id': 1,
37
        'name': '홍길동',
38
        'email': 'hong@example.com',
39
      });
40
    });
41


42
    test('equality works correctly', () {
43
      // Arrange
44
      final user1 = User(id: 1, name: '홍길동', email: 'hong@example.com');
45
      final user2 = User(id: 1, name: '홍길동', email: 'hong@example.com');
46
      final user3 = User(id: 2, name: '김철수', email: 'kim@example.com');
47


48
      // Assert
49
      expect(user1, equals(user2));
50
      expect(user1, isNot(equals(user3)));
51
    });
52


53
    test('fromJson throws when fields are missing', () {
54
      // Arrange
55
      final incompleteJson = {
56
        'id': 1,
57
        'name': '홍길동',
58
        // email이 누락됨
59
      };
60


61
      // Act & Assert
62
      expect(
63
        () => User.fromJson(incompleteJson),
64
        throwsA(isA<TypeError>()),
65
      );
66
    });
67
  });
68
}
```

## 비동기 코드 테스트

[Section titled “비동기 코드 테스트”](#비동기-코드-테스트)

Flutter 앱에서는 네트워크 요청, 파일 입출력 등 비동기 코드가 흔합니다. 이러한 코드를 테스트하는 방법을 살펴보겠습니다:

lib/services/user\_service.dart

```dart
1
import 'dart:convert';
2
import 'package:http/http.dart' as http;
3
import '../models/user.dart';
4


5
class UserService {
6
  final String baseUrl;
7
  final http.Client client;
8


9
  UserService({
10
    required this.baseUrl,
11
    required this.client,
12
  });
13


14
  Future<User> fetchUser(int id) async {
15
    final response = await client.get(Uri.parse('$baseUrl/users/$id'));
16


17
    if (response.statusCode == 200) {
18
      return User.fromJson(json.decode(response.body));
19
    } else {
20
      throw Exception('Failed to load user');
21
    }
22
  }
23


24
  Future<List<User>> fetchUsers() async {
25
    final response = await client.get(Uri.parse('$baseUrl/users'));
26


27
    if (response.statusCode == 200) {
28
      final List<dynamic> userJsonList = json.decode(response.body);
29
      return userJsonList.map((json) => User.fromJson(json)).toList();
30
    } else {
31
      throw Exception('Failed to load users');
32
    }
33
  }
34
}
```

이 `UserService` 클래스의 단위 테스트:

test/services/user\_service\_test.dart

```dart
1
import 'dart:convert';
2
import 'package:flutter_test/flutter_test.dart';
3
import 'package:http/http.dart' as http;
4
import 'package:mockito/annotations.dart';
5
import 'package:mockito/mockito.dart';
6
import 'package:my_app/models/user.dart';
7
import 'package:my_app/services/user_service.dart';
8


9
import 'user_service_test.mocks.dart';
10


11
// Mockito를 사용하여 http.Client 클래스를 모방하는 Mock 클래스 생성
12
@GenerateMocks([http.Client])
13
void main() {
14
  late MockClient mockClient;
15
  late UserService userService;
16


17
  setUp(() {
18
    mockClient = MockClient();
19
    userService = UserService(
20
      baseUrl: 'https://api.example.com',
21
      client: mockClient,
22
    );
23
  });
24


25
  group('UserService', () {
26
    test('fetchUser returns a User if the http call completes successfully', () async {
27
      // Arrange
28
      final userData = {
29
        'id': 1,
30
        'name': '홍길동',
31
        'email': 'hong@example.com',
32
      };
33


34
      // mock 클라이언트가 GET 요청을 받으면 가짜 응답을 반환하도록 설정
35
      when(mockClient.get(Uri.parse('https://api.example.com/users/1')))
36
          .thenAnswer((_) async => http.Response(json.encode(userData), 200));
37


38
      // Act
39
      final user = await userService.fetchUser(1);
40


41
      // Assert
42
      expect(user.id, 1);
43
      expect(user.name, '홍길동');
44
      expect(user.email, 'hong@example.com');
45
    });
46


47
    test('fetchUser throws an exception if the http call fails', () async {
48
      // Arrange
49
      when(mockClient.get(Uri.parse('https://api.example.com/users/1')))
50
          .thenAnswer((_) async => http.Response('Not Found', 404));
51


52
      // Act & Assert
53
      expect(userService.fetchUser(1), throwsException);
54
    });
55


56
    test('fetchUsers returns a list of Users if the http call completes successfully', () async {
57
      // Arrange
58
      final usersData = [
59
        {
60
          'id': 1,
61
          'name': '홍길동',
62
          'email': 'hong@example.com',
63
        },
64
        {
65
          'id': 2,
66
          'name': '김철수',
67
          'email': 'kim@example.com',
68
        },
69
      ];
70


71
      when(mockClient.get(Uri.parse('https://api.example.com/users')))
72
          .thenAnswer((_) async => http.Response(json.encode(usersData), 200));
73


74
      // Act
75
      final users = await userService.fetchUsers();
76


77
      // Assert
78
      expect(users.length, 2);
79
      expect(users[0].id, 1);
80
      expect(users[0].name, '홍길동');
81
      expect(users[1].id, 2);
82
      expect(users[1].name, '김철수');
83
    });
84
  });
85
}
```

이 테스트를 실행하기 전에 Mockito 패키지를 설치하고 코드를 생성해야 합니다:

```yaml
1
dev_dependencies:
2
  flutter_test:
3
    sdk: flutter
4
  mockito: ^5.4.2
5
  build_runner: ^2.4.6
```

그리고 다음 명령어를 실행하여 Mock 클래스를 생성합니다:

```bash
1
dart run build_runner build
```

## 비즈니스 로직 레이어(Provider, Riverpod, Bloc 등) 테스트

[Section titled “비즈니스 로직 레이어(Provider, Riverpod, Bloc 등) 테스트”](#비즈니스-로직-레이어provider-riverpod-bloc-등-테스트)

상태 관리 라이브러리를 사용하는 비즈니스 로직 레이어 테스트를 살펴보겠습니다. 여기서는 Riverpod를 예시로 들겠습니다:

lib/providers/counter\_provider.dart

```dart
1
import 'package:riverpod_annotation/riverpod_annotation.dart';
2


3
part 'counter_provider.g.dart';
4


5
@riverpod
6
class Counter extends _$Counter {
7
  @override
8
  int build() => 0;
9


10
  void increment() {
11
    state = state + 1;
12
  }
13


14
  void decrement() {
15
    if (state > 0) {
16
      state = state - 1;
17
    }
18
  }
19


20
  void reset() {
21
    state = 0;
22
  }
23
}
```

이 Riverpod 프로바이더의 단위 테스트:

test/providers/counter\_provider\_test.dart

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2
import 'package:flutter_test/flutter_test.dart';
3
import 'package:my_app/providers/counter_provider.dart';
4


5
void main() {
6
  late ProviderContainer container;
7


8
  setUp(() {
9
    container = ProviderContainer();
10
  });
11


12
  tearDown(() {
13
    container.dispose();
14
  });
15


16
  group('CounterProvider', () {
17
    test('initial value is 0', () {
18
      final value = container.read(counterProvider);
19
      expect(value, 0);
20
    });
21


22
    test('increment increases state by 1', () {
23
      final notifier = container.read(counterProvider.notifier);
24


25
      // 초기값 확인
26
      expect(container.read(counterProvider), 0);
27


28
      // 증가 실행
29
      notifier.increment();
30


31
      // 변경된 값 확인
32
      expect(container.read(counterProvider), 1);
33
    });
34


35
    test('decrement decreases state by 1', () {
36
      final notifier = container.read(counterProvider.notifier);
37


38
      // 초기값을 1로 변경
39
      notifier.increment();
40
      expect(container.read(counterProvider), 1);
41


42
      // 감소 실행
43
      notifier.decrement();
44


45
      // 변경된 값 확인
46
      expect(container.read(counterProvider), 0);
47
    });
48


49
    test('decrement does not go below 0', () {
50
      final notifier = container.read(counterProvider.notifier);
51


52
      // 초기값 확인
53
      expect(container.read(counterProvider), 0);
54


55
      // 감소 실행
56
      notifier.decrement();
57


58
      // 여전히 0이어야 함
59
      expect(container.read(counterProvider), 0);
60
    });
61


62
    test('reset sets state back to 0', () {
63
      final notifier = container.read(counterProvider.notifier);
64


65
      // 증가 실행
66
      notifier.increment();
67
      notifier.increment();
68
      expect(container.read(counterProvider), 2);
69


70
      // 리셋 실행
71
      notifier.reset();
72


73
      // 0으로 리셋됨
74
      expect(container.read(counterProvider), 0);
75
    });
76


77
    test('confirms state changes correctly with multiple operations', () {
78
      final notifier = container.read(counterProvider.notifier);
79


80
      notifier.increment(); // 1
81
      notifier.increment(); // 2
82
      notifier.decrement(); // 1
83
      notifier.increment(); // 2
84
      notifier.increment(); // 3
85


86
      expect(container.read(counterProvider), 3);
87
    });
88
  });
89
}
```

## Freezed 또는 json\_serializable 모델 테스트

[Section titled “Freezed 또는 json\_serializable 모델 테스트”](#freezed-또는-json_serializable-모델-테스트)

Freezed나 json\_serializable을 사용하는 모델의 테스트 예시입니다:

lib/models/product.dart

```dart
1
import 'package:freezed_annotation/freezed_annotation.dart';
2
import 'package:json_annotation/json_annotation.dart';
3


4
part 'product.freezed.dart';
5
part 'product.g.dart';
6


7
@freezed
8
class Product with _$Product {
9
  const factory Product({
10
    required int id,
11
    required String name,
12
    required double price,
13
    @Default(0) int stock,
14
    String? description,
15
    @Default([]) List<String> categories,
16
  }) = _Product;
17


18
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
19
}
```

이 Freezed 모델의 테스트:

test/models/product\_test.dart

```dart
1
import 'package:flutter_test/flutter_test.dart';
2
import 'package:my_app/models/product.dart';
3


4
void main() {
5
  group('Product', () {
6
    test('fromJson creates a valid Product instance', () {
7
      // Arrange
8
      final json = {
9
        'id': 1,
10
        'name': '노트북',
11
        'price': 1200000.0,
12
        'stock': 10,
13
        'description': '고성능 노트북',
14
        'categories': ['전자제품', '컴퓨터'],
15
      };
16


17
      // Act
18
      final product = Product.fromJson(json);
19


20
      // Assert
21
      expect(product.id, 1);
22
      expect(product.name, '노트북');
23
      expect(product.price, 1200000.0);
24
      expect(product.stock, 10);
25
      expect(product.description, '고성능 노트북');
26
      expect(product.categories, ['전자제품', '컴퓨터']);
27
    });
28


29
    test('fromJson creates a valid Product with default values', () {
30
      // Arrange
31
      final json = {
32
        'id': 1,
33
        'name': '노트북',
34
        'price': 1200000.0,
35
      };
36


37
      // Act
38
      final product = Product.fromJson(json);
39


40
      // Assert
41
      expect(product.id, 1);
42
      expect(product.name, '노트북');
43
      expect(product.price, 1200000.0);
44
      expect(product.stock, 0); // 기본값
45
      expect(product.description, null); // 기본값(null)
46
      expect(product.categories, isEmpty); // 기본값(빈 배열)
47
    });
48


49
    test('toJson returns valid JSON', () {
50
      // Arrange
51
      final product = Product(
52
        id: 1,
53
        name: '노트북',
54
        price: 1200000.0,
55
        stock: 10,
56
        description: '고성능 노트북',
57
        categories: ['전자제품', '컴퓨터'],
58
      );
59


60
      // Act
61
      final json = product.toJson();
62


63
      // Assert
64
      expect(json['id'], 1);
65
      expect(json['name'], '노트북');
66
      expect(json['price'], 1200000.0);
67
      expect(json['stock'], 10);
68
      expect(json['description'], '고성능 노트북');
69
      expect(json['categories'], ['전자제품', '컴퓨터']);
70
    });
71


72
    test('copyWith works correctly', () {
73
      // Arrange
74
      final product = Product(
75
        id: 1,
76
        name: '노트북',
77
        price: 1200000.0,
78
      );
79


80
      // Act
81
      final updatedProduct = product.copyWith(
82
        name: '고성능 노트북',
83
        price: 1300000.0,
84
        stock: 5,
85
      );
86


87
      // Assert
88
      expect(updatedProduct.id, 1); // 변경되지 않음
89
      expect(updatedProduct.name, '고성능 노트북'); // 변경됨
90
      expect(updatedProduct.price, 1300000.0); // 변경됨
91
      expect(updatedProduct.stock, 5); // 변경됨
92
    });
93


94
    test('두 제품이 같은 값을 가질 때 동등하게 취급된다', () {
95
      // Arrange
96
      final product1 = Product(
97
        id: 1,
98
        name: '노트북',
99
        price: 1200000.0,
100
      );
101


102
      final product2 = Product(
103
        id: 1,
104
        name: '노트북',
105
        price: 1200000.0,
106
      );
107


108
      // Assert
109
      expect(product1, equals(product2));
110
    });
111
  });
112
}
```

## 복잡한 비즈니스 로직 테스트

[Section titled “복잡한 비즈니스 로직 테스트”](#복잡한-비즈니스-로직-테스트)

복잡한 비즈니스 로직이 포함된 클래스의 테스트 예시입니다:

lib/services/cart\_service.dart

```dart
1
import '../models/product.dart';
2


3
class CartItem {
4
  final Product product;
5
  final int quantity;
6


7
  CartItem({required this.product, required this.quantity});
8


9
  double get totalPrice => product.price * quantity;
10


11
  CartItem copyWith({int? quantity}) {
12
    return CartItem(
13
      product: product,
14
      quantity: quantity ?? this.quantity,
15
    );
16
  }
17
}
18


19
class CartService {
20
  final Map<int, CartItem> _items = {};
21


22
  List<CartItem> get items => _items.values.toList();
23


24
  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);
25


26
  double get totalAmount => _items.values.fold(
27
        0,
28
        (sum, item) => sum + item.totalPrice,
29
      );
30


31
  void addProduct(Product product, {int quantity = 1}) {
32
    if (product.stock < quantity) {
33
      throw Exception('재고가 부족합니다');
34
    }
35


36
    if (_items.containsKey(product.id)) {
37
      final existingItem = _items[product.id]!;
38
      final newQuantity = existingItem.quantity + quantity;
39


40
      if (product.stock < newQuantity) {
41
        throw Exception('재고가 부족합니다');
42
      }
43


44
      _items[product.id] = existingItem.copyWith(quantity: newQuantity);
45
    } else {
46
      _items[product.id] = CartItem(product: product, quantity: quantity);
47
    }
48
  }
49


50
  void updateQuantity(int productId, int quantity) {
51
    if (!_items.containsKey(productId)) {
52
      throw Exception('장바구니에 해당 상품이 없습니다');
53
    }
54


55
    final item = _items[productId]!;
56


57
    if (quantity <= 0) {
58
      _items.remove(productId);
59
      return;
60
    }
61


62
    if (item.product.stock < quantity) {
63
      throw Exception('재고가 부족합니다');
64
    }
65


66
    _items[productId] = item.copyWith(quantity: quantity);
67
  }
68


69
  void removeProduct(int productId) {
70
    _items.remove(productId);
71
  }
72


73
  void clear() {
74
    _items.clear();
75
  }
76


77
  bool hasProduct(int productId) {
78
    return _items.containsKey(productId);
79
  }
80
}
```

이 `CartService` 클래스의 단위 테스트:

test/services/cart\_service\_test.dart

```dart
1
import 'package:flutter_test/flutter_test.dart';
2
import 'package:my_app/models/product.dart';
3
import 'package:my_app/services/cart_service.dart';
4


5
void main() {
6
  late CartService cartService;
7
  late Product laptop;
8
  late Product phone;
9


10
  setUp(() {
11
    cartService = CartService();
12


13
    laptop = Product(
14
      id: 1,
15
      name: '노트북',
16
      price: 1200000.0,
17
      stock: 10,
18
    );
19


20
    phone = Product(
21
      id: 2,
22
      name: '스마트폰',
23
      price: 800000.0,
24
      stock: 5,
25
    );
26
  });
27


28
  group('CartService', () {
29
    test('초기 장바구니는 비어있다', () {
30
      expect(cartService.items, isEmpty);
31
      expect(cartService.itemCount, 0);
32
      expect(cartService.totalAmount, 0);
33
    });
34


35
    test('상품을 장바구니에 추가할 수 있다', () {
36
      // Act
37
      cartService.addProduct(laptop);
38


39
      // Assert
40
      expect(cartService.items.length, 1);
41
      expect(cartService.items[0].product, laptop);
42
      expect(cartService.items[0].quantity, 1);
43
      expect(cartService.itemCount, 1);
44
      expect(cartService.totalAmount, 1200000.0);
45
    });
46


47
    test('같은 상품을 추가하면 수량이 증가한다', () {
48
      // Arrange
49
      cartService.addProduct(laptop);
50


51
      // Act
52
      cartService.addProduct(laptop);
53


54
      // Assert
55
      expect(cartService.items.length, 1);
56
      expect(cartService.items[0].quantity, 2);
57
      expect(cartService.itemCount, 2);
58
      expect(cartService.totalAmount, 2400000.0);
59
    });
60


61
    test('재고보다 많은 수량을 추가하려고 하면 예외가 발생한다', () {
62
      // Act & Assert
63
      expect(
64
        () => cartService.addProduct(laptop, quantity: 11),
65
        throwsException,
66
      );
67
    });
68


69
    test('장바구니에 있는 상품의 수량을 업데이트할 수 있다', () {
70
      // Arrange
71
      cartService.addProduct(laptop);
72


73
      // Act
74
      cartService.updateQuantity(laptop.id, 3);
75


76
      // Assert
77
      expect(cartService.items[0].quantity, 3);
78
      expect(cartService.itemCount, 3);
79
      expect(cartService.totalAmount, 3600000.0);
80
    });
81


82
    test('수량을 0 이하로 설정하면 상품이 장바구니에서 제거된다', () {
83
      // Arrange
84
      cartService.addProduct(laptop);
85


86
      // Act
87
      cartService.updateQuantity(laptop.id, 0);
88


89
      // Assert
90
      expect(cartService.items, isEmpty);
91
    });
92


93
    test('존재하지 않는 상품의 수량을 업데이트하려고 하면 예외가 발생한다', () {
94
      // Act & Assert
95
      expect(
96
        () => cartService.updateQuantity(999, 1),
97
        throwsException,
98
      );
99
    });
100


101
    test('상품을 장바구니에서 제거할 수 있다', () {
102
      // Arrange
103
      cartService.addProduct(laptop);
104
      cartService.addProduct(phone);
105
      expect(cartService.items.length, 2);
106


107
      // Act
108
      cartService.removeProduct(laptop.id);
109


110
      // Assert
111
      expect(cartService.items.length, 1);
112
      expect(cartService.items[0].product, phone);
113
    });
114


115
    test('장바구니를 비울 수 있다', () {
116
      // Arrange
117
      cartService.addProduct(laptop);
118
      cartService.addProduct(phone);
119
      expect(cartService.items.length, 2);
120


121
      // Act
122
      cartService.clear();
123


124
      // Assert
125
      expect(cartService.items, isEmpty);
126
      expect(cartService.itemCount, 0);
127
      expect(cartService.totalAmount, 0);
128
    });
129


130
    test('hasProduct는 상품의 존재 여부를 올바르게 확인한다', () {
131
      // Arrange
132
      cartService.addProduct(laptop);
133


134
      // Assert
135
      expect(cartService.hasProduct(laptop.id), true);
136
      expect(cartService.hasProduct(phone.id), false);
137
    });
138


139
    test('여러 상품을 추가하면 totalAmount가 올바르게 계산된다', () {
140
      // Act
141
      cartService.addProduct(laptop); // 1,200,000
142
      cartService.addProduct(phone, quantity: 2); // 800,000 * 2 = 1,600,000
143


144
      // Assert
145
      expect(cartService.itemCount, 3);
146
      expect(cartService.totalAmount, 2800000.0);
147
    });
148
  });
149
}
```

## 테스트 커버리지 측정하기

[Section titled “테스트 커버리지 측정하기”](#테스트-커버리지-측정하기)

테스트 커버리지는 코드가 테스트에 의해 얼마나 실행되었는지를 나타내는 지표입니다. Flutter에서는 다음과 같이 커버리지를 측정할 수 있습니다:

```bash
1
flutter test --coverage
```

이 명령어는 테스트를 실행하고 `coverage/lcov.info` 파일을 생성합니다. 이 파일을 사람이 읽기 쉬운 HTML 리포트로 변환하려면 `lcov` 도구를 사용합니다:

```bash
1
genhtml coverage/lcov.info -o coverage/html
```

그런 다음 `coverage/html/index.html` 파일을 브라우저에서 열어 커버리지 리포트를 확인할 수 있습니다.

## 단위 테스트 모범 사례

[Section titled “단위 테스트 모범 사례”](#단위-테스트-모범-사례)

### 1. AAA 패턴 사용하기

[Section titled “1. AAA 패턴 사용하기”](#1-aaa-패턴-사용하기)

AAA(Arrange, Act, Assert) 패턴은 테스트를 구조화하는 명확한 방법을 제공합니다:

* **Arrange**: 테스트에 필요한 데이터와 객체를 설정합니다.
* **Act**: 테스트하려는 동작을 실행합니다.
* **Assert**: 예상 결과를 실제 결과와 비교합니다.

### 2. 테스트 이름을 명확하게 지정하기

[Section titled “2. 테스트 이름을 명확하게 지정하기”](#2-테스트-이름을-명확하게-지정하기)

```dart
1
// 좋지 않은 예
2
test('add', () {
3
  expect(calculator.add(2, 3), 5);
4
});
5


6
// 좋은 예
7
test('add returns the sum of two numbers', () {
8
  expect(calculator.add(2, 3), 5);
9
});
```

### 3. 테스트 그룹화하기

[Section titled “3. 테스트 그룹화하기”](#3-테스트-그룹화하기)

관련 테스트를 `group` 함수를 사용하여 그룹화하면 테스트 출력을 더 잘 구조화할 수 있습니다:

```dart
1
group('Calculator', () {
2
  group('add', () {
3
    test('returns the sum of two positive numbers', () {
4
      // ...
5
    });
6


7
    test('returns the correct sum when one number is negative', () {
8
      // ...
9
    });
10
  });
11


12
  group('divide', () {
13
    test('returns the quotient of two numbers', () {
14
      // ...
15
    });
16


17
    test('throws ArgumentError when dividing by zero', () {
18
      // ...
19
    });
20
  });
21
});
```

### 4. 중복 제거하기

[Section titled “4. 중복 제거하기”](#4-중복-제거하기)

`setUp`과 `tearDown` 함수를 사용하여 테스트 간에 공통 코드를 추출하면 테스트의 가독성과 유지보수성이 향상됩니다.

### 5. 의미 있는 어설션 사용하기

[Section titled “5. 의미 있는 어설션 사용하기”](#5-의미-있는-어설션-사용하기)

테스트가 실패했을 때 무엇이 잘못되었는지 명확하게 나타내는 어설션을 사용하세요:

```dart
1
// 좋지 않은 예
2
expect(user.toJson(), json); // 오류 메시지가 모호할 수 있음
3


4
// 좋은 예: 개별 필드 테스트
5
expect(user.toJson()['id'], json['id']);
6
expect(user.toJson()['name'], json['name']);
7
expect(user.toJson()['email'], json['email']);
```

### 6. 테스트 분리 유지하기

[Section titled “6. 테스트 분리 유지하기”](#6-테스트-분리-유지하기)

각 테스트는 독립적이어야 하며 다른 테스트나 외부 상태에 의존해서는 안 됩니다. 테스트의 순서가 결과에 영향을 미치지 않아야 합니다.

### 7. 경계 조건 테스트하기

[Section titled “7. 경계 조건 테스트하기”](#7-경계-조건-테스트하기)

함수나 메서드의 동작을 검증할 때는 일반적인 케이스뿐만 아니라 경계 조건도 테스트하세요. 예를 들어:

* 빈 리스트나 맵
* null 값 (nullable 필드인 경우)
* 음수, 0, 매우 큰 숫자
* 매우 긴 문자열 또는 빈 문자열

### 8. 실패 케이스 테스트하기

[Section titled “8. 실패 케이스 테스트하기”](#8-실패-케이스-테스트하기)

함수나 메서드가 오류를 올바르게 처리하는지 확인하기 위해 실패 케이스도 테스트하세요:

```dart
1
test('fetchUser throws exception for non-existent user', () {
2
  // Act & Assert
3
  expect(userService.fetchUser(-1), throwsException);
4
});
```

## 결론

[Section titled “결론”](#결론)

단위 테스트는 코드의 신뢰성을 높이는 데 매우 중요합니다. Flutter에서 단위 테스트를 작성하면 앱의 품질이 향상되고, 버그를 조기에 발견할 수 있으며, 코드의 유지보수성이 개선됩니다. 이 장에서는 Dart 함수, 모델 클래스, 비동기 코드, 비즈니스 로직 등 다양한 코드 유형에 대한 단위 테스트 작성 방법을 살펴보았습니다.

가장 좋은 방법은 처음부터 테스트를 작성하는 것이지만, 기존 프로젝트에서도 점진적으로 테스트를 추가하여 이점을 얻을 수 있습니다. 테스트 주도 개발(TDD) 접근 방식을 사용하면 더 견고하고 유지보수하기 쉬운 코드베이스를 구축하는 데 도움이 됩니다.

다음 장에서는 위젯 테스트에 대해 자세히 알아보겠습니다. 위젯 테스트는 단위 테스트보다 한 단계 더 나아가 Flutter 위젯의 동작과 상호작용을 테스트합니다.

# 위젯 테스트

단위 테스트가 개별 함수나 클래스의 동작을 검증하는 것이라면, 위젯 테스트는 Flutter 위젯의 렌더링과 상호작용을 검증합니다. 이 장에서는 Flutter에서 위젯 테스트를 작성하고 실행하는 방법을 알아보겠습니다.

## 위젯 테스트의 필요성

[Section titled “위젯 테스트의 필요성”](#위젯-테스트의-필요성)

위젯 테스트를 작성해야 하는 이유는 다음과 같습니다:

1. **UI 일관성 보장**: 변경 사항이 위젯의 외관과 동작에 미치는 영향을 검증합니다.
2. **사용자 상호작용 검증**: 탭, 슬라이드, 스크롤 등 사용자 상호작용이 예상대로 작동하는지 확인합니다.
3. **상태 관리 테스트**: 위젯의 상태 변경이 UI에 올바르게 반영되는지 검증합니다.
4. **통합 검증**: 여러 위젯이 함께 작동할 때의 동작을 검증합니다.
5. **회귀 방지**: UI 변경이 기존 기능을 손상시키지 않는지 확인합니다.

## 위젯 테스트 설정

[Section titled “위젯 테스트 설정”](#위젯-테스트-설정)

위젯 테스트는 `flutter_test` 패키지를 사용하며, 이 패키지는 Flutter SDK에 기본으로 포함되어 있습니다. `pubspec.yaml` 파일에 다음과 같이 의존성이 포함되어 있어야 합니다:

```yaml
1
dev_dependencies:
2
  flutter_test:
3
    sdk: flutter
```

## 기본 위젯 테스트 작성하기

[Section titled “기본 위젯 테스트 작성하기”](#기본-위젯-테스트-작성하기)

간단한 위젯 테스트 예제를 살펴보겠습니다. 다음은 테스트할 간단한 카운터 앱 위젯입니다:

lib/widgets/counter.dart

```dart
1
import 'package:flutter/material.dart';
2


3
class Counter extends StatefulWidget {
4
  const Counter({Key? key}) : super(key: key);
5


6
  @override
7
  _CounterState createState() => _CounterState();
8
}
9


10
class _CounterState extends State<Counter> {
11
  int _count = 0;
12


13
  void _increment() {
14
    setState(() {
15
      _count++;
16
    });
17
  }
18


19
  @override
20
  Widget build(BuildContext context) {
21
    return Column(
22
      mainAxisAlignment: MainAxisAlignment.center,
23
      children: <Widget>[
24
        Text(
25
          'Counter Value:',
26
          style: Theme.of(context).textTheme.headlineSmall,
27
        ),
28
        Text(
29
          '$_count',
30
          style: Theme.of(context).textTheme.headlineMedium,
31
        ),
32
        ElevatedButton(
33
          onPressed: _increment,
34
          child: const Text('Increment'),
35
        ),
36
      ],
37
    );
38
  }
39
}
```

이제 이 `Counter` 위젯을 테스트하는 코드를 작성해 보겠습니다:

test/widgets/counter\_test.dart

```dart
1
import 'package:flutter/material.dart';
2
import 'package:flutter_test/flutter_test.dart';
3
import 'package:my_app/widgets/counter.dart';
4


5
void main() {
6
  testWidgets('Counter increments when button is pressed', (WidgetTester tester) async {
7
    // 위젯 렌더링
8
    await tester.pumpWidget(const MaterialApp(
9
      home: Scaffold(
10
        body: Counter(),
11
      ),
12
    ));
13


14
    // 초기 상태 확인: 카운터 값이 0인지 확인
15
    expect(find.text('0'), findsOneWidget);
16
    expect(find.text('1'), findsNothing);
17


18
    // 버튼 찾기 및 탭 동작 수행
19
    await tester.tap(find.byType(ElevatedButton));
20


21
    // 위젯 리빌드
22
    await tester.pump();
23


24
    // 변경된 상태 확인: 카운터 값이 1로 증가했는지 확인
25
    expect(find.text('0'), findsNothing);
26
    expect(find.text('1'), findsOneWidget);
27
  });
28
}
```

### 중요한 단계 설명

[Section titled “중요한 단계 설명”](#중요한-단계-설명)

1. **위젯 펌핑(Pumping)**:

   * `await tester.pumpWidget()`: 테스트 환경에 위젯을 렌더링합니다.
   * `await tester.pump()`: 위젯을 리빌드합니다(상태 변경 후 UI 업데이트).

2. **위젯 찾기(Finding)**:

   * `find.text()`: 특정 텍스트를 포함한 위젯을 찾습니다.
   * `find.byType()`: 특정 타입의 위젯을 찾습니다.
   * `find.byKey()`: 특정 키를 가진 위젯을 찾습니다.

3. **상호작용(Interaction)**:

   * `await tester.tap()`: 위젯을 탭합니다.
   * `await tester.drag()`: 드래그 동작을 수행합니다.
   * `await tester.enterText()`: 텍스트 필드에 텍스트를 입력합니다.

4. **검증(Verification)**:

   * `expect(finder, matcher)`: 찾은 위젯이 예상한 상태인지 확인합니다.
   * 일반적인 matcher: `findsOneWidget`, `findsNothing`, `findsNWidgets(n)` 등

## 다양한 위젯 테스트 기법

[Section titled “다양한 위젯 테스트 기법”](#다양한-위젯-테스트-기법)

### 1. 텍스트 입력 테스트

[Section titled “1. 텍스트 입력 테스트”](#1-텍스트-입력-테스트)

```dart
1
testWidgets('TextField updates when text is entered', (WidgetTester tester) async {
2
  final textFieldKey = Key('my-textfield');
3


4
  await tester.pumpWidget(MaterialApp(
5
    home: Scaffold(
6
      body: TextField(key: textFieldKey),
7
    ),
8
  ));
9


10
  // 텍스트 입력
11
  await tester.enterText(find.byKey(textFieldKey), '안녕하세요');
12
  await tester.pump();
13


14
  // 입력된 텍스트 확인
15
  expect(find.text('안녕하세요'), findsOneWidget);
16
});
```

### 2. 스크롤 테스트

[Section titled “2. 스크롤 테스트”](#2-스크롤-테스트)

```dart
1
testWidgets('ListView can be scrolled', (WidgetTester tester) async {
2
  await tester.pumpWidget(MaterialApp(
3
    home: Scaffold(
4
      body: ListView.builder(
5
        itemCount: 100,
6
        itemBuilder: (context, index) => ListTile(
7
          title: Text('항목 $index'),
8
        ),
9
      ),
10
    ),
11
  ));
12


13
  // 항목 50은 처음에는 화면에 보이지 않음
14
  expect(find.text('항목 50'), findsNothing);
15


16
  // 아래로 스크롤
17
  await tester.dragUntilVisible(
18
    find.text('항목 50'),
19
    find.byType(ListView),
20
    Offset(0, -500), // 위쪽으로 드래그
21
  );
22


23
  // 스크롤 후 항목 50이 화면에 보임
24
  expect(find.text('항목 50'), findsOneWidget);
25
});
```

### 3. 탭과 제스처 테스트

[Section titled “3. 탭과 제스처 테스트”](#3-탭과-제스처-테스트)

```dart
1
testWidgets('GestureDetector responds to tap', (WidgetTester tester) async {
2
  bool tapped = false;
3


4
  await tester.pumpWidget(MaterialApp(
5
    home: Scaffold(
6
      body: GestureDetector(
7
        onTap: () {
8
          tapped = true;
9
        },
10
        child: Container(
11
          width: 100,
12
          height: 100,
13
          color: Colors.blue,
14
        ),
15
      ),
16
    ),
17
  ));
18


19
  // 초기 상태
20
  expect(tapped, false);
21


22
  // 탭 수행
23
  await tester.tap(find.byType(Container));
24


25
  // 탭 후 상태
26
  expect(tapped, true);
27
});
```

### 4. 애니메이션 테스트

[Section titled “4. 애니메이션 테스트”](#4-애니메이션-테스트)

```dart
1
testWidgets('Animation completes correctly', (WidgetTester tester) async {
2
  await tester.pumpWidget(MaterialApp(
3
    home: MyAnimatedWidget(),
4
  ));
5


6
  // 애니메이션 시작 전 상태 확인
7
  final initialTransform = tester.widget<Transform>(find.byType(Transform)).transform;
8


9
  // 애니메이션 트리거
10
  await tester.tap(find.byType(ElevatedButton));
11


12
  // 애니메이션의 중간 프레임 확인 (300ms)
13
  await tester.pump(Duration(milliseconds: 300));
14


15
  // 애니메이션 완료까지 기다림
16
  await tester.pumpAndSettle();
17


18
  // 애니메이션 완료 후 상태 확인
19
  final finalTransform = tester.widget<Transform>(find.byType(Transform)).transform;
20


21
  // 초기값과 최종값이 다른지 확인
22
  expect(initialTransform, isNot(equals(finalTransform)));
23
});
```

### 5. 네비게이션 테스트

[Section titled “5. 네비게이션 테스트”](#5-네비게이션-테스트)

```dart
1
testWidgets('Navigation works correctly', (WidgetTester tester) async {
2
  await tester.pumpWidget(MaterialApp(
3
    routes: {
4
      '/': (context) => HomeScreen(),
5
      '/details': (context) => DetailScreen(),
6
    },
7
  ));
8


9
  // 홈 화면에서 시작
10
  expect(find.text('홈 화면'), findsOneWidget);
11
  expect(find.text('상세 화면'), findsNothing);
12


13
  // 상세 버튼 탭
14
  await tester.tap(find.byType(ElevatedButton));
15
  await tester.pumpAndSettle(); // 화면 전환 애니메이션 완료까지 기다림
16


17
  // 상세 화면으로 이동했는지 확인
18
  expect(find.text('홈 화면'), findsNothing);
19
  expect(find.text('상세 화면'), findsOneWidget);
20
});
```

## StatefulWidget 테스트

[Section titled “StatefulWidget 테스트”](#statefulwidget-테스트)

StatefulWidget의 경우 내부 상태와 라이프사이클 메서드를 테스트해야 할 수 있습니다:

```dart
1
testWidgets('StatefulWidget lifecycle and state updates', (WidgetTester tester) async {
2
  final myWidgetKey = GlobalKey<MyWidgetState>();
3


4
  await tester.pumpWidget(MaterialApp(
5
    home: MyWidget(key: myWidgetKey),
6
  ));
7


8
  // 직접 상태에 접근
9
  final state = myWidgetKey.currentState!;
10


11
  // 초기 상태 확인
12
  expect(state.counter, 0);
13


14
  // 상태 업데이트 메서드 호출
15
  state.incrementCounter();
16
  await tester.pump();
17


18
  // 업데이트된 상태 확인
19
  expect(state.counter, 1);
20
  expect(find.text('1'), findsOneWidget);
21
});
```

## 임의의 시간이 지난 후 상태 테스트

[Section titled “임의의 시간이 지난 후 상태 테스트”](#임의의-시간이-지난-후-상태-테스트)

일정 시간이 지난 후 위젯 상태를 확인하고 싶을 때는 `pump`와 `pumpAndSettle` 메서드를 활용합니다:

```dart
1
testWidgets('Timer updates UI after delay', (WidgetTester tester) async {
2
  await tester.pumpWidget(MaterialApp(
3
    home: TimerWidget(),
4
  ));
5


6
  // 초기 상태
7
  expect(find.text('대기 중...'), findsOneWidget);
8


9
  // 3초 경과를 시뮬레이션
10
  await tester.pump(Duration(seconds: 3));
11


12
  // 업데이트된 상태
13
  expect(find.text('완료!'), findsOneWidget);
14
});
```

## 비동기 작업 테스트

[Section titled “비동기 작업 테스트”](#비동기-작업-테스트)

API 호출과 같은 비동기 작업을 포함하는 위젯을 테스트하려면 모킹(mocking)을 사용해야 합니다:

```dart
1
testWidgets('Widget loads data from API', (WidgetTester tester) async {
2
  // Mock API 서비스 설정
3
  final mockService = MockApiService();
4
  when(mockService.fetchData()).thenAnswer((_) async => {'name': '홍길동'});
5


6
  await tester.pumpWidget(MaterialApp(
7
    home: DataWidget(apiService: mockService),
8
  ));
9


10
  // 초기 로딩 상태
11
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
12


13
  // 데이터 로딩 완료를 기다림
14
  await tester.pumpAndSettle();
15


16
  // 로딩된 데이터 확인
17
  expect(find.text('홍길동'), findsOneWidget);
18
});
```

## 테스트 그룹화 및 셋업

[Section titled “테스트 그룹화 및 셋업”](#테스트-그룹화-및-셋업)

관련 테스트를 그룹화하고 공통 설정을 추출할 수 있습니다:

```dart
1
void main() {
2
  group('Counter Widget Tests', () {
3
    late Widget testWidget;
4


5
    setUp(() {
6
      testWidget = MaterialApp(
7
        home: Scaffold(
8
          body: Counter(),
9
        ),
10
      );
11
    });
12


13
    testWidgets('renders initial state correctly', (WidgetTester tester) async {
14
      await tester.pumpWidget(testWidget);
15
      expect(find.text('0'), findsOneWidget);
16
    });
17


18
    testWidgets('increments counter when button is pressed', (WidgetTester tester) async {
19
      await tester.pumpWidget(testWidget);
20
      await tester.tap(find.byType(ElevatedButton));
21
      await tester.pump();
22
      expect(find.text('1'), findsOneWidget);
23
    });
24
  });
25
}
```

## 테스트에서 키 활용하기

[Section titled “테스트에서 키 활용하기”](#테스트에서-키-활용하기)

테스트에서 위젯을 더 쉽게 찾기 위해 위젯에 키(Key)를 할당하는 것이 좋습니다:

lib/screens/login\_screen.dart

```dart
1
class LoginScreen extends StatelessWidget {
2
  // 키 상수 정의
3
  static const kEmailFieldKey = Key('email-field');
4
  static const kPasswordFieldKey = Key('password-field');
5
  static const kLoginButtonKey = Key('login-button');
6


7
  @override
8
  Widget build(BuildContext context) {
9
    return Scaffold(
10
      body: Column(
11
        children: [
12
          TextField(key: kEmailFieldKey, decoration: InputDecoration(labelText: 'Email')),
13
          TextField(key: kPasswordFieldKey, decoration: InputDecoration(labelText: 'Password')),
14
          ElevatedButton(
15
            key: kLoginButtonKey,
16
            onPressed: () {},
17
            child: Text('Login'),
18
          ),
19
        ],
20
      ),
21
    );
22
  }
23
}
24


25
// test/screens/login_screen_test.dart
26
testWidgets('Login form submits with email and password', (WidgetTester tester) async {
27
  await tester.pumpWidget(MaterialApp(home: LoginScreen()));
28


29
  // 키를 사용하여 위젯 찾기
30
  await tester.enterText(find.byKey(LoginScreen.kEmailFieldKey), 'user@example.com');
31
  await tester.enterText(find.byKey(LoginScreen.kPasswordFieldKey), 'password123');
32
  await tester.tap(find.byKey(LoginScreen.kLoginButtonKey));
33
  await tester.pump();
34


35
  // 검증 로직...
36
});
```

## 골든 테스트 (시각적 회귀 테스트)

[Section titled “골든 테스트 (시각적 회귀 테스트)”](#골든-테스트-시각적-회귀-테스트)

골든 테스트는 위젯의 외관이 예상과 일치하는지 확인하는 테스트입니다:

```dart
1
testWidgets('MyWidget looks correct', (WidgetTester tester) async {
2
  await tester.pumpWidget(MaterialApp(
3
    theme: ThemeData.light(),
4
    home: MyWidget(),
5
  ));
6


7
  await expectLater(
8
    find.byType(MyWidget),
9
    matchesGoldenFile('my_widget_light.png'),
10
  );
11


12
  // 다크 테마에서도 확인
13
  await tester.pumpWidget(MaterialApp(
14
    theme: ThemeData.dark(),
15
    home: MyWidget(),
16
  ));
17


18
  await expectLater(
19
    find.byType(MyWidget),
20
    matchesGoldenFile('my_widget_dark.png'),
21
  );
22
});
```

## 팁과 베스트 프랙티스

[Section titled “팁과 베스트 프랙티스”](#팁과-베스트-프랙티스)

1. **작은 위젯부터 테스트하기**: 복잡한 화면 대신 재사용 가능한 작은 위젯부터 테스트하세요.

2. **모킹 활용하기**: 외부 종속성(API, 데이터베이스 등)은 모킹하여 테스트하세요.

3. **테스트 가능성을 고려한 설계**: 위젯을 설계할 때 테스트 가능성을 고려하세요. 종속성 주입을 활용하면 테스트가 쉬워집니다.

4. **모든 상호작용 후 pump() 호출하기**: 상태 변경 후에는 항상 `tester.pump()`를 호출하여 UI를 업데이트하세요.

5. **키 활용하기**: 복잡한 UI에서는 위젯을 쉽게 찾을 수 있도록 키를 할당하세요.

6. **다양한 시나리오 테스트하기**: 정상 경로뿐만 아니라 오류 경로, 경계 조건도 테스트하세요.

## Riverpod 통합 위젯 테스트

[Section titled “Riverpod 통합 위젯 테스트”](#riverpod-통합-위젯-테스트)

Riverpod를 사용하는 경우 테스트 설정 방법:

```dart
1
testWidgets('CounterWidget with Riverpod', (WidgetTester tester) async {
2
  await tester.pumpWidget(
3
    ProviderScope(
4
      overrides: [
5
        // 프로바이더 오버라이드
6
        counterProvider.overrideWithValue(10),
7
      ],
8
      child: MaterialApp(
9
        home: CounterWidget(),
10
      ),
11
    ),
12
  );
13


14
  // 오버라이드된 값으로 위젯이 렌더링되었는지 확인
15
  expect(find.text('10'), findsOneWidget);
16


17
  // 상호작용 및 추가 검증
18
  await tester.tap(find.byType(ElevatedButton));
19
  await tester.pump();
20


21
  // 상태 업데이트 확인
22
  expect(find.text('11'), findsOneWidget);
23
});
```

## 결론

[Section titled “결론”](#결론)

위젯 테스트는 Flutter 앱의 UI가 예상대로 동작하는지 확인하는 중요한 단계입니다. 단위 테스트와 통합 테스트를 함께 사용하여 앱의 모든 측면을 테스트하는 것이 좋습니다. 위젯 테스트를 통해 UI 변경이 기존 기능을 손상시키지 않고, 사용자 상호작용이 올바르게 처리됨을 보장할 수 있습니다.

다음 장에서는 통합 테스트(Integration Test)에 대해 알아보겠습니다. 통합 테스트는 위젯 테스트보다 더 넓은 범위에서 앱의 여러 부분이 함께 작동하는 방식을 테스트합니다.

# 사용자 분석 도구

앱을 배포한 후에는 사용자들이 앱을 어떻게 사용하는지 분석하는 것이 중요합니다. 이를 통해 UX를 개선하고, 사용자 행동 패턴을 파악하며, 비즈니스 결정을 내리는 데 도움이 됩니다. 이 문서에서는 Flutter 앱에서 사용할 수 있는 주요 분석 도구인 Firebase Analytics와 PostHog를 살펴보겠습니다.

## 분석 도구의 중요성

[Section titled “분석 도구의 중요성”](#분석-도구의-중요성)

분석 도구를 사용하면 다음과 같은 이점이 있습니다:

1. **사용자 행동 이해**: 어떤 기능을 많이 사용하는지, 어디서 이탈하는지 파악
2. **앱 성능 모니터링**: 오류 발생률, 응답 시간 등 측정
3. **비즈니스 목표 추적**: 전환율, 사용자 유지율 등 측정
4. **A/B 테스트**: 여러 변형을 테스트하여 최적의 UX 결정
5. **마케팅 효과 측정**: 다양한 마케팅 채널의 효과 분석

## Firebase Analytics

[Section titled “Firebase Analytics”](#firebase-analytics)

Firebase Analytics는 Google의 모바일 앱 분석 도구로, 무료이면서도 강력한 기능을 제공합니다.

### Firebase Analytics 설정하기

[Section titled “Firebase Analytics 설정하기”](#firebase-analytics-설정하기)

#### 1. Firebase 프로젝트 설정

[Section titled “1. Firebase 프로젝트 설정”](#1-firebase-프로젝트-설정)

먼저 [Firebase Console](https://console.firebase.google.com/)에서 프로젝트를 생성하고 Flutter 앱을 등록해야 합니다:

1. Firebase Console에 로그인하고 프로젝트 생성

2. Flutter 앱 등록 (Android 및 iOS 패키지 이름 입력)

3. 설정 파일 다운로드(`google-services.json` 및 `GoogleService-Info.plist`)

4. 각 파일을 프로젝트의 적절한 위치에 배치:

   * Android: `android/app/google-services.json`
   * iOS: `ios/Runner/GoogleService-Info.plist`

#### 2. 필요한 패키지 추가

[Section titled “2. 필요한 패키지 추가”](#2-필요한-패키지-추가)

pubspec.yaml에 다음 패키지를 추가합니다:

```yaml
1
dependencies:
2
  firebase_core: ^3.13.0
3
  firebase_analytics: ^11.4.5
```

그리고 패키지를 설치합니다:

```bash
1
flutter pub get
```

#### 3. Firebase 초기화

[Section titled “3. Firebase 초기화”](#3-firebase-초기화)

앱의 메인 파일에서 Firebase를 초기화합니다:

```dart
1
import 'package:firebase_core/firebase_core.dart';
2
import 'package:firebase_analytics/firebase_analytics.dart';
3
import 'package:flutter/material.dart';
4


5
Future<void> main() async {
6
  WidgetsFlutterBinding.ensureInitialized();
7
  await Firebase.initializeApp();
8
  runApp(MyApp());
9
}
10


11
class MyApp extends StatelessWidget {
12
  // Firebase Analytics 인스턴스 생성
13
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
14
  static FirebaseAnalyticsObserver observer =
15
      FirebaseAnalyticsObserver(analytics: analytics);
16


17
  @override
18
  Widget build(BuildContext context) {
19
    return MaterialApp(
20
      title: 'Firebase Analytics Demo',
21
      navigatorObservers: [observer], // 화면 전환 추적을 위한 설정
22
      home: MyHomePage(),
23
    );
24
  }
25
}
```

### 이벤트 추적하기

[Section titled “이벤트 추적하기”](#이벤트-추적하기)

Firebase Analytics에서 사용자 행동을 추적하려면 이벤트를 기록해야 합니다:

```dart
1
class AnalyticsService {
2
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
3


4
  // 화면 보기 이벤트 로깅
5
  Future<void> logScreenView({
6
    required String screenName,
7
    String screenClass = 'Flutter',
8
  }) async {
9
    await _analytics.logScreenView(
10
      screenName: screenName,
11
      screenClass: screenClass,
12
    );
13
  }
14


15
  // 로그인 이벤트 로깅
16
  Future<void> logLogin({String? loginMethod}) async {
17
    await _analytics.logLogin(loginMethod: loginMethod);
18
  }
19


20
  // 구매 이벤트 로깅
21
  Future<void> logPurchase({
22
    required double price,
23
    required String currency,
24
    required String itemId,
25
    required String itemName,
26
  }) async {
27
    await _analytics.logPurchase(
28
      currency: currency,
29
      value: price,
30
      items: [
31
        AnalyticsEventItem(
32
          itemId: itemId,
33
          itemName: itemName,
34
          price: price,
35
        ),
36
      ],
37
    );
38
  }
39


40
  // 사용자 속성 설정
41
  Future<void> setUserProperty({
42
    required String name,
43
    required String value,
44
  }) async {
45
    await _analytics.setUserProperty(name: name, value: value);
46
  }
47


48
  // 사용자 ID 설정 (식별 가능한 정보는 피해야 함)
49
  Future<void> setUserId(String? id) async {
50
    await _analytics.setUserId(id: id);
51
  }
52


53
  // 커스텀 이벤트 로깅
54
  Future<void> logCustomEvent({
55
    required String name,
56
    Map<String, dynamic>? parameters,
57
  }) async {
58
    await _analytics.logEvent(
59
      name: name,
60
      parameters: parameters,
61
    );
62
  }
63
}
```

### 이벤트 사용 예시

[Section titled “이벤트 사용 예시”](#이벤트-사용-예시)

위의 서비스를 사용하여 앱 내에서 이벤트를 추적하는 방법:

```dart
1
class ProductDetailPage extends StatelessWidget {
2
  final Product product;
3
  final AnalyticsService _analyticsService = AnalyticsService();
4


5
  ProductDetailPage({required this.product});
6


7
  @override
8
  Widget build(BuildContext context) {
9
    // 화면이 표시될 때 화면 보기 이벤트 로깅
10
    _analyticsService.logScreenView(
11
      screenName: 'product_detail',
12
      screenClass: 'ProductDetailPage',
13
    );
14


15
    return Scaffold(
16
      appBar: AppBar(title: Text(product.name)),
17
      body: Column(
18
        children: [
19
          // 제품 상세 정보...
20
          ElevatedButton(
21
            onPressed: () {
22
              // 구매 버튼 클릭 시 이벤트 로깅
23
              _analyticsService.logCustomEvent(
24
                name: 'add_to_cart',
25
                parameters: {
26
                  'item_id': product.id,
27
                  'item_name': product.name,
28
                  'item_price': product.price,
29
                },
30
              );
31
              // 장바구니에 추가 로직...
32
            },
33
            child: Text('장바구니에 추가'),
34
          ),
35
        ],
36
      ),
37
    );
38
  }
39
}
```

### Riverpod과 함께 사용하기

[Section titled “Riverpod과 함께 사용하기”](#riverpod과-함께-사용하기)

Riverpod을 사용하는 경우 다음과 같이 분석 서비스를 제공할 수 있습니다:

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2


3
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
4
  return AnalyticsService();
5
});
6


7
// 사용 예시
8
class ProductDetailPage extends ConsumerWidget {
9
  final Product product;
10


11
  ProductDetailPage({required this.product});
12


13
  @override
14
  Widget build(BuildContext context, WidgetRef ref) {
15
    final analyticsService = ref.read(analyticsServiceProvider);
16


17
    // 화면 로깅
18
    analyticsService.logScreenView(
19
      screenName: 'product_detail',
20
      screenClass: 'ProductDetailPage',
21
    );
22


23
    // 나머지 UI 코드...
24
  }
25
}
```

### 디버그 모드에서 이벤트 검증

[Section titled “디버그 모드에서 이벤트 검증”](#디버그-모드에서-이벤트-검증)

개발 중에는 이벤트가 올바르게 전송되는지 확인하는 것이 중요합니다. Firebase Analytics는 다음과 같은 디버그 기능을 제공합니다:

```dart
1
// 디버그 모드 활성화 (개발 중에만 사용)
2
await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
3


4
// iOS 디버그 모드 활성화
5
if (Platform.isIOS) {
6
  await FirebaseAnalytics.instance.setIosAnalyticsCollectionEnabled(true);
7
}
8


9
// Android 디버그 모드 활성화
10
if (Platform.isAndroid) {
11
  await FirebaseAnalytics.instance.setAndroidAnalyticsCollectionEnabled(true);
12
}
```

Firebase Console의 DebugView에서 실시간으로 전송되는 이벤트를 확인할 수 있습니다.

## PostHog

[Section titled “PostHog”](#posthog)

PostHog는 오픈소스 제품 분석 플랫폼으로, 자체 호스팅이 가능하고 고급 기능을 제공합니다.

### PostHog 특징

[Section titled “PostHog 특징”](#posthog-특징)

* **오픈소스**: 자체 호스팅 가능
* **제품 중심 분석**: 사용자 행동 흐름 및 퍼널 분석
* **세션 레코딩**: 사용자 세션 녹화 및 재생
* **히트맵**: 클릭, 스크롤 등의 사용자 상호작용 시각화
* **피처 플래그**: A/B 테스트 및 기능 출시 제어
* **개인정보 중심**: EU GDPR 준수를 위한 기능 제공

### PostHog 설정하기

[Section titled “PostHog 설정하기”](#posthog-설정하기)

#### 1. 패키지 추가

[Section titled “1. 패키지 추가”](#1-패키지-추가)

pubspec.yaml에 다음 패키지를 추가합니다:

```yaml
1
dependencies:
2
  posthog_flutter: ^3.1.0
```

그리고 패키지를 설치합니다:

```bash
1
flutter pub get
```

#### 2. PostHog 초기화

[Section titled “2. PostHog 초기화”](#2-posthog-초기화)

앱의 메인 파일에서 PostHog를 초기화합니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:posthog_flutter/posthog_flutter.dart';
3


4
Future<void> main() async {
5
  WidgetsFlutterBinding.ensureInitialized();
6


7
  // PostHog 초기화
8
  await Posthog.initAsync(
9
    apiKey: 'YOUR_API_KEY',
10
    options: PosthogOptions(
11
      host: 'https://app.posthog.com',  // 또는 자체 호스팅 URL
12
      captureApplicationLifecycleEvents: true,
13
      persistenceStrategy: PersistenceStrategy.memory,
14
      flushAt: 20,  // 이벤트가 20개 쌓이면 서버로 전송
15
      flushInterval: 30,  // 30초마다 서버로 전송
16
      debug: true,  // 개발 중에만 true로 설정
17
    ),
18
  );
19


20
  runApp(MyApp());
21
}
```

### 이벤트 추적하기

[Section titled “이벤트 추적하기”](#이벤트-추적하기-1)

PostHog를 사용하여 이벤트를 추적하는 방법:

```dart
1
class PostHogAnalyticsService {
2
  // 이벤트 캡처
3
  void captureEvent(String eventName, {Map<String, dynamic>? properties}) {
4
    Posthog.capture(
5
      eventName: eventName,
6
      properties: properties,
7
    );
8
  }
9


10
  // 화면 보기 이벤트 캡처
11
  void captureScreenView(String screenName, {Map<String, dynamic>? properties}) {
12
    final screenProperties = {
13
      'screen_name': screenName,
14
      ...?properties,
15
    };
16
    Posthog.capture(
17
      eventName: 'Screen View',
18
      properties: screenProperties,
19
    );
20
  }
21


22
  // 사용자 식별
23
  void identify(String userId, {Map<String, dynamic>? userProperties}) {
24
    Posthog.identify(
25
      userId: userId,
26
      userProperties: userProperties,
27
    );
28
  }
29


30
  // 사용자 속성 설정
31
  void setUserProperties(Map<String, dynamic> properties) {
32
    Posthog.identify(userProperties: properties);
33
  }
34


35
  // 그룹 설정 (팀, 조직 등)
36
  void setGroup(String groupType, String groupKey) {
37
    Posthog.group(
38
      groupType: groupType,
39
      groupKey: groupKey,
40
    );
41
  }
42


43
  // 이벤트 플러시 (즉시 서버로 전송)
44
  void flush() {
45
    Posthog.flush();
46
  }
47


48
  // 추적 중지 (예: 로그아웃 시)
49
  void reset() {
50
    Posthog.reset();
51
  }
52
}
```

### 피처 플래그 사용하기

[Section titled “피처 플래그 사용하기”](#피처-플래그-사용하기)

PostHog의 주요 기능 중 하나는 피처 플래그(Feature Flags)로, 런타임에 특정 기능을 활성화하거나 비활성화할 수 있습니다:

```dart
1
class FeatureFlagService {
2
  // 피처 플래그 값 가져오기
3
  Future<bool> isFeatureEnabled(String flagKey) async {
4
    return await Posthog.isFeatureEnabled(flagKey) ?? false;
5
  }
6


7
  // 모든 피처 플래그 가져오기
8
  Future<Map<String, bool>> getAllFeatureFlags() async {
9
    return await Posthog.getAllFeatureFlags() ?? {};
10
  }
11


12
  // 특정 피처 플래그와 연관된 페이로드 가져오기
13
  Future<dynamic> getFeatureFlagPayload(String flagKey) async {
14
    return await Posthog.getFeatureFlagPayload(flagKey);
15
  }
16


17
  // 새로운 피처 플래그 가져오기 (서버에서 새로고침)
18
  Future<void> reloadFeatureFlags() async {
19
    await Posthog.reloadFeatureFlags();
20
  }
21
}
```

### 피처 플래그 사용 예시

[Section titled “피처 플래그 사용 예시”](#피처-플래그-사용-예시)

```dart
1
class NewFeatureWidget extends StatelessWidget {
2
  final FeatureFlagService _featureFlagService = FeatureFlagService();
3


4
  @override
5
  Widget build(BuildContext context) {
6
    return FutureBuilder<bool>(
7
      future: _featureFlagService.isFeatureEnabled('new-ui-design'),
8
      builder: (context, snapshot) {
9
        if (snapshot.connectionState == ConnectionState.waiting) {
10
          return CircularProgressIndicator();
11
        }
12


13
        final isNewDesignEnabled = snapshot.data ?? false;
14


15
        return isNewDesignEnabled
16
            ? NewDesignWidget()  // 새 디자인 위젯
17
            : OldDesignWidget();  // 기존 디자인 위젯
18
      },
19
    );
20
  }
21
}
```

### Riverpod과 함께 사용하기

[Section titled “Riverpod과 함께 사용하기”](#riverpod과-함께-사용하기-1)

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2


3
final posthogAnalyticsProvider = Provider<PostHogAnalyticsService>((ref) {
4
  return PostHogAnalyticsService();
5
});
6


7
final featureFlagProvider = Provider<FeatureFlagService>((ref) {
8
  return FeatureFlagService();
9
});
10


11
// 특정 기능 플래그 상태를 제공하는 provider
12
final newUiFeatureFlagProvider = FutureProvider<bool>((ref) async {
13
  final featureFlagService = ref.read(featureFlagProvider);
14
  return await featureFlagService.isFeatureEnabled('new-ui-design');
15
});
16


17
// 사용 예시
18
class NewFeatureScreen extends ConsumerWidget {
19
  @override
20
  Widget build(BuildContext context, WidgetRef ref) {
21
    // 분석 서비스 사용
22
    final analyticsService = ref.read(posthogAnalyticsProvider);
23
    analyticsService.captureScreenView('new_feature_screen');
24


25
    // 피처 플래그 상태 확인
26
    final isNewUiEnabled = ref.watch(newUiFeatureFlagProvider);
27


28
    return isNewUiEnabled.when(
29
      data: (isEnabled) => isEnabled ? NewUiWidget() : OldUiWidget(),
30
      loading: () => CircularProgressIndicator(),
31
      error: (_, __) => OldUiWidget(),  // 오류 시 기본 UI 표시
32
    );
33
  }
34
}
```

## 분석 데이터 해석 및 활용

[Section titled “분석 데이터 해석 및 활용”](#분석-데이터-해석-및-활용)

수집한 분석 데이터를 실제로 활용하는 방법에 대해 알아보겠습니다.

### 주요 메트릭 추적

[Section titled “주요 메트릭 추적”](#주요-메트릭-추적)

일반적으로 추적해야 할 중요한 메트릭:

1. **사용자 획득**: 신규 사용자 수, 설치 수, 설치 출처
2. **사용자 참여**: 일/주/월간 활성 사용자(DAU/WAU/MAU), 세션 길이, 세션 빈도
3. **사용자 유지**: 리텐션 비율, 이탈률
4. **전환**: 가입 완료, 구매, 구독 등의 핵심 전환 이벤트
5. **앱 성능**: 크래시 비율, 응답 시간, ANR(App Not Responding) 발생 수

### 분석 데이터 기반 개선 사례

[Section titled “분석 데이터 기반 개선 사례”](#분석-데이터-기반-개선-사례)

수집된 데이터를 기반으로 앱을 개선할 수 있는 예시:

1. **사용자 여정 최적화**:

   * 데이터: 결제 페이지에서 높은 이탈률 발견
   * 개선: 결제 프로세스 단순화, 오류 메시지 개선

2. **핵심 기능 강화**:

   * 데이터: 특정 기능의 사용 빈도가 매우 높음
   * 개선: 해당 기능을 더 쉽게 접근할 수 있도록 UI 개선

3. **사용자 유지율 향상**:

   * 데이터: 설치 후 3일 이내 이탈하는 사용자가 많음
   * 개선: 온보딩 개선, 초기 가치 제안 강화

### 주의할 점

[Section titled “주의할 점”](#주의할-점)

분석 도구를 사용할 때 주의해야 할 사항:

1. **개인정보 보호**: GDPR, CCPA 등 데이터 보호 규정 준수
2. **사용자 동의**: 추적 전에 사용자 동의 획득
3. **과도한 추적 방지**: 필요한 데이터만 수집
4. **식별 정보 제한**: 개인 식별 정보는 최소화
5. **데이터 보관 정책**: 불필요한 데이터는 적절히 폐기

## 적절한 도구 선택하기

[Section titled “적절한 도구 선택하기”](#적절한-도구-선택하기)

Firebase Analytics와 PostHog 중 어떤 것을 선택해야 할지 결정하는 기준:

### Firebase Analytics가 적합한 경우

[Section titled “Firebase Analytics가 적합한 경우”](#firebase-analytics가-적합한-경우)

* 무료로 시작하고 싶을 때
* Google 생태계의 다른 서비스와 통합이 필요할 때
* 간단한 이벤트 추적과 기본적인 분석 기능이 필요할 때
* 모바일 앱 성능에 민감한 경우 (경량화된 SDK)

### PostHog가 적합한 경우

[Section titled “PostHog가 적합한 경우”](#posthog가-적합한-경우)

* 데이터 소유권과 개인정보 보호가 중요할 때 (자체 호스팅 가능)
* 세션 레코딩, 히트맵 등 고급 분석 기능이 필요할 때
* A/B 테스트와 피처 플래그가 필요할 때
* 오픈소스 솔루션을 선호할 때

## 결론

[Section titled “결론”](#결론)

사용자 분석 도구는 앱의 개선과 사용자 경험 향상에 중요한 역할을 합니다. Firebase Analytics는 시작하기 쉽고 Google 생태계와의 통합이 뛰어나며, PostHog는 더 많은 고급 기능과 데이터 소유권을 제공합니다.

애플리케이션의 요구사항, 예산, 개인정보 보호 요구 등을 고려하여 적절한 도구를 선택하고, 사용자 행동을 체계적으로 추적하여 데이터 기반 의사 결정을 내리는 것이 중요합니다. 이러한 도구를 활용하면 사용자의 필요와 행동 패턴을 더 잘 이해하고, 더 나은 앱 경험을 제공할 수 있습니다.

# 빌드 모드 (debug / profile / release)

Flutter는 세 가지 주요 빌드 모드를 제공합니다. 각 모드는 개발 과정의 다른 단계에서 사용되며, 각기 다른 최적화와 기능을 제공합니다.

## 빌드 모드 개요

[Section titled “빌드 모드 개요”](#빌드-모드-개요)

Flutter의 빌드 모드는 다음과 같습니다:

## Debug 모드

[Section titled “Debug 모드”](#debug-모드)

Debug 모드는 개발 과정에서 주로 사용하는 모드입니다.

### 특징

[Section titled “특징”](#특징)

* **Hot Reload/Restart**: 코드 변경 사항을 빠르게 확인할 수 있습니다.
* **디버깅 도구**: 콘솔 로그, 디버거 연결, 인스펙터 등 개발 도구 사용 가능합니다.
* **확인용 배너**: 앱 우측 상단에 DEBUG 배너가 표시됩니다.
* **비최적화 빌드**: 성능이 최적화되지 않고 디버깅 정보가 포함되어 있습니다.

### 실행 방법

[Section titled “실행 방법”](#실행-방법)

```bash
1
# 명시적으로 debug 모드로 실행
2
flutter run --debug
3


4
# 기본값이므로 일반적으로 다음과 같이 실행
5
flutter run
```

### 사용 시나리오

[Section titled “사용 시나리오”](#사용-시나리오)

* 앱 개발 및 기능 테스트
* 코드 디버깅
* UI 구현 및 확인

## Profile 모드

[Section titled “Profile 모드”](#profile-모드)

Profile 모드는 성능 분석과 프로파일링을 위한 모드입니다.

### 특징

[Section titled “특징”](#특징-1)

* **성능 트래킹**: Timeline, DevTools 등을 통한 성능 측정 가능
* **일부 디버깅 비활성화**: Hot Reload, 일부 디버깅 기능은 비활성화
* **실제 성능과 유사**: Release 모드와 유사한 성능 특성을 가지지만, 프로파일링 도구 사용 가능
* **Flutter Inspector**: UI 레이아웃 및 렌더링 분석 가능

### 실행 방법

[Section titled “실행 방법”](#실행-방법-1)

```bash
1
flutter run --profile
```

> **주의**: Profile 모드는 에뮬레이터/시뮬레이터에서 정확한 성능 측정이 어려우므로 실제 기기에서 실행하는 것이 좋습니다.

### 사용 시나리오

[Section titled “사용 시나리오”](#사용-시나리오-1)

* 앱 성능 분석
* 병목 현상 파악
* 메모리 사용량 및 프레임 드롭 확인
* 실제 기기에서의 사용자 경험 검증

## Release 모드

[Section titled “Release 모드”](#release-모드)

Release 모드는 최종 사용자에게 배포하기 위한 최적화된 빌드 모드입니다.

### 특징

[Section titled “특징”](#특징-2)

* **최적화된 성능**: 모든 성능 최적화 기능 활성화
* **코드 최소화**: 사용하지 않는 코드 제거 및 최소화
* **디버깅 기능 비활성화**: 모든 디버깅 도구와 코드 제거
* **R8/ProGuard (Android)**: 코드 축소, 난독화 및 최적화

### 실행 방법

[Section titled “실행 방법”](#실행-방법-2)

```bash
1
flutter run --release
```

### 빌드 방법

[Section titled “빌드 방법”](#빌드-방법)

```bash
1
# Android APK 빌드
2
flutter build apk --release
3


4
# Android App Bundle 빌드
5
flutter build appbundle --release
6


7
# iOS 빌드
8
flutter build ios --release
```

### 사용 시나리오

[Section titled “사용 시나리오”](#사용-시나리오-2)

* 앱 스토어 제출
* 사용자 배포
* 최종 성능 테스트
* 배포 전 검증

## 모드 간 비교

[Section titled “모드 간 비교”](#모드-간-비교)

| 기능          | Debug | Profile | Release |
| ----------- | ----- | ------- | ------- |
| 성능 최적화      | ❌     | ✅       | ✅       |
| 코드 크기 최적화   | ❌     | ✅       | ✅       |
| Hot Reload  | ✅     | ❌       | ❌       |
| 디버거 연결      | ✅     | 제한적     | ❌       |
| 성능 오버헤드     | 높음    | 낮음      | 없음      |
| 앱 크기        | 큼     | 중간      | 작음      |
| 프로파일링 도구    | ✅     | ✅       | ❌       |
| Assert 문 실행 | ✅     | ❌       | ❌       |

## 모드 전환 시 주의사항

[Section titled “모드 전환 시 주의사항”](#모드-전환-시-주의사항)

### Debug에서 Release로 전환 시 확인 사항

[Section titled “Debug에서 Release로 전환 시 확인 사항”](#debug에서-release로-전환-시-확인-사항)

1. **assert 문**: Debug 모드에서만, Release 모드에서는 무시됩니다.
2. **환경 변수**: kDebugMode, kProfileMode, kReleaseMode 플래그를 사용한 조건부 코드 확인
3. **로그 출력**: 불필요한 print() 문 제거 검토

```dart
1
// 빌드 모드에 따른 조건부 코드 예시
2
if (kDebugMode) {
3
  print('이 메시지는 Debug 모드에서만 출력됩니다');
4
} else if (kProfileMode) {
5
  // 프로파일 모드 특화 코드
6
} else if (kReleaseMode) {
7
  // 릴리즈 모드 특화 코드
8
}
```

4. **플랫폼 채널**: 네이티브 코드와의 통신이 제대로 작동하는지 확인
5. **타이밍 차이**: 디버그 모드보다 릴리즈 모드에서 실행 속도가 빠를 수 있음을 고려

## 빌드 모드 활용 팁

[Section titled “빌드 모드 활용 팁”](#빌드-모드-활용-팁)

### 다양한 모드 테스트

[Section titled “다양한 모드 테스트”](#다양한-모드-테스트)

개발 과정에서 정기적으로 Profile 및 Release 모드로 앱을 테스트하여 실제 사용자 경험을 확인하는 것이 좋습니다.

### 조건부 코드 작성

[Section titled “조건부 코드 작성”](#조건부-코드-작성)

```dart
1
// 개발 중에만 필요한 코드
2
if (kDebugMode) {
3
  // 개발 환경에서만 사용할 추가 기능
4
  enableDevFeatures();
5
}
6


7
// 릴리즈에서만 활성화할 코드
8
if (kReleaseMode) {
9
  // 분석 도구 초기화 등
10
  initializeAnalytics();
11
}
```

### Flavor와 함께 사용

[Section titled “Flavor와 함께 사용”](#flavor와-함께-사용)

빌드 모드는 Flavor(제품 환경)와 함께 사용하여 개발, 스테이징, 프로덕션 환경을 구분할 수 있습니다.

```plaintext
1
Debug + Dev Flavor = 개발 환경 테스트
2
Profile + Staging Flavor = 스테이징 성능 테스트
3
Release + Production Flavor = 최종 배포 빌드
```

## 결론

[Section titled “결론”](#결론)

Flutter의 세 가지 빌드 모드(Debug, Profile, Release)는 각각 다른 목적으로 사용되며, 개발 과정의 다양한 단계에서 활용됩니다. 개발 중에는 Debug 모드를 사용하여 빠른 반복 개발을, 성능 테스트에는 Profile 모드를, 최종 배포에는 Release 모드를 사용하는 것이 권장됩니다. 각 모드의 특성을 이해하고 적절히 활용하면 효율적인 개발과 최적화된 앱 배포가 가능합니다.

# Codemagic을 활용한 CI/CD 구성

Flutter 앱 개발에서 지속적 통합(CI) 및 지속적 배포(CD)는 개발 및 배포 과정을 자동화하여 효율성을 높이고 오류를 줄이는 중요한 요소입니다. Codemagic은 Flutter 앱에 특화된 CI/CD 플랫폼으로, 쉽게 구성하고 사용할 수 있습니다.

## CI/CD 개요

[Section titled “CI/CD 개요”](#cicd-개요)

CI/CD는 개발 워크플로우를 개선하기 위한 방법론입니다:

* **지속적 통합(CI)**: 개발자가 코드 변경사항을 주기적으로 통합하고, 자동화된 빌드와 테스트를 통해 빠르게 문제를 발견하는 방식
* **지속적 배포(CD)**: 빌드와 테스트를 통과한 코드를 자동으로 배포 환경에 릴리스하는 방식

## Codemagic 소개

[Section titled “Codemagic 소개”](#codemagic-소개)

Codemagic은 Flutter 앱 개발을 위해 설계된 CI/CD 플랫폼으로, 다음과 같은 특징을 제공합니다:

* Flutter 전용 빌드 환경
* 다양한 플랫폼(iOS, Android, Web, macOS) 지원
* 간편한 설정과 직관적인 UI
* 자동 버전 관리
* 앱스토어 및 구글 플레이 스토어 자동 배포
* TestFlight, Firebase App Distribution 등 통합
* 빌드 알림(이메일, Slack)

## Codemagic 설정 방법

[Section titled “Codemagic 설정 방법”](#codemagic-설정-방법)

### 1. 계정 생성 및 프로젝트 연결

[Section titled “1. 계정 생성 및 프로젝트 연결”](#1-계정-생성-및-프로젝트-연결)

1. [Codemagic 웹사이트](https://codemagic.io/signup)에서 계정 생성
2. GitHub, GitLab, Bitbucket 등 코드 리포지토리 연결
3. Flutter 프로젝트 선택

### 2. 빌드 설정 방법

[Section titled “2. 빌드 설정 방법”](#2-빌드-설정-방법)

Codemagic에서는 두 가지 방법으로 빌드를 설정할 수 있습니다:

1. **UI를 통한 설정**: 웹 인터페이스에서 직관적으로 설정
2. **YAML 파일을 통한 설정**: `codemagic.yaml` 파일로 빌드 파이프라인 정의

### UI를 통한 설정

[Section titled “UI를 통한 설정”](#ui를-통한-설정)

1. 프로젝트 선택 후 “Start your first build” 클릭

2. 빌드 설정 구성:

   * 빌드할 플랫폼 선택 (iOS / Android / Web)
   * Flutter 버전 선택
   * 빌드 트리거 설정 (브랜치, 태그 등)
   * 환경 변수 설정
   * 빌드 스크립트 설정

3. “Start new build” 클릭하여 빌드 시작

### YAML 파일을 통한 설정

[Section titled “YAML 파일을 통한 설정”](#yaml-파일을-통한-설정)

프로젝트 루트에 `codemagic.yaml` 파일을 생성합니다:

```yaml
1
workflows:
2
  flutter-app:
3
    name: Flutter App
4
    environment:
5
      flutter: stable
6
      xcode: latest
7
      cocoapods: default
8
    cache:
9
      cache_paths:
10
        - ~/.pub-cache
11
        - pubspec.lock
12
    triggering:
13
      events:
14
        - push
15
      branch_patterns:
16
        - pattern: "main"
17
          include: true
18
    scripts:
19
      - name: Flutter analyze
20
        script: flutter analyze
21
      - name: Flutter test
22
        script: flutter test
23
      - name: Build iOS
24
        script: |
25
          flutter build ios --release --no-codesign
26
      - name: Build Android
27
        script: |
28
          flutter build appbundle --release
29
    artifacts:
30
      - build/ios/ipa/*.ipa
31
      - build/app/outputs/bundle/release/app-release.aab
```

## 기본 CI/CD 워크플로우 구성

[Section titled “기본 CI/CD 워크플로우 구성”](#기본-cicd-워크플로우-구성)

일반적인 Flutter 앱의 CI/CD 워크플로우는 다음과 같습니다:

### 1. 코드 검증 단계

[Section titled “1. 코드 검증 단계”](#1-코드-검증-단계)

```yaml
1
scripts:
2
  - name: Flutter analyze
3
    script: flutter analyze
4
  - name: Flutter format check
5
    script: flutter format --set-exit-if-changed .
6
  - name: Flutter test
7
    script: flutter test
```

### 2. 빌드 단계 (Android)

[Section titled “2. 빌드 단계 (Android)”](#2-빌드-단계-android)

```yaml
1
scripts:
2
  - name: Build Android
3
    script: |
4
      flutter build apk --release
5
      flutter build appbundle --release
6
artifacts:
7
  - build/app/outputs/flutter-apk/app-release.apk
8
  - build/app/outputs/bundle/release/app-release.aab
```

### 3. 빌드 단계 (iOS)

[Section titled “3. 빌드 단계 (iOS)”](#3-빌드-단계-ios)

```yaml
1
scripts:
2
  - name: Set up code signing
3
    script: |
4
      echo $IOS_CERTIFICATE | base64 --decode > certificate.p12
5
      keychain add-certificates --certificate certificate.p12 --password $CERTIFICATE_PASSWORD
6
      app-store-connect fetch-signing-files $(BUNDLE_ID) --type IOS_APP_STORE --create
7
      keychain use-signing-files
8
  - name: Build iOS
9
    script: |
10
      flutter build ios --release
11
      cd ios
12
      xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release archive -archivePath Runner.xcarchive
13
      xcodebuild -exportArchive -archivePath Runner.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build
14
artifacts:
15
  - build/ios/ipa/*.ipa
```

### 4. 배포 단계

[Section titled “4. 배포 단계”](#4-배포-단계)

```yaml
1
publishing:
2
  app_store_connect:
3
    api_key: $APP_STORE_CONNECT_PRIVATE_KEY
4
    key_id: $APP_STORE_CONNECT_KEY_ID
5
    issuer_id: $APP_STORE_CONNECT_ISSUER_ID
6
    submit_to_testflight: true
7
  google_play:
8
    credentials: $GCLOUD_SERVICE_ACCOUNT_CREDENTIALS
9
    track: internal # 또는 alpha, beta, production
```

## 환경별 빌드 구성 (Flavors)

[Section titled “환경별 빌드 구성 (Flavors)”](#환경별-빌드-구성-flavors)

개발, 스테이징, 프로덕션 등 다양한 환경에 맞춰 빌드를 구성할 수 있습니다:

```yaml
1
workflows:
2
  development:
3
    name: Development Build
4
    environment:
5
      flutter: stable
6
    triggering:
7
      events:
8
        - push
9
      branch_patterns:
10
        - pattern: "develop"
11
          include: true
12
    scripts:
13
      - name: Build Development
14
        script: flutter build apk --flavor development --target lib/main_development.dart
15


16
  staging:
17
    name: Staging Build
18
    environment:
19
      flutter: stable
20
    triggering:
21
      events:
22
        - push
23
      branch_patterns:
24
        - pattern: "staging"
25
          include: true
26
    scripts:
27
      - name: Build Staging
28
        script: flutter build apk --flavor staging --target lib/main_staging.dart
29


30
  production:
31
    name: Production Build
32
    environment:
33
      flutter: stable
34
    triggering:
35
      events:
36
        - push
37
      branch_patterns:
38
        - pattern: "main"
39
          include: true
40
      tag_patterns:
41
        - pattern: "v*.*.*"
42
          include: true
43
    scripts:
44
      - name: Build Production
45
        script: flutter build apk --flavor production --target lib/main_production.dart
```

## 환경 변수 및 보안

[Section titled “환경 변수 및 보안”](#환경-변수-및-보안)

Codemagic에서는 다음과 같은 방법으로 보안 정보를 관리할 수 있습니다:

### 1. 웹 인터페이스를 통한 환경 변수 설정

[Section titled “1. 웹 인터페이스를 통한 환경 변수 설정”](#1-웹-인터페이스를-통한-환경-변수-설정)

1. 프로젝트 설정 > Environment variables 섹션
2. 변수 이름과 값 입력
3. 보안이 필요한 경우 “Secure” 옵션 선택

### 2. YAML 파일에서 환경 변수 참조

[Section titled “2. YAML 파일에서 환경 변수 참조”](#2-yaml-파일에서-환경-변수-참조)

```yaml
1
environment:
2
  vars:
3
    APP_ID: com.example.myapp
4
  flutter: stable
5
scripts:
6
  - name: Use environment variable
7
    script: echo "Building app with ID: $APP_ID"
```

### 3. 암호화된 파일 사용

[Section titled “3. 암호화된 파일 사용”](#3-암호화된-파일-사용)

iOS 인증서나 Google Play 서비스 계정 키와 같은 파일은 암호화하여 사용할 수 있습니다:

```yaml
1
environment:
2
  vars:
3
    ENCRYPTED_KEYSTORE_FILE: Encrypted(...)
4
scripts:
5
  - name: Decode keystore
6
    script: echo $ENCRYPTED_KEYSTORE_FILE | base64 --decode > keystore.jks
```

## 실전 활용 예제

[Section titled “실전 활용 예제”](#실전-활용-예제)

### 예제 1: PR 검증 워크플로우

[Section titled “예제 1: PR 검증 워크플로우”](#예제-1-pr-검증-워크플로우)

Pull Request가 생성될 때 코드 품질을 검증하는 워크플로우:

```yaml
1
workflows:
2
  pull-request-checks:
3
    name: Pull Request Checks
4
    instance_type: mac_mini_m1
5
    max_build_duration: 30
6
    environment:
7
      flutter: stable
8
    triggering:
9
      events:
10
        - pull_request
11
    scripts:
12
      - name: Get Flutter packages
13
        script: flutter pub get
14
      - name: Flutter analyze
15
        script: flutter analyze
16
      - name: Flutter format check
17
        script: flutter format --dry-run --set-exit-if-changed .
18
      - name: Flutter test
19
        script: flutter test --coverage
20
      - name: Upload coverage reports
21
        script: |
22
          # 코드 커버리지 보고서 업로드 스크립트
23
          bash <(curl -s https://codecov.io/bash)
```

### 예제 2: 완전한 Android 빌드 및 배포 워크플로우

[Section titled “예제 2: 완전한 Android 빌드 및 배포 워크플로우”](#예제-2-완전한-android-빌드-및-배포-워크플로우)

Android 앱을 빌드하고 Google Play에 배포하는 워크플로우:

```yaml
1
workflows:
2
  android-workflow:
3
    name: Android Release
4
    instance_type: linux
5
    max_build_duration: 60
6
    environment:
7
      android_signing:
8
        - keystore_reference
9
      vars:
10
        PACKAGE_NAME: "com.example.myapp"
11
        GOOGLE_PLAY_TRACK: internal
12
      flutter: stable
13
    triggering:
14
      events:
15
        - tag
16
      tag_patterns:
17
        - pattern: "v*.*.*"
18
          include: true
19
    scripts:
20
      - name: Set up build number
21
        script: |
22
          # 태그에서 버전 추출
23
          VERSION=$(echo $CM_TAG | cut -d'v' -f2)
24
          # pubspec.yaml 파일 업데이트
25
          sed -i "s/version: .*/version: $VERSION/" pubspec.yaml
26


27
      - name: Flutter test
28
        script: flutter test
29


30
      - name: Build AAB
31
        script: |
32
          flutter build appbundle \
33
            --release \
34
            --build-number=$(($(date +%s) / 60))
35


36
    artifacts:
37
      - build/app/outputs/bundle/release/app-release.aab
38


39
    publishing:
40
      google_play:
41
        credentials: $GOOGLE_PLAY_SERVICE_ACCOUNT
42
        track: $GOOGLE_PLAY_TRACK
43
        submit_as_draft: false
```

### 예제 3: iOS 및 Android 동시 빌드

[Section titled “예제 3: iOS 및 Android 동시 빌드”](#예제-3-ios-및-android-동시-빌드)

iOS와 Android 앱을 동시에 빌드하고 배포하는 워크플로우:

```yaml
1
workflows:
2
  ios-android-release:
3
    name: iOS & Android Release
4
    instance_type: mac_mini_m1
5
    max_build_duration: 120
6
    environment:
7
      ios_signing:
8
        distribution_type: app_store
9
        bundle_identifier: com.example.myapp
10
      flutter: stable
11
    triggering:
12
      events:
13
        - tag
14
      tag_patterns:
15
        - pattern: "v*.*.*"
16
          include: true
17
    scripts:
18
      - name: Set build number
19
        script: |
20
          BUILD_NUMBER=$(($(date +%s) / 60))
21
          echo "Build number: $BUILD_NUMBER"
22


23
      - name: Flutter build iOS
24
        script: |
25
          flutter build ios --release \
26
            --build-number=$BUILD_NUMBER \
27
            --no-codesign
28


29
      - name: Flutter build Android
30
        script: |
31
          flutter build appbundle --release \
32
            --build-number=$BUILD_NUMBER
33


34
      - name: iOS code signing and packaging
35
        script: |
36
          cd ios
37
          xcode-project use-profiles
38
          xcode-project build-ipa \
39
            --workspace Runner.xcworkspace \
40
            --scheme Runner
41


42
    artifacts:
43
      - build/ios/ipa/*.ipa
44
      - build/app/outputs/bundle/release/app-release.aab
45
      - flutter_drive.log
46


47
    publishing:
48
      app_store_connect:
49
        api_key: $APP_STORE_CONNECT_KEY
50
        submit_to_testflight: true
51
      google_play:
52
        credentials: $GOOGLE_PLAY_SERVICE_ACCOUNT
53
        track: internal
```

## 빌드 성능 최적화 팁

[Section titled “빌드 성능 최적화 팁”](#빌드-성능-최적화-팁)

Codemagic에서 빌드 시간을 단축하기 위한 팁:

1. **캐싱 활용**:

   ```yaml
   1
   cache:
   2
     cache_paths:
   3
       - ~/.pub-cache
   4
       - ~/.gradle
   5
       - ~/.cocoapods
   ```

2. **불필요한 스크립트 제거**: 테스트나 분석이 필요 없는 릴리스 빌드에서는 해당 스크립트 제거

3. **적절한 인스턴스 유형 선택**:

   ```yaml
   1
   workflows:
   2
     my-workflow:
   3
       instance_type: mac_mini_m1 # 더 빠른 M1 인스턴스 사용
   ```

4. **병렬 실행 활용**:

   ```yaml
   1
   scripts:
   2
     - name: Parallel jobs
   3
       script: |
   4
         flutter analyze &
   5
         flutter test &
   6
         wait  # 모든 백그라운드 작업이 완료될 때까지 대기
   ```

## 테스트 자동화 및 품질 관리

[Section titled “테스트 자동화 및 품질 관리”](#테스트-자동화-및-품질-관리)

### 코드 커버리지 보고

[Section titled “코드 커버리지 보고”](#코드-커버리지-보고)

```yaml
1
scripts:
2
  - name: Run tests with coverage
3
    script: |
4
      flutter test --coverage
5
      lcov --remove coverage/lcov.info '**/*.g.dart' '**/*.freezed.dart' -o coverage/lcov.info
6
      genhtml coverage/lcov.info -o coverage/html
7
artifacts:
8
  - coverage/html/**
```

### 통합 테스트

[Section titled “통합 테스트”](#통합-테스트)

```yaml
1
scripts:
2
  - name: Integration tests
3
    script: |
4
      # 에뮬레이터 시작
5
      flutter emulators --launch flutter_emulator
6


7
      # 통합 테스트 실행
8
      flutter drive \
9
        --driver=test_driver/integration_test.dart \
10
        --target=integration_test/app_test.dart \
11
        -d flutter_emulator
```

## 결론

[Section titled “결론”](#결론)

Codemagic은 Flutter 앱 개발을 위한 강력한 CI/CD 도구로, 다양한 기능과 유연한 설정으로 개발 및 배포 과정을 효율적으로 자동화할 수 있습니다. 이 가이드에서 소개한 설정과 예제를 활용하여 프로젝트에 맞는 CI/CD 파이프라인을 구축하면 개발 생산성을 크게 향상시킬 수 있습니다.

기본적인 검증 및 빌드 자동화부터 시작해서, 점진적으로 배포 자동화, 테스트 자동화, 품질 관리 등을 추가하며 워크플로우를 개선하는 것이 좋은 접근 방식입니다.

# Android / iOS 배포 절차

Flutter 앱을 개발한 후 사용자들에게 제공하기 위해 앱 스토어에 배포하는 절차를 알아봅니다. Android와 iOS 플랫폼은 각각 다른 배포 프로세스를 가지고 있습니다.

## 배포 준비 체크리스트

[Section titled “배포 준비 체크리스트”](#배포-준비-체크리스트)

앱 스토어에 제출하기 전에 다음 항목을 먼저 확인하세요:

* [ ] 모든 주요 기능 테스트 완료
* [ ] 앱 아이콘 및 스플래시 스크린 구현
* [ ] 다양한 화면 크기/해상도 테스트
* [ ] 접근성 지원 확인
* [ ] 개인정보 처리방침 준비
* [ ] 앱 스크린샷 및 설명 준비

## Android 앱 배포 절차

[Section titled “Android 앱 배포 절차”](#android-앱-배포-절차)

### 1. 배포용 키스토어 생성

[Section titled “1. 배포용 키스토어 생성”](#1-배포용-키스토어-생성)

Android 앱을 서명하기 위한 키스토어(keystore) 파일을 생성해야 합니다. 이 키는 앱 업데이트 시 동일한 키로 서명해야 하므로 안전하게 보관해야 합니다.

```bash
1
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. 키스토어 설정

[Section titled “2. 키스토어 설정”](#2-키스토어-설정)

`android/app/build.gradle` 파일에 키스토어 정보를 추가합니다. 보안을 위해 다음과 같이 별도의 파일로 관리합니다.

1. `android/key.properties` 파일 생성:

```properties
1
storePassword=<키스토어 비밀번호>
2
keyPassword=<키 비밀번호>
3
keyAlias=upload
4
storeFile=<키스토어 파일 경로, 예: /Users/username/upload-keystore.jks>
```

2. `android/app/build.gradle` 파일 수정:

```txt
1
// 파일 상단에 다음 코드 추가
2
def keystoreProperties = new Properties()
3
def keystorePropertiesFile = rootProject.file('key.properties')
4
if (keystorePropertiesFile.exists()) {
5
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
6
}
7


8
android {
9
    // 기존 코드 ...
10


11
    signingConfigs {
12
        release {
13
            keyAlias keystoreProperties['keyAlias']
14
            keyPassword keystoreProperties['keyPassword']
15
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
16
            storePassword keystoreProperties['storePassword']
17
        }
18
    }
19
    buildTypes {
20
        release {
21
            signingConfig signingConfigs.release
22
            // 기타 릴리즈 설정 ...
23
        }
24
    }
25
}
```

### 3. 앱 버전 설정

[Section titled “3. 앱 버전 설정”](#3-앱-버전-설정)

`pubspec.yaml` 파일에서 앱 버전을 설정합니다.

```yaml
1
version: 1.0.0+1 # <버전 이름>+<빌드 번호>
```

### 4. 앱 매니페스트 설정

[Section titled “4. 앱 매니페스트 설정”](#4-앱-매니페스트-설정)

`android/app/src/main/AndroidManifest.xml` 파일에서 필요한 권한과 설정을 확인합니다.

```xml
1
<manifest ...>
2
    <!-- 필요한 권한 설정 -->
3
    <uses-permission android:name="android.permission.INTERNET" />
4
    <!-- 기타 필요한 권한들 -->
5


6
    <application
7
        android:label="앱 이름"
8
        android:icon="@mipmap/ic_launcher"
9
        ...>
10
        <!-- 앱 설정 -->
11
    </application>
12
</manifest>
```

### 5. 앱 번들/APK 생성

[Section titled “5. 앱 번들/APK 생성”](#5-앱-번들apk-생성)

Google Play는 Android App Bundle(AAB) 형식을 권장합니다.

```bash
1
# App Bundle 생성 (권장)
2
flutter build appbundle
3


4
# 또는 APK 생성
5
flutter build apk --release
```

빌드된 파일은 다음 위치에서 찾을 수 있습니다:

* App Bundle: `build/app/outputs/bundle/release/app-release.aab`
* APK: `build/app/outputs/flutter-apk/app-release.apk`

### 6. Google Play Console에 앱 등록

[Section titled “6. Google Play Console에 앱 등록”](#6-google-play-console에-앱-등록)

1. [Google Play Console](https://play.google.com/console)에 로그인합니다.

2. “새 앱 만들기”를 선택합니다.

3. 앱 정보(이름, 언어, 앱/게임 여부, 유료/무료 여부)를 입력합니다.

4. 개인정보 처리방침 URL을 제공합니다.

5. 다음 정보를 등록합니다:

   * 앱 카테고리 및 태그
   * 연락처 정보
   * 스크린샷, 프로모션 이미지, 앱 아이콘
   * 앱 설명(짧은 설명 및 전체 설명)

### 7. 앱 번들 업로드

[Section titled “7. 앱 번들 업로드”](#7-앱-번들-업로드)

1. “앱 릴리즈” > “프로덕션” 트랙 선택
2. “새 릴리즈 만들기” 클릭
3. 생성한 App Bundle(.aab) 파일 업로드
4. 릴리즈 노트 작성
5. 검토 후 출시

### 8. 출시 및 검토

[Section titled “8. 출시 및 검토”](#8-출시-및-검토)

Google Play 검토 프로세스는 보통 몇 시간에서 며칠까지 소요될 수 있습니다. 검토 완료 후 앱이 출시됩니다.

## iOS 앱 배포 절차

[Section titled “iOS 앱 배포 절차”](#ios-앱-배포-절차)

### 1. Apple Developer Program 가입

[Section titled “1. Apple Developer Program 가입”](#1-apple-developer-program-가입)

iOS 앱을 App Store에 배포하려면 연간 $99의 비용으로 [Apple Developer Program](https://developer.apple.com/programs/)에 가입해야 합니다.

### 2. Xcode에서 인증서 및 프로비저닝 프로필 설정

[Section titled “2. Xcode에서 인증서 및 프로비저닝 프로필 설정”](#2-xcode에서-인증서-및-프로비저닝-프로필-설정)

1. Xcode 열기: `open ios/Runner.xcworkspace`
2. “Signing & Capabilities” 탭에서 팀 선택 및 자동 서명 활성화
3. 번들 ID 설정 (고유한 식별자, 예: com.yourcompany.appname)

### 3. 앱 버전 및 빌드 번호 설정

[Section titled “3. 앱 버전 및 빌드 번호 설정”](#3-앱-버전-및-빌드-번호-설정)

`pubspec.yaml` 파일에서 버전을 설정합니다:

```yaml
1
version: 1.0.0+1 # <버전 이름>+<빌드 번호>
```

iOS 특정 버전은 Xcode의 Runner 프로젝트 설정이나 `ios/Runner/Info.plist` 파일에서도 확인/수정할 수 있습니다.

### 4. iOS 앱 설정

[Section titled “4. iOS 앱 설정”](#4-ios-앱-설정)

`ios/Runner/Info.plist` 파일에서 필요한 설정을 확인합니다:

```xml
1
<key>CFBundleDisplayName</key>
2
<string>앱 이름</string>
3


4
<!-- 필요한 권한 설명 추가 -->
5
<key>NSCameraUsageDescription</key>
6
<string>카메라 사용 이유 설명</string>
```

### 5. 앱 아이콘 설정

[Section titled “5. 앱 아이콘 설정”](#5-앱-아이콘-설정)

`ios/Runner/Assets.xcassets/AppIcon.appiconset`에 다양한 크기의 앱 아이콘을 추가합니다.

### 6. 릴리즈 빌드 생성

[Section titled “6. 릴리즈 빌드 생성”](#6-릴리즈-빌드-생성)

```bash
1
flutter build ios --release
```

### 7. Xcode에서 Archive 생성

[Section titled “7. Xcode에서 Archive 생성”](#7-xcode에서-archive-생성)

1. Xcode에서 “Product” > “Destination” > “Any iOS Device” 선택
2. “Product” > “Archive” 선택
3. Archive가 완료되면 Xcode Organizer가 자동으로 열립니다

### 8. TestFlight를 통한 테스트 (선택 사항)

[Section titled “8. TestFlight를 통한 테스트 (선택 사항)”](#8-testflight를-통한-테스트-선택-사항)

TestFlight를 통해 앱을 테스터에게 배포하여 최종 테스트를 진행할 수 있습니다.

1. Xcode Organizer에서 Archive 선택
2. “Distribute App” > “App Store Connect” > “Upload” 선택
3. 앱 배포 옵션 설정 (자동 서명 권장)
4. 업로드 완료 후 [App Store Connect](https://appstoreconnect.apple.com/)에서 TestFlight 구성
5. 내부 및 외부 테스터 추가

### 9. App Store Connect에서 앱 정보 설정

[Section titled “9. App Store Connect에서 앱 정보 설정”](#9-app-store-connect에서-앱-정보-설정)

1. [App Store Connect](https://appstoreconnect.apple.com/)에 로그인

2. “내 앱” > ”+” > “새로운 앱” 선택

3. 다음 정보 입력:

   * 앱 이름, 기본 언어, 번들 ID
   * SKU (내부 추적용 고유 ID)
   * 사용자 액세스 설정

### 10. 앱 정보 등록

[Section titled “10. 앱 정보 등록”](#10-앱-정보-등록)

1. App Store 정보 탭에서 다음 항목 작성:

   * 프로모션 텍스트 (최대 170자)
   * 설명 (최대 4,000자)
   * 키워드 (최대 100자)
   * 지원 URL 및 마케팅 URL
   * 스크린샷 (다양한 기기 크기별)
   * 앱 미리보기 영상 (선택 사항)
   * 앱 아이콘 (1024x1024 픽셀)
   * 연령 등급
   * 개인정보 처리방침 URL
   * 가격 및 가용성

### 11. 앱 심사 제출

[Section titled “11. 앱 심사 제출”](#11-앱-심사-제출)

1. “앱 버전” 섹션에서 제출할 빌드 선택
2. 필요한 수출 규정 준수 정보 제공
3. “심사를 위해 제출” 클릭

### 12. 앱 심사 및 출시

[Section titled “12. 앱 심사 및 출시”](#12-앱-심사-및-출시)

Apple의 앱 심사는 보통 1-3일 소요됩니다. 거부될 경우 이유가 제공되며, 수정 후 재제출할 수 있습니다. 승인되면 “출시 준비됨” 상태가 되고, 수동 또는 자동으로 출시할 수 있습니다.

## CI/CD를 활용한 자동화 배포

[Section titled “CI/CD를 활용한 자동화 배포”](#cicd를-활용한-자동화-배포)

배포 과정을 자동화하기 위해 CI/CD 도구를 활용할 수 있습니다. 대표적인 도구로는 Codemagic, Fastlane, GitHub Actions 등이 있습니다.

### Codemagic 활용 예시

[Section titled “Codemagic 활용 예시”](#codemagic-활용-예시)

`codemagic.yaml` 파일 구성:

```yaml
1
workflows:
2
  android-workflow:
3
    name: Android Release
4
    environment:
5
      vars:
6
        KEYSTORE_PATH: /tmp/keystore.jks
7
        FCI_KEYSTORE_FILE: Encrypted(...) # 키스토어 파일 암호화
8
      flutter: stable
9
    scripts:
10
      - name: Set up keystore
11
        script: echo $FCI_KEYSTORE_FILE | base64 --decode > $KEYSTORE_PATH
12
      - name: Build AAB
13
        script: flutter build appbundle --release
14
    artifacts:
15
      - build/app/outputs/bundle/release/app-release.aab
16
    publishing:
17
      google_play:
18
        credentials: Encrypted(...) # Google Play API 키
19
        track: internal # 또는 alpha, beta, production
20


21
  ios-workflow:
22
    name: iOS Release
23
    environment:
24
      flutter: stable
25
      xcode: latest
26
      cocoapods: default
27
    scripts:
28
      - name: Build iOS
29
        script: flutter build ios --release --no-codesign
30
      - name: Set up code signing
31
        script: |
32
          keychain initialize
33
          app-store-connect fetch-signing-files $(BUNDLE_ID) --type IOS_APP_STORE
34
          keychain add-certificates
35
          xcode-project use-profiles
36
      - name: Build IPA
37
        script: xcode-project build-ipa --workspace ios/Runner.xcworkspace --scheme Runner
38
    artifacts:
39
      - build/ios/ipa/*.ipa
40
    publishing:
41
      app_store_connect:
42
        api_key: Encrypted(...) # App Store Connect API 키
43
        submit_to_testflight: true
```

## 배포 관련 팁

[Section titled “배포 관련 팁”](#배포-관련-팁)

### 앱 크기 최적화

[Section titled “앱 크기 최적화”](#앱-크기-최적화)

* 사용하지 않는 리소스 제거
* 이미지 최적화 및 압축
* ProGuard/R8 활성화 (Android)

### 버전 관리 전략

[Section titled “버전 관리 전략”](#버전-관리-전략)

Semantic Versioning(SemVer) 규칙을 따르는 것이 좋습니다:

* `MAJOR.MINOR.PATCH+BUILD_NUMBER`

  * MAJOR: 호환되지 않는 API 변경
  * MINOR: 호환되는 기능 추가
  * PATCH: 버그 수정
  * BUILD\_NUMBER: 앱 스토어용 빌드 번호 (매 배포마다 증가)

### 단계적 출시

[Section titled “단계적 출시”](#단계적-출시)

대규모 업데이트는 단계적으로 출시하는 것이 좋습니다:

1. 내부 테스트 → 2. 알파/베타 테스트 → 3. 제한된 사용자 그룹 → 4. 전체 출시

## Flutter 배포 관련 자주 묻는 질문

[Section titled “Flutter 배포 관련 자주 묻는 질문”](#flutter-배포-관련-자주-묻는-질문)

### Q: 앱이 너무 큰데 어떻게 크기를 줄일 수 있나요?

[Section titled “Q: 앱이 너무 큰데 어떻게 크기를 줄일 수 있나요?”](#q-앱이-너무-큰데-어떻게-크기를-줄일-수-있나요)

A: `flutter build apk --split-per-abi`로 ABI별 분할, 미사용 리소스 제거, 이미지 최적화, 코드 축소(R8/ProGuard) 활성화 등을 시도해보세요.

### Q: 앱이 심사에서 거부됐어요. 어떻게 해야 하나요?

[Section titled “Q: 앱이 심사에서 거부됐어요. 어떻게 해야 하나요?”](#q-앱이-심사에서-거부됐어요-어떻게-해야-하나요)

A: 거부 사유를 주의 깊게 읽고, 해당 문제를 수정한 후 재제출하세요. 명확하지 않은 경우 Apple/Google의 개발자 지원에 문의하세요.

### Q: iOS와 Android 배포 중 어떤 것을 먼저 해야 하나요?

[Section titled “Q: iOS와 Android 배포 중 어떤 것을 먼저 해야 하나요?”](#q-ios와-android-배포-중-어떤-것을-먼저-해야-하나요)

A: 일반적으로 iOS 심사가 더 오래 걸리므로 iOS를 먼저 제출하고, 이후 Android를 제출하는 것이 효율적입니다.

## 결론

[Section titled “결론”](#결론)

앱 배포는 Flutter 개발 과정의 중요한 마무리 단계입니다. 이 가이드를 통해 Android와 iOS 플랫폼에 앱을 성공적으로 배포하는 전체 과정을 이해할 수 있습니다. 각 플랫폼의 요구사항과 프로세스를 잘 파악하고, CI/CD 도구를 활용하면 효율적이고 안정적인 배포가 가능합니다.

# 환경 분리 및 Flavor 설정

실제 앱 개발에서는 개발, 테스트, 스테이징, 프로덕션 등 여러 환경을 관리해야 합니다. Flutter에서는 Flavor라는 기능을 통해 서로 다른 환경에 맞는 앱 변형을 만들 수 있습니다. 이 장에서는 Flutter에서 환경을 분리하고 Flavor를 설정하는 방법에 대해 알아보겠습니다.

Tip

[flutter\_flavorizr](https://pub.dev/packages/flutter_flavorizr)를 이용하면 조금 더 쉽게 Flavor 설정을 하실 수 있습니다.

```sh
1
dart pub add flutter_flavorizr
```

## 환경 분리의 필요성

[Section titled “환경 분리의 필요성”](#환경-분리의-필요성)

동일한 코드베이스로 다양한 환경에서 작동하는 앱을 만들어야 하는 경우가 많습니다:

환경 분리가 필요한 이유:

1. **API 엔드포인트**: 개발, 스테이징, 프로덕션 서버가 다른 경우
2. **기능 제어**: 특정 환경에서만 활성화되는 실험적 기능
3. **분석 및 모니터링**: 프로덕션에서만 실제 분석 데이터 수집
4. **시각적 구분**: 개발자가 어떤 환경에서 실행 중인지 쉽게 구분
5. **앱 ID 분리**: 동일 기기에 여러 환경의 앱 설치 가능

## Flavor 개념 이해하기

[Section titled “Flavor 개념 이해하기”](#flavor-개념-이해하기)

Flavor는 동일한 코드베이스에서 다양한 앱 변형을 빌드하기 위한 설정입니다. 이는 안드로이드의 ‘Build Variants’와 iOS의 ‘Schemes/Configurations’와 유사한 개념입니다.

### 일반적인 Flavor 구성

[Section titled “일반적인 Flavor 구성”](#일반적인-flavor-구성)

보통 다음과 같은 Flavor를 구성합니다:

1. **development**: 개발 중인 환경, 개발 서버 사용
2. **staging**: 출시 전 테스트 환경, 스테이징 서버 사용
3. **production**: 최종 사용자에게 배포되는 환경, 실제 서버 사용

## Flavor 설정 방법

[Section titled “Flavor 설정 방법”](#flavor-설정-방법)

Flutter에서 Flavor를 설정하는 과정을 단계별로 알아보겠습니다.

### 1. Flutter 측 설정

[Section titled “1. Flutter 측 설정”](#1-flutter-측-설정)

#### lib/flavors.dart 파일 생성

[Section titled “lib/flavors.dart 파일 생성”](#libflavorsdart-파일-생성)

먼저 Flavor를 정의하는 enum과 설정을 만듭니다:

```dart
1
enum Flavor {
2
  development,
3
  staging,
4
  production,
5
}
6


7
class FlavorConfig {
8
  final Flavor flavor;
9
  final String name;
10
  final String apiBaseUrl;
11
  final bool showDebugBanner;
12
  final String? sentryDsn;
13
  final bool reportErrors;
14


15
  // 기타 환경별 설정들...
16


17
  static FlavorConfig? _instance;
18


19
  factory FlavorConfig({
20
    required Flavor flavor,
21
    required String name,
22
    required String apiBaseUrl,
23
    bool showDebugBanner = true,
24
    String? sentryDsn,
25
    bool reportErrors = false,
26
  }) {
27
    _instance ??= FlavorConfig._internal(
28
      flavor: flavor,
29
      name: name,
30
      apiBaseUrl: apiBaseUrl,
31
      showDebugBanner: showDebugBanner,
32
      sentryDsn: sentryDsn,
33
      reportErrors: reportErrors,
34
    );
35


36
    return _instance!;
37
  }
38


39
  FlavorConfig._internal({
40
    required this.flavor,
41
    required this.name,
42
    required this.apiBaseUrl,
43
    required this.showDebugBanner,
44
    required this.sentryDsn,
45
    required this.reportErrors,
46
  });
47


48
  static FlavorConfig get instance {
49
    return _instance!;
50
  }
51


52
  static bool get isDevelopment => instance.flavor == Flavor.development;
53
  static bool get isStaging => instance.flavor == Flavor.staging;
54
  static bool get isProduction => instance.flavor == Flavor.production;
55
}
```

#### 각 환경별 진입점 생성

[Section titled “각 환경별 진입점 생성”](#각-환경별-진입점-생성)

각 Flavor에 대한 main 파일을 생성합니다:

**lib/main\_development.dart**:

```dart
1
import 'package:flutter/material.dart';
2
import 'flavors.dart';
3
import 'app.dart';
4


5
void main() {
6
  FlavorConfig(
7
    flavor: Flavor.development,
8
    name: 'DEV',
9
    apiBaseUrl: 'https://dev-api.example.com',
10
    showDebugBanner: true,
11
    reportErrors: false,
12
  );
13


14
  runApp(const MyApp());
15
}
```

**lib/main\_staging.dart**:

```dart
1
import 'package:flutter/material.dart';
2
import 'flavors.dart';
3
import 'app.dart';
4


5
void main() {
6
  FlavorConfig(
7
    flavor: Flavor.staging,
8
    name: 'STAGING',
9
    apiBaseUrl: 'https://staging-api.example.com',
10
    showDebugBanner: true,
11
    reportErrors: true,
12
    sentryDsn: 'https://your-staging-sentry-dsn',
13
  );
14


15
  runApp(const MyApp());
16
}
```

**lib/main\_production.dart**:

```dart
1
import 'package:flutter/material.dart';
2
import 'flavors.dart';
3
import 'app.dart';
4


5
void main() {
6
  FlavorConfig(
7
    flavor: Flavor.production,
8
    name: 'PROD',
9
    apiBaseUrl: 'https://api.example.com',
10
    showDebugBanner: false,
11
    reportErrors: true,
12
    sentryDsn: 'https://your-production-sentry-dsn',
13
  );
14


15
  runApp(const MyApp());
16
}
```

#### 공통 앱 구성 생성

[Section titled “공통 앱 구성 생성”](#공통-앱-구성-생성)

**lib/app.dart**:

```dart
1
import 'package:flutter/material.dart';
2
import 'flavors.dart';
3


4
class MyApp extends StatelessWidget {
5
  const MyApp({Key? key}) : super(key: key);
6


7
  @override
8
  Widget build(BuildContext context) {
9
    return MaterialApp(
10
      title: 'Flavor Example',
11
      debugShowCheckedModeBanner: FlavorConfig.instance.showDebugBanner,
12
      theme: ThemeData(
13
        primarySwatch: Colors.blue,
14
      ),
15
      home: const MyHomePage(),
16
    );
17
  }
18
}
19


20
class MyHomePage extends StatelessWidget {
21
  const MyHomePage({Key? key}) : super(key: key);
22


23
  @override
24
  Widget build(BuildContext context) {
25
    return Scaffold(
26
      appBar: AppBar(
27
        title: const Text('Flavor Example'),
28
      ),
29
      body: Center(
30
        child: Column(
31
          mainAxisAlignment: MainAxisAlignment.center,
32
          children: [
33
            Text(
34
              '현재 환경: ${FlavorConfig.instance.name}',
35
              style: Theme.of(context).textTheme.headlineMedium,
36
            ),
37
            const SizedBox(height: 20),
38
            Text(
39
              'API URL: ${FlavorConfig.instance.apiBaseUrl}',
40
              style: Theme.of(context).textTheme.titleMedium,
41
            ),
42
            // 환경에 따라 다른 UI 표시
43
            if (FlavorConfig.isDevelopment)
44
              ElevatedButton(
45
                onPressed: () {},
46
                child: const Text('개발 전용 기능'),
47
              ),
48
          ],
49
        ),
50
      ),
51
    );
52
  }
53
}
```

### 2. Android 설정

[Section titled “2. Android 설정”](#2-android-설정)

**android/app/build.gradle** 파일을 수정하여 각 Flavor에 대한 설정을 추가합니다:

```txt
1
android {
2
    // 기존 설정...
3


4
    flavorDimensions "environment"
5
    productFlavors {
6
        development {
7
            dimension "environment"
8
            applicationIdSuffix ".dev"
9
            versionNameSuffix "-dev"
10
            resValue "string", "app_name", "MyApp Dev"
11
        }
12
        staging {
13
            dimension "environment"
14
            applicationIdSuffix ".staging"
15
            versionNameSuffix "-staging"
16
            resValue "string", "app_name", "MyApp Staging"
17
        }
18
        production {
19
            dimension "environment"
20
            // 프로덕션은 기본 applicationId 사용
21
            resValue "string", "app_name", "MyApp"
22
        }
23
    }
24


25
    // Android 앱 변형에 맞게 Flutter 엔트리 포인트 매핑
26
    // Gradle 7.0 이상에서는 적용되지 않을 수 있음
27
    // 이 경우 아래 buildTypes 방식으로 대체
28
    productFlavors.all { flavor ->
29
        flavor.manifestPlaceholders = [
30
            appName: flavor.resValue.find { it.key == "string" && it.name == "app_name" }?.value ?: "MyApp"
31
        ]
32
    }
33
}
```

### 3. iOS 설정

[Section titled “3. iOS 설정”](#3-ios-설정)

iOS에서는 Xcode 구성과 스키마를 설정해야 합니다. 터미널에서 다음 명령을 실행하여 Flutter의 도우미 패키지를 설치합니다:

```bash
1
flutter pub add --dev flutter_flavorizr
```

**pubspec.yaml**에 flutter\_flavorizr 설정을 추가합니다:

```yaml
1
flavorizr:
2
  app:
3
    android:
4
      flavorDimensions: "environment"
5
    ios:
6
      xcodeproj: "Runner.xcodeproj"
7
      buildSettings:
8
        BUNDLE_ID_SUFFIX:
9
          development: ".dev"
10
          staging: ".staging"
11
          production: ""
12
  flavors:
13
    development:
14
      app:
15
        name: "MyApp Dev"
16
      android:
17
        applicationId: "com.example.myapp.dev"
18
      ios:
19
        bundleId: "com.example.myapp.dev"
20
    staging:
21
      app:
22
        name: "MyApp Staging"
23
      android:
24
        applicationId: "com.example.myapp.staging"
25
      ios:
26
        bundleId: "com.example.myapp.staging"
27
    production:
28
      app:
29
        name: "MyApp"
30
      android:
31
        applicationId: "com.example.myapp"
32
      ios:
33
        bundleId: "com.example.myapp"
```

그런 다음 다음 명령을 실행하여 설정을 적용합니다:

```bash
1
flutter pub run flutter_flavorizr
```

이 명령은 iOS와 Android 모두에 대한 Flavor 설정을 자동으로 구성합니다.

## Flavor 앱 실행 방법

[Section titled “Flavor 앱 실행 방법”](#flavor-앱-실행-방법)

설정한 Flavor로 앱을 실행하려면 다음 명령어를 사용합니다:

```bash
1
# 개발 환경으로 실행
2
flutter run --flavor development -t lib/main_development.dart
3


4
# 스테이징 환경으로 실행
5
flutter run --flavor staging -t lib/main_staging.dart
6


7
# 프로덕션 환경으로 실행
8
flutter run --flavor production -t lib/main_production.dart
```

## Flavor에 따른 앱 아이콘 및 스플래시 변경

[Section titled “Flavor에 따른 앱 아이콘 및 스플래시 변경”](#flavor에-따른-앱-아이콘-및-스플래시-변경)

각 환경에 따라 다른 앱 아이콘과 스플래시 화면을 설정할 수 있습니다.

### Android 아이콘 변경

[Section titled “Android 아이콘 변경”](#android-아이콘-변경)

각 Flavor에 맞는 리소스 디렉토리를 생성합니다:

* android/app/src/development/res/mipmap-\*
* android/app/src/staging/res/mipmap-\*
* android/app/src/production/res/mipmap-\*

각 디렉토리에 해당 환경의 아이콘을 배치합니다.

### iOS 아이콘 변경

[Section titled “iOS 아이콘 변경”](#ios-아이콘-변경)

iOS는 flutter\_flavorizr를 사용했다면 이미 각 Flavor에 대한 Asset Catalog가 생성되어 있을 것입니다. 각 환경에 맞는 아이콘을 해당 Asset Catalog에 추가하면 됩니다.

## 환경별 구성 파일 사용

[Section titled “환경별 구성 파일 사용”](#환경별-구성-파일-사용)

각 환경에 특화된 구성을 JSON, YAML 등의 파일로 관리할 수도 있습니다:

**assets/config/development.json**:

```json
1
{
2
  "apiUrl": "https://dev-api.example.com",
3
  "timeout": 30,
4
  "featureFlags": {
5
    "newFeature": true,
6
    "experimentalUI": true
7
  }
8
}
```

**assets/config/production.json**:

```json
1
{
2
  "apiUrl": "https://api.example.com",
3
  "timeout": 10,
4
  "featureFlags": {
5
    "newFeature": false,
6
    "experimentalUI": false
7
  }
8
}
```

코드에서 다음과 같이 사용합니다:

```dart
1
import 'dart:convert';
2
import 'package:flutter/services.dart';
3
import 'flavors.dart';
4


5
class AppConfig {
6
  final String apiUrl;
7
  final int timeout;
8
  final Map<String, bool> featureFlags;
9


10
  AppConfig({
11
    required this.apiUrl,
12
    required this.timeout,
13
    required this.featureFlags,
14
  });
15


16
  static Future<AppConfig> load() async {
17
    final flavor = FlavorConfig.instance.flavor.toString().split('.').last;
18
    final configString = await rootBundle.loadString('assets/config/$flavor.json');
19
    final config = json.decode(configString);
20


21
    return AppConfig(
22
      apiUrl: config['apiUrl'],
23
      timeout: config['timeout'],
24
      featureFlags: Map<String, bool>.from(config['featureFlags']),
25
    );
26
  }
27


28
  bool isFeatureEnabled(String featureName) {
29
    return featureFlags[featureName] ?? false;
30
  }
31
}
```

## 환경 변수 및 시크릿 관리

[Section titled “환경 변수 및 시크릿 관리”](#환경-변수-및-시크릿-관리)

### 방법 1: .env 파일 사용

[Section titled “방법 1: .env 파일 사용”](#방법-1-env-파일-사용)

flutter\_dotenv 패키지를 사용하여 환경 변수를 관리할 수 있습니다:

```bash
1
flutter pub add flutter_dotenv
```

각 환경에 맞는 .env 파일을 생성합니다:

**.env.development**:

```plaintext
1
API_KEY=dev_api_key_123
2
SENTRY_DSN=https://dev.sentry.io/123
```

**.env.production**:

```plaintext
1
API_KEY=prod_api_key_789
2
SENTRY_DSN=https://prod.sentry.io/789
```

main 파일에서 해당 환경의 .env 파일을 로드합니다:

```dart
1
import 'package:flutter_dotenv/flutter_dotenv.dart';
2


3
Future<void> main() async {
4
  await dotenv.load(fileName: '.env.development');
5


6
  FlavorConfig(
7
    // 설정...
8
  );
9


10
  runApp(const MyApp());
11
}
```

### 방법 2: —dart-define 사용

[Section titled “방법 2: —dart-define 사용”](#방법-2-dart-define-사용)

빌드 시 다트 컴파일러에 직접 환경 변수를 전달할 수 있습니다:

```bash
1
flutter run --flavor production -t lib/main_production.dart --dart-define=API_KEY=my_secret_key --dart-define=BASE_URL=https://api.example.com
```

코드에서 다음과 같이 접근합니다:

```dart
1
const apiKey = String.fromEnvironment('API_KEY');
2
const baseUrl = String.fromEnvironment('BASE_URL');
```

## Flavor를 이용한 환경별 Firebase 설정

[Section titled “Flavor를 이용한 환경별 Firebase 설정”](#flavor를-이용한-환경별-firebase-설정)

Firebase 프로젝트를 환경별로 분리하여 관리하는 것이 좋습니다:

1. 각 환경(개발, 스테이징, 프로덕션)에 대한 Firebase 프로젝트 생성
2. 각 환경에 맞는 google-services.json(Android) 및 GoogleService-Info.plist(iOS) 파일 다운로드
3. 파일 이름 변경(예: google-services-dev.json, google-services-prod.json)
4. 빌드 스크립트에서 현재 Flavor에 따라 적절한 파일을 복사하도록 설정

**android/app/build.gradle**:

```txt
1
android {
2
    // 기존 설정...
3


4
    applicationVariants.all { variant ->
5
        variant.tasks.matching { it.name == "processDebugGoogleServices" || it.name == "processReleaseGoogleServices" }.all { task ->
6
            task.doFirst {
7
                def flavor = variant.flavorName
8
                copy {
9
                    from "../../firebase/${flavor}/google-services.json"
10
                    into '.'
11
                }
12
            }
13
        }
14
    }
15
}
```

## Visual Studio Code에서 Flavor 실행 구성

[Section titled “Visual Studio Code에서 Flavor 실행 구성”](#visual-studio-code에서-flavor-실행-구성)

VS Code에서 편리하게 Flavor를 실행할 수 있도록 구성할 수 있습니다. `.vscode/launch.json` 파일을 생성하거나 수정합니다:

```json
1
{
2
  "version": "0.2.0",
3
  "configurations": [
4
    {
5
      "name": "Development",
6
      "request": "launch",
7
      "type": "dart",
8
      "program": "lib/main_development.dart",
9
      "args": ["--flavor", "development"]
10
    },
11
    {
12
      "name": "Staging",
13
      "request": "launch",
14
      "type": "dart",
15
      "program": "lib/main_staging.dart",
16
      "args": ["--flavor", "staging"]
17
    },
18
    {
19
      "name": "Production",
20
      "request": "launch",
21
      "type": "dart",
22
      "program": "lib/main_production.dart",
23
      "args": ["--flavor", "production"]
24
    }
25
  ]
26
}
```

## Riverpod과 함께 Flavor 사용하기

[Section titled “Riverpod과 함께 Flavor 사용하기”](#riverpod과-함께-flavor-사용하기)

Riverpod을 사용하는 경우, 환경별 Provider를 구성할 수 있습니다:

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2
import 'flavors.dart';
3


4
// API 클라이언트 Provider
5
final apiClientProvider = Provider<ApiClient>((ref) {
6
  final config = FlavorConfig.instance;
7
  return ApiClient(
8
    baseUrl: config.apiBaseUrl,
9
    timeout: FlavorConfig.isProduction ? 10 : 30,
10
  );
11
});
12


13
// 기능 플래그 Provider
14
final featureFlagProvider = Provider<FeatureFlag>((ref) {
15
  switch (FlavorConfig.instance.flavor) {
16
    case Flavor.development:
17
      return FeatureFlag(
18
        enableExperimentalFeatures: true,
19
        showDebugMenu: true,
20
      );
21
    case Flavor.staging:
22
      return FeatureFlag(
23
        enableExperimentalFeatures: true,
24
        showDebugMenu: false,
25
      );
26
    case Flavor.production:
27
      return FeatureFlag(
28
        enableExperimentalFeatures: false,
29
        showDebugMenu: false,
30
      );
31
  }
32
});
```

## 실전 팁 및 모범 사례

[Section titled “실전 팁 및 모범 사례”](#실전-팁-및-모범-사례)

### 1. 일관된 환경 관리

[Section titled “1. 일관된 환경 관리”](#1-일관된-환경-관리)

* 개발, 테스트, 스테이징, 프로덕션 등 모든 환경을 일관되게 관리
* 환경별 차이점을 명확히 문서화

### 2. 환경별 시각적 구분

[Section titled “2. 환경별 시각적 구분”](#2-환경별-시각적-구분)

* 개발 및 스테이징 환경에서는 앱 이름, 아이콘, 색상 등으로 구분하여 실수 방지
* 예: 개발 환경에서는 앱 바에 “DEV” 배지 표시

### 3. 배포 자동화

[Section titled “3. 배포 자동화”](#3-배포-자동화)

* CI/CD 파이프라인에서 Flavor를 활용하여 자동 빌드 및 배포
* 예: develop 브랜치 푸시 → 개발 환경 빌드, main 브랜치 푸시 → 프로덕션 빌드

### 4. 안전한 시크릿 관리

[Section titled “4. 안전한 시크릿 관리”](#4-안전한-시크릿-관리)

* API 키, 비밀번호 등은 소스 코드나 공개 저장소에 커밋하지 않기
* CI/CD 시스템의 시크릿 관리 기능이나 암호화된 환경 파일 사용

## 결론

[Section titled “결론”](#결론)

Flutter의 Flavor 기능을 활용하면 단일 코드베이스로 여러 환경에 맞춘 앱을 효율적으로 관리할 수 있습니다. 올바른 환경 분리는 개발 효율성을 높이고, 테스트를 용이하게 하며, 배포 과정을 안전하게 만듭니다. 환경별 구성, 아이콘, 이름, API 엔드포인트 등을 적절히 분리하여 관리함으로써 더 안정적인 앱 개발이 가능해집니다.

# 에러 추적. Crashlytics와 Sentry

모든 개발자는 완벽한 앱을 만들고 싶지만, 현실에서는 크래시와 예기치 않은 오류가 발생할 수 있습니다. 이러한 문제를 효과적으로 관리하기 위해 에러 추적 도구를 사용하는 것이 중요합니다. 이 문서에서는 Flutter 앱에서 사용할 수 있는 두 가지 주요 에러 추적 도구인 Firebase Crashlytics와 Sentry에 대해 알아보겠습니다.

## 에러 추적의 중요성

[Section titled “에러 추적의 중요성”](#에러-추적의-중요성)

앱 출시 후 사용자 경험에 영향을 미치는 문제를 빠르게 발견하고 수정하는 것은 매우 중요합니다.

에러 추적 도구는 다음과 같은 이점을 제공합니다:

1. **실시간 모니터링**: 앱에서 발생하는 문제를 실시간으로 감지
2. **자세한 오류 정보**: 오류 발생 상황, 디바이스 정보, 앱 상태 등 상세 정보 제공
3. **우선순위 결정**: 가장 많이 발생하는 오류나 심각한, 최근에 발생한 오류에 집중
4. **사용자 영향 파악**: 얼마나 많은 사용자가 영향을 받는지 확인
5. **트렌드 분석**: 시간에 따른 오류 발생 패턴 분석

## Firebase Crashlytics

[Section titled “Firebase Crashlytics”](#firebase-crashlytics)

Firebase Crashlytics는 Google에서 제공하는 경량 실시간 크래시 리포팅 도구입니다.

### Firebase Crashlytics 특징

[Section titled “Firebase Crashlytics 특징”](#firebase-crashlytics-특징)

* **실시간 크래시 리포팅**: 오류 발생 직후 알림
* **이슈 우선순위 지정**: 영향을 받는 사용자 수, 심각도에 따른 자동 정렬
* **크래시 인사이트**: 문제의 근본 원인 파악 지원
* **최소한의 앱 성능 영향**: 백그라운드에서 효율적으로 작동
* **Firebase 생태계 통합**: Analytics, Performance Monitoring 등과 통합

### Firebase Crashlytics 설정하기

[Section titled “Firebase Crashlytics 설정하기”](#firebase-crashlytics-설정하기)

#### 1. Firebase 설정

[Section titled “1. Firebase 설정”](#1-firebase-설정)

Firebase 프로젝트가 아직 설정되지 않았다면, 먼저 [Firebase Console](https://console.firebase.google.com/)에서 프로젝트를 생성해야 합니다:

1. Firebase Console에서 프로젝트 생성
2. Flutter 앱 등록 (Android 및 iOS 패키지 이름 입력)
3. 설정 파일 다운로드 및 적용 (`google-services.json` 및 `GoogleService-Info.plist`)

#### 2. 필요한 패키지 추가

[Section titled “2. 필요한 패키지 추가”](#2-필요한-패키지-추가)

pubspec.yaml에 다음 패키지를 추가합니다:

```yaml
1
dependencies:
2
  firebase_core: ^3.13.0
3
  firebase_crashlytics: ^4.3.5
```

패키지를 설치합니다:

```bash
1
flutter pub get
```

#### 3. Flutter 앱에서 Crashlytics 초기화

[Section titled “3. Flutter 앱에서 Crashlytics 초기화”](#3-flutter-앱에서-crashlytics-초기화)

앱의 메인 파일에서 Crashlytics를 초기화합니다:

```dart
1
import 'package:firebase_core/firebase_core.dart';
2
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
3
import 'package:flutter/foundation.dart';
4
import 'package:flutter/material.dart';
5


6
Future<void> main() async {
7
  WidgetsFlutterBinding.ensureInitialized();
8
  await Firebase.initializeApp();
9


10
  // Crashlytics 설정
11
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
12


13
  // Flutter 오류를 Crashlytics에 보고
14
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
15


16
  // Zone 오류도 잡아서 Crashlytics에 보고
17
  runZonedGuarded<Future<void>>(() async {
18
    runApp(const MyApp());
19
  }, (error, stack) {
20
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
21
  });
22
}
```

### Crashlytics 사용하기

[Section titled “Crashlytics 사용하기”](#crashlytics-사용하기)

#### 1. 에러 기록하기

[Section titled “1. 에러 기록하기”](#1-에러-기록하기)

```dart
1
try {
2
  // 위험한 작업 수행
3
} catch (e, stack) {
4
  FirebaseCrashlytics.instance.recordError(e, stack);
5
}
```

#### 2. 커스텀 로그 추가하기

[Section titled “2. 커스텀 로그 추가하기”](#2-커스텀-로그-추가하기)

```dart
1
// 로그 추가
2
FirebaseCrashlytics.instance.log('사용자가 결제 버튼 클릭');
3


4
// 로그와 함께 에러 기록
5
FirebaseCrashlytics.instance.recordError(
6
  exception,
7
  stackTrace,
8
  reason: '결제 처리 중 오류',
9
  information: ['상품 ID: $productId', '사용자 ID: $userId'],
10
);
```

#### 3. 사용자 정보 설정

[Section titled “3. 사용자 정보 설정”](#3-사용자-정보-설정)

```dart
1
// 비식별 사용자 ID 설정
2
FirebaseCrashlytics.instance.setUserIdentifier(userId);
3


4
// 커스텀 키-값 정보 추가
5
FirebaseCrashlytics.instance.setCustomKey('subscription_type', 'premium');
6
FirebaseCrashlytics.instance.setCustomKey('last_purchase_date', '2023-10-15');
```

#### 4. 테스트를 위한 강제 크래시

[Section titled “4. 테스트를 위한 강제 크래시”](#4-테스트를-위한-강제-크래시)

```dart
1
ElevatedButton(
2
  onPressed: () {
3
    FirebaseCrashlytics.instance.crash();  // 앱 크래시 발생
4
  },
5
  child: Text('테스트 크래시 발생'),
6
),
```

### Riverpod과 함께 사용하기

[Section titled “Riverpod과 함께 사용하기”](#riverpod과-함께-사용하기)

Riverpod을 사용하는 경우, 에러 관찰자를 만들 수 있습니다:

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
3


4
// Crashlytics 프로바이더
5
final crashlyticsProvider = Provider<FirebaseCrashlytics>((ref) {
6
  return FirebaseCrashlytics.instance;
7
});
8


9
// Riverpod 에러 관찰자
10
class CrashlyticsObserver extends ProviderObserver {
11
  final FirebaseCrashlytics crashlytics;
12


13
  CrashlyticsObserver(this.crashlytics);
14


15
  @override
16
  void providerDidFail(
17
    ProviderBase provider,
18
    Object error,
19
    StackTrace stackTrace,
20
    ProviderContainer container,
21
  ) {
22
    crashlytics.recordError(
23
      error,
24
      stackTrace,
25
      reason: 'Provider 오류: ${provider.name ?? provider.runtimeType}',
26
    );
27
  }
28
}
29


30
// main에서 설정
31
void main() {
32
  // ... Firebase 초기화 코드
33


34
  final container = ProviderContainer(
35
    observers: [
36
      CrashlyticsObserver(FirebaseCrashlytics.instance),
37
    ],
38
  );
39


40
  runApp(UncontrolledProviderScope(
41
    container: container,
42
    child: const MyApp(),
43
  ));
44
}
```

## Sentry

[Section titled “Sentry”](#sentry)

Sentry는 다양한 플랫폼에서 오류 추적, 성능 모니터링, 사용자 피드백 수집 등을 지원하는 종합 모니터링 플랫폼입니다.

### Sentry 특징

[Section titled “Sentry 특징”](#sentry-특징)

* **다양한 플랫폼 지원**: Flutter, Web, 서버 등 통합 모니터링
* **실시간 오류 추적**: 발생 직후 알림
* **성능 모니터링**: 앱 성능 측정 및 병목 현상 파악
* **릴리스 추적**: 특정 버전에서의 오류 추적
* **풍부한 컨텍스트**: 사용자 정보, 브레드크럼, 태그 등 상세 정보
* **자체 호스팅 옵션**: 온프레미스 설치 가능

### Sentry 설정하기

[Section titled “Sentry 설정하기”](#sentry-설정하기)

#### 1. 계정 생성 및 프로젝트 설정

[Section titled “1. 계정 생성 및 프로젝트 설정”](#1-계정-생성-및-프로젝트-설정)

1. [Sentry 웹사이트](https://sentry.io/)에서 계정 생성
2. 새 프로젝트 생성 (Flutter 플랫폼 선택)
3. DSN(Data Source Name) 복사

#### 2. 패키지 추가

[Section titled “2. 패키지 추가”](#2-패키지-추가)

pubspec.yaml에 다음 패키지를 추가합니다:

```yaml
1
dependencies:
2
  sentry_flutter: ^8.14.2
```

패키지를 설치합니다:

```bash
1
flutter pub get
```

#### 3. Sentry 초기화

[Section titled “3. Sentry 초기화”](#3-sentry-초기화)

앱의 메인 파일에서 Sentry를 초기화합니다:

```dart
1
import 'package:flutter/material.dart';
2
import 'package:sentry_flutter/sentry_flutter.dart';
3


4
Future<void> main() async {
5
  await SentryFlutter.init(
6
    (options) {
7
      options.dsn = 'https://your-dsn-here@o0.ingest.sentry.io/0';
8
      options.tracesSampleRate = 1.0;  // 성능 모니터링 활성화 (0.0 - 1.0)
9
      options.environment = 'production';  // 환경 설정
10
      options.attachScreenshot = true;  // 스크린샷 첨부 (iOS/Android만 지원)
11
      options.attachViewHierarchy = true;  // UI 계층 구조 첨부
12
      options.debug = false;  // 프로덕션에서는 false로 설정
13
    },
14
    appRunner: () => runApp(const MyApp()),
15
  );
16
}
```

### Sentry 사용하기

[Section titled “Sentry 사용하기”](#sentry-사용하기)

#### 1. 에러 캡처하기

[Section titled “1. 에러 캡처하기”](#1-에러-캡처하기)

```dart
1
try {
2
  // 위험한 작업 수행
3
} catch (exception, stackTrace) {
4
  await Sentry.captureException(
5
    exception,
6
    stackTrace: stackTrace,
7
  );
8
}
```

#### 2. 커스텀 이벤트 기록하기

[Section titled “2. 커스텀 이벤트 기록하기”](#2-커스텀-이벤트-기록하기)

```dart
1
Sentry.captureMessage(
2
  '사용자가 결제를 완료했습니다',
3
  level: SentryLevel.info,
4
);
```

#### 3. 트랜잭션 및 성능 모니터링

[Section titled “3. 트랜잭션 및 성능 모니터링”](#3-트랜잭션-및-성능-모니터링)

```dart
1
// 트랜잭션 시작
2
final transaction = Sentry.startTransaction(
3
  'processPayment',
4
  'operation',
5
);
6


7
try {
8
  // 작업 수행
9
  await processPayment();
10


11
  // 작업 성공
12
  transaction.status = SpanStatus.ok();
13
} catch (exception) {
14
  // 작업 실패
15
  transaction.status = SpanStatus.internalError();
16
  await Sentry.captureException(exception);
17
} finally {
18
  // 트랜잭션 종료
19
  await transaction.finish();
20
}
```

#### 4. 사용자 정보 추가

[Section titled “4. 사용자 정보 추가”](#4-사용자-정보-추가)

```dart
1
Sentry.configureScope((scope) {
2
  scope.setUser(SentryUser(
3
    id: 'user-123',
4
    email: 'user@example.com',
5
    ipAddress: '{{auto}}',
6
    data: {'subscription': 'premium'},
7
  ));
8
});
```

#### 5. 브레드크럼 추가

[Section titled “5. 브레드크럼 추가”](#5-브레드크럼-추가)

브레드크럼은 오류 발생 전의 사용자 활동을 추적하는 데 유용합니다:

```dart
1
// 사용자 활동 기록
2
Sentry.addBreadcrumb(
3
  Breadcrumb(
4
    category: 'ui.click',
5
    message: '결제 버튼 클릭',
6
    level: SentryLevel.info,
7
    data: {'productId': '12345'},
8
  ),
9
);
```

### Riverpod과 함께 사용하기

[Section titled “Riverpod과 함께 사용하기”](#riverpod과-함께-사용하기-1)

```dart
1
import 'package:flutter_riverpod/flutter_riverpod.dart';
2
import 'package:sentry_flutter/sentry_flutter.dart';
3


4
// Riverpod 에러 관찰자
5
class SentryProviderObserver extends ProviderObserver {
6
  @override
7
  void providerDidFail(
8
    ProviderBase provider,
9
    Object error,
10
    StackTrace stackTrace,
11
    ProviderContainer container,
12
  ) {
13
    Sentry.captureException(
14
      error,
15
      stackTrace: stackTrace,
16
      hint: Hint.withMap({
17
        'provider': provider.name ?? provider.runtimeType.toString(),
18
      }),
19
    );
20
  }
21
}
22


23
// main에서 설정
24
void main() async {
25
  await SentryFlutter.init(
26
    (options) {
27
      options.dsn = 'your-dsn-here';
28
      // 기타 옵션 설정
29
    },
30
    appRunner: () {
31
      final container = ProviderContainer(
32
        observers: [SentryProviderObserver()],
33
      );
34


35
      runApp(UncontrolledProviderScope(
36
        container: container,
37
        child: const MyApp(),
38
      ));
39
    },
40
  );
41
}
```

## Crashlytics와 Sentry 비교

[Section titled “Crashlytics와 Sentry 비교”](#crashlytics와-sentry-비교)

두 도구 모두 훌륭한 오류 추적 기능을 제공하지만, 몇 가지 차이점이 있습니다:

| 기능      | Firebase Crashlytics             | Sentry               |
| ------- | -------------------------------- | -------------------- |
| 가격      | 무료                               | 제한적 무료 티어, 유료 플랜     |
| 설정 난이도  | 쉬움                               | 중간                   |
| 플랫폼 지원  | 모바일 중심                           | 모바일, 웹, 서버 등 다양      |
| 생태계 통합  | Firebase 서비스와 통합                 | 다양한 플랫폼 지원           |
| 성능 모니터링 | 제한적 (Firebase Performance 별도 사용) | 기본 포함                |
| 사용자 피드백 | 지원하지 않음                          | 지원                   |
| 자체 호스팅  | 지원하지 않음                          | 지원                   |
| 실시간 알림  | 이메일, 슬랙 등                        | 이메일, 슬랙, PagerDuty 등 |

### Crashlytics가 적합한 경우

[Section titled “Crashlytics가 적합한 경우”](#crashlytics가-적합한-경우)

* Firebase 생태계를 이미 사용 중인 경우
* 무료 솔루션이 필요한 경우
* 모바일 앱에 특화된 기능이 필요한 경우
* 간단한 설정을 선호하는 경우

### Sentry가 적합한 경우

[Section titled “Sentry가 적합한 경우”](#sentry가-적합한-경우)

* 여러 플랫폼(모바일, 웹, 서버 등)을 모니터링하는 경우
* 더 상세한 오류 컨텍스트가 필요한 경우
* 성능 모니터링이 중요한 경우
* 사용자 피드백 수집 기능이 필요한 경우
* 데이터 주권이 중요하여 자체 호스팅이 필요한 경우

## 에러 추적 모범 사례

[Section titled “에러 추적 모범 사례”](#에러-추적-모범-사례)

### 1. 의미 있는 오류 컨텍스트 제공

[Section titled “1. 의미 있는 오류 컨텍스트 제공”](#1-의미-있는-오류-컨텍스트-제공)

```dart
1
try {
2
  await api.fetchData();
3
} catch (e, stack) {
4
  // 구체적인 맥락 정보 추가
5
  await errorTracker.recordError(
6
    e,
7
    stack,
8
    reason: 'API 데이터 가져오기 실패',
9
    information: [
10
      '엔드포인트: /users',
11
      '요청 파라미터: $parameters',
12
      '네트워크 상태: ${connectivity.status}',
13
    ],
14
  );
15
}
```

### 2. 사용자를 구분하되 개인정보 보호

[Section titled “2. 사용자를 구분하되 개인정보 보호”](#2-사용자를-구분하되-개인정보-보호)

```dart
1
// 좋은 예: 식별 가능하지만 개인정보는 아닌 ID 사용
2
errorTracker.setUserIdentifier('user_12345');
3


4
// 나쁜 예: 개인 이메일 사용
5
errorTracker.setUserIdentifier('user@example.com');  // 개인정보!
```

### 3. 중요 흐름에 브레드크럼 추가

[Section titled “3. 중요 흐름에 브레드크럼 추가”](#3-중요-흐름에-브레드크럼-추가)

```dart
1
// 주요 사용자 액션 추적
2
void onCheckoutButtonPressed() {
3
  // 브레드크럼 추가
4
  errorTracker.addBreadcrumb(
5
    'checkout_started',
6
    {'cart_total': '$cartTotal', 'items_count': '${cart.items.length}'},
7
  );
8


9
  // 결제 로직 실행
10
  startCheckoutProcess();
11
}
```

### 4. 릴리스 및 환경 구분

[Section titled “4. 릴리스 및 환경 구분”](#4-릴리스-및-환경-구분)

```dart
1
// Crashlytics
2
FirebaseCrashlytics.instance.setCustomKey('app_version', '1.2.3');
3
FirebaseCrashlytics.instance.setCustomKey('environment', 'production');
4


5
// Sentry
6
await SentryFlutter.init(
7
  (options) {
8
    options.dsn = 'your-dsn';
9
    options.release = '1.2.3';
10
    options.environment = 'production';
11
  },
12
  appRunner: () => runApp(MyApp()),
13
);
```

### 5. 비동기 초기화 패턴 사용

[Section titled “5. 비동기 초기화 패턴 사용”](#5-비동기-초기화-패턴-사용)

```dart
1
Future<void> initializeApp() async {
2
  try {
3
    await Firebase.initializeApp();
4
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
5


6
    // 다른 초기화 로직
7
    await loadSettings();
8
    await authenticateUser();
9
  } catch (e, stack) {
10
    FirebaseCrashlytics.instance.recordError(e, stack);
11
    // 폴백 또는 기본 설정으로 진행
12
  }
13
}
```

### 6. 디버그와 릴리스 모드 분리

[Section titled “6. 디버그와 릴리스 모드 분리”](#6-디버그와-릴리스-모드-분리)

```dart
1
// 디버그 모드에서는 에러 추적 비활성화
2
bool shouldEnableErrorTracking = kReleaseMode;
3


4
// 또는 더 세분화된 제어
5
bool shouldEnableErrorTracking = kReleaseMode || kProfileMode;
6


7
FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
8
  shouldEnableErrorTracking,
9
);
```

## 결론

[Section titled “결론”](#결론)

효과적인 에러 추적은 안정적인 앱을 유지하고 사용자 경험을 향상시키는 데 필수적입니다. Firebase Crashlytics와 Sentry는 각자의 강점을 가진 뛰어난 도구로, 프로젝트의 요구사항에 맞게 선택할 수 있습니다.

Crashlytics는 Firebase 생태계와의 통합, 무료 사용, 간편한 설정이 장점이며, Sentry는 크로스 플랫폼 지원, 성능 모니터링, 사용자 피드백, 자체 호스팅 등의 고급 기능을 제공합니다.

어떤 도구를 선택하든, 의미 있는 컨텍스트를 제공하고, 사용자 개인정보를 보호하며, 중요 흐름을 추적하는 등의 모범 사례를 따르는 것이 중요합니다. 이를 통해 오류를 효과적으로 감지하고 해결하여 사용자에게 더 안정적인 앱 경험을 제공할 수 있습니다.

# 기능별 vs 계층별 폴더 구조

Flutter 프로젝트를 시작할 때 가장 중요한 결정 중 하나는 코드를 어떻게 구성할 것인지 결정하는 것입니다. 적절한 프로젝트 구조는 코드의 가독성을 높이고, 확장성을 향상시키며, 팀 협업을 원활하게 합니다. 이 문서에서는 두 가지 주요 프로젝트 구조 접근 방식인 ‘기능별 구조’와 ‘계층별 구조’에 대해 살펴보고, 각각의 장단점 및 적합한 사용 사례를 분석합니다.

## 프로젝트 구조의 중요성

[Section titled “프로젝트 구조의 중요성”](#프로젝트-구조의-중요성)

좋은 프로젝트 구조는 다음과 같은 이점을 제공합니다:

1. **새로운 개발자의 온보딩 시간 단축**: 직관적인 구조는 새로운 팀원이 프로젝트를 더 빠르게 이해하도록 돕습니다.
2. **코드 충돌 감소**: 잘 정의된 구조는 여러 개발자가 동시에 작업할 때 충돌을 줄입니다.
3. **기능 구현 시간 단축**: 관련 코드를 쉽게 찾고 수정할 수 있습니다.
4. **테스트 용이성**: 모듈화된 구조는 테스트를 더 쉽게 작성하고 실행할 수 있게 합니다.
5. **코드 재사용 촉진**: 잘 구성된 구조는 코드 재사용을 장려하고 중복을 줄입니다.

## 계층별 폴더 구조

[Section titled “계층별 폴더 구조”](#계층별-폴더-구조)

계층별 폴더 구조(Layer-based Structure)는 코드를 기술적 관심사 또는 아키텍처 계층에 따라 구성하는 방식입니다.

### 계층별 구조의 기본 예시

[Section titled “계층별 구조의 기본 예시”](#계층별-구조의-기본-예시)

* lib/

  * models/ # 데이터 모델 클래스

    * user.dart
    * product.dart
    * order.dart

  * views/ # UI 컴포넌트 및 화면

    * home\_screen.dart
    * product\_screen.dart
    * profile\_screen.dart

  * controllers/ # 비즈니스 로직 및 상태 관리

    * auth\_controller.dart
    * product\_controller.dart
    * order\_controller.dart

  * services/ # 외부 서비스 통신 (API, 데이터베이스 등)

    * api\_service.dart
    * storage\_service.dart
    * analytics\_service.dart

  * utils/ # 유틸리티 함수 및 상수

    * constants.dart
    * extensions.dart
    * helpers.dart

  * main.dart

### 계층별 구조의 변형: MVVM 패턴

[Section titled “계층별 구조의 변형: MVVM 패턴”](#계층별-구조의-변형-mvvm-패턴)

* lib/

  * data/

    * models/ # 데이터 모델

      * …

    * repositories/ # 데이터 액세스 계층

      * …

    * data\_sources/ # 로컬/원격 데이터 소스

      * …

  * domain/

    * entities/ # 비즈니스 모델

      * …

    * repositories/ # 리포지토리 인터페이스

      * …

    * usecases/ # 비즈니스 규칙 및 로직

      * …

  * presentation/

    * pages/ # 화면

      * …

    * widgets/ # 재사용 가능한 UI 컴포넌트

      * …

    * viewmodels/ # 뷰 모델 (상태 관리)

      * …

  * core/

    * utils/ # 유틸리티 함수

      * …

    * constants/ # 상수

      * …

    * theme/ # 앱 테마

      * …

  * main.dart

### 계층별 구조의 장점

[Section titled “계층별 구조의 장점”](#계층별-구조의-장점)

1. **기술적 관심사 분리**: 코드를 역할에 따라 명확하게 구분합니다.
2. **구조 이해 용이성**: 새로운 개발자가 아키텍처를 쉽게 이해할 수 있습니다.
3. **역할 기반 작업 분담**: 프론트엔드/백엔드 개발자가 각자 담당 영역에 집중할 수 있습니다.
4. **유사한 코드 패턴**: 같은 계층에 있는 코드는 유사한 패턴을 따르기 쉽습니다.
5. **기술 스택 변경 용이성**: 특정 계층의 기술을 교체할 때 영향 범위가 제한적입니다.

### 계층별 구조의 단점

[Section titled “계층별 구조의 단점”](#계층별-구조의-단점)

1. **관련 코드 분산**: 하나의 기능을 구현하기 위해 여러 폴더를 탐색해야 합니다.
2. **파일 수 증가에 따른 복잡성**: 프로젝트가 커지면 각 폴더의 파일 수가 많아져 찾기 어려워집니다.
3. **기능 추가 시 여러 폴더 수정**: 새 기능 추가 시 여러 폴더에 걸쳐 파일을 생성/수정해야 합니다.
4. **관련 코드의 결합도 파악 어려움**: 서로 다른 폴더에 있는 관련 코드 간의 관계를 파악하기 어렵습니다.
5. **코드 재사용 저해**: 특정 기능에 특화된 코드를 식별하고 재사용하기 어려울 수 있습니다.

## 기능별 폴더 구조

[Section titled “기능별 폴더 구조”](#기능별-폴더-구조)

기능별 폴더 구조(Feature-based Structure)는 코드를 비즈니스 기능이나 앱의 주요 기능에 따라 구성하는 방식입니다.

### 기능별 구조의 기본 예시

[Section titled “기능별 구조의 기본 예시”](#기능별-구조의-기본-예시)

* lib/

  * features/

    * auth/ # 인증 관련 기능

      * data/

        * repositories/

          * …

        * models/

          * …

      * domain/

        * usecases/

          * …

      * presentation/

        * pages/

          * login\_page.dart
          * signup\_page.dart

        * widgets/

          * …

        * providers/

          * …

    * products/ # 제품 관련 기능

      * data/

        * …

      * domain/

        * …

      * presentation/

        * pages/

          * product\_list\_page.dart
          * product\_detail\_page.dart

        * widgets/

          * …

        * providers/

          * …

    * profile/ # 프로필 관련 기능

      * data/

        * …

      * domain/

        * …

      * presentation/

        * …

  * core/ # 공통 기능

    * network/

      * …

    * storage/

      * …

    * theme/

      * …

    * utils/

      * …

  * main.dart

### 기능별 구조의 변형: DDD(Domain-Driven Design) 적용

[Section titled “기능별 구조의 변형: DDD(Domain-Driven Design) 적용”](#기능별-구조의-변형-ddddomain-driven-design-적용)

* lib/

  * application/ # 애플리케이션 서비스 (UseCase)

    * auth/

      * …

    * products/

      * …

    * profile/

      * …

  * domain/ # 도메인 모델 및 규칙

    * auth/

      * …

    * products/

      * …

    * profile/

      * …

  * infrastructure/ # 인프라 계층 (리포지토리 구현, 데이터 소스)

    * auth/

      * …

    * products/

      * …

    * profile/

      * …

  * presentation/ # UI 계층

    * auth/

      * …

    * products/

      * …

    * profile/

      * …

  * shared/ # 공통 기능

    * constants/

      * …

    * extensions/

      * …

    * widgets/

      * …

  * main.dart

### 기능별 구조의 장점

[Section titled “기능별 구조의 장점”](#기능별-구조의-장점)

1. **관련 코드 근접성**: 하나의 기능과 관련된 모든 코드가 같은 폴더에 위치합니다.
2. **독립적인 기능 개발**: 각 기능을 독립적으로 개발하고 테스트할 수 있습니다.
3. **기능 단위의 캡슐화**: 각 기능은 자체 모델, 뷰, 로직을 포함하여 자율적입니다.
4. **기능별 작업 분담**: 팀원이 특정 기능에 집중하여 작업할 수 있습니다.
5. **확장성**: 새로운 기능을 추가할 때 기존 코드를 변경할 필요가 적습니다.
6. **코드 재사용**: 기능별로 특화된 코드를 쉽게 식별하고 재사용할 수 있습니다.

### 기능별 구조의 단점

[Section titled “기능별 구조의 단점”](#기능별-구조의-단점)

1. **중복 코드 가능성**: 여러 기능 간에 유사한 코드가 중복될 수 있습니다.
2. **일관성 유지 어려움**: 각 기능별로 다른 패턴이 적용될 수 있습니다.
3. **기능 간 경계 설정 어려움**: 어떤 코드가 어느 기능에 속하는지 결정하기 어려울 수 있습니다.
4. **공통 코드 관리**: 여러 기능에서 사용하는 공통 코드의 위치를 결정하기 어려울 수 있습니다.
5. **아키텍처 이해의 어려움**: 전체 아키텍처를 한눈에 파악하기 어려울 수 있습니다.

## 실제 프로젝트 구조 예시: Riverpod + GoRouter

[Section titled “실제 프로젝트 구조 예시: Riverpod + GoRouter”](#실제-프로젝트-구조-예시-riverpod--gorouter)

### 계층별 구조 예시

[Section titled “계층별 구조 예시”](#계층별-구조-예시)

* lib/

  * models/ # 데이터 모델

    * user.dart
    * product.dart
    * order.dart

  * providers/ # Riverpod 프로바이더

    * auth\_provider.dart
    * product\_provider.dart
    * cart\_provider.dart

  * repositories/ # 데이터 액세스 계층

    * auth\_repository.dart
    * product\_repository.dart
    * order\_repository.dart

  * screens/ # 화면 위젯

    * auth/

      * login\_screen.dart
      * signup\_screen.dart

    * products/

      * product\_list\_screen.dart
      * product\_detail\_screen.dart

    * profile/

      * profile\_screen.dart

  * widgets/ # 재사용 위젯

    * product\_card.dart
    * custom\_button.dart
    * loading\_indicator.dart

  * router/ # GoRouter 설정

    * router.dart

  * utils/ # 유틸리티

    * constants.dart
    * extensions.dart

  * main.dart

### 기능별 구조 예시

[Section titled “기능별 구조 예시”](#기능별-구조-예시)

* lib/

  * features/

    * auth/

      * models/

        * user.dart

      * repositories/

        * auth\_repository.dart

      * providers/

        * auth\_provider.dart

      * screens/

        * login\_screen.dart
        * signup\_screen.dart

      * widgets/

        * login\_form.dart
        * social\_login\_buttons.dart

    * products/

      * models/

        * product.dart

      * repositories/

        * product\_repository.dart

      * providers/

        * product\_provider.dart

      * screens/

        * product\_list\_screen.dart
        * product\_detail\_screen.dart

      * widgets/

        * product\_card.dart

    * cart/

      * models/

        * cart\_item.dart

      * repositories/

        * cart\_repository.dart

      * providers/

        * cart\_provider.dart

      * screens/

        * cart\_screen.dart
        * checkout\_screen.dart

      * widgets/

        * cart\_item\_widget.dart

  * core/

    * router/

      * router.dart

    * theme/

      * app\_theme.dart

    * widgets/

      * custom\_button.dart
      * loading\_indicator.dart

    * utils/

      * constants.dart
      * extensions.dart

  * main.dart

## 하이브리드 접근 방식

[Section titled “하이브리드 접근 방식”](#하이브리드-접근-방식)

많은 실제 프로젝트에서는 두 가지 접근 방식을 혼합하여 사용합니다. 다음은 하이브리드 구조의 예시입니다:

* lib/

  * features/ # 주요 기능별 구성

    * auth/

      * …

    * products/

      * …

    * cart/

      * …

  * shared/ # 공유 컴포넌트

    * models/ # 공통 모델

      * …

    * widgets/ # 공통 위젯

      * …

    * services/ # 공통 서비스

      * …

    * utils/ # 유틸리티

      * …

  * core/ # 핵심 인프라

    * network/ # 네트워크 관련

      * …

    * storage/ # 로컬 스토리지

      * …

    * di/ # 의존성 주입

      * …

    * router/ # 라우팅

      * …

  * main.dart

이 접근 방식은 다음과 같은 이점을 제공합니다:

1. **주요 기능의 독립성**: 핵심 기능은 독립적으로 구성
2. **공통 코드 관리**: 여러 기능에서 공유하는 코드는 중앙에서 관리
3. **핵심 인프라 분리**: 앱의 기반이 되는 인프라 코드를 명확하게 분리
4. **유연성**: 프로젝트 요구사항에 맞게 구조를 조정할 수 있음

## Riverpod과 함께 사용하는 패턴

[Section titled “Riverpod과 함께 사용하는 패턴”](#riverpod과-함께-사용하는-패턴)

Riverpod을 사용할 때는 프로바이더를 어떻게 구성할지도 중요한 고려 사항입니다:

### 계층별 구조에서의 Riverpod 패턴

[Section titled “계층별 구조에서의 Riverpod 패턴”](#계층별-구조에서의-riverpod-패턴)

providers/product\_provider.dart

```dart
1
final productRepositoryProvider = Provider<ProductRepository>((ref) {
2
  return ProductRepositoryImpl(ref.read(apiServiceProvider));
3
});
4


5
final productsProvider = FutureProvider<List<Product>>((ref) async {
6
  final repository = ref.watch(productRepositoryProvider);
7
  return repository.getProducts();
8
});
9


10
final productDetailsProvider = FutureProvider.family<Product, String>((ref, id) async {
11
  final repository = ref.watch(productRepositoryProvider);
12
  return repository.getProductById(id);
13
});
```

### 기능별 구조에서의 Riverpod 패턴

[Section titled “기능별 구조에서의 Riverpod 패턴”](#기능별-구조에서의-riverpod-패턴)

features/products/providers/product\_provider.dart

```dart
1
final productRepositoryProvider = Provider<ProductRepository>((ref) {
2
  return ProductRepositoryImpl(ref.read(apiServiceProvider));
3
});
4


5
final productsProvider = FutureProvider<List<Product>>((ref) async {
6
  final repository = ref.watch(productRepositoryProvider);
7
  return repository.getProducts();
8
});
9


10
final productDetailsProvider = FutureProvider.family<Product, String>((ref, id) async {
11
  final repository = ref.watch(productRepositoryProvider);
12
  return repository.getProductById(id);
13
});
```

### 추천 패턴: 계층적 프로바이더 구성

[Section titled “추천 패턴: 계층적 프로바이더 구성”](#추천-패턴-계층적-프로바이더-구성)

features/products/providers/product\_provider.dart

```dart
1
// 1. 데이터 소스 프로바이더 (최하위 계층)
2
@riverpod
3
ProductDataSource productDataSource(ProductDataSourceRef ref) {
4
  final apiClient = ref.watch(apiClientProvider);
5
  return ProductDataSourceImpl(apiClient);
6
}
7


8
// 2. 리포지토리 프로바이더
9
@riverpod
10
ProductRepository productRepository(ProductRepositoryRef ref) {
11
  final dataSource = ref.watch(productDataSourceProvider);
12
  return ProductRepositoryImpl(dataSource);
13
}
14


15
// 3. 유스케이스 프로바이더 (선택적)
16
@riverpod
17
GetProductsUseCase getProductsUseCase(GetProductsUseCaseRef ref) {
18
  final repository = ref.watch(productRepositoryProvider);
19
  return GetProductsUseCase(repository);
20
}
21


22
// 4. 상태 프로바이더
23
@riverpod
24
class ProductsNotifier extends _$ProductsNotifier {
25
  @override
26
  FutureOr<List<Product>> build() async {
27
    return _fetchProducts();
28
  }
29


30
  Future<List<Product>> _fetchProducts() {
31
    final useCase = ref.watch(getProductsUseCaseProvider);
32
    return useCase.execute();
33
  }
34


35
  Future<void> refresh() async {
36
    state = const AsyncValue.loading();
37
    state = await AsyncValue.guard(_fetchProducts);
38
  }
39
}
```

## 어떤 구조를 선택해야 할까?

[Section titled “어떤 구조를 선택해야 할까?”](#어떤-구조를-선택해야-할까)

프로젝트 구조 선택 시 고려해야 할 요소:

### 계층별 구조가 적합한 경우

[Section titled “계층별 구조가 적합한 경우”](#계층별-구조가-적합한-경우)

1. **소규모 프로젝트**: 기능이 적고 단순한 앱
2. **명확한 기술적 분리**: 프론트엔드/백엔드 개발자 역할이 명확히 구분된 팀
3. **아키텍처 패턴 중시**: MVC, MVVM과 같은 아키텍처 패턴을 엄격히 따르고자 할 때
4. **초보 개발자 팀**: 명확한 폴더 구조가 필요한 경우

### 기능별 구조가 적합한 경우

[Section titled “기능별 구조가 적합한 경우”](#기능별-구조가-적합한-경우)

1. **중대형 프로젝트**: 다양한 기능이 있는 복잡한 앱
2. **수직적 팀 구조**: 팀원이 특정 기능을 전담하는 경우
3. **마이크로서비스 지향**: 각 기능을 독립적으로 개발/테스트하고자 할 때
4. **기능 단위 배포**: 기능별로 점진적 배포를 계획하는 경우
5. **도메인 중심 설계**: DDD(Domain-Driven Design) 원칙을 따르는 경우

## 실제 업계 사례

[Section titled “실제 업계 사례”](#실제-업계-사례)

대형 Flutter 앱들의 구조를 살펴보면 다음과 같은 패턴을 볼 수 있습니다:

1. **Google의 Flutter 샘플 앱**: 기능별 구조를 선호 (Flutter Gallery, Flutter Samples)
2. **Alibaba의 Flutter 앱**: 하이브리드 구조 채택 (일부 공통 모듈은 계층별, 주요 기능은 기능별)
3. **중소규모 앱**: 초기에는 계층별 구조로 시작하여 점차 기능별 또는 하이브리드 구조로 전환하는 경향

## 결론

[Section titled “결론”](#결론)

프로젝트 구조는 정답이 없는 주제입니다. 중요한 것은 팀과 프로젝트 특성에 맞는 구조를 선택하고, 일관성 있게 유지하는 것입니다.

* **소규모/단순 앱**: 계층별 구조가 직관적이고 빠르게 구성 가능
* **중대형/복잡한 앱**: 기능별 구조 또는 하이브리드 구조가 유지보수와 확장성에 유리
* **성장 예상 앱**: 처음부터 기능별 구조 또는 하이브리드 구조로 시작하는 것이 장기적으로 유리

어떤 구조를 선택하든, 코드 가독성, 유지보수성, 확장성, 팀 협업 용이성이라는 핵심 목표를 기억하며 구조를 설계해야 합니다. 또한 프로젝트가 발전함에 따라 구조를 재평가하고 필요에 따라 조정하는 유연성을 유지하는 것이 중요합니다.

# melos를 이용한 모노레포



# 멀티 모듈 아키텍처

대규모 Flutter 프로젝트에서는 코드베이스가 커짐에 따라 빌드 시간 증가, 유지보수 복잡성, 팀 협업 어려움 등의 문제가 발생할 수 있습니다. 이러한 문제를 해결하기 위한 방법 중 하나가 멀티 모듈 아키텍처입니다. 이 문서에서는 Flutter에서 멀티 모듈 아키텍처를 구현하는 방법, 장단점, 그리고 실제 적용 사례를 살펴보겠습니다.

## 멀티 모듈 아키텍처란?

[Section titled “멀티 모듈 아키텍처란?”](#멀티-모듈-아키텍처란)

멀티 모듈 아키텍처는 하나의 큰 애플리케이션을 여러 개의 독립적인 모듈(또는 패키지)로 분리하는 접근 방식입니다. 각 모듈은 특정 기능이나 도메인에 초점을 맞추고, 명확하게 정의된 인터페이스를 통해 다른 모듈과 통신합니다.

## 멀티 모듈의 장점

[Section titled “멀티 모듈의 장점”](#멀티-모듈의-장점)

1. **빌드 시간 단축**: 전체 앱이 아닌 변경된 모듈만 재빌드하여 개발 속도를 높일 수 있습니다.
2. **관심사 분리**: 각 모듈은 특정 기능에 집중하여 코드 이해와 유지보수가 용이해집니다.
3. **팀 협업 개선**: 각 팀이 독립적인 모듈에서 작업하여 코드 충돌을 줄일 수 있습니다.
4. **코드 재사용성**: 모듈을 다른 프로젝트에서 재사용할 수 있습니다.
5. **테스트 용이성**: 모듈별로 독립적인 테스트가 가능합니다.
6. **의존성 명확화**: 모듈 간 의존성이 명시적으로 정의되어 구조가 명확해집니다.

## 멀티 모듈의 단점

[Section titled “멀티 모듈의 단점”](#멀티-모듈의-단점)

1. **초기 설정 복잡성**: 프로젝트 구조 설정이 복잡하고 시간이 소요됩니다.
2. **의존성 관리 어려움**: 모듈 간 의존성을 올바르게 관리해야 합니다.
3. **통합 테스트 복잡성**: 모듈 간 통합 테스트가 더 복잡해질 수 있습니다.
4. **학습 곡선**: 팀원들이 모듈 구조에 적응하는 데 시간이 필요합니다.
5. **오버엔지니어링 위험**: 작은 프로젝트에서는 불필요한 복잡성이 추가될 수 있습니다.

## Flutter에서의 멀티 모듈 구현 방법

[Section titled “Flutter에서의 멀티 모듈 구현 방법”](#flutter에서의-멀티-모듈-구현-방법)

Flutter에서 멀티 모듈 아키텍처를 구현하는 여러 방법이 있습니다. 가장 일반적인 방법은 다음과 같습니다:

### 1. 로컬 패키지 사용

[Section titled “1. 로컬 패키지 사용”](#1-로컬-패키지-사용)

같은 저장소 내에서 여러 패키지를 관리하는 방법입니다.

#### 프로젝트 구조 예시

[Section titled “프로젝트 구조 예시”](#프로젝트-구조-예시)

* my\_flutter\_project/

  * app/ # 메인 앱 모듈

    * lib/

      * …

    * pubspec.yaml

    * …

  * packages/

    * core/ # 핵심 기능 모듈

      * lib/

        * …

      * pubspec.yaml

    * feature\_auth/ # 인증 기능 모듈

      * lib/

        * …

      * pubspec.yaml

    * feature\_home/ # 홈 기능 모듈

      * lib/

        * …

      * pubspec.yaml

    * feature\_profile/ # 프로필 기능 모듈

      * lib/

        * …

      * pubspec.yaml

  * pubspec.yaml # 루트 pubspec.yaml (옵션)

#### 각 모듈의 pubspec.yaml 설정

[Section titled “각 모듈의 pubspec.yaml 설정”](#각-모듈의-pubspecyaml-설정)

app/pubspec.yaml

```yaml
1
name: my_app
2
description: Main application module
3
version: 1.0.0+1
4


5
environment:
6
  sdk: ">=3.0.0 <4.0.0"
7
  flutter: ">=3.10.0"
8


9
dependencies:
10
  flutter:
11
    sdk: flutter
12
  # 로컬 패키지 의존성
13
  core:
14
    path: ../packages/core
15
  feature_auth:
16
    path: ../packages/feature_auth
17
  feature_home:
18
    path: ../packages/feature_home
19
  feature_profile:
20
    path: ../packages/feature_profile
```

packages/core/pubspec.yaml

```yaml
1
name: core
2
description: Core module with shared functionality
3
version: 0.0.1
4


5
environment:
6
  sdk: ">=3.0.0 <4.0.0"
7
  flutter: ">=3.10.0"
8


9
dependencies:
10
  flutter:
11
    sdk: flutter
12
  # 코어 모듈의 의존성
13
  http: ^1.1.0
14
  shared_preferences: ^2.2.0
```

packages/feature\_auth/pubspec.yaml

```yaml
1
name: feature_auth
2
description: Authentication feature module
3
version: 0.0.1
4


5
environment:
6
  sdk: ">=3.0.0 <4.0.0"
7
  flutter: ">=3.10.0"
8


9
dependencies:
10
  flutter:
11
    sdk: flutter
12
  # 코어 모듈에 의존
13
  core:
14
    path: ../core
15
  # 기타 의존성
16
  firebase_auth: ^4.6.0
```

### 2. melos를 사용한 모노레포

[Section titled “2. melos를 사용한 모노레포”](#2-melos를-사용한-모노레포)

[melos](https://github.com/invertase/melos)는 Dart/Flutter 프로젝트에서 모노레포를 관리하기 위한 도구로, 여러 패키지를 효율적으로 관리할 수 있게 해줍니다.

#### 설치 및 설정

[Section titled “설치 및 설정”](#설치-및-설정)

1. melos 설치:

```bash
1
dart pub global activate melos
```

2. 프로젝트 루트에 `melos.yaml` 파일 생성:

melos.yaml

```yaml
1
name: my_flutter_project
2


3
packages:
4
  - app
5
  - packages/**
6


7
scripts:
8
  analyze:
9
    run: melos exec -- "flutter analyze"
10
    description: Run flutter analyze in all packages
11


12
  test:
13
    run: melos exec -- "flutter test"
14
    description: Run flutter test in all packages
15


16
  pub_get:
17
    run: melos exec -- "flutter pub get"
18
    description: Run flutter pub get in all packages
```

3. 사용 예시:

```bash
1
# 모든 패키지에서 flutter pub get 실행
2
melos pub_get
3


4
# 모든 패키지에서 flutter analyze 실행
5
melos analyze
6


7
# 모든 패키지에서 flutter test 실행
8
melos test
```

### 3. Flutter Flavors와 조합

[Section titled “3. Flutter Flavors와 조합”](#3-flutter-flavors와-조합)

멀티 모듈 아키텍처는 Flutter Flavors와 결합하여 다양한 앱 버전(개발, 스테이징, 프로덕션 등)을 관리할 수 있습니다:

app/lib/main\_dev.dart

```dart
1
import 'package:core/config.dart';
2
import 'package:flutter/material.dart';
3
import 'app.dart';
4


5
void main() {
6
  AppConfig.initialize(
7
    env: Environment.dev,
8
    apiUrl: 'https://dev-api.example.com',
9
  );
10
  runApp(const MyApp());
11
}
```

app/lib/main\_prod.dart

```dart
1
import 'package:core/config.dart';
2
import 'package:flutter/material.dart';
3
import 'app.dart';
4


5
void main() {
6
  AppConfig.initialize(
7
    env: Environment.prod,
8
    apiUrl: 'https://api.example.com',
9
  );
10
  runApp(const MyApp());
11
}
```

## 모듈 구조 및 설계 방법론

[Section titled “모듈 구조 및 설계 방법론”](#모듈-구조-및-설계-방법론)

### 모듈 유형

[Section titled “모듈 유형”](#모듈-유형)

멀티 모듈 아키텍처에서 일반적으로 사용되는 모듈 유형은 다음과 같습니다:

1. **앱 모듈(App Module)**: 애플리케이션의 진입점이며 다른 모든 모듈을 통합합니다.
2. **코어 모듈(Core Module)**: 공통 기능, 유틸리티, 핵심 컴포넌트 등을 포함합니다.
3. **기능 모듈(Feature Module)**: 특정 기능 또는 도메인에 집중한 모듈입니다.
4. **UI 모듈(UI Module)**: 재사용 가능한 UI 컴포넌트를 포함합니다.
5. **데이터 모듈(Data Module)**: 데이터 액세스 로직을 담당합니다.

### 의존성 방향

[Section titled “의존성 방향”](#의존성-방향)

모듈 간 의존성 방향은 명확하게 설정해야 합니다:

* **코어 모듈**: 다른 모든 모듈의 기반이 되며, 다른 모듈에 의존하지 않습니다.
* **기능 모듈**: 코어 모듈과 UI 모듈에 의존할 수 있지만, 다른 기능 모듈에 직접 의존하지 않는 것이 좋습니다.
* **앱 모듈**: 모든 모듈을 통합하고 의존합니다.

### 모듈 간 통신

[Section titled “모듈 간 통신”](#모듈-간-통신)

모듈 간 통신은 다음과 같은 방법으로 이루어질 수 있습니다:

1. **인터페이스 기반 통신**: 모듈은 인터페이스를 정의하고 구현체는 필요한 모듈에서 제공합니다.
2. **이벤트 기반 통신**: 이벤트 버스나 스트림을 통해 모듈 간 이벤트를 전달합니다.
3. **의존성 주입**: Riverpod이나 GetIt 같은 도구를 사용하여 모듈 간 의존성을 관리합니다.

#### 인터페이스 기반 통신 예시

[Section titled “인터페이스 기반 통신 예시”](#인터페이스-기반-통신-예시)

core/lib/src/auth/auth\_service.dart

```dart
1
abstract class AuthService {
2
  Future<User?> getCurrentUser();
3
  Future<User> signIn(String email, String password);
4
  Future<void> signOut();
5
}
```

feature\_auth/lib/src/services/firebase\_auth\_service.dart

```dart
1
class FirebaseAuthService implements AuthService {
2
  @override
3
  Future<User?> getCurrentUser() {
4
    // Firebase 구현
5
  }
6


7
  @override
8
  Future<User> signIn(String email, String password) {
9
    // Firebase 구현
10
  }
11


12
  @override
13
  Future<void> signOut() {
14
    // Firebase 구현
15
  }
16
}
```

app/lib/di/service\_locator.dart

```dart
1
void setupServiceLocator() {
2
  GetIt.I.registerSingleton<AuthService>(FirebaseAuthService());
3
}
```

## 모듈 내부 구조

[Section titled “모듈 내부 구조”](#모듈-내부-구조)

각 모듈 내부는 클린 아키텍처나 MVVM 같은 아키텍처 패턴을 따를 수 있습니다.

### 기능 모듈 예시

[Section titled “기능 모듈 예시”](#기능-모듈-예시)

* feature\_auth/

  * lib/

    * src/

      * data/

        * models/

          * …

        * repositories/

          * …

        * datasources/

          * …

      * domain/

        * entities/

          * …

        * usecases/

          * …

        * repositories/

          * …

      * presentation/

        * pages/

          * …

        * widgets/

          * …

        * providers/

          * …

      * di/

        * auth\_module.dart

    * feature\_auth.dart # 공개 API

    * testing.dart # 테스트 지원 API (선택사항)

  * test/

    * …

  * pubspec.yaml

### 공개 API 설계

[Section titled “공개 API 설계”](#공개-api-설계)

각 모듈은 명확한 공개 API를 정의해야 합니다. 모듈 내부 구현은 숨기고 필요한 기능만 노출하는 것이 좋습니다.

feature\_auth/lib/feature\_auth.dart

```dart
1
library feature_auth;
2


3
// 공개 API
4
export 'src/presentation/pages/login_page.dart';
5
export 'src/presentation/pages/register_page.dart';
6
export 'src/domain/entities/user.dart';
7
export 'src/di/auth_module.dart';
```

feature\_auth/lib/src/di/auth\_module.dart

```dart
1
import 'package:get_it/get_it.dart';
2
import '../data/repositories/auth_repository_impl.dart';
3
import '../data/datasources/auth_remote_datasource.dart';
4
import '../domain/repositories/auth_repository.dart';
5
import '../domain/usecases/sign_in.dart';
6
import '../domain/usecases/sign_out.dart';
7


8
class AuthModule {
9
  static void init() {
10
    final GetIt sl = GetIt.instance;
11


12
    // Data sources
13
    sl.registerLazySingleton<AuthRemoteDataSource>(
14
      () => AuthRemoteDataSourceImpl(client: sl()),
15
    );
16


17
    // Repositories
18
    sl.registerLazySingleton<AuthRepository>(
19
      () => AuthRepositoryImpl(remoteDataSource: sl()),
20
    );
21


22
    // Use cases
23
    sl.registerLazySingleton(() => SignIn(sl()));
24
    sl.registerLazySingleton(() => SignOut(sl()));
25
  }
26
}
```

## 실제 적용 사례: 전자상거래 앱

[Section titled “실제 적용 사례: 전자상거래 앱”](#실제-적용-사례-전자상거래-앱)

실제 전자상거래 앱에 멀티 모듈 아키텍처를 적용해보겠습니다.

### 프로젝트 구조

[Section titled “프로젝트 구조”](#프로젝트-구조)

* ecommerce\_app/

  * app/ # 메인 앱 모듈

    * …

  * packages/

    * core/ # 핵심 기능 모듈

      * …

    * ui\_kit/ # UI 컴포넌트 모듈

      * …

    * feature\_auth/ # 인증 기능 모듈

      * …

    * feature\_products/ # 상품 기능 모듈

      * …

    * feature\_cart/ # 장바구니 기능 모듈

      * …

    * feature\_checkout/ # 결제 기능 모듈

      * …

    * feature\_profile/ # 프로필 기능 모듈

      * …

  * melos.yaml

### 코어 모듈

[Section titled “코어 모듈”](#코어-모듈)

코어 모듈은 다른 모든 모듈에서 사용하는 공통 기능을 포함합니다:

core/lib/core.dart

```dart
1
library core;
2


3
export 'src/config/app_config.dart';
4
export 'src/network/api_client.dart';
5
export 'src/storage/local_storage.dart';
6
export 'src/utils/extensions.dart';
7
export 'src/di/service_locator.dart';
8
export 'src/navigation/router.dart';
```

core/lib/src/config/app\_config.dart

```dart
1
enum Environment { dev, staging, prod }
2


3
class AppConfig {
4
  static late Environment _environment;
5
  static late String _apiUrl;
6


7
  static Environment get environment => _environment;
8
  static String get apiUrl => _apiUrl;
9


10
  static void initialize({
11
    required Environment env,
12
    required String apiUrl,
13
  }) {
14
    _environment = env;
15
    _apiUrl = apiUrl;
16
  }
17


18
  static bool get isDev => _environment == Environment.dev;
19
  static bool get isStaging => _environment == Environment.staging;
20
  static bool get isProd => _environment == Environment.prod;
21
}
```

### UI 키트 모듈

[Section titled “UI 키트 모듈”](#ui-키트-모듈)

UI 키트 모듈은 앱 전체에서 사용되는 공통 UI 컴포넌트를 포함합니다:

ui\_kit/lib/ui\_kit.dart

```dart
1
library ui_kit;
2


3
export 'src/buttons/primary_button.dart';
4
export 'src/cards/product_card.dart';
5
export 'src/theme/app_theme.dart';
6
export 'src/inputs/text_field.dart';
```

ui\_kit/lib/src/buttons/primary\_button.dart

```dart
1
import 'package:flutter/material.dart';
2


3
class PrimaryButton extends StatelessWidget {
4
  final String text;
5
  final VoidCallback onPressed;
6
  final bool isLoading;
7


8
  const PrimaryButton({
9
    Key? key,
10
    required this.text,
11
    required this.onPressed,
12
    this.isLoading = false,
13
  }) : super(key: key);
14


15
  @override
16
  Widget build(BuildContext context) {
17
    return ElevatedButton(
18
      onPressed: isLoading ? null : onPressed,
19
      child: isLoading
20
          ? const CircularProgressIndicator(color: Colors.white)
21
          : Text(text),
22
    );
23
  }
24
}
```

### 기능 모듈: 상품

[Section titled “기능 모듈: 상품”](#기능-모듈-상품)

상품 기능 모듈은 상품 목록, 상세 정보, 검색 등의 기능을 담당합니다:

feature\_products/lib/feature\_products.dart

```dart
1
library feature_products;
2


3
export 'src/presentation/pages/product_list_page.dart';
4
export 'src/presentation/pages/product_detail_page.dart';
5
export 'src/domain/entities/product.dart';
6
export 'src/di/products_module.dart';
```

feature\_products/lib/src/presentation/pages/product\_list\_page.dart

```dart
1
import 'package:core/core.dart';
2
import 'package:flutter/material.dart';
3
import 'package:flutter_riverpod/flutter_riverpod.dart';
4
import 'package:ui_kit/ui_kit.dart';
5
import '../providers/products_provider.dart';
6


7
class ProductListPage extends ConsumerWidget {
8
  const ProductListPage({Key? key}) : super(key: key);
9


10
  @override
11
  Widget build(BuildContext context, WidgetRef ref) {
12
    final productsAsync = ref.watch(productsProvider);
13


14
    return Scaffold(
15
      appBar: AppBar(title: const Text('상품 목록')),
16
      body: productsAsync.when(
17
        data: (products) => GridView.builder(
18
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
19
            crossAxisCount: 2,
20
            childAspectRatio: 0.7,
21
          ),
22
          itemCount: products.length,
23
          itemBuilder: (context, index) {
24
            final product = products[index];
25
            return ProductCard(
26
              product: product,
27
              onTap: () => Navigator.of(context).pushNamed(
28
                '/product/${product.id}',
29
              ),
30
            );
31
          },
32
        ),
33
        loading: () => const Center(child: CircularProgressIndicator()),
34
        error: (error, stackTrace) => Center(
35
          child: Text('오류가 발생했습니다: $error'),
36
        ),
37
      ),
38
    );
39
  }
40
}
```

### 통합: 앱 모듈

[Section titled “통합: 앱 모듈”](#통합-앱-모듈)

앱 모듈은 모든 기능 모듈을 통합하고 앱의 진입점 역할을 합니다:

app/lib/main\_dev.dart

```dart
1
import 'package:core/core.dart';
2
import 'package:feature_auth/feature_auth.dart';
3
import 'package:feature_products/feature_products.dart';
4
import 'package:feature_cart/feature_cart.dart';
5
import 'package:feature_checkout/feature_checkout.dart';
6
import 'package:feature_profile/feature_profile.dart';
7
import 'package:flutter/material.dart';
8
import 'app.dart';
9


10
void main() {
11
  // 앱 설정 초기화
12
  AppConfig.initialize(
13
    env: Environment.dev,
14
    apiUrl: 'https://dev-api.example.com',
15
  );
16


17
  // 의존성 주입 설정
18
  setupServiceLocator();
19


20
  // 모듈별 의존성 초기화
21
  AuthModule.init();
22
  ProductsModule.init();
23
  CartModule.init();
24
  CheckoutModule.init();
25
  ProfileModule.init();
26


27
  runApp(const MyApp());
28
}
```

app/lib/app.dart

```dart
1
import 'package:core/core.dart';
2
import 'package:ui_kit/ui_kit.dart';
3
import 'package:flutter/material.dart';
4
import 'package:flutter_riverpod/flutter_riverpod.dart';
5


6
class MyApp extends StatelessWidget {
7
  const MyApp({Key? key}) : super(key: key);
8


9
  @override
10
  Widget build(BuildContext context) {
11
    return ProviderScope(
12
      child: MaterialApp.router(
13
        title: 'E-Commerce App',
14
        theme: AppTheme.lightTheme,
15
        darkTheme: AppTheme.darkTheme,
16
        themeMode: ThemeMode.system,
17
        routerConfig: appRouter,
18
      ),
19
    );
20
  }
21
}
```

## 멀티 모듈 아키텍처의 과제와 해결책

[Section titled “멀티 모듈 아키텍처의 과제와 해결책”](#멀티-모듈-아키텍처의-과제와-해결책)

### 1. 모듈 간 의존성 순환 문제

[Section titled “1. 모듈 간 의존성 순환 문제”](#1-모듈-간-의존성-순환-문제)

#### 문제

[Section titled “문제”](#문제)

모듈 간 의존성이 순환 구조를 형성하면 복잡성이 증가하고 빌드 문제가 발생할 수 있습니다.

#### 해결책

[Section titled “해결책”](#해결책)

* 의존성 방향을 엄격하게 설정하고 준수합니다.
* 필요한 경우 이벤트 기반 통신을 사용합니다.
* 공통 코드를 코어 모듈로 이동시킵니다.

core/lib/core.dart

```dart
1
// 이벤트 기반 통신 예시 (core 모듈)
2
class AppEvent {
3
  // 이벤트 정의
4
}
5


6
class EventBus {
7
  static final EventBus _instance = EventBus._internal();
8
  factory EventBus() => _instance;
9
  EventBus._internal();
10


11
  final _eventController = StreamController<AppEvent>.broadcast();
12


13
  Stream<AppEvent> get events => _eventController.stream;
14


15
  void fire(AppEvent event) {
16
    _eventController.add(event);
17
  }
18


19
  void dispose() {
20
    _eventController.close();
21
  }
22
}
```

### 2. 빌드 시간 및 성능 문제

[Section titled “2. 빌드 시간 및 성능 문제”](#2-빌드-시간-및-성능-문제)

#### 문제

[Section titled “문제”](#문제-1)

여러 모듈이 많은 의존성을 가지면 빌드 시간이 길어질 수 있습니다.

#### 해결책

[Section titled “해결책”](#해결책-1)

* 필요한 의존성만 추가합니다.
* melos와 같은 도구를 사용하여 빌드 프로세스를 최적화합니다.
* 의존성 트리를 주기적으로 검토하고 정리합니다.

### 3. 디버깅 복잡성

[Section titled “3. 디버깅 복잡성”](#3-디버깅-복잡성)

#### 문제

[Section titled “문제”](#문제-2)

여러 모듈에 걸친 문제를 디버깅하기 어려울 수 있습니다.

#### 해결책

[Section titled “해결책”](#해결책-2)

* 각 모듈에 적절한 로깅을 추가합니다.
* 테스트 커버리지를 높게 유지합니다.
* 통합 테스트를 작성하여 모듈 간 상호작용을 검증합니다.

## 언제 멀티 모듈 아키텍처를 적용해야 하는가?

[Section titled “언제 멀티 모듈 아키텍처를 적용해야 하는가?”](#언제-멀티-모듈-아키텍처를-적용해야-하는가)

다음과 같은 경우에 멀티 모듈 아키텍처를 고려해 볼 수 있습니다:

1. **대규모 프로젝트**: 코드베이스가 크고 복잡한 경우
2. **여러 팀이 협업**: 다수의 개발자가 동시에 작업하는 경우
3. **빌드 시간 문제**: 빌드 시간이 과도하게 길어지는 경우
4. **코드 재사용 요구**: 여러 프로젝트에서 코드를 재사용해야 하는 경우
5. **독립 배포 필요**: 특정 모듈만 독립적으로 업데이트해야 하는 경우

그러나 다음과 같은 경우에는 적용을 신중하게 검토해야 합니다:

1. **소규모 프로젝트**: 간단한 앱은 오히려 복잡성만 증가할 수 있습니다.
2. **작은 팀**: 소수의 개발자만 있는 경우 이점이 제한적일 수 있습니다.
3. **빠른 프로토타이핑**: 빠르게 개발해야 하는 경우 초기 설정에 시간을 투자하기 어려울 수 있습니다.

## 결론

[Section titled “결론”](#결론)

멀티 모듈 아키텍처는 대규모 Flutter 프로젝트의 복잡성을 관리하고 개발 효율성을 높이는 강력한 방법입니다. 모듈 간 명확한 경계와 잘 정의된 인터페이스를 통해 코드베이스의 확장성, 유지보수성, 테스트 용이성을 개선할 수 있습니다.

그러나 모든 프로젝트에 적합한 것은 아니며, 특히 작은 프로젝트나 초기 단계에서는 오버엔지니어링이 될 수 있습니다. 프로젝트의 규모, 팀 구성, 미래 확장 계획 등을 고려하여 적용 여부를 결정해야 합니다.

멀티 모듈 아키텍처는 초기 설정의 복잡성이 있지만, 장기적으로는 개발 효율성과 코드 품질의 향상을 가져올 수 있습니다. 특히 여러 팀이 협업하는 대규모 프로젝트에서 그 이점이 더욱 두드러집니다.