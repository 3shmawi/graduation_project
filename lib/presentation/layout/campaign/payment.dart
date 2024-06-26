// import 'dart:convert';
//
// import 'package:donation/app/api.dart';
// import 'package:donation/presentation/auth/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen(this.campaignId, {super.key});
//
//   final String campaignId;
//   @override
//   PaymentScreenState createState() => PaymentScreenState();
// }
//
// class PaymentScreenState extends State<PaymentScreen> {
//   final TextEditingController _amountController = TextEditingController();
//   bool _isLoading = false;
//
//   void _handlePayment() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Create a payment method
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         params: const PaymentMethodParams.card(
//           paymentMethodData: PaymentMethodData(),
//         ),
//       );
//
//       // Call your backend to create a payment intent and confirm the payment
//       await _processPayment(paymentMethod.id, _amountController.text);
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Payment successful"),
//       ));
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Payment failed: $e"),
//       ));
//     }
//   }
//
//   Future<void> _processPayment(String paymentMethodId, String amount) async {
//     final response = await http.post(
//       Uri.parse("${ApiUrl.baseUrl}${ApiUrl.payment}"),
//       // Replace with your backend endpoint
//       headers: {
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode({
//         "campaignId": widget.campaignId,
//         "amount": amount,
//         "paymentMethodId": paymentMethodId,
//         "userId": AuthCtrl.usrId,
//       }),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception("Failed to process payment");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Make a Donation"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: "Amount"),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 20),
//             _isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _handlePayment,
//                     child: const Text("Donate"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
