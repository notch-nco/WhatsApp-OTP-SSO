import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_based_verification/whatsapp_sending_message_factory.dart';
import 'package:whatsapp_based_verification/whatsapp_based_verification.dart';

void main() {
  runApp(const WhatsAppHomeScreen());
}

/// The main application widget.
/// The main screen for WhatsApp-based messaging functionality.
/// Displays a form to send WhatsApp verification messages.
class WhatsAppHomeScreen extends StatefulWidget {
  const WhatsAppHomeScreen({super.key});

  @override
  State<WhatsAppHomeScreen> createState() => _WhatsAppHomeScreenState();
}

/// State class for the WhatsAppHomeScreen.
/// Manages the state and interactions within the screen.
class _WhatsAppHomeScreenState extends State<WhatsAppHomeScreen> with SingleTickerProviderStateMixin {
  /// An instance of the service responsible for handling WhatsApp message operations.
  final WhatsappSendingMessageService _whatsappSendingMessageService = WhatsappSendingMessageService();

  /// A key used to identify the form and manage its validation state.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controllers for user inputs.
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _verificationMessageController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final Color mainColor = const Color(0xff1ED6BB);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _mobileNumberController.dispose();
    _verificationMessageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.lightImpact(); // Gives a small vibration feedback on tap
      await _whatsappSendingMessageService.verifyMessage(
        phoneNumber: _mobileNumberController.text,
        message: _verificationMessageController.text,
        callback: (result) => _whatsappSendingMessageService.handleMessageResult(result),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        colorScheme: ColorScheme.light(
          primary: mainColor,
        ),
      ),
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Content Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: AnimatedOpacity(
                  opacity: _fadeAnimation.value,
                  duration: const Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                            ),
                            const Text(
                              'Enter a valid mobile number (e.g., +20XXXXXXXXXX).',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                prefixIcon: Icon(Icons.phone, color: mainColor),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mobile number can\'t be empty.';
                                }
                                /*else if (value.length != 13) {
                                  return 'Mobile number must be 13 digits.';
                                }*/
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Enter the verification message:',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _verificationMessageController,
                              decoration: InputDecoration(
                                labelText: 'Verification Message',
                                prefixIcon: Icon(Icons.message, color: mainColor),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Message can\'t be empty.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTapDown: (_) => _controller.reverse(), // Press animation
                              onTapUp: (_) {
                                _controller.forward();
                                _sendMessage();
                              },
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _controller.value * 0.02 + 1, // Scale effect
                                    child: child,
                                  );
                                },
                                child: ElevatedButton(
                                  onPressed: _sendMessage,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: MediaQuery.of(context).size.width * 0.1,
                                    ),
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: const Text(
                                    'Send Verification Message',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            //const SizedBox(height: 30),
                            Spacer(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Powered by ',
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                  TextSpan(
                                    text: 'Notchnco Inc.',
                                    style: TextStyle(color: mainColor, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A service class that handles WhatsApp message sending functionality.
/// It manages the logic for sending verification messages using the WhatsApp plugin.
class WhatsappSendingMessageService {
  /// Instance of the plugin for sending WhatsApp messages.
  final WhatsappSendingMessage _whatsappSendingMessagePlugin = WhatsappSendingMessageFactory.create();

  /// Sends a WhatsApp message using the WhatsApp plugin.
  ///
  /// Parameters:
  /// - [message]: The verification message to send.
  /// - [phoneNumber]: The recipient's mobile number (including the country code).
  /// - [callback]: A callback function to handle the result of the message sending operation.
  Future<void> verifyMessage({
    required String message,
    required String phoneNumber,
    required void Function(Map<String, dynamic> result) callback,
  }) async {
    await _whatsappSendingMessagePlugin.sendingVerificationMessageViaWhatsApp(
      message,
      phoneNumber,
      callback,
    );
  }

  /// Handles the result of the WhatsApp message sending action.
  ///
  /// Logs the result of the operation for debugging purposes.
  ///
  /// [result]: A map containing the status of the message sending operation.
  void handleMessageResult(Map<String, dynamic> result) {
    debugPrint('Result: $result'); // Outputs the result of sending the message.
  }
}
