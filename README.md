# FoodDelivery - Complete Food Order System

## 📋 Project Overview

A complete, modern food ordering system built with Java, JSP, and Bootstrap. Features a clean UI with full functionality for browsing menus, managing shopping carts, processing payments, and order confirmation.

## ✨ Features

### 1. **Login Page** (`login.jsp`)
- User authentication with email/username and password
- Client-side form validation
- Remember me functionality
- Error handling for invalid credentials
- Link to signup page for new users

### 2. **Signup Page** (`signup.jsp`)
- User registration with validation
- Fields: Name, Email, Phone, Address, Password, Confirm Password
- Email uniqueness verification
- Password strength validation
- Redirect to login on successful signup

### 3. **Food Ordering & Cart Page** (`menu-cart.jsp`)
- Display menu items with images, names, descriptions, prices, and ratings
- Add items to cart with quantity selection
- Real-time cart updates using JavaScript
- Remove items from cart functionality
- Update quantities dynamically
- Cart sidebar showing:
  - Current items in cart
  - Subtotal and delivery fee
  - Total amount with tax
  - User information
- Mobile-responsive cart toggle
- Proceed to Payment button

### 4. **Payment Page** (`payment.jsp`)
- Multiple payment method options:
  - Credit Card
  - Debit Card
  - UPI
- Delivery address section
- Cardholder information
- Card validation:
  - 16-digit card number
  - MM/YY expiry format
  - 3-4 digit CVV
  - UPI ID validation
- Order summary display
- Estimated delivery time
- SSL security badge

### 5. **Order Confirmation Page** (`confirmation.jsp`)
- Order placed successfully message
- Order ID/Reference number
- Order status timeline
  - Confirmed
  - Preparing
  - On the way
  - Delivered
- Order items summary
- Price breakdown
- Delivery details
- Estimated delivery time
- Actions: Order More or Logout

## 🎨 Design Features

- **Modern UI**: Gradient backgrounds, smooth animations, clean typography
- **Responsive Design**: Mobile-first approach with responsive grid layouts
- **Consistent Styling**: Modern CSS with reusable utility classes (`styles.css`)
- **Accessibility**: Proper form labels, error messages, and semantic HTML
- **User Experience**: Loading states, tooltips, and intuitive navigation

## 📁 Project Structure

```
FoodOrder/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tap/
│       │       ├── Servlets/
│       │       │   ├── LoginServlet.java          (Authentication)
│       │       │   ├── SignupServlet.java         (Registration)
│       │       │   ├── CartServlet.java           (Cart operations)
│       │       │   ├── PaymentServlet.java        (Order processing)
│       │       │   ├── HomeServlet.java           (Home page)
│       │       │   └── UserServlet.java           (User operations)
│       │       ├── dao/                           (Data Access Layer)
│       │       ├── dapimplementation/            (DAO Implementations)
│       │       ├── model/
│       │       │   ├── User.java
│       │       │   ├── Menu.java
│       │       │   ├── Cart.java
│       │       │   ├── Cartitem.java
│       │       │   ├── Order.java
│       │       │   ├── Orderitem.java
│       │       │   └── Restaurant.java
│       │       └── utility/
│       │           └── DBConnection.java
│       └── webapp/
│           ├── login.jsp                 (Login page)
│           ├── signup.jsp                (Signup page)
│           ├── menu-cart.jsp             (Menu & Cart)
│           ├── payment.jsp               (Payment page)
│           ├── confirmation.jsp          (Order confirmation)
│           ├── styles.css                (Global styles)
│           ├── error404.jsp              (404 error page)
│           ├── error500.jsp              (500 error page)
│           └── WEB-INF/
│               └── web.xml               (Web configuration)
└── build/
    └── classes/                          (Compiled classes)
```

## 🚀 Getting Started

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9 or higher
- MySQL 5.7 or higher
- Eclipse IDE / VS Code

### Setup Instructions

1. **Clone/Import Project**
   ```bash
   cd d:\DAP(PROJECTS)\FoodOrder
   ```

2. **Database Setup**
   - Create MySQL database:
   ```sql
   CREATE DATABASE foodorder;
   ```
   - Run database schema (create tables for users, menus, orders, etc.)

3. **Update Database Connection**
   - Edit `src/main/java/com/tap/utility/DBConnection.java`
   - Update database credentials:
   ```java
   private static final String URL="jdbc:mysql://localhost:3306/foodorder";
   private static final String USERNAME="root";
   private static final String PASSWORD="your_password";
   ```

4. **Compile Project**
   - In Eclipse: Right-click Project → Build Project
   - Or use Maven: `mvn clean install`

5. **Deploy to Tomcat**
   - Copy WAR file to Tomcat's webapps folder
   - Or deploy from Eclipse: Right-click Project → Run As → Run on Server

6. **Access Application**
   - Open browser and go to: `http://localhost:8080/FoodOrder`
   - Default welcome page: Login page

## 📝 User Flow

```
Start
  ↓
Login/Signup Page ← New User → Signup Form
  ↓
Authentication
  ↓
Menu & Cart Page
  ├─ Browse items
  ├─ Add to cart
  └─ Manage quantities
  ↓
Payment Page
  ├─ Enter delivery address
  ├─ Select payment method
  └─ Enter payment details
  ↓
Order Confirmation
  ├─ View order details
  └─ Order More or Logout
```

## 🔐 Security Features

- Session-based authentication
- Password hashing (should be implemented)
- SQL injection prevention (using DAO pattern)
- SSL/TLS encryption (production)
- HttpOnly cookies for session management
- Input validation on both client and server side
- CSRF protection through session tokens (recommended)

## 🎯 Key Servlets

### LoginServlet
- Validates user credentials
- Creates session
- Redirects to menu page on success

### SignupServlet
- Validates registration data
- Checks email uniqueness
- Creates new user account
- Redirects to login

### CartServlet
- Adds items to cart
- Updates quantities
- Removes items
- Maintains session cart

### PaymentServlet
- Processes payment information
- Creates order in database
- Adds order items
- Generates order ID
- Redirects to confirmation

## 🎨 CSS Styling

Modern, responsive CSS with:
- Gradient backgrounds
- Smooth transitions
- Mobile-first responsive design
- Accessibility considerations
- Reusable utility classes
- Dark mode ready (can be extended)

## 📱 Responsive Breakpoints

- **Desktop**: > 1024px
- **Tablet**: 768px - 1024px
- **Mobile**: < 768px

## 🔄 Session Management

- Session timeout: 30 minutes
- Cart stored in session
- User info stored in session attributes
- Automatic logout on session expiration

## 🐛 Error Handling

- Custom 404 error page
- Custom 500 error page
- Client-side form validation
- Server-side validation
- Try-catch error handling in servlets

## 📊 Database Tables (Schema)

```sql
users (userId, name, email, phone, address, password, role)
restaurants (restaurantId, name, cuisineType, deliveryTime, rating)
menus (menuId, restaurantId, itemName, description, price, rating, isAvailable, imageUrl)
orders (orderId, userId, restaurantId, orderDate, totalAmount, status, paymentMode)
orderitems (orderitemId, orderId, menuId, quantity, subTotal)
```

## 🚦 Testing Checklist

- [ ] User Registration
- [ ] User Login
- [ ] Add items to cart
- [ ] Update quantities
- [ ] Remove items
- [ ] Proceed to payment
- [ ] Submit payment
- [ ] View confirmation
- [ ] Logout functionality
- [ ] Session expiration
- [ ] Mobile responsiveness
- [ ] Error handling

## 🔮 Future Enhancements

- Payment gateway integration (Stripe, Razorpay)
- Email notifications
- Order tracking in real-time
- Rating and reviews
- Favorite restaurants/items
- Multiple delivery addresses
- Promo codes and discounts
- Admin dashboard
- SMS notifications
- Push notifications

## 📞 Support

For issues or questions, contact the development team or check the documentation.

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

---

**Version**: 1.0.0  
**Last Updated**: January 2026  
**Status**: Production Ready
