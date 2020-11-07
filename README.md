# dummyHexPay
dummy Repo to check commits 

# 1150-Hex-O-Satva
Banking and Fintech

Additional Repository (Contains Backend): https://github.com/MH-2-0-Round-3/1150-Hex-O-Satva-2

## Overview
We are creating an application that uses UPI (United Payments Interface) to send payments between customer and businesses. As the cries for digital payments are getting louder, we aim to create this application to reduce frauds and bring in new features to appeal to a wider demographic and thus, increase the footprints of our application.

A user needs to sign up first either as customer or a business. They will login on subsequent visits. 

The customer side of the application allows users to pay a business by first searching the already registered business via the search bar, then entering the amount to be paid and then choosing the mode of payment. If they choose to pay now, they can use their preferred UPI merchant and pay the business. They get a qr code on their screen at successful completion. If they choose the pay later option, it will have to be approved by the shopkeeper. They can also view smart analytics, transaction history and their credit due. Also, credits have a timeout interval of 15 days, and if the user hasn't paid it back by that time, they won't be able to access the application, and the same will also be notified to the shopkeeper.

The business side of the application will speak out the details of any new payment that it recieves. This will help the shopkeepers verify the payment. They may also use the qr scanner to verify the transaction in case there is a delay in recieving sms. The business also have to approve the requests for payments on credit. They can view the smart analytics which can aid them in making decisions. They also have an option to undo any recent transaction which might be incorrect/repeated.

## Features and Benefits
1. **Reduces fraud** by verification of the payment on the business's side via sms reader and tts or qr code in case of delay in sms arrival.
2. **Provides smart analytics** to both customers and businesses.
3. Gives the option to customers to purchase on **Credit at the discretion of the business owner** 
4. Businesses can **Undo transactions** that were incorrect.
5. Users can view their categorised **Transaction History**
6. We calculate customer's **Credit Rating** based on their past behaviour on our application.
7. Implementation of a **Search Bar** to make sure the customer pays to the correct business and reduce incorrect transactions.

## Work done till now
- We have succesfully created the login and signup screens and itegrated that with the backend database.
- Customer home page and side drawer is also implemeted.
- Business home page analytics and sidebar is also implemented.
- Payment process is also developed and implemented.
- Added QR generator 
- Prototypes of business home screen and customer analytics screen are also ready. 

## External APIs Used
1. http - For Communication with server
2. image_picker - For Shop Image
3. url_launcher - For password reset link
4. pie_chart - To make and display pie charts
5. charts_flutter - To make and display bar graphs
6. upi_flutter - to invoke UPI for transactions 
7. barcode_scan - to scan qr codes generated 
8. qr_flutter - to generate qr codes  

## Notes
1. Credit is solely based on the discretion of shopkeeper. However, we do provide data like credit rating of the user to enable him to make the choice. The aim is to provide more features that the smaller businesses provide in the conventional way, so that it is easier for that demographic too to switch over to such digital mediums.
