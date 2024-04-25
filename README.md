# StyleCast

# Firebase setup
https://www.youtube.com/watch?v=Y0IKGgBM8zo&list=PLgRxBCVPaZ_3jdqcrGKgbQrDwRXMHaE5B&index=3

# Generate iOS reversed_client_id
https://console.firebase.google.com/u/0/project/stylecast-ad37e/authentication/providers?hl=ko

# Generate android debug.keystore
keytool -genkey -v -keystore debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000

# Firebase_core setup
flutter pub add firebase_core
flutter pub get

# Firebase_auth setup
flutter pub add firebase_auth
flutter pub get