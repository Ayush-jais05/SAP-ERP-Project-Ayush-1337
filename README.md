# 🏢 SAP ABAP ERP Process Simulation Project

![SAP](https://img.shields.io/badge/SAP-ABAP-blue)
![Status](https://img.shields.io/badge/Status-Complete-green)
![Level](https://img.shields.io/badge/Level-Beginner-yellow)
![University](https://img.shields.io/badge/University-KIIT-orange)
![Language](https://img.shields.io/badge/Language-ABAP-red)
![Modules](https://img.shields.io/badge/Modules-FI%20%7C%20MM%20%7C%20SD-blue)

---

## 📌 Project Title
**SAP ABAP ERP Process Simulation — P2P, O2C & ALV Report**

---

## 👨‍🎓 Student Details

| Field | Details |
|-------|---------|
| **Name** | Ayush Raj |
| **Roll Number** | 23051337 |
| **Program** | B.Tech — SAP Business Cloud Data Analyst |
| **University** | KIIT University, Bhubaneswar |
| **Academic Year** | 2024 – 2025 |

---

## 📝 Description

This project simulates three core **SAP ERP business processes** using **ABAP (SE38 Reports)**:

| Module | Process | Transactions Covered |
|--------|---------|----------------------|
| MM + FI | Procure-to-Pay (P2P) | PR → PO → GR → Invoice → Payment |
| SD + FI | Order-to-Cash (O2C) | Sales Order → Delivery → Billing → Receipt |
| SD | ALV Report | Grid display of all orders with totals |

> **Purpose:** Academic student project demonstrating SAP ERP process understanding through ABAP programming.

> **Important:** This is a **simulation project** — it uses internal tables (in-memory data), not actual SAP database tables. No real SAP master data or configuration is required to run these programs.

---

## 📁 Project Structure

```
SAP_Project/
│
├── ZP2P_PROCESS.abap     ← Procure-to-Pay simulation (MM + FI)
├── ZO2C_PROCESS.abap     ← Order-to-Cash simulation (SD + FI)
├── ZALV_REPORT.abap      ← ALV Grid Report (Sales + Purchase Summary)
└── README.md             ← This file
```

---

## 🔄 Process Flow Overview

```
╔══════════════════════════════════════════════════════════════╗
║              PROCURE-TO-PAY (P2P)   [MM + FI]               ║
║   PR  ──►  PO  ──►  GR  ──►  Invoice  ──►  Payment          ║
╠══════════════════════════════════════════════════════════════╣
║              ORDER-TO-CASH (O2C)    [SD + FI]                ║
║   SO  ──►  Delivery  ──►  PGI  ──►  Billing  ──►  Receipt   ║
╠══════════════════════════════════════════════════════════════╣
║              ALV REPORT             [SD]                     ║
║   Internal Table  ──►  Field Catalog  ──►  Grid Display      ║
╚══════════════════════════════════════════════════════════════╝
```

---

## ✅ Features

### 🔹 Program 1: ZP2P_PROCESS — Procure to Pay
Simulates the complete **buying/procurement cycle**:
- ✅ **Purchase Requisition (PR)** — Internal request to buy goods
- ✅ **Purchase Order (PO)** — Official order placed with vendor
- ✅ **Goods Receipt (GR)** — Goods received and stored in warehouse
- ✅ **Invoice Verification** — Vendor bill matched with PO & GR (3-way matching)
- ✅ **Payment to Vendor** — Final payment made (FI cleared)

### 🔹 Program 2: ZO2C_PROCESS — Order to Cash
Simulates the complete **selling/revenue cycle**:
- ✅ **Sales Order (SO)** — Customer places order
- ✅ **Delivery** — Goods packed and shipped to customer
- ✅ **Post Goods Issue (PGI)** — Stock reduced in SAP automatically
- ✅ **Billing Document** — Invoice created for customer (AR posted)
- ✅ **Payment Receipt** — Customer payment received and cleared

### 🔹 Program 3: ZALV_REPORT — ALV Grid Report
Displays a professional **interactive report** showing:
- ✅ Order ID, Order Type, Customer/Vendor Name
- ✅ Material, Quantity, Amount (INR)
- ✅ Order Date, Status
- ✅ **Column Totals** for Amount
- ✅ **Zebra striping** for readability
- ✅ **Selection screen** for filtering by customer

---

## 🖥️ How to Run in SAP (SE38 Steps)

### Prerequisites
- Access to **SAP GUI** (any version — ECC 6.0 or S/4HANA)
- User with authorization for **SE38** transaction

### Step-by-Step Instructions

#### ▶️ Step 1 — Open SE38
1. Log in to **SAP GUI**
2. In the **command bar**, type: `SE38`
3. Press **Enter**

#### ▶️ Step 2 — Create New Program
1. In the **Program** field, type the program name:
   - `ZP2P_PROCESS` (for P2P)
   - `ZO2C_PROCESS` (for O2C)
   - `ZALV_REPORT` (for ALV)
2. Click **Create** (or press `F5`)
3. Enter Title: e.g., `P2P Process Simulation`
4. Type: `Executable Program`
5. Click **Save** → assign to a **Package** or use `$TMP` (local)

#### ▶️ Step 3 — Paste the Code
1. In the ABAP Editor, **delete** all existing code
2. **Copy** the full code from the `.abap` file
3. **Paste** it into the editor
4. Click **Save** (`Ctrl + S`)

#### ▶️ Step 4 — Activate the Program
1. Click the **Activate** button (or press `Ctrl + F3`)
2. Wait for "Object activated" message
3. No syntax errors should appear ✅

#### ▶️ Step 5 — Execute / Run
1. Press **F8** (Execute)
2. For `ZALV_REPORT` — a selection screen appears first; press F8 again
3. The output will display on screen

> 💡 **Tip:** If you get a "package" popup when saving, just click the **Local Object** button (or enter `$TMP`) to save without a transport request.

---

## 🧑‍💻 Program Explanation (Viva Ready)

### ZP2P_PROCESS — Procure to Pay

| Concept Used | Where Used |
|---|---|
| `TYPES:` | Defining custom structures (PR, PO, GR, Invoice, Payment) |
| `DATA:` | Declaring internal tables and work areas |
| `APPEND` | Adding rows to internal table |
| `LOOP AT ... INTO` | Reading each row from table for display |
| `WRITE:` | Printing output on screen |
| `CLEAR` | Resetting work area between entries |

**Key ABAP Concepts demonstrated:**
- Custom data types using `TYPES`
- Internal tables (like a temporary database table in memory)
- Work areas (like a single row/buffer)
- Basic I/O using `WRITE`
- Step-by-step linear process simulation

---

### ZO2C_PROCESS — Order to Cash

Same concepts as P2P, additionally:
- **Date arithmetic** — `lv_due_date = sy-datum + 30` (adds 30 days for payment due date)
- **System variables** — `sy-datum` (today's date), `sy-repid` (current program name)
- **Linear process flow** — each step builds on previous
- **3 customers** simulated: Ramesh Electronics, Sunita Traders, Patel Home Appliances

---

### ZALV_REPORT — ALV Report

| Concept Used | Purpose |
|---|---|
| `SELECTION-SCREEN` | User input/filter screen before report runs |
| `slis_t_fieldcat_alv` | ALV field catalog type — defines columns |
| `slis_layout_alv` | Controls grid appearance (zebra, separators) |
| `PERFORM ... FORM` | Subroutines (modular code — good practice) |
| `CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'` | Standard SAP function to display the grid |
| `do_sum = 'X'` | Enables automatic column total for Amount |
| `col_pos` | Sets the position/order of each column |
| `outputlen` | Sets the width of each column |

---

## 🔗 FI-MM-SD Integration (How the modules connect)

```
┌─────────────────────────────────────────────────┐
│              SAP ERP Integration                 │
│                                                  │
│  MM (Buy Goods)    SD (Sell Goods)               │
│       │                  │                       │
│  GR Posted          PGI Posted                   │
│       │                  │                       │
│       └──────┬───────────┘                       │
│              ▼                                   │
│    FI (Financial Accounting)                     │
│  Auto accounting entries created                 │
│  Inventory / Revenue / COGS / AR / AP            │
└─────────────────────────────────────────────────┘
```

| Event in MM/SD | Auto Entry in FI |
|---|---|
| Goods Receipt (GR) | Debit Inventory, Credit GR/IR Clearing |
| Invoice Verification (MIRO) | Debit GR/IR Clearing, Credit Vendor Payable |
| Vendor Payment (F-53) | Debit Vendor, Credit Bank |
| Post Goods Issue (PGI) | Debit COGS, Credit Inventory |
| Customer Billing (VF01) | Debit Customer Receivable, Credit Sales Revenue |
| Customer Payment (F-28) | Debit Bank, Credit Customer Receivable |

---

## 📊 Sample Output Preview

### P2P Process Output:
```
============================================================
   SAP P2P PROCESS SIMULATION - Procure to Pay
   Module: MM + FI
============================================================
>>> STEP 1: PURCHASE REQUISITION (PR)
------------------------------------------------------------
PR Number   Material         Qty   Department      Status
--------   --------         ---   ----------      ------
PR-1001     Office Chairs    10   HR Department   Created
PR-1002     Laptops           5   IT Department   Created
** Purchase Requisition Created Successfully! **

>>> STEP 2: PURCHASE ORDER (PO)
------------------------------------------------------------
PO-2001   ABC Furniture Ltd   Office Chairs   10   2500.00   25000.00
PO-2002   TechWorld Pvt Ltd   Laptops          5  45000.00  225000.00
** Purchase Order Created & Sent to Vendor! **
...
** Procure-to-Pay (P2P) Process Completed Successfully! **
============================================================
```

### O2C Process Output:
```
============================================================
   SAP O2C PROCESS SIMULATION - Order to Cash
   Module: SD + FI
============================================================
>>> STEP 1: SALES ORDER (SO)
SO-1001   Ramesh Electronics   LED Television 55in   3   35000.00   105000.00
SO-1002   Sunita Traders       Gaming Laptop         2   75000.00   150000.00
** Sales Orders Created & Confirmed! **
...
** Order-to-Cash (O2C) Process Completed Successfully! **
============================================================
```

### ALV Grid Output:
```
┌──────────┬───────────┬─────────────────────┬───────────────────┬─────┬──────────────┬────────────┬───────────┐
│ Order ID │Order Type │ Customer/Vendor      │ Material/Product  │ Qty │ Amount (INR) │ Order Date │  Status   │
├──────────┼───────────┼─────────────────────┼───────────────────┼─────┼──────────────┼────────────┼───────────┤
│ SO-1001  │ Sales     │ Ramesh Electronics   │ LED Television    │   3 │   105,000.00 │ 18.04.2024 │ Completed │
│ SO-1002  │ Sales     │ Sunita Traders       │ Gaming Laptop     │   2 │   150,000.00 │ 18.04.2024 │ Completed │
│ SO-1003  │ Sales     │ Patel Home Appl.     │ Washing Machine   │   5 │   110,000.00 │ 18.04.2024 │ Completed │
│ PO-2001  │ Purchase  │ ABC Furniture Ltd    │ Office Chairs     │  10 │    25,000.00 │ 18.04.2024 │ Paid      │
│ PO-2002  │ Purchase  │ TechWorld Pvt Ltd    │ Laptops           │   5 │   225,000.00 │ 18.04.2024 │ Paid      │
├──────────┼───────────┼─────────────────────┼───────────────────┼─────┼──────────────┼────────────┼───────────┤
│          │           │                      │            Total  │     │   840,000.00 │            │           │
└──────────┴───────────┴─────────────────────┴───────────────────┴─────┴──────────────┴────────────┴───────────┘
```

---

## 🎓 Viva Quick Reference

| Question | Answer |
|---|---|
| What is an internal table? | A temporary table stored in memory during execution — like a spreadsheet in RAM |
| What is a work area? | A single-row buffer used to read/write one row at a time from an internal table |
| What does `APPEND` do? | Copies the work area row into the internal table (adds a new row) |
| What is `sy-datum`? | SAP system variable that returns today's date |
| What is ALV? | ABAP List Viewer — displays data as an interactive, sortable, exportable grid |
| What is 3-way matching? | Checking that PO + GR + Invoice all match before paying vendor — prevents fraud |
| What does PGI mean? | Post Goods Issue — stock leaves warehouse, SAP reduces inventory automatically |
| What is `REUSE_ALV_GRID_DISPLAY`? | Standard SAP function module that renders the ALV grid on screen |
| What is `do_sum = 'X'`? | Flag in field catalog that enables automatic column total in ALV |
| What is `$TMP` package? | A local package in SAP for development objects that don't need transport |
| Why Z prefix in program names? | SAP naming convention — Z/Y programs are customer-created (custom development) |

---

## 👨‍🎓 About This Project

| Field | Details |
|-------|---------|
| Language | ABAP (Advanced Business Application Programming) |
| SAP Version | Compatible with SAP ECC 6.0 / S/4HANA |
| Transaction | SE38 (ABAP Editor) |
| Level | Beginner / Student |
| Modules | MM (Materials Management), SD (Sales & Distribution), FI (Financial Accounting) |
| Pattern | Simulation — internal tables only (no real DB tables) |
| Company Simulated | VedaStar Retail Solutions Pvt. Ltd. (Fictitious) |

---

## ⚠️ Notes

- This is a **simulation project** — it uses internal tables (in-memory), not actual SAP database tables
- No real SAP master data is required
- Programs can be run in any SAP system with SE38 access
- Code is intentionally kept simple for learning purposes
- All variable names and comments are written in plain English for easy understanding
- The `TEXT-001` element in `ZALV_REPORT` needs to be created in SE38 under **Goto → Text Elements → Text Symbols** — or simply replace `TEXT-001` with a hardcoded string like `'Selection Parameters'`

---

## 📚 Key T-Codes Used in This Project

| T-Code | Full Name | Used In |
|--------|-----------|---------|
| SE38 | ABAP Editor | Running all programs |
| ME51N | Create Purchase Requisition | P2P Step 1 |
| ME21N | Create Purchase Order | P2P Step 2 |
| MIGO | Goods Movement | P2P Step 3 |
| MIRO | Invoice Verification | P2P Step 4 |
| F-53 | Post Outgoing Payment | P2P Step 5 |
| VA01 | Create Sales Order | O2C Step 1 |
| VL01N | Create Delivery | O2C Step 2 |
| VL02N | Change Delivery / PGI | O2C Step 3 |
| VF01 | Create Billing Document | O2C Step 4 |
| F-28 | Post Incoming Payment | O2C Step 5 |

---

*Made with ❤️ for SAP ABAP Learning — KIIT University 2024–2025*