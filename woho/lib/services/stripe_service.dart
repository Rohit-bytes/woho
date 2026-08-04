import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static Future<void> makePayment({required String clientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Woho',
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }
}
