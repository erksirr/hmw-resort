import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hemawan_resort/core/constants/api_constants.dart';
import '../models/room_model.dart';
import '../models/room_search_params.dart';

class RoomRepository {
  final http.Client client;

  RoomRepository({required this.client});

  Future<List<RoomModel>> getSearchRooms({RoomSearchParams? params}) async {
    try {
      final body = params?.toJson() ?? const RoomSearchParams().toJson();

      final response = await client.post(
        Uri.parse(ApiConstants.roomSearchUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => RoomModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load rooms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching rooms: $e');
    }
  }

  Future<RoomModel> getRoomDetail(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.roomDetailUrl}/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return RoomModel.fromJson(json);
      } else {
        throw Exception('Failed to load room detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching room detail: $e');
    }
  }
}