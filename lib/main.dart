import 'package:flutter/material.dart';

void main() {
  runApp(const FuelCalculatorApp());
}

class FuelCalculatorApp extends StatelessWidget {
  const FuelCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fuel Calculator",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const FuelCalculatorPage(),
    );
  }
}

class FuelCalculatorPage extends StatefulWidget {
  const FuelCalculatorPage({super.key});

  @override
  State<FuelCalculatorPage> createState() {
    return _FuelCalculatorPageState();
  }
}

class _FuelCalculatorPageState extends State<FuelCalculatorPage> {
  final TextEditingController _distanceController = TextEditingController();

  final TextEditingController _fuelController = TextEditingController();

  String _result = 'Introduceți datele și apăsați butonul.';

  void _calculateConsumption() {
    final String distanceText = _distanceController.text.trim().replaceAll(
      ',',
      '.',
    );

    final String fuelText = _fuelController.text.trim().replaceAll(',', '.');

    final double? distance = double.tryParse(distanceText);
    final double? fuel = double.tryParse(fuelText);

    if (distance == null || fuel == null) {
      setState(() {
        _result = 'Introduceți valori numerice valide.';
      });
      return;
    }

    if (distance <= 0) {
      setState(() {
        _result = 'Distanța trebuie să fie mai mare decât zero.';
      });
      return;
    }

    if (fuel < 0) {
      setState(() {
        _result = 'Combustibilul nu poate fi negativ.';
      });
      return;
    }

    final double consumption = fuel / distance * 100;

    setState(() {
      _result =
          'Consumul mediu este ${consumption.toStringAsFixed(2)} l/100 km';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fuel Calculator"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.local_gas_station, size: 72, color: Colors.green),
            const SizedBox(height: 24),

            TextField(
              controller: _distanceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Distanța parcursă',
                hintText: 'Exemplu: 500',
                suffixText: 'km',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _fuelController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Combustibil consumat',
                hintText: 'Exemplu: 35',
                suffixText: 'litri',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _calculateConsumption,
              child: const Text('CALCULEAZĂ'),
            ),
            const SizedBox(height: 24),

            Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }
}
