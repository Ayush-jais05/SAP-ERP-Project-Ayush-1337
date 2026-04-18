*&---------------------------------------------------------------------*
*& Program Name : ZP2P_PROCESS
*& Description  : Procure-to-Pay (P2P) Process Simulation
*& Modules      : MM (Materials Management) + FI (Financial Accounting)
*& Author       : Student Project
*& Created On   : 2024
*&---------------------------------------------------------------------*
*
*  PROCESS FLOW:
*  1. Purchase Requisition (PR)  --> Request to buy goods
*  2. Purchase Order (PO)        --> Official order to vendor
*  3. Goods Receipt (GR)         --> Goods received in warehouse
*  4. Invoice Verification       --> Vendor sends bill
*  5. Payment                    --> Company pays vendor
*
*&---------------------------------------------------------------------*

REPORT ZP2P_PROCESS.

*---------------------------------------------------------------------*
* STEP 1: Define Data Types (Structures)
*---------------------------------------------------------------------*

" Structure for Purchase Requisition
TYPES: BEGIN OF ty_purchase_req,
         pr_number   TYPE char10,     " PR Number
         material    TYPE char20,     " Material Name
         quantity    TYPE i,          " Quantity Required
         department  TYPE char20,     " Department Name
         status      TYPE char10,     " Status of PR
       END OF ty_purchase_req.

" Structure for Purchase Order
TYPES: BEGIN OF ty_purchase_order,
         po_number   TYPE char10,     " PO Number
         pr_number   TYPE char10,     " Linked PR Number
         vendor      TYPE char20,     " Vendor Name
         material    TYPE char20,     " Material Name
         quantity    TYPE i,          " Ordered Quantity
         unit_price  TYPE p DECIMALS 2,  " Price per unit
         total_amt   TYPE p DECIMALS 2,  " Total Amount
         status      TYPE char10,     " Status
       END OF ty_purchase_order.

" Structure for Goods Receipt
TYPES: BEGIN OF ty_goods_receipt,
         gr_number   TYPE char10,     " GR Number
         po_number   TYPE char10,     " Linked PO Number
         material    TYPE char20,     " Material Name
         qty_recv    TYPE i,          " Quantity Received
         recv_date   TYPE sy-datum,   " Date of Receipt
         status      TYPE char10,     " Status
       END OF ty_goods_receipt.

" Structure for Invoice
TYPES: BEGIN OF ty_invoice,
         inv_number  TYPE char10,     " Invoice Number
         po_number   TYPE char10,     " Linked PO Number
         vendor      TYPE char20,     " Vendor Name
         amount      TYPE p DECIMALS 2,  " Invoice Amount
         inv_date    TYPE sy-datum,   " Invoice Date
         status      TYPE char10,     " Status
       END OF ty_invoice.

" Structure for Payment
TYPES: BEGIN OF ty_payment,
         pay_number  TYPE char10,     " Payment Number
         inv_number  TYPE char10,     " Linked Invoice Number
         vendor      TYPE char20,     " Vendor Name
         amount_paid TYPE p DECIMALS 2,  " Amount Paid
         pay_date    TYPE sy-datum,   " Payment Date
         status      TYPE char10,     " Status
       END OF ty_payment.

*---------------------------------------------------------------------*
* STEP 2: Declare Internal Tables and Work Areas
*---------------------------------------------------------------------*

DATA: it_pr      TYPE TABLE OF ty_purchase_req,   " PR Table
      wa_pr      TYPE ty_purchase_req,             " PR Work Area

      it_po      TYPE TABLE OF ty_purchase_order,  " PO Table
      wa_po      TYPE ty_purchase_order,           " PO Work Area

      it_gr      TYPE TABLE OF ty_goods_receipt,   " GR Table
      wa_gr      TYPE ty_goods_receipt,            " GR Work Area

      it_inv     TYPE TABLE OF ty_invoice,         " Invoice Table
      wa_inv     TYPE ty_invoice,                  " Invoice Work Area

      it_pay     TYPE TABLE OF ty_payment,         " Payment Table
      wa_pay     TYPE ty_payment.                  " Payment Work Area

*---------------------------------------------------------------------*
* STEP 3: START OF SELECTION (Main Program Execution)
*---------------------------------------------------------------------*

START-OF-SELECTION.

  " Print Program Header
  WRITE: /1 '============================================================'.
  WRITE: /1 '   SAP P2P PROCESS SIMULATION - Procure to Pay'.
  WRITE: /1 '   Module: MM + FI'.
  WRITE: /1 '============================================================'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 1: Create Purchase Requisition
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 1: PURCHASE REQUISITION (PR)'.
  WRITE: /1 '------------------------------------------------------------'.

  " Fill work area with PR data
  wa_pr-pr_number  = 'PR-1001'.
  wa_pr-material   = 'Office Chairs'.
  wa_pr-quantity   = 10.
  wa_pr-department = 'HR Department'.
  wa_pr-status     = 'Created'.

  " Append to internal table
  APPEND wa_pr TO it_pr.
  CLEAR wa_pr.

  " Second PR entry
  wa_pr-pr_number  = 'PR-1002'.
  wa_pr-material   = 'Laptops'.
  wa_pr-quantity   = 5.
  wa_pr-department = 'IT Department'.
  wa_pr-status     = 'Created'.
  APPEND wa_pr TO it_pr.
  CLEAR wa_pr.

  " Display PR Records
  WRITE: /3 'PR Number   Material         Qty   Department      Status'.
  WRITE: /3 '--------   --------         ---   ----------      ------'.

  LOOP AT it_pr INTO wa_pr.
    WRITE: /3 wa_pr-pr_number,
            15 wa_pr-material,
            35 wa_pr-quantity,
            42 wa_pr-department,
            60 wa_pr-status.
  ENDLOOP.

  WRITE: /3 '** Purchase Requisition Created Successfully! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 2: Create Purchase Order
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 2: PURCHASE ORDER (PO)'.
  WRITE: /1 '------------------------------------------------------------'.

  " PO for PR-1001
  wa_po-po_number  = 'PO-2001'.
  wa_po-pr_number  = 'PR-1001'.
  wa_po-vendor     = 'ABC Furniture Ltd'.
  wa_po-material   = 'Office Chairs'.
  wa_po-quantity   = 10.
  wa_po-unit_price = 2500.00.
  wa_po-total_amt  = wa_po-quantity * wa_po-unit_price.
  wa_po-status     = 'Open'.
  APPEND wa_po TO it_po.
  CLEAR wa_po.

  " PO for PR-1002
  wa_po-po_number  = 'PO-2002'.
  wa_po-pr_number  = 'PR-1002'.
  wa_po-vendor     = 'TechWorld Pvt Ltd'.
  wa_po-material   = 'Laptops'.
  wa_po-quantity   = 5.
  wa_po-unit_price = 45000.00.
  wa_po-total_amt  = wa_po-quantity * wa_po-unit_price.
  wa_po-status     = 'Open'.
  APPEND wa_po TO it_po.
  CLEAR wa_po.

  " Display PO Records
  WRITE: /3 'PO Number   Vendor              Material       Qty  Unit Price   Total Amt'.
  WRITE: /3 '---------   ------              --------       ---  ----------   ---------'.

  LOOP AT it_po INTO wa_po.
    WRITE: /3 wa_po-po_number,
            13 wa_po-vendor,
            34 wa_po-material,
            50 wa_po-quantity,
            55 wa_po-unit_price,
            70 wa_po-total_amt.
  ENDLOOP.

  WRITE: /3 '** Purchase Order Created & Sent to Vendor! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 3: Goods Receipt
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 3: GOODS RECEIPT (GR)'.
  WRITE: /1 '------------------------------------------------------------'.

  " GR for PO-2001
  wa_gr-gr_number  = 'GR-3001'.
  wa_gr-po_number  = 'PO-2001'.
  wa_gr-material   = 'Office Chairs'.
  wa_gr-qty_recv   = 10.
  wa_gr-recv_date  = sy-datum.
  wa_gr-status     = 'Received'.
  APPEND wa_gr TO it_gr.
  CLEAR wa_gr.

  " GR for PO-2002
  wa_gr-gr_number  = 'GR-3002'.
  wa_gr-po_number  = 'PO-2002'.
  wa_gr-material   = 'Laptops'.
  wa_gr-qty_recv   = 5.
  wa_gr-recv_date  = sy-datum.
  wa_gr-status     = 'Received'.
  APPEND wa_gr TO it_gr.
  CLEAR wa_gr.

  " Display GR Records
  WRITE: /3 'GR Number   PO Number   Material       Qty  Recv Date   Status'.
  WRITE: /3 '---------   ---------   --------       ---  ---------   ------'.

  LOOP AT it_gr INTO wa_gr.
    WRITE: /3 wa_gr-gr_number,
            13 wa_gr-po_number,
            24 wa_gr-material,
            40 wa_gr-qty_recv,
            45 wa_gr-recv_date,
            57 wa_gr-status.
  ENDLOOP.

  WRITE: /3 '** Goods Received & Updated in Inventory (MM)! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 4: Invoice Verification (FI)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 4: INVOICE VERIFICATION (FI)'.
  WRITE: /1 '------------------------------------------------------------'.

  " Invoice from vendor for PO-2001
  wa_inv-inv_number = 'INV-4001'.
  wa_inv-po_number  = 'PO-2001'.
  wa_inv-vendor     = 'ABC Furniture Ltd'.
  wa_inv-amount     = 25000.00.
  wa_inv-inv_date   = sy-datum.
  wa_inv-status     = 'Verified'.
  APPEND wa_inv TO it_inv.
  CLEAR wa_inv.

  " Invoice from vendor for PO-2002
  wa_inv-inv_number = 'INV-4002'.
  wa_inv-po_number  = 'PO-2002'.
  wa_inv-vendor     = 'TechWorld Pvt Ltd'.
  wa_inv-amount     = 225000.00.
  wa_inv-inv_date   = sy-datum.
  wa_inv-status     = 'Verified'.
  APPEND wa_inv TO it_inv.
  CLEAR wa_inv.

  " Display Invoice Records
  WRITE: /3 'Invoice No   PO Number   Vendor              Amount      Inv Date   Status'.
  WRITE: /3 '----------   ---------   ------              ------      --------   ------'.

  LOOP AT it_inv INTO wa_inv.
    WRITE: /3 wa_inv-inv_number,
            14 wa_inv-po_number,
            25 wa_inv-vendor,
            46 wa_inv-amount,
            60 wa_inv-inv_date,
            72 wa_inv-status.
  ENDLOOP.

  WRITE: /3 '** Invoice Verified - Accounting Document Posted (FI)! **'.
  SKIP.

*---------------------------------------------------------------------*
* PROCESS STEP 5: Payment to Vendor (FI)
*---------------------------------------------------------------------*
  WRITE: /1 '>>> STEP 5: PAYMENT TO VENDOR (FI)'.
  WRITE: /1 '------------------------------------------------------------'.

  " Payment for INV-4001
  wa_pay-pay_number  = 'PAY-5001'.
  wa_pay-inv_number  = 'INV-4001'.
  wa_pay-vendor      = 'ABC Furniture Ltd'.
  wa_pay-amount_paid = 25000.00.
  wa_pay-pay_date    = sy-datum.
  wa_pay-status      = 'Paid'.
  APPEND wa_pay TO it_pay.
  CLEAR wa_pay.

  " Payment for INV-4002
  wa_pay-pay_number  = 'PAY-5002'.
  wa_pay-inv_number  = 'INV-4002'.
  wa_pay-vendor      = 'TechWorld Pvt Ltd'.
  wa_pay-amount_paid = 225000.00.
  wa_pay-pay_date    = sy-datum.
  wa_pay-status      = 'Paid'.
  APPEND wa_pay TO it_pay.
  CLEAR wa_pay.

  " Display Payment Records
  WRITE: /3 'Pay Number   Invoice No   Vendor              Amount Paid   Pay Date   Status'.
  WRITE: /3 '----------   ----------   ------              -----------   --------   ------'.

  LOOP AT it_pay INTO wa_pay.
    WRITE: /3 wa_pay-pay_number,
            14 wa_pay-inv_number,
            26 wa_pay-vendor,
            47 wa_pay-amount_paid,
            62 wa_pay-pay_date,
            74 wa_pay-status.
  ENDLOOP.

  WRITE: /3 '** Payment Cleared - Vendor Account Updated (FI)! **'.
  SKIP.

*---------------------------------------------------------------------*
* FINAL SUMMARY
*---------------------------------------------------------------------*
  WRITE: /1 '============================================================'.
  WRITE: /1 '   P2P PROCESS SUMMARY'.
  WRITE: /1 '============================================================'.
  WRITE: /3 'Total Purchase Requisitions : 2'.
  WRITE: /3 'Total Purchase Orders       : 2'.
  WRITE: /3 'Total Goods Receipts        : 2'.
  WRITE: /3 'Total Invoices Verified     : 2'.
  WRITE: /3 'Total Payments Made         : 2'.
  WRITE: /3 'Total Amount Paid           : INR 2,50,000'.
  SKIP.
  WRITE: /1 '** Procure-to-Pay (P2P) Process Completed Successfully! **'.
  WRITE: /1 '============================================================'.
