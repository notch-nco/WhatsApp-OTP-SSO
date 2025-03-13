## WhatsApp-OTP-SSO

**WhatsApp OTP SSO: Seamless Authentication Without a PIN**

WhatsApp OTP SSO enables effortless phone number verification via WhatsApp without requiring a PIN. A unique code is generated in-memory within the mobile app, and users are redirected to WhatsApp to send it. The backend API then validates the code, ensuring a secure and seamless authentication process.

Effortless Integration for Your Mobile App
To launch your mobile app in production with WhatsApp-based authentication—without writing any code—Notchnco handles the entire process, including:

**WhatsApp Portfolio Setup:** Creating and configuring the necessary WhatsApp business profile and settings.
**Full WhatsApp Integration:** Managing all API integrations and ensuring secure, server-to-server data transmission to your backend.
**Technical Support:** Assisting both frontend and backend teams in implementing the integration as per the provided documentation.

Client Requirements
Clients need to provide an API endpoint to receive the following data securely via Meta’s server-to-server integration:

Mobile number used to send the authentication message.
Verification message passed through the mobile app, allowing the backend to generate a token and send it back to the app.
For a detailed proposal, email shady.hany@notch-nco.com.


## High-Level Flow 

Simplify integrating WhatsApp-based verification into your Flutter apps with this powerful plugin. 
Allowing your app to send verification messages to users effortlessly.
By leveraging WhatsApp's communication capabilities, this plugin helps reduce dependency on costly SMS services and minimizes waste by ensuring the user initiates the verification process.
With a simple API and platform abstraction, you can focus on building core app features while delivering your users a secure and efficient verification experience.

**Plugin input parameters from the mobile app developer:**

  [message]: The verification message will be sent to the WhatsApp phone number from your app through whatsapp_based_verification.  
  [phoneNumber]: The business WhatsApp phone number.  
  [callback]: A callback function to handle the result of the message operation.  

**For more information or if you need any support or proposal, please communicate via email: shady.hany@notch-nco.com **

## Technical Details

**1. Purpose of the Plugin**

The WhatsApp Verification plugin simplifies the integration of WhatsApp-based OTP verification in Flutter apps, enabling businesses to implement a modern solution.  

It is designed to:  
**1. Cost-Free Verification:** Provides a completely free solution for OTP verification, benefiting both businesses and users by eliminating expenses associated with SMS.  
**2. Cross-Platform Support:** Ensures seamless functionality across devices with a single codebase, avoiding platform-specific complexities.  
**3. Effortless Integration:** Allows developers to add WhatsApp-based verification features without requiring extensive knowledge of native code.  
**4. Improved Efficiency:** Speeds up the implementation process, enabling rapid deployment of secure and reliable phone number verification for user authentication.  



**2. Core Capabilities**

Key features of the plugin include:  
• WhatsApp Integration: Seamlessly launches the native WhatsApp app with a pre-filled verification message, ensuring secure user interaction and protecting data.  

• Status Callbacks: Offers real-time updates on the status of launching WhatsApp, enabling better error handling and smoother user experiences.  

• Unified Codebase: Simplifies the integration process by eliminating the need for platform-specific adjustments, making OTP verification implementation more straightforward for developers.



**3. Plugin Diagram**

**Message Generation:**  
• The plugin generates a pre-filled WhatsApp verification message, using the (WhatsAppUrlGenerator) class. This ensures the message includes all necessary information (e.g., OTP or verification code).  

• The URL for the message is created using the (IUrlGenerationService) and parsed via the (IParsingUriService) to ensure compatibility with the WhatsApp URL scheme.  

**WhatsApp Launching:**  
• Once the URL is prepared, the (WhatsAppLauncherService) attempts to launch the native WhatsApp app. This opens WhatsApp directly, pre-filled with the verification message.  

**Platform Support:**  
• The plugin is cross-platform and works on both Android and iOS devices.  

**Status Feedback:**  
**• Success:** If WhatsApp launches successfully, the plugin notifies the app via a callback, enabling the user to proceed with verification.  

**• Failure:** If WhatsApp fails to launch, the plugin notifies the app and prompts the user with an error message (e.g., "Failed to launch WhatsApp").  

 ![Sending Whatsapp verification](https://github.com/user-attachments/assets/013228c9-5fb9-428f-8389-6d05edcec18e)


**4. Code Explanation**

The WhatsApp Verification plugin is structured to deliver a clean, organized, and modular approach to handling WhatsApp-based OTP verification in Flutter applications.  
Here’s a detailed explanation of the key components, their architecture, and functionalities included in the codebase:  

**5.1 Plugin Structure:**

The plugin follows a layered architecture, separating concerns into distinct modules for services, handlers, and DTOs. This modularity ensures that each component can be developed, tested, and maintained independently.  

**5.1.1 Core Classes:**

**• IUrlGenerationService:** This abstract class defines the core functionality for generating encoded URLs, specifically for WhatsApp messages. It ensures flexibility by allowing customization of the URL encoding process, making it adaptable for various use cases in the future.  

 ![Picture1](https://github.com/user-attachments/assets/8ba52384-7b79-4e7f-8a6b-10c388f0b941)


**• IParsingUriService:** This abstract class defines the core functionality for parsing a given URI string into a standardized (Uri) object. It provides a flexible and modular approach to handle URI parsing, ensuring consistency and adaptability across different use cases.  

 ![Picture2](https://github.com/user-attachments/assets/b8a8305b-441c-43f1-b6c2-1dd130f87a9e)


**• WhatsAppUrlGenerator:** This class implements both the IUrlGenerationService and IParsingUriService interfaces, providing a unified approach for generating and parsing WhatsApp URLs.  

It offers:  
**• _generateWhatsappUrl:** A private method that constructs a complete WhatsApp URL by combining the phone number and a pre-encoded message.  

**• generateUri:** A public method that generates a URI by parsing the constructed WhatsApp URL for seamless usage.  

**• encodedUrl:** Encodes the message text to ensure proper URL formatting.  

**• parseUri:** Parses a given URL string into a Uri object for consistent handling.  
 
![Picture3](https://github.com/user-attachments/assets/720aee8d-f4ee-410f-827e-bfea969eac0a)


**• WhatsAppSendingResultDto:** A DTO that represents the result of a WhatsApp message operation.  

**• Properties:**  

   **• launchingStatus:** Indicates if WhatsApp was successfully launched.  
   **• message:** Contains the success or error message.  

**• toMap Method:** Serializes the object into a map for easy storage or transmission.  

 ![Picture4](https://github.com/user-attachments/assets/c5205988-9f80-4c80-a81a-0e7dbed41f71)






**5.1.2 WhatsApp Messaging Handler:**  

**• WhatsAppMessageResultHandler:** A handler class for processing WhatsApp message operation results.  
**• callbackResultHandler Method:** Converts a WhatsAppSendingResultDto into a map for further processing or callback handling.  
**• SendingMessageResultCallback:** A typedef for the callback function that handles the result map.  

![Picture5](https://github.com/user-attachments/assets/53622799-3346-43d1-af06-59e5b2f25ee9)



**• IWhatsappLauncherService:** An abstract interface for launching WhatsApp with a pre-filled message.  

**• launch Method:** This method defines the contract for launching WhatsApp with a specified message and phone number. It requires a callback function to handle the result of the operation.  

 ![Picture6](https://github.com/user-attachments/assets/418aa0d4-e4f5-412d-8417-e44e45651614)



**• WhatsappLauncherService:** A service responsible for launching WhatsApp with a pre-filled message.  
• Implements the IWhatsappLauncherService interface.  
• Uses the WhatsAppUrlGenerator to create the deep link and attempts to launch WhatsApp.  
• Returns the result via a callback function, using the WhatsAppMessageResultHandler to process the result.  
• Handles errors gracefully by invoking the callback with a failure message if launching WhatsApp fails.  

 ![Picture7](https://github.com/user-attachments/assets/3c616ff0-1ebc-4f5a-b0bc-ab76462b8b4b)



**5.1.3 Factory Design Pattern:**  

**• WhatsappSendingMessageFactory:** A factory class for creating and configuring instances of WhatsappSendingMessage.  
• Provides a static create method to initialize WhatsappSendingMessage with its required dependencies, such as WhatsappLauncherService.  
• Promotes separation of concerns and ensures better testability by encapsulating the setup process for WhatsApp messaging functionality.  
• Returns a fully configured WhatsappSendingMessage instance, ready for handling WhatsApp-based actions.  

![Picture8](https://github.com/user-attachments/assets/c1157e14-bad7-40c0-ae04-a7ffe99f0a33)




**5.1.4 Singleton Design Pattern:**  

**WhatsappSendingMessage:** The central class for managing WhatsApp messaging operations.  
• Implements a singleton pattern to ensure only one instance is created and used throughout the application.  

**• Dependencies:** Includes a WhatsappLauncherService to handle WhatsApp deep linking and messaging actions.  

**• Initialization:** Provides an initialize method to inject the WhatsappLauncherService dependency.  

**• Core Functionality:** Offers sendingVerificationMessageViaWhatsApp to send a verification message via WhatsApp, taking the message, recipient’s phone number, and a callback to handle the result.  

![Picture9](https://github.com/user-attachments/assets/9ef63dc8-f304-4fed-9bfd-125ae2a857b6)



 
**6. Example of Usage**  

Integrating the WhatsApp-based Verification plugin into your Flutter application is straightforward. Below is a step-by-step guide on how to set up and use the plugin for sending verification messages.  

**Step 1: Add Android Permissions:**  
First, add uses-Permissions to your AndroidManifest.xml file:  

 ![Picture10](https://github.com/user-attachments/assets/f212fecc-58bf-4a85-9a68-e8d79312da38)
 ![snippet](https://github.com/user-attachments/assets/bdef2579-2911-470a-a159-bebce3a0af3e)



**Step 2: Add Dependency:**  
Add the plugin to your pubspec.yaml file:  

 ![Picture11](https://github.com/user-attachments/assets/1be8afee-250b-419a-8402-68844120ffe8)


Make sure to run **flutter pub get** to install the package.  

**Step 3: Import the Plugin:**  
In your Dart file, import the plugin:  

![Picture12](https://github.com/user-attachments/assets/341b45ba-96ff-4026-8923-ec76c87b79ff)

 
**Step 4: Send verification message:**  
To send a Verification message via WhatsApp, use the whatsappSendingMessageService class. Here’s how you can send a verification message using the plugin:  

 ![Picture13](https://github.com/user-attachments/assets/f2062169-f773-4cb8-9257-062139ed76e3)






**Step 6: Handling Results**  
The callback function in the verifyMessage method provides a result map, which contains the status of the WhatsApp launching operation and a launching message body. You can use this information to manage the results effectively in your application.  

![Picture14](https://github.com/user-attachments/assets/4895132a-571d-40f4-8621-91f6bfd5ef26)




**7.Conclusion**  

The WhatsApp Messaging Service framework is an essential tool for applications aiming to streamline WhatsApp-based communication. By providing a structured approach to deep linking and message operations, the service simplifies the integration of WhatsApp functionality, enabling developers to focus on enhancing user experience. With its adherence to clean code principles and the SOLID architecture, the framework ensures maintainability and scalability. By leveraging this solution, businesses can efficiently send verification messages and engage users through a familiar platform, ensuring seamless communication while minimizing development complexity.

