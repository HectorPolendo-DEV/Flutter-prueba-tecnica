import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tips_viewmodel.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TipsViewModel(),
      child: const _TipsView(),
    );
  }
}

class _TipsView extends StatefulWidget {
  const _TipsView();

  @override
  State<_TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<_TipsView> {
  final totalController = TextEditingController();
  final customController = TextEditingController();

  @override
  void dispose() {
    totalController.dispose();
    customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TipsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Propinas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total de la cuenta', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ingresa el total de la cuenta',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: vm.setTotal,
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona un porcentaje',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                for (var p in [3, 5, 10, 15])
                  ChoiceChip(
                    label: Text('$p%'),
                    selected: vm.percentage == p && !vm.customMode,
                    onSelected: (_) => vm.setPercentage(p.toDouble()),
                  ),
                ChoiceChip(
                  label: const Text('Otra cantidad'),
                  selected: vm.customMode,
                  onSelected: vm.setCustomMode,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (vm.customMode)
              TextField(
                controller: customController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingresa la propina personalizada',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: vm.setCustomTipAmount,
              ),
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Propina:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Text(
                        '\$${vm.tipAmount.toStringAsFixed(2)}',
                        key: ValueKey(vm.tipAmount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (vm.total > 0 && vm.tipAmount > 0)
                  Row(
                    children: [
                      Text(
                        'Total a pagar:',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Text(
                          '\$${(vm.total + vm.tipAmount).toStringAsFixed(2)}',
                          key: ValueKey(vm.total + vm.tipAmount),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
