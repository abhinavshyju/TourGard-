import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DioPostWidget extends StatefulWidget {
  final String url;
  final Map<String, dynamic> data;
  final Function(Response<dynamic>) onSuccess;
  final Function(DioError) onError;

  DioPostWidget({
    required this.url,
    required this.data,
    required this.onSuccess,
    required this.onError,
    Key? key,
  }) : super(key: key);

  @override
  _DioPostWidgetState createState() => _DioPostWidgetState();
}

class _DioPostWidgetState extends State<DioPostWidget> {
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _performPostRequest();
      },
      child: Text('Make POST Request'),
    );
  }

  Future<void> _performPostRequest() async {
    try {
      final response = await _dio.post(
        widget.url,
        data: widget.data,
      );
      widget.onSuccess(response);
    } on DioError catch (e) {
      widget.onError(e);
    }
  }
}
