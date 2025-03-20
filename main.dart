//this code is generated by chatgpt and modified by sukhmanpreet Singh
import 'package:flutter/material.dart';
import 'dart:convert';

// Sample JSON Data
const String jsonData = '''
{
  "accounts": [
    {
      "type": "Chequing",
      "account_number": "CHQ123456789",
      "balance": 2500.00
    },
    {
      "type": "Savings",
      "account_number": "SAV987654321",
      "balance": 5000.00
    }
  ],
  "transactions": {
    "Chequing": [
      { "date": "2024-04-14", "description": "Utility Bill Payment", "amount": -120.00 },
      { "date": "2024-04-16", "description": "ATM Withdrawal", "amount": -75.00 },
      { "date": "2024-04-17", "description": "Deposit", "amount": 100.00 },
      { "date": "2024-04-18", "description": "Withdrawal", "amount": -50.00 }
    ],
    "Savings": [
      { "date": "2024-04-12", "description": "Withdrawal", "amount": -300.00 },
      { "date": "2024-04-15", "description": "Interest", "amount": 10.00 },
      { "date": "2024-04-16", "description": "Deposit", "amount": 200.00 },
      { "date": "2024-04-18", "description": "Transfer to Chequing", "amount": -500.00 }
    ]
  }
}
''';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

// 🎉 Welcome Screen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String today = DateTime.now().toLocal().toString().split(' ')[0];

    return Scaffold(
      body: Container(
        decoration: _gradientBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, size: 120, color: Colors.white),
              SizedBox(height: 20),
              Text('Welcome to Mobile Banking',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 10),
              Text("Today's Date: $today", style: TextStyle(fontSize: 18, color: Colors.white70)),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountsListScreen()));
                },
                icon: Icon(Icons.account_balance, color: Colors.white),
                label: Text('View Accounts'),
                style: _elevatedButtonStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📂 Accounts List Screen
class AccountsListScreen extends StatelessWidget {
  final Map<String, dynamic> bankData = jsonDecode(jsonData);

  @override
  Widget build(BuildContext context) {
    List accounts = bankData['accounts'];

    return Scaffold(
      appBar: AppBar(title: Text('Your Accounts')),
      body: Container(
        decoration: _gradientBackground(),
        child: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            var account = accounts[index];
            return Padding(
              padding: EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.blueAccent, size: 40),
                  title: Text('${account["type"]} Account',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: Text('Account Number: ${account["account_number"]}\nBalance: \$${account["balance"]}',
                      style: TextStyle(fontSize: 16)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransactionsScreen(accountType: account["type"])),
                      );
                    },
                    child: Text('View'),
                    style: _elevatedButtonStyle(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}

// 💰 Transactions Screen (Shows Transactions for Selected Account Type)
class TransactionsScreen extends StatelessWidget {
  final String accountType;
  TransactionsScreen({required this.accountType});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> bankData = jsonDecode(jsonData);
    List transactions = bankData['transactions'][accountType] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('$accountType Transactions')),
      body: Container(
        decoration: _gradientBackground(),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            var transaction = transactions[index];
            return Padding(
              padding: EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(
                    transaction['amount'] < 0 ? Icons.remove_circle : Icons.add_circle,
                    color: transaction['amount'] < 0 ? Colors.redAccent : Colors.green,
                    size: 35,
                  ),
                  title: Text(transaction['description'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('Date: ${transaction['date']}'),
                  trailing: Text(
                    '\$${transaction['amount']}',
                    style: TextStyle(
                      color: transaction['amount'] < 0 ? Colors.red : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}

// 🌟 UI Helpers
BoxDecoration _gradientBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blueAccent, Colors.indigo],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

ButtonStyle _elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    backgroundColor: Colors.blueAccent,
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
