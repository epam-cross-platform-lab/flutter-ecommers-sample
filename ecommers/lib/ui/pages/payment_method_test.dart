import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodTest extends StatefulWidget {
  @override
  _PaymentMethodTestState createState() => _PaymentMethodTestState();
}

class _PaymentMethodTestState extends State<PaymentMethodTest> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = null; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;
 final  ScrollController _controller = ScrollController();
  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_aSaULNS8cJU6Tvo20VAXy6rp',
      merchantId: 'Test',
      androidPayMode: 'test',
    ));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _source = null;
                _paymentIntent = null;
                _paymentMethod = null;
                _paymentToken = null;
              });
            },
          )
        ],
      ),
      body: ListView(
        controller: _controller,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              StripePayment.createSourceWithParams(SourceParams(
                type: 'ideal',
                amount: 1099,
                currency: 'eur',
                returnURL: 'example://stripe-redirect',
              )).then((source) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${source.sourceId}')));
                setState(() {
                  _source = source;
                });
              }).catchError(setError);
            },
            child: const Text('Create Source'),
          ),
          const Divider(),
          RaisedButton(
            onPressed: () {
              StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
                  .then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${paymentMethod.id}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                });
              }).catchError(setError);
            },
            child: const Text('Create Token with Card Form'),
          ),
          RaisedButton(
            onPressed: () {
              StripePayment.createTokenWithCard(
                testCard,
              ).then((token) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${token.tokenId}')));
                setState(() {
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
            child: const Text('Create Token with Card'),
          ),
          const Divider(),
          RaisedButton(
            onPressed: () {
              StripePayment.createPaymentMethod(
                PaymentMethodRequest(
                  card: testCard,
                ),
              ).then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${paymentMethod.id}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                });
              }).catchError(setError);
            },
            child: const Text('Create Payment Method with Card'),
          ),
          RaisedButton(
            onPressed: _paymentToken == null
                ? null
                : () {
                    StripePayment.createPaymentMethod(
                      PaymentMethodRequest(
                        card: CreditCard(
                          token: _paymentToken.tokenId,
                        ),
                      ),
                    ).then((paymentMethod) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Received ${paymentMethod.id}')));
                      setState(() {
                        _paymentMethod = paymentMethod;
                      });
                    }).catchError(setError);
                  },
            child: const Text('Create Payment Method with existing token'),
          ),
          const Divider(),
          RaisedButton(
            onPressed: _paymentMethod == null || _currentSecret == null
                ? null
                : () {
                    StripePayment.confirmPaymentIntent(
                      PaymentIntent(
                        clientSecret: _currentSecret,
                        paymentMethodId: _paymentMethod.id,
                      ),
                    ).then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                      });
                    }).catchError(setError);
                  },
            child: const Text('Confirm Payment Intent'),
          ),
          RaisedButton(
            onPressed: _currentSecret == null
                ? null
                : () {
                    StripePayment.authenticatePaymentIntent(
                            clientSecret: _currentSecret)
                        .then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                      });
                    }).catchError(setError);
                  },
            child: const Text('Authenticate Payment Intent'),
          ),
          const Divider(),
          RaisedButton(
            onPressed: () {
              if (Platform.isIOS) {
                _controller.jumpTo(450);
              }
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: '1.20',
                  currencyCode: 'EUR',
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'DE',
                  currencyCode: 'EUR',
                  items: [
                    ApplePayItem(
                      label: 'Test',
                      amount: '13',
                    )
                  ],
                ),
              ).then((token) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${token.tokenId}')));
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
            child: const Text('Native payment'),
          ),
          RaisedButton(
            onPressed: () {
              StripePayment.completeNativePayRequest().then((_) {
                _scaffoldKey.currentState.showSnackBar(
                    const SnackBar(content: Text('Completed successfully')));
              }).catchError(setError);
            },
            child: const Text('Complete Native Payment'),
          ),
          RaisedButton(
            onPressed: () async {
              final isSupport = await StripePayment.deviceSupportsNativePay();
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Completed successfully $isSupport')));
            },
            child: const Text('Check support Native Pasy'),
          ),
          const Divider(),
          const Text('Current source:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
            style: const TextStyle(fontFamily: 'Monospace'),
          ),
          const Divider(),
          const Text('Current token:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_paymentToken?.toJson() ?? {}),
            style: const TextStyle(fontFamily: 'Monospace'),
          ),
          const Divider(),
          const Text('Current payment method:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentMethod?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
         const Divider(),
          const Text('Current payment intent:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentIntent?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          const Divider(),
          Text('Current error: $_error'),
          const Divider(),
          Text('Current error: $_error'),
        ],
      ),
    );
  }
}
