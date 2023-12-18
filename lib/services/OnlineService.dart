import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
//Class containing strings to make GET requests from the external API
class OnlineService {
  //GET request for audiobooks
  String booksUrl = 'https://librivox.org/api/feed/audiobooks/?format=json&extended=1';

  //GET request for authors
  String authorsUrl = 'https://librivox.org/api/feed/authors/?format=json';

  //GET request for audiotracks
  String chaptersUrl = 'https://librivox.org/api/feed/audiotracks/?format=json';
}