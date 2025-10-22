import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../core/network/dio_client.dart';
import '../features/search/data/datasource/remote/unsplash_remote_datasource.dart';
import '../features/search/data/repositories/photo_repository_impl.dart';
import '../features/search/presentation/viewmodel/search_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (_) => SearchViewModel(
      PhotoRepositoryImpl(
        UnsplashRemoteDataSource(
          DioClient(
            baseUrl: 'https://api.unsplash.com',
            accessKey: dotenv.env['UNSPLASH_KEY'],
          ),
        ),
      ),
    ),
  ),
];
