import 'package:election_2566_poll/services/api.dart';
import 'package:flutter/material.dart';
//import 'package:election_2566_poll/models/poll.dart';
//import 'package:election_2566_poll/pages/my_scaffold.dart';
import '../../models/poll.dart';
import '../my_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll>? _polls;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
    });
    // todo: Load list of polls here
    //await Future.delayed(const Duration(seconds: 3), () {});
    try {
      var result = await ApiClient().getPolls();
      setState(() {
        _polls = result;
      });
    } catch (e) {
      setState(() {
      });
      // todo: กรณี Error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network('https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                if (_polls != null) _buildList(),
                    _polls == null
                    ? const SizedBox.shrink()
                    : ListView.builder(
                    itemCount: _polls!.length,
                    itemBuilder: (context, index){
                      return Text(_polls![index].id.toString());
                  },
                ),
                if (_isLoading) _buildProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    _polls == null;
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (BuildContext context, int index) {
        // todo: Create your poll item by replacing this Container()
        return Text(_polls![index].question); //return Container();
      },
    );
  }

  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
