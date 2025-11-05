---
title: "Hometown Marketplace"
date: 2025-01-01
tags: ["react-native", "expo", "firebase", "stripe", "e-commerce", "mobile", "typescript"]
summary: "A mobile-first local marketplace platform connecting buyers with artisans and small businesses in their community. Built with React Native, Firebase, and Stripe for a seamless farmers market experience, always open."
---

![Last Commit](https://img.shields.io/github/last-commit/jaredcoderman/hometown-marketplace-expo)

`Hometown Marketplace` is a cross-platform mobile marketplace that brings the farmers market experience to your phone. Built with React Native and Expo, it connects local buyers with artisans, makers, and small businesses in their community through location-based discovery, secure payments, and real-time messaging.

### Key Features

- **📍 Location-Based Discovery**: Find sellers and products near you using geolocation and geospatial queries
- **💳 Stripe Payment Processing**: Full Stripe Connect integration with secure checkout sessions and automated seller payouts
- **💰 Subscription Tiers**: Community (free) and Active ($5/month) subscription plans with automated tier management
- **🛍️ Dual Mode Interface**: Sellers can seamlessly switch between selling and buying modes within the same app
- **💌 Complete Order System**: Order management with shipping and pickup options, real-time status tracking
- **📧 Email Automation**: Transactional emails for orders, payments, and buyer/seller communications via Resend
- **💬 Real-Time Messaging**: In-app messaging system between buyers and sellers
- **❤️ Favorites System**: Save products and sellers for easy access
- **⭐ Ratings & Reviews**: Build trust through community feedback and ratings
- **📊 Seller Analytics**: Business performance tracking and order management dashboards

### Why I Built It

Hometown Marketplace was inspired by my mom, who handcrafts natural soaps and sells them at local farmers markets every weekend. Watching her connect with customers and build community made me realize that farmers markets aren't just about transactions—they're about relationships, supporting local artisans, and strengthening communities.

But farmers markets only happen once a week. I wanted to create a platform that brings that same sense of community, discovery, and local connection to every day, making it easier for local artisans to reach customers and for buyers to discover amazing products in their neighborhood.

This project gave me the opportunity to work with modern mobile development, payment processing, real-time databases, and building a full-stack application that solves a real problem for real people.

### Architecture Highlights

The app follows a mobile-first, serverless architecture:

- **Client**: React Native app with Expo Router for cross-platform deployment (iOS, Android, Web)
- **Real-Time Database**: Cloud Firestore with security rules and real-time sync
- **Serverless Backend**: Firebase Cloud Functions (2nd Gen) for payment processing, email delivery, and webhook handling
- **Storage**: Firebase Cloud Storage for product images and user avatars
- **Authentication**: Firebase Auth with email/password and email verification
- **Payments**: Stripe Connect for marketplace payments with automated seller payouts
- **Email**: Resend for transactional email delivery

### Tech Stack

- **Frontend**:
  - React Native 0.81.5 with Expo Router
  - TypeScript for type safety
  - React Context API for state management
  - Expo SDK 54 for cross-platform capabilities

- **Backend & Infrastructure**:
  - Firebase Authentication
  - Cloud Firestore (real-time database)
  - Firebase Cloud Storage
  - Firebase Cloud Functions (2nd Gen, Node.js 22)
  - Stripe Connect API
  - Resend API

- **Key Libraries**:
  - `expo-location` for geolocation services
  - `geofire-common` for geospatial queries
  - `stripe` (Node.js SDK) for payment processing
  - `expo-image-picker` for product image management
  - `react-hook-form` for form validation

### Code Highlights

**Subscription Management (`functions/src/index.ts`)**  
Serverless functions handle Stripe subscription creation, cancellation, and webhook processing. Includes automated tier management and subscription status tracking.

**Location-Based Seller Discovery (`services/seller.service.ts`)**  
Geospatial queries using Firestore and geohashing to find sellers within a specified radius, enabling location-based product discovery.

**Stripe Connect Integration (`functions/src/index.ts`)**  
Complete marketplace payment flow with Stripe Connect: seller onboarding, checkout session creation, payment processing, and automated payouts to seller accounts.

**Real-Time Order System**  
Webhook-driven order creation and status updates with real-time Firestore sync, ensuring buyers and sellers always see current order status.

### Future Improvements

- Push notifications for mobile apps
- Advanced search and filtering capabilities
- Seller verification badges for trusted artisans
- Multi-language support
- Subscription upgrade/downgrade flow improvements
- Analytics dashboard enhancements

### Live Demo

Visit the live web app: **[hometown-marketplace.com](https://hometown-marketplace.com)**

*Note: While optimized for mobile, the app is fully responsive and works beautifully on desktop too.*

### Source Code

[Repository](https://github.com/jaredcoderman/hometown-marketplace-expo)