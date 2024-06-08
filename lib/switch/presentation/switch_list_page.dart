import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwitchListPage extends StatefulWidget {
  const SwitchListPage({Key? key}) : super(key: key);

  @override
  _SwitchListPageState createState() => _SwitchListPageState();
}

class _SwitchListPageState extends State<SwitchListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スイッチ一覧'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('switches').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final switches = snapshot.data?.docs ?? [];

          if (switches.isEmpty) {
            return const Center(child: Text('スイッチがありません'));
          }

          return ListView.builder(
            itemCount: switches.length,
            itemBuilder: (context, index) {
              final switchData = switches[index].data() as Map<String, dynamic>;
              final switchId = switches[index].id;
              final switchName = switchData['name'] as String? ?? 'No Name';
              final switchState = switchData['state'] as bool? ?? false;

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    switchState ? Icons.toggle_on : Icons.toggle_off,
                    color: switchState ? Colors.green : Colors.grey,
                    size: 32,
                  ),
                  title: Text(switchName),
                  subtitle: Text('ID: $switchId'),
                  onTap: () {
                    _toggleSwitch(switchId, !switchState);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleSwitch(String switchId, bool newState) {
    _firestore.collection('switches').doc(switchId).update({'state': newState});
  }
}