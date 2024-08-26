import 'package:flutter/material.dart';

class RequestHistoryPage extends StatelessWidget {
  final List<Map<String, String>> requestHistory = [
    // {
    //   'requestId': 'REQ1001',
    //   'passengerName': 'Alice Brown',
    //   'pickupLocation': 'Market Street',
    //   'destination': 'Train Station',
    //   'status': 'Accepted',
    //   'date': '2024-08-01',
    // },
    // {
    //   'requestId': 'REQ1002',
    //   'passengerName': 'David Wilson',
    //   'pickupLocation': 'Park Avenue',
    //   'destination': 'Hospital',
    //   'status': 'Declined',
    //   'date': '2024-08-02',
    // },
    // {
    //   'requestId': 'REQ1003',
    //   'passengerName': 'Sarah Lee',
    //   'pickupLocation': 'University Campus',
    //   'destination': 'Library',
    //   'status': 'Accepted',
    //   'date': '2024-08-03',
    // },
    // // Add more history data here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:requestHistory.isEmpty
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Text(
                  'Your Ride History is empty',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ])
          :  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildTableHeader(),
              SizedBox(height: 8),
              _buildDataTable(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Text(
      'Ride  History', 
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: DataTable(
          headingRowColor: WidgetStateColor.resolveWith(
              (states) => Colors.white),
          dataRowColor: WidgetStateColor.resolveWith(
              (states) => Colors.white),
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          columns: const [
            DataColumn(label: Text('Request ID',style: TextStyle(color: Colors.pink),)),
            DataColumn(label: Text('Passenger Name', style: TextStyle(color: Colors.pink),)),
            DataColumn(label: Text('Pickup Location',style: TextStyle(color: Colors.pink),)),
            DataColumn(label: Text('Destination',style: TextStyle(color: Colors.pink),)),
            DataColumn(label: Text('Status',style: TextStyle(color: Colors.pink),)),
            DataColumn(label: Text('Date',style: TextStyle(color: Colors.pink),)),
          ],
          rows: requestHistory.map((request) {
            final bool isAccepted = request['status'] == 'Accepted';
            return DataRow(
              cells: [
                DataCell(Text(request['requestId'] ?? '')),
                DataCell(Text(request['passengerName'] ?? '')),
                DataCell(Text(request['pickupLocation'] ?? '')),
                DataCell(Text(request['destination'] ?? '')),
                DataCell(
                  Text(
                    request['status'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isAccepted ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                DataCell(Text(request['date'] ?? '')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RequestHistoryPage(),
  ));
}
