import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Propinas')),
      body: const Center(child: Text('TipsPage')),
    );
  }
}
