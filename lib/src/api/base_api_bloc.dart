import 'dart:async';

import 'package:state_bloc/src/api/api_response.dart';

class BaseApiBloc<T> {
  StreamController _streamController =
      StreamController<ApiResponse<T>>.broadcast();

  StreamSink<ApiResponse<T>> get apiDataSink => _streamController.sink;

  Stream<ApiResponse<T>> get apiDataSinkStream => _streamController.stream;

  streamDispose() {
    _streamController?.close();
  }

  void startLoading(String message) {
    apiDataSink.add(ApiResponse.loading(message));
  }

  void addDataToStream(data) {
    apiDataSink.add(ApiResponse.completed(data));
  }

  void addErrorToStream(e) {
    apiDataSink.add(ApiResponse.error(e));
  }
}

/*
* class SampleBloc extends BaseApiBloc<List> {
  fetchMovieList() async {
    startLoading('Fetching Popular Movies');
    try {
      // Do something
      addDataToStream(List());
    } catch (e) {
      handleError(
        e,
        onException: (String value) {
          addErrorToStream(value);
        },
      );
    }
  }

  void dispose() {
    streamDispose();
  }
}*/

/*class SampleWidget extends StatefulWidget {
  @override
  _SampleWidgetState createState() => _SampleWidgetState();
}

class _SampleWidgetState extends State<SampleWidget> {
  SampleBloc sampleBloc = SampleBloc();

  @override
  void initState() {
    super.initState();

    sampleBloc.fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ApiStreamBuilder<List>(stream: sampleBloc.apiDataSinkStream,
      dataWidget: (List<dynamic> value) {
        return Container();
      },
      loadingWidget: (String message) {
        return CircularProgressIndicator();
      },
      errorWidget: (String message) {
      //show popup
        return Container();
      },
    );
  }
}*/
