*&---------------------------------------------------------------------*
*& Program Name : ZO2C_PROCESS
*& Description  : Order-to-Cash (O2C) Process Simulation
*& Modules      : SD (Sales & Distribution) + FI (Financial Accounting)
*& Author       : Student Project
*& Created On   : 2024
*&---------------------------------------------------------------------*
*
*  PROCESS FLOW:
*  1. Sales Order (SO)    --> Customer places order
*  2. Delivery            --> Goods packed and shipped
*  3. Billing (Invoice)   --> Bill sent to customer
*  4. Payment Receipt     --> Customer pays the bill
*
*&---------------------------------------------------------------------*

REPORT ZO2C_PROCESS.

*---------------------------------------------------------------------*
* STEP 1: Define Data Types (Structures)
*---------------------------------------------------------------------*

" Structure for Sales Order
TYPES: BEGIN OF ty_sales_order,
         so_number   TYPE char10,          " Sales Order Number
         customer    TYPE char25,          " Customer Name
         material    TYPE char20,          " Product/Material
         quantity    TYPE i,               " Ordered Quantity
         unit_price  TYPE p DECIMALS 2,    " Price per Unit
         total_amt   TYPE p DECIMALS 2,    " Total Order Amount
         order_date  TYPE sy-datum,        " Date of Order
         status      TYPE char15,          " Order Status
       END OF ty_sales_order.

" Structure for Delivery
TYPES: BEGIN OF ty_delivery,
         del_number  TYPE char10,          " Delivery Number
         so_number   TYPE char10,          " Linked Sales Order
         customer    TYPE char25,          " Customer Name
         material    TYPE char20,          " Material Delivered
         qty_shipped TYPE i,               " Shipped Quantity
         ship_date   TYPE sy-datum,        " Shipping Date
         status      TYPE char15,          " Delivery Status
       END OF ty_delivery.

" Structure for Billing Document
TYPES: BEGIN OF ty_billing,
         bill_number TYPE char10,          " Billing Document Number
         so_number   TYPE char10,          " Linked Sales Order
         del_number  TYPE char10,          " Linked Delivery
         customer    TYPE char25,          " Customer Name
         amount      TYPE p DECIMALS 2,    " Billed Amount
         bill_date   TYPE sy-datum,        " Billing Date
         due_date    TYPE sy-datum,        " Payment Due Date
         status      TYPE char15,          " Billing Status
       END OF ty_billing.

" Structure for Payment Receipt
TYPES: BEGIN OF ty_payment,
         rcpt_number TYPE char10,          " Receipt Number
         bill_number TYPE char10,          " Linked Billing Doc
         customer    TYPE char25,          " Customer Name
         amount_recv TYPE p DECIMALS 2,    " Amount Received
         recv_date   TYPE sy-datum,        " Receipt Date
         pay_method  TYPE char15,          " Payment Method
         status      TYPE char15,          " Payment Status
       END OF ty_payment.

*---------------------------------------------------------------------*
* STEP 2: Declare Internal Tables and Work Areas
*---------------------------------------------------------------------*

DATA: it_so      TYPE TABLE OF ty_sales_order,   " Sales Order Table
      wa_so      TYPE ty_sales_order,             " Sales Order Work Area

      it_del     TYPE TABLE OF ty_delivery,       " Delivery Table
      wa_del     TYPE ty_delivery,                " Delivery Work Area

      it_bill    TYPE TABLE OF ty_billing,        " Billing Table
      wa_bill    TYPE ty_billing,                 " Billing Work Area

      it_pay     TYPE TABLE OF ty_payment,        " Payment Table
      wa_pay     TYPE ty_payment.                 " Payment Work Area

" Variable for calculating due date (30 days credit period)
DATA: lv_due_date TYPE sy-datum.

*---------------------------------------------------------------------*
* STEP 3: START OF SELECTION (Main Program Execution)
*---------------------------------------------------------------------*

START-OF-SELECTION.

  " Print Program Header
  WRITE: /1 '============================================================'.
  WRITE: /1 '   SAP O2C PROCESS SIMULATION - Order to Cash'.
  WRITE: /1 '   Module: SD + FI'.
  WRITE: /1 '============================================================'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 1: Create Sales Order (SD)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 1: SALES ORDER (SO)'.
  WRITE: /1 '------------------------------------------------------------'.

  " Sales Order 1 - Customer buys TV
  wa_so-so_number  = 'SO-1001'.
  wa_so-customer   = 'Ramesh Electronics'.
  wa_so-material   = 'LED Television 55in'.
  wa_so-quantity   = 3.
  wa_so-unit_price = 35000.00.
  wa_so-total_amt  = wa_so-quantity * wa_so-unit_price.
  wa_so-order_date = sy-datum.
  wa_so-status     = 'Open'.
  APPEND wa_so TO it_so.
  CLEAR wa_so.

  " Sales Order 2 - Customer buys Laptops
  wa_so-so_number  = 'SO-1002'.
  wa_so-customer   = 'Sunita Traders'.
  wa_so-material   = 'Gaming Laptop'.
  wa_so-quantity   = 2.
  wa_so-unit_price = 75000.00.
  wa_so-total_amt  = wa_so-quantity * wa_so-unit_price.
  wa_so-order_date = sy-datum.
  wa_so-status     = 'Open'.
  APPEND wa_so TO it_so.
  CLEAR wa_so.

  " Sales Order 3 - Customer buys Washing Machine
  wa_so-so_number  = 'SO-1003'.
  wa_so-customer   = 'Patel Home Appliances'.
  wa_so-material   = 'Washing Machine 8kg'.
  wa_so-quantity   = 5.
  wa_so-unit_price = 22000.00.
  wa_so-total_amt  = wa_so-quantity * wa_so-unit_price.
  wa_so-order_date = sy-datum.
  wa_so-status     = 'Open'.
  APPEND wa_so TO it_so.
  CLEAR wa_so.

  " Display Sales Order Records
  WRITE: /3 'SO Number   Customer               Material             Qty  Unit Price    Total Amt'.
  WRITE: /3 '---------   --------               --------             ---  ----------    ---------'.

  LOOP AT it_so INTO wa_so.
    WRITE: /3 wa_so-so_number,
            13 wa_so-customer,
            38 wa_so-material,
            58 wa_so-quantity,
            63 wa_so-unit_price,
            78 wa_so-total_amt.
  ENDLOOP.

  WRITE: /3 '** Sales Orders Created & Confirmed! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 2: Create Delivery (SD)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 2: DELIVERY'.
  WRITE: /1 '------------------------------------------------------------'.

  " Delivery for SO-1001
  wa_del-del_number  = 'DEL-2001'.
  wa_del-so_number   = 'SO-1001'.
  wa_del-customer    = 'Ramesh Electronics'.
  wa_del-material    = 'LED Television 55in'.
  wa_del-qty_shipped = 3.
  wa_del-ship_date   = sy-datum.
  wa_del-status      = 'Shipped'.
  APPEND wa_del TO it_del.
  CLEAR wa_del.

  " Delivery for SO-1002
  wa_del-del_number  = 'DEL-2002'.
  wa_del-so_number   = 'SO-1002'.
  wa_del-customer    = 'Sunita Traders'.
  wa_del-material    = 'Gaming Laptop'.
  wa_del-qty_shipped = 2.
  wa_del-ship_date   = sy-datum.
  wa_del-status      = 'Shipped'.
  APPEND wa_del TO it_del.
  CLEAR wa_del.

  " Delivery for SO-1003
  wa_del-del_number  = 'DEL-2003'.
  wa_del-so_number   = 'SO-1003'.
  wa_del-customer    = 'Patel Home Appliances'.
  wa_del-material    = 'Washing Machine 8kg'.
  wa_del-qty_shipped = 5.
  wa_del-ship_date   = sy-datum.
  wa_del-status      = 'Shipped'.
  APPEND wa_del TO it_del.
  CLEAR wa_del.

  " Display Delivery Records
  WRITE: /3 'Del Number   SO Number   Customer               Material             Qty  Ship Date   Status'.
  WRITE: /3 '----------   ---------   --------               --------             ---  ---------   ------'.

  LOOP AT it_del INTO wa_del.
    WRITE: /3 wa_del-del_number,
            14 wa_del-so_number,
            25 wa_del-customer,
            47 wa_del-material,
            67 wa_del-qty_shipped,
            72 wa_del-ship_date,
            84 wa_del-status.
  ENDLOOP.

  WRITE: /3 '** Goods Picked, Packed & Shipped to Customer! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 3: Billing / Customer Invoice (SD + FI)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 3: BILLING DOCUMENT'.
  WRITE: /1 '------------------------------------------------------------'.

  " Calculate due date: today + 30 days credit
  lv_due_date = sy-datum + 30.

  " Billing for DEL-2001
  wa_bill-bill_number = 'BILL-3001'.
  wa_bill-so_number   = 'SO-1001'.
  wa_bill-del_number  = 'DEL-2001'.
  wa_bill-customer    = 'Ramesh Electronics'.
  wa_bill-amount      = 105000.00.
  wa_bill-bill_date   = sy-datum.
  wa_bill-due_date    = lv_due_date.
  wa_bill-status      = 'Posted'.
  APPEND wa_bill TO it_bill.
  CLEAR wa_bill.

  " Billing for DEL-2002
  wa_bill-bill_number = 'BILL-3002'.
  wa_bill-so_number   = 'SO-1002'.
  wa_bill-del_number  = 'DEL-2002'.
  wa_bill-customer    = 'Sunita Traders'.
  wa_bill-amount      = 150000.00.
  wa_bill-bill_date   = sy-datum.
  wa_bill-due_date    = lv_due_date.
  wa_bill-status      = 'Posted'.
  APPEND wa_bill TO it_bill.
  CLEAR wa_bill.

  " Billing for DEL-2003
  wa_bill-bill_number = 'BILL-3003'.
  wa_bill-so_number   = 'SO-1003'.
  wa_bill-del_number  = 'DEL-2003'.
  wa_bill-customer    = 'Patel Home Appliances'.
  wa_bill-amount      = 110000.00.
  wa_bill-bill_date   = sy-datum.
  wa_bill-due_date    = lv_due_date.
  wa_bill-status      = 'Posted'.
  APPEND wa_bill TO it_bill.
  CLEAR wa_bill.

  " Display Billing Records
  WRITE: /3 'Bill No     SO Number   Customer               Amount      Bill Date   Due Date    Status'.
  WRITE: /3 '-------     ---------   --------               ------      ---------   --------    ------'.

  LOOP AT it_bill INTO wa_bill.
    WRITE: /3 wa_bill-bill_number,
            13 wa_bill-so_number,
            24 wa_bill-customer,
            47 wa_bill-amount,
            61 wa_bill-bill_date,
            73 wa_bill-due_date,
            85 wa_bill-status.
  ENDLOOP.

  WRITE: /3 '** Billing Documents Created - AR Posted in FI! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 4: Payment Receipt (FI)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 4: PAYMENT RECEIPT (FI)'.
  WRITE: /1 '------------------------------------------------------------'.

  " Payment from Ramesh Electronics
  wa_pay-rcpt_number = 'RCP-4001'.
  wa_pay-bill_number = 'BILL-3001'.
  wa_pay-customer    = 'Ramesh Electronics'.
  wa_pay-amount_recv = 105000.00.
  wa_pay-recv_date   = sy-datum.
  wa_pay-pay_method  = 'Bank Transfer'.
  wa_pay-status      = 'Cleared'.
  APPEND wa_pay TO it_pay.
  CLEAR wa_pay.

  " Payment from Sunita Traders
  wa_pay-rcpt_number = 'RCP-4002'.
  wa_pay-bill_number = 'BILL-3002'.
  wa_pay-customer    = 'Sunita Traders'.
  wa_pay-amount_recv = 150000.00.
  wa_pay-recv_date   = sy-datum.
  wa_pay-pay_method  = 'Cheque'.
  wa_pay-status      = 'Cleared'.
  APPEND wa_pay TO it_pay.
  CLEAR wa_pay.

  " Payment from Patel Home Appliances
  wa_pay-rcpt_number = 'RCP-4003'.
  wa_pay-bill_number = 'BILL-3003'.
  wa_pay-customer    = 'Patel Home Appliances'.
  wa_pay-amount_recv = 110000.00.
  wa_pay-recv_date   = sy-datum.
  wa_pay-pay_method  = 'Online'.
  wa_pay-status      = 'Cleared'.
  APPEND wa_pay TO it_pay.
  CLEAR wa_pay.

  " Display Payment Records
  WRITE: /3 'Receipt No   Bill No     Customer               Amount Recv   Pay Method     Status'.
  WRITE: /3 '----------   -------     --------               -----------   ----------     ------'.

  LOOP AT it_pay INTO wa_pay.
    WRITE: /3 wa_pay-rcpt_number,
            14 wa_pay-bill_number,
            26 wa_pay-customer,
            49 wa_pay-amount_recv,
            64 wa_pay-pay_method,
            80 wa_pay-status.
  ENDLOOP.

  WRITE: /3 '** Payments Received - Customer Accounts Cleared (FI)! **'.
  SKIP.

*---------------------------------------------------------------------*
* FINAL SUMMARY
*---------------------------------------------------------------------*
  WRITE: /1 '============================================================'.
  WRITE: /1 '   O2C PROCESS SUMMARY'.
  WRITE: /1 '============================================================'.
  WRITE: /3 'Total Sales Orders Created  : 3'.
  WRITE: /3 'Total Deliveries Shipped    : 3'.
  WRITE: /3 'Total Billing Documents     : 3'.
  WRITE: /3 'Total Payments Received     : 3'.
  WRITE: /3 'Total Revenue Generated     : INR 3,65,000'.
  SKIP.
  WRITE: /3 'Revenue Breakdown:'.
  WRITE: /3 '  Ramesh Electronics        : INR 1,05,000'.
  WRITE: /3 '  Sunita Traders            : INR 1,50,000'.
  WRITE: /3 '  Patel Home Appliances     : INR 1,10,000'.
  SKIP.
  WRITE: /1 '** Order-to-Cash (O2C) Process Completed Successfully! **'.
  WRITE: /1 '============================================================'.
