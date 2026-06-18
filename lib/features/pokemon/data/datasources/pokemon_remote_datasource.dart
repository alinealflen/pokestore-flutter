import 'package:dio/dio.dart';

class PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource(this.dio);

  Future<List<dynamic>> getPokemons({required int offset}) async {
    try {
      final response = await dio.get('/pokemon?limit=20&offset=$offset');
      return response.data['results'];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getPokemonDetail(String url) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Timeout ao conectar com servidor');
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Tempo de resposta excedido');
    }

    if (e.response != null) {
      return Exception('Erro na API: ${e.response?.statusCode}');
    }

    return Exception('Erro desconhecido');
  }

  Future<List<dynamic>> getPokemonNames() async {
    try {
      final response = await dio.get('/pokemon?limit=2000');

      return response.data['results'];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
