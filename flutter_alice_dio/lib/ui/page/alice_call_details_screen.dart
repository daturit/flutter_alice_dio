import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice_dio/alice_core/alice_core.dart';
import 'package:flutter_alice_dio/alice_helper/alice_save_helper.dart';
import 'package:flutter_alice_dio/model/alice_http_call.dart';
import 'package:flutter_alice_dio/model/alice_http_request.dart';
import 'package:flutter_alice_dio/ui/utils/alice_constants.dart';
import 'package:flutter_alice_dio/ui/widget/alice_call_error_widget.dart';
import 'package:flutter_alice_dio/ui/widget/alice_call_overview_widget.dart';
import 'package:flutter_alice_dio/ui/widget/alice_call_request_widget.dart';
import 'package:flutter_alice_dio/ui/widget/alice_call_response_widget.dart';
import 'package:share_plus/share_plus.dart';

class AliceCallDetailsScreen extends StatefulWidget {
  final AliceHttpCall call;
  final AliceCore core;

  AliceCallDetailsScreen(this.call, this.core);

  @override
  _AliceCallDetailsScreenState createState() => _AliceCallDetailsScreenState();
}

class _AliceCallDetailsScreenState extends State<AliceCallDetailsScreen>
    with SingleTickerProviderStateMixin {
  AliceHttpCall get call => widget.call;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: widget.core.brightness,
        primarySwatch: Colors.green,
      ),
      child: StreamBuilder<List<AliceHttpCall>>(
        stream: widget.core.callsSubject,
        initialData: [widget.call],
        builder: (context, callsSnapshot) {
          if (callsSnapshot.hasData) {
            AliceHttpCall? call = callsSnapshot.data?.firstWhere(
                (snapshotCall) => snapshotCall.id == widget.call.id,
                orElse: null);
            if (call != null) {
              return _buildMainWidget();
            } else {
              return _buildErrorWidget();
            }
          } else {
            return _buildErrorWidget();
          }
        },
      ),
    );
  }

  Widget _buildMainWidget() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AliceConstants.lightRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          key: Key('share_key'),
          onPressed: () async {
            await Clipboard.setData(
              ClipboardData(text: await _getSharableResponseString()),
            );
            Share.share(
              await _getSharableResponseString(),
              subject: 'Request Details',
            );
          },
          child: Icon(Icons.share, color: Colors.white),
        ),
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: AliceConstants.lightRed,
            tabs: _getTabBars(),
          ),
          title: Text('Alice - HTTP Call Details'),
        ),
        body: TabBarView(
          children: _getTabBarViewList(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(child: Text("Failed to load data"));
  }

  Future<String> _getSharableResponseString() async {
    log(widget.call.getCurlCommand(), name: 'CURL');
    return AliceSaveHelper.buildCallLog(widget.call);
  }

  List<Widget> _getTabBars() {
    List<Widget> widgets = [];
    widgets.add(Tab(icon: Icon(Icons.info_outline), text: "Overview"));
    widgets.add(Tab(icon: Icon(Icons.arrow_upward), text: "Request"));
    widgets.add(Tab(icon: Icon(Icons.arrow_downward), text: "Response"));
    widgets.add(
      Tab(
        icon: Icon(Icons.warning),
        text: "Error",
      ),
    );
    return widgets;
  }

  List<Widget> _getTabBarViewList() {
    List<Widget> widgets = [];
    widgets.add(AliceCallOverviewWidget(widget.call));
    widgets.add(
      AliceCallRequestWidget(widget.call.request ?? AliceHttpRequest()),
    );
    widgets.add(AliceCallResponseWidget(widget.call));
    widgets.add(AliceCallErrorWidget(widget.call));
    return widgets;
  }
}
