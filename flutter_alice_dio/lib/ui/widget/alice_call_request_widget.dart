import 'package:flutter/material.dart';
import 'package:flutter_alice_dio/model/alice_http_request.dart';
import 'package:flutter_alice_dio/ui/widget/alice_base_call_details_widget.dart';

class AliceCallRequestWidget extends StatefulWidget {
  final AliceHttpRequest request;

  AliceCallRequestWidget(this.request);

  @override
  State<StatefulWidget> createState() {
    return _AliceCallRequestWidget();
  }
}

class _AliceCallRequestWidget
    extends AliceBaseCallDetailsWidgetState<AliceCallRequestWidget> {
  AliceHttpRequest get _request => widget.request;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(getListRow("Started:", _request.time.toString()));
    rows.add(getListRow("Bytes sent:", formatBytes(_request.size)));
    rows.add(getListRow("Content type:", getContentType(_request.headers)!));

    var body = _request.body;
    String? bodyContent = "Body is empty";
    if (body != null) {
      bodyContent = formatBody(body, getContentType(_request.headers));
    }
    rows.add(getListRow("Body:", bodyContent!));
    var formDataFields = _request.formDataFields;
    if (formDataFields?.isNotEmpty == true) {
      rows.add(getListRow("Form data fields: ", ""));
      formDataFields!.forEach(
        (field) {
          rows.add(getListRow("   • ${field.name}:", "${field.value}"));
        },
      );
    }
    var formDataFiles = _request.formDataFiles;
    if (formDataFiles?.isNotEmpty == true) {
      rows.add(getListRow("Form data files: ", ""));
      formDataFiles!.forEach(
        (field) {
          rows.add(getListRow("   • ${field.fileName}:",
              "${field.contentType} / ${field.length} B"));
        },
      );
    }

    var headers = _request.headers;
    var headersContent = "Headers are empty";
    if (headers.isNotEmpty) {
      headersContent = "";
    }
    rows.add(getListRow("Headers: ", headersContent));
    _request.headers.forEach((header, value) {
      rows.add(getListRow("   • $header:", value.toString()));
    });

    print("qr: ${_request.queryParameters}");
    var queryParameters = _request.queryParameters;
    var queryParametersContent = "Query parameters are empty";
    if (queryParameters.isNotEmpty) {
      queryParametersContent = "";
    }
    rows.add(getListRow("Query Parameters: ", queryParametersContent));
    _request.queryParameters.forEach((query, value) {
      rows.add(getListRow("   • $query:", value.toString()));
    });

    return Container(
      padding: const EdgeInsets.all(6),
      child: ListView(children: rows),
    );
  }
}
