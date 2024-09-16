
# ☕ Hamada Coffee Shop Management Program (Assembly)

Welcome to **Hamada Coffee Shop**, a comprehensive program designed to manage a coffee shop's inventory, sales, and stock operations using Assembly language! This project is a demonstration of advanced Assembly coding for managing a real-world use case: a coffee shop. The system allows users to explore inventory, process sales, restock items, and view sales reports—all within an interactive DOS-based interface.

---

## 📋 Table of Contents

- [🚀 Features](#-features)
- [⚙️ Program Structure](#-program-structure)
  - [Data](#data)
  - [Procedures](#procedures)
- [📦 Installation](#-installation)
- [🎮 Usage](#-usage)
  - [Main Menu](#main-menu)
  - [Inventory Management](#inventory-management)
  - [Sales Operations](#sales-operations)
  - [Restocking Items](#restocking-items)
  - [Sales Report](#sales-report)
- [👨‍💻 Authors](#-authors)

---

## 🚀 Features

- **Explore Coffee Shop Inventory**: View detailed information about each item (ID, Name, Stock, Price).
- **Process Sales**: Sell items by entering their ID and quantity, with real-time inventory updates.
- **Restock Inventory**: Easily replenish stock by selecting the item ID and specifying the amount.
- **Arrange Inventory**: Sort items by availability, including highlighting items that need replenishment.
- **Sales Summary**: Generate and display sales statistics, including total revenue earned.
- **User-Friendly Interface**: Interactive menu for seamless navigation and operations.

---

## ⚙️ Program Structure

### Data
The program stores key details about inventory items, including:
- **Item ID**: Unique identifier for each product.
- **Item Name**: Coffee types, e.g., Espresso, Cappuccino.
- **Stock Level**: Quantity available for each item.
- **Price**: Price of each coffee.
- **Sales Information**: Number of items sold and total revenue generated.

### Procedures

The program operates using a set of well-defined procedures:
- **Main Menu**: The starting point of the program that allows users to navigate to different features.
- **Inventory Management**: Displays the current stock and enables sorting based on availability.
- **Sales Operations**: Allows users to process a sale by selecting items and updating stock in real time.
- **Restocking Items**: Offers users the ability to replenish stock for selected items.
- **Sales Report Generation**: Summarizes sales data, including the number of items sold and the total revenue.

---

## 📦 Installation

To run this Assembly language program on DOS, follow these steps:

### Prerequisites:
- **TASM** (Turbo Assembler) or equivalent assembler.
- **DOSBox** or a similar DOS emulator.

### Steps:
1. Clone or download the program files.
2. Open the program in your DOS-based emulator.
3. Assemble the `.asm` file using the following commands:
   ```bash
   tasm /zi hamada_coffee_shop.asm
   tlink /v hamada_coffee_shop.obj
   ```
4. Run the executable:
   ```bash
   hamada_coffee_shop.exe
   ```

---

## 🎮 Usage

### Main Menu

When the program starts, the user is greeted with a **Main Menu**. From here, users can:
- View inventory.
- Process sales.
- Restock items.
- View sales reports.
- Exit the program.

### Inventory Management

- **Explore Inventory**: Lists all coffee items with their respective stock levels, prices, and IDs.
- **Restocking**: Users can add more stock to selected items.
  
⚠️ *Items that need replenishment are displayed in **red**.*

### Sales Operations

- Users can sell items by entering the **item ID** and the **quantity**.
- If the stock is insufficient, the program will notify the user with an error.
  
💡 *Once the sale is successful, the inventory is updated in real-time.*

### Restocking Items

- Select the item ID and specify the quantity to restock.
- The system updates the inventory and confirms successful restocking.

### Sales Report

- **Sales Summary**: Displays the total number of items sold and total revenue generated.
- Users can view the sales data for each item, including the quantity sold and revenue.

---

## 👨‍💻 Authors

- **TP066168**: Mohamed Khairy Mohamed Abdelraouf

This project was built as part of a programming course using Assembly language to develop a fully functional coffee shop management system.

---

## 🎯 Conclusion

The **Hamada Coffee Shop Program** demonstrates the power and flexibility of Assembly language in building real-world applications. With features like sales processing, inventory management, and a seamless user interface, this project highlights how low-level programming can be used to solve complex tasks.

---

Thank you for visiting **Hamada Coffee Shop**! We hope you enjoyed exploring this project. ☕
