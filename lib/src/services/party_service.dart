import 'dart:convert';

import 'package:http/http.dart' show post, get, put;

import '../models/http_exception.dart';
import './servicesUtils/service_utils.dart';
import '../models/party.dart';

class PartyService with ServiceUtils {
  final String url = "http://10.0.2.2:3000/api/v1/parties";

  Future<Party> createParty(String guestId, String movieName) async {
    try {
      final _token = await token;
      final response = await post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
        body: json.encode({
          '_guest': guestId,
          'movieName': movieName,
        }),
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final party = Party.fromJson(responseBody['data']);

      return party;
    } catch (error) {
      throw error;
    }
  }

  Future<Party> changePartyStatus(String partyId, String status) async {
    try {
      final _token = await token;
      final subUrl = '$url/$partyId';
      final response = await put(
        subUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
        body: json.encode({
          'status': status,
        }),
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final party = Party.fromJson(responseBody['data']);

      return party;
    } catch (error) {
      throw error;
    }
  }

  Future<Party> getParty(String partyId) async {
    final subUrl = url + '/$partyId';
    try {
      final _token = await token;
      final response = await get(
        subUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final party = Party.fromJson(responseBody['data']);

      return party;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Party>> getPendingParties() async {
    final subUrl = url + '?status=waiting';
    try {
      final _token = await token;
      final response = await get(
        subUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final parties = List<Party>();

      final data = responseBody['data'] as List;
      for (int i = 0; i < data.length; i++) {
        parties.add(Party.fromJson(data[i]));
      }

      return parties;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Party>> getPrevParties() async {
    final subUrl = url + '?status=accepted';
    try {
      final _token = await token;
      final response = await get(
        subUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final parties = List<Party>();

      final data = responseBody['data'] as List;
      for (int i = 0; i < data.length; i++) {
        parties.add(Party.fromJson(data[i]));
      }

      return parties;
    } catch (error) {
      throw error;
    }
  }
}
