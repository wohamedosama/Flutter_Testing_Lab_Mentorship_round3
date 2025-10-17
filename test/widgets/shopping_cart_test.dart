import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';

void main() {
  testWidgets('shopping cart should display empty state', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ShoppingCart())));
    expect(find.text('Cart is empty'), findsOneWidget);
    expect(find.text('Total Items: 0'), findsOneWidget);
    expect(find.text('Subtotal: \$${0.00.toStringAsFixed(2)}'), findsOneWidget);
    expect(
      find.text('Total Discount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
  });

  testWidgets('shopping cart should add items', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ShoppingCart())));
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();
    expect(find.text('Total Items: 1'), findsOneWidget);
    expect(
      find.text('Subtotal: \$${999.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Discount: \$${100.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${899.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Apple iPhone'), findsOneWidget);
    expect(
      find.text('Price: \$${999.99.toStringAsFixed(2)} each'),
      findsOneWidget,
    );
    expect(find.text('Discount: 10%'), findsOneWidget);
    expect(
      find.text('Item Total: \$${999.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
  });

  testWidgets('shopping cart should remove items', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ShoppingCart())));
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();
    expect(find.text('Total Items: 1'), findsOneWidget);
    expect(
      find.text('Subtotal: \$${999.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Discount: \$${100.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${899.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Apple iPhone'), findsOneWidget);

    // Now remove the item and verify it's gone
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(find.text('Total Items: 0'), findsOneWidget);
    expect(find.text('Subtotal: \$${0.00.toStringAsFixed(2)}'), findsOneWidget);
    expect(
      find.text('Total Discount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Cart is empty'), findsOneWidget);
  });

  testWidgets('shopping cart should update quantity', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ShoppingCart())));
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();
    expect(find.text('Total Items: 1'), findsOneWidget);
    expect(
      find.text('Subtotal: \$${999.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Discount: \$${100.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${899.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Apple iPhone'), findsOneWidget);

    // Increase quantity and verify totals
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Total Items: 2'), findsOneWidget);
    expect(
      find.text('Subtotal: \$${1999.98.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Discount: \$${200.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${1799.98.toStringAsFixed(2)}'),
      findsOneWidget,
    );
  });

  testWidgets('shopping cart should clear cart', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ShoppingCart())));
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();
    expect(find.text('Total Items: 1'), findsOneWidget);
    expect(
      find.text('Subtotal: \$${999.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Discount: \$${100.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${899.99.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Apple iPhone'), findsOneWidget);

    // Clear cart and verify it's empty
    await tester.tap(find.text('Clear Cart'));
    await tester.pump();
    expect(find.text('Total Items: 0'), findsOneWidget);
    expect(find.text('Subtotal: \$${0.00.toStringAsFixed(2)}'), findsOneWidget);
    expect(
      find.text('Total Discount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(
      find.text('Total Amount: \$${0.00.toStringAsFixed(2)}'),
      findsOneWidget,
    );
    expect(find.text('Cart is empty'), findsOneWidget);
  });
}
