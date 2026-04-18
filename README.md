# 🏢 SAP ABAP ERP Process Simulation Project

![SAP](https://img.shields.io/badge/SAP-ABAP-blue) ![Status](https://img.shields.io/badge/Status-Complete-green) ![Level](https://img.shields.io/badge/Level-Beginner-yellow)

---

## 📌 Project Title
**SAP ABAP ERP Process Simulation — P2P, O2C & ALV Report**

---

## 📝 Description

This project simulates three core **SAP ERP business processes** using **ABAP (SE38 Reports)**:

| Module | Process | Transactions Covered |
|--------|---------|----------------------|
| MM + FI | Procure-to-Pay (P2P) | PR → PO → GR → Invoice → Payment |
| SD + FI | Order-to-Cash (O2C) | Sales Order → Delivery → Billing → Receipt |
| SD | ALV Report | Grid display of all orders with totals |

> **Purpose:** Academic student project demonstrating SAP ERP process understanding through ABAP programming.

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

## ✅ Features

### 🔹 Program 1: ZP2P_PROCESS — Procure to Pay
Simulates the complete **buying/procurement cycle**:
- ✅ **Purchase Requisition (PR)** — Internal request to buy goods
- ✅ **Purchase Order (PO)** — Official order placed with vendor
- ✅ **Goods Receipt (GR)** — Goods received and stored in warehouse
- ✅ **Invoice Verification** — Vendor bill matched with PO & GR
- ✅ **Payment to Vendor** — Final payment made (FI cleared)

### 🔹 Program 2: ZO2C_PROCESS — Order to Cash
Simulates the complete **selling/revenue cycle**:
- ✅ **Sales Order (SO)** — Customer places order
- ✅ **Delivery** — Goods packed and shipped to customer
- ✅ **Billing Document** — Invoice created for customer (AR posted)
- ✅ **Payment Receipt** — Customer payment received and cleared

### 🔹 Program 3: ZALV_REPORT — ALV Grid Report
Displays a professional **interactive report** showing:
- ✅ Order ID, Order Type, Customer/Vendor Name
- ✅ Material, Quantity, Amount (INR)
- ✅ Order Date, Status
- ✅ **Column Totals** for Amount
- ✅ **Zebra striping** for readability

---

## 🖥️ How to Run in SAP (SE38 Steps)

### Prerequisites
- Access to **SAP GUI** (any version)
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
4. Click **Save** (Ctrl + S)

#### ▶️ Step 4 — Activate the Program
1. Click the **Activate** button (or press `Ctrl + F3`)
2. Wait for "Object activated" message
3. No syntax errors should appear

#### ▶️ Step 5 — Execute / Run
1. Press **F8** (Execute)
2. For `ZALV_REPORT` — a selection screen appears first; press F8 again
3. The output will display on screen

---

## 🧑‍💻 Program Explanation (Viva Ready)

### ZP2P_PROCESS — Procure to Pay

| Concept Used | Where Used |
|---|---|
| `TYPES:` | Defining custom structures |
| `DATA:` | Declaring internal tables and work areas |
| `APPEND` | Adding rows to internal table |
| `LOOP AT ... INTO` | Reading each row from table |
| `WRITE:` | Printing output on screen |
| `CLEAR` | Resetting work area between entries |

**Key ABAP Concepts demonstrated:**
- Custom data types using `TYPES`
- Internal tables (like a temporary database table in memory)
- Work areas (like a single row/buffer)
- Basic I/O using `WRITE`

---

### ZO2C_PROCESS — Order to Cash

Same concepts as P2P, additionally:
- **Date arithmetic** — `lv_due_date = sy-datum + 30` (adds 30 days)
- **System variables** — `sy-datum` (today's date)
- **Linear process flow** — each step builds on previous

---

### ZALV_REPORT — ALV Report

| Concept Used | Purpose |
|---|---|
| `SELECTION-SCREEN` | User input/filter screen |
| `slis_t_fieldcat_alv` | ALV field catalog type |
| `slis_layout_alv` | Controls grid appearance |
| `PERFORM ... FORM` | Subroutines (modular code) |
| `CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'` | Displays the grid |
| `do_sum = 'X'` | Enables column total |

---

## 🌐 GitHub Upload — Step by Step

### Step 1 — Create GitHub Account
1. Go to [github.com](https://github.com)
2. Click **Sign Up**
3. Enter email, password, username
4. Verify your email

### Step 2 — Create a New Repository
1. Click the **+** icon (top right) → **New repository**
2. Repository name: `SAP-ABAP-ERP-Project`
3. Description: `SAP ABAP P2P O2C ALV simulation project`
4. Set visibility: **Public**
5. Check ✅ **Add a README file**
6. Click **Create repository**

### Step 3 — Upload Your Files
**Option A — Using GitHub Web (Easiest):**
1. Inside your repository, click **Add file** → **Upload files**
2. Drag and drop all `.abap` files and `README.md`
3. Scroll down, add commit message: `Add SAP ABAP project files`
4. Click **Commit changes**

**Option B — Using Git Commands (Terminal):**
```bash
git clone https://github.com/YOUR_USERNAME/SAP-ABAP-ERP-Project.git
cd SAP-ABAP-ERP-Project
# Copy your files here
git add .
git commit -m "Add SAP ABAP project files"
git push origin main
```

### Step 4 — Verify Upload
1. Go back to your repository page
2. All files should be visible: `ZP2P_PROCESS.abap`, `ZO2C_PROCESS.abap`, `ZALV_REPORT.abap`, `README.md`

### Step 5 — Copy & Share Your Link
1. Copy the URL from your browser:  
   `https://github.com/YOUR_USERNAME/SAP-ABAP-ERP-Project`
2. Share this link for submission ✅

---

## 📦 ZIP Submission — Steps

1. Open your **SAP_Project** folder
2. Select **all files** inside it:
   - `ZP2P_PROCESS.abap`
   - `ZO2C_PROCESS.abap`
   - `ZALV_REPORT.abap`
   - `README.md`
3. **Right-click** → **Compress** (or Send to → Zip)
   - Windows: Right-click → **Send to → Compressed (zipped) folder**
   - Mac: Right-click → **Compress**
4. Rename the ZIP: `SAP_ABAP_Project_[YourName].zip`
5. Submit the ZIP file ✅

---

## 📊 Sample Output Preview

### P2P Process Output:
```
============================================================
   SAP P2P PROCESS SIMULATION - Procure to Pay
============================================================
>>> STEP 1: PURCHASE REQUISITION (PR)
PR-1001   Office Chairs   10   HR Department   Created
PR-1002   Laptops          5   IT Department   Created
** Purchase Requisition Created Successfully! **

>>> STEP 2: PURCHASE ORDER (PO)
PO-2001   ABC Furniture Ltd   Office Chairs   10   2500.00   25000.00
PO-2002   TechWorld Pvt Ltd   Laptops          5  45000.00  225000.00
...
```

### ALV Output:
```
┌──────────┬───────────┬─────────────────────┬───────────────────┬─────┬──────────────┬────────────┬───────────┐
│ Order ID │Order Type │ Customer/Vendor      │ Material/Product  │ Qty │ Amount (INR) │ Order Date │  Status   │
├──────────┼───────────┼─────────────────────┼───────────────────┼─────┼──────────────┼────────────┼───────────┤
│ SO-1001  │ Sales     │ Ramesh Electronics   │ LED Television    │   3 │   105,000.00 │ 18.04.2024 │ Completed │
│ SO-1002  │ Sales     │ Sunita Traders       │ Gaming Laptop     │   2 │   150,000.00 │ 18.04.2024 │ Completed │
│ PO-2001  │ Purchase  │ ABC Furniture Ltd    │ Office Chairs     │  10 │    25,000.00 │ 18.04.2024 │ Paid      │
├──────────┼───────────┼─────────────────────┼───────────────────┼─────┼──────────────┼────────────┼───────────┤
│          │           │                      │            Total  │     │   840,000.00 │            │           │
└──────────┴───────────┴─────────────────────┴───────────────────┴─────┴──────────────┴────────────┴───────────┘
```

---

## 👨‍🎓 About This Project

| Field | Details |
|-------|---------|
| Language | ABAP (Advanced Business Application Programming) |
| SAP Version | Compatible with SAP ECC 6.0 / S/4HANA |
| Transaction | SE38 (ABAP Editor) |
| Level | Beginner / Student |
| Modules | MM, SD, FI |
| Pattern | Simulation (no real DB tables used) |

---

## ⚠️ Notes

- This is a **simulation project** — it uses internal tables (in-memory), not actual SAP database tables
- No real SAP master data is required
- Programs can be run in any SAP system with SE38 access
- Code is intentionally kept simple for learning purposes

---

*Made with ❤️ for SAP ABAP Learning*
