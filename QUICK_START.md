# 🚀 Quick Start Guide - FoodDelivery Application

## ⚡ 5-Minute Setup

### Step 1: Prepare Database
```sql
-- Create database
CREATE DATABASE foodorder;
USE foodorder;

-- Sample Users table
CREATE TABLE users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    role VARCHAR(20)
);

-- Sample Menus table
CREATE TABLE menus (
    menuId INT AUTO_INCREMENT PRIMARY KEY,
    restaurantId INT,
    itemName VARCHAR(100),
    description VARCHAR(255),
    price FLOAT,
    rating INT,
    isAvailable BOOLEAN,
    imageUrl VARCHAR(255)
);

-- Sample Orders table
CREATE TABLE orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    restauranrId INT,
    orderDate TIMESTAMP,
    totalAmount FLOAT,
    status VARCHAR(50),
    paymentMode VARCHAR(50)
);

-- Sample OrderItems table
CREATE TABLE orderitems (
    orderitemId INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT,
    menuId INT,
    quantity INT,
    subTotal FLOAT
);
```

### Step 2: Configure Database Connection
Edit: `src/main/java/com/tap/utilty/DBConnection.java`

```java
private static final String URL = "jdbc:mysql://localhost:3306/foodorder";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

### Step 3: Compile & Deploy
```bash
# In Eclipse IDE:
# Right-click Project → Build Project
# Right-click Project → Run As → Run on Server

# Or using Maven:
# mvn clean install
# mvn tomcat7:deploy
```

### Step 4: Access Application
```
http://localhost:8080/FoodOrder
```

---

## 📱 Test User Flow

### 1. **Signup** (if needed)
- Go to Signup page
- Fill in all fields
- Click "Create Account"
- Redirects to Login

### 2. **Login**
- Enter email: test@example.com
- Enter password: test123
- Click "Login"
- Redirects to Menu & Cart page

### 3. **Browse & Order**
- Click items to see details
- Enter quantity
- Click "+" to add to cart
- Cart updates in real-time

### 4. **Checkout**
- Click "Proceed to Payment"
- Fill delivery address
- Select payment method
- Enter payment details
- Click "Complete Payment"

### 5. **Confirmation**
- View order confirmation
- See order ID and timeline
- Click "Order More" or "Logout"

---

## 🔧 Troubleshooting

### Database Connection Error
**Problem**: "Cannot connect to database"
**Solution**:
1. Ensure MySQL is running
2. Check database URL, username, password in DBConnection.java
3. Verify database exists
4. Check MySQL port (default: 3306)

### Page Not Found (404)
**Problem**: "Page not found" error
**Solution**:
1. Check URL matches servlet mapping in web.xml
2. Verify file exists in webapp folder
3. Check spelling of JSP file names
4. Restart Tomcat

### Session Issues
**Problem**: "Session expired" or "User not found"
**Solution**:
1. Check session timeout in web.xml
2. Verify LoginServlet sets session attributes
3. Check browser cookies are enabled
4. Clear browser cache

### Form Validation Fails
**Problem**: "Cannot submit form"
**Solution**:
1. Check browser console for JavaScript errors
2. Verify all required fields are filled
3. Check field formats match validation rules
4. Try different browser if issue persists

---

## 📋 Page Mapping

| URL | Page | Purpose |
|-----|------|---------|
| `/FoodOrder/login.jsp` | Login | User authentication |
| `/FoodOrder/signup.jsp` | Signup | New user registration |
| `/FoodOrder/menu-cart.jsp` | Menu & Cart | Browse & shop |
| `/FoodOrder/payment.jsp` | Payment | Enter payment details |
| `/FoodOrder/confirmation.jsp` | Confirmation | Order confirmed |

---

## 🔐 Admin / Test Credentials

### Test User
```
Email: test@example.com
Password: test123
```

### Create Test User
1. Go to signup.jsp
2. Fill in details
3. Password must be 6+ characters
4. Email must be unique

---

## 📊 Sample Menu Items (Insert into DB)

```sql
INSERT INTO menus (restaurantId, itemName, description, price, rating, isAvailable, imageUrl)
VALUES 
(1, 'Biryani', 'Delicious rice with spices', 250, 4.5, true, 'images/menu/biryani.jpg'),
(1, 'Pizza', 'Cheesy and delicious', 180, 4.2, true, 'images/menu/pizza.jpg'),
(1, 'Burger', 'Classic burger', 120, 4, true, 'images/menu/burger.jpg');
```

---

## 🎨 Customization

### Change Colors
Edit: `styles.css`

```css
:root {
    --primary-color: #667eea;      /* Change primary color */
    --secondary-color: #764ba2;    /* Change secondary color */
    --danger-color: #dc3545;       /* Change error color */
}
```

### Change Delivery Fee
Edit: `menu-cart.jsp`

```javascript
const DELIVERY_FEE = 50;  // Change this value
```

### Change Tax Rate
Edit: `payment.jsp` and `confirmation.jsp`

```javascript
const TAX_RATE = 0.05;  // 5% tax
```

---

## 🐛 Common Issues & Solutions

### Issue: "Cannot resolve symbol User"
**Solution**: Check import statements in servlet, ensure model classes are in classpath

### Issue: Cart not updating
**Solution**: Check JavaScript console for errors, verify CartServlet is mapped correctly

### Issue: Payment not processing
**Solution**: Check PaymentServlet logic, verify database connections, check for exceptions in server logs

### Issue: Images not loading
**Solution**: Upload images to `webapp/images/menu/` folder, update image URLs in database

---

## 📈 Performance Tips

1. **Database Optimization**
   - Add indexes on frequently queried columns
   - Use connection pooling
   - Optimize queries

2. **Frontend Optimization**
   - Minimize CSS/JavaScript
   - Optimize images
   - Use browser caching

3. **Server Optimization**
   - Increase Tomcat heap size
   - Enable gzip compression
   - Use CDN for static files

---

## 📚 File Reference

### JSP Files (User Interface)
- `login.jsp` - Login page (420 lines)
- `signup.jsp` - Registration page (410 lines)
- `menu-cart.jsp` - Shopping interface (480 lines)
- `payment.jsp` - Payment form (520 lines)
- `confirmation.jsp` - Order confirmation (410 lines)

### Java Servlets (Business Logic)
- `LoginServlet.java` - Authentication (70 lines)
- `SignupServlet.java` - Registration (60 lines)
- `CartServlet.java` - Cart management (80 lines)
- `PaymentServlet.java` - Order processing (90 lines)

### Styling
- `styles.css` - Global CSS (700+ lines)

---

## 🎯 Features Checklist

- ✅ User Authentication (Login/Signup)
- ✅ Menu Display with Images
- ✅ Shopping Cart
- ✅ Quantity Management
- ✅ Payment Form
- ✅ Multiple Payment Methods
- ✅ Order Confirmation
- ✅ Order Timeline
- ✅ Responsive Design
- ✅ Form Validation
- ✅ Session Management
- ✅ Error Handling

---

## 🔗 API Endpoints

### Servlets
```
POST /FoodOrder/LoginServlet      - User login
POST /FoodOrder/SignupServlet     - User registration
POST /FoodOrder/CartServlet       - Cart operations
POST /FoodOrder/PaymentServlet    - Process payment
GET  /FoodOrder/LoginServlet?action=logout - Logout
```

---

## 📞 Support Resources

- **Documentation**: See `README.md` for detailed info
- **Implementation Details**: See `IMPLEMENTATION_SUMMARY.md`
- **Database Schema**: See SQL scripts above
- **Code Comments**: Check source files for inline documentation

---

## 🚀 Deploy to Production

1. **Update web.xml** with production settings
2. **Enable HTTPS/SSL** in Tomcat
3. **Set secure cookies** in web.xml
4. **Configure firewall** to block direct DB access
5. **Set up backup** strategy
6. **Enable logging** and monitoring
7. **Test thoroughly** before going live
8. **Set up load balancer** if needed

---

## 💡 Next Steps

1. Test all functionality locally
2. Add more menu items to database
3. Customize styling as needed
4. Integrate payment gateway
5. Set up email notifications
6. Add order tracking feature
7. Deploy to production server
8. Monitor performance and logs

---

**Happy Coding! 🎉**

For questions or issues, refer to the detailed documentation in `README.md` and `IMPLEMENTATION_SUMMARY.md`.
