*&---------------------------------------------------------------------*
*& Program Name : ZALV_REPORT
*& Description  : ALV Grid Report - Sales Order Summary
*& Module       : SD (Sales & Distribution)
*& Author       : Student Project
*& Created On   : 2024
*&---------------------------------------------------------------------*
*
*  WHAT IS ALV?
*  ALV = ABAP List Viewer
*  It displays data in a professional GRID format with:
*  - Sorting  - Filtering  - Totals  - Export to Excel
*
*  This report shows: Order ID, Customer Name, Amount
*
*&---------------------------------------------------------------------*

REPORT ZALV_REPORT.

*---------------------------------------------------------------------*
* STEP 1: Include the Function Group for ALV
*---------------------------------------------------------------------*
" These are standard SAP includes needed for ALV
TABLES: sscrfields.    " Screen fields for selection screen

*---------------------------------------------------------------------*
* STEP 2: Define the Output Structure (what columns will appear)
*---------------------------------------------------------------------*

" This structure defines each COLUMN in our ALV report
TYPES: BEGIN OF ty_order_report,
         order_id     TYPE char10,        " Column 1: Order ID
         order_type   TYPE char10,        " Column 2: Order Type (SO/PO)
         customer     TYPE char25,        " Column 3: Customer/Vendor Name
         material     TYPE char25,        " Column 4: Material/Product
         quantity     TYPE i,             " Column 5: Quantity
         amount       TYPE p DECIMALS 2,  " Column 6: Amount (INR)
         order_date   TYPE sy-datum,      " Column 7: Date
         status       TYPE char15,        " Column 8: Status
       END OF ty_order_report.

*---------------------------------------------------------------------*
* STEP 3: Declare Variables
*---------------------------------------------------------------------*

" Internal table to hold report data
DATA: it_report    TYPE TABLE OF ty_order_report,
      wa_report    TYPE ty_order_report.

" ALV Field Catalog - Defines column properties (labels, width, etc.)
DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
      wa_fieldcat  TYPE slis_fieldcat_alv.

" ALV Layout - Controls overall look of the grid
DATA: ls_layout    TYPE slis_layout_alv.

" ALV Title
DATA: lv_title     TYPE lvc_title.

*---------------------------------------------------------------------*
* STEP 4: SELECTION SCREEN (optional filter for user)
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_cust FOR wa_report-customer NO-EXTENSION.
  PARAMETERS: p_type TYPE char10 DEFAULT 'ALL'.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  TEXT-001 = 'Selection Parameters'.

*---------------------------------------------------------------------*
* STEP 5: START OF SELECTION
*---------------------------------------------------------------------*

START-OF-SELECTION.

  " Perform subroutines in order
  PERFORM fill_data.        " 1. Fill data into internal table
  PERFORM build_fieldcat.   " 2. Build field catalog (column definitions)
  PERFORM set_layout.       " 3. Set ALV layout
  PERFORM display_alv.      " 4. Display the ALV report


*&---------------------------------------------------------------------*
*& FORM : FILL_DATA
*& Purpose: Populate internal table with sample sales order data
*&---------------------------------------------------------------------*
FORM fill_data.

  " ---------- Sales Orders (SO) ----------
  wa_report-order_id   = 'SO-1001'.
  wa_report-order_type = 'Sales'.
  wa_report-customer   = 'Ramesh Electronics'.
  wa_report-material   = 'LED Television 55in'.
  wa_report-quantity   = 3.
  wa_report-amount     = 105000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Completed'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  wa_report-order_id   = 'SO-1002'.
  wa_report-order_type = 'Sales'.
  wa_report-customer   = 'Sunita Traders'.
  wa_report-material   = 'Gaming Laptop'.
  wa_report-quantity   = 2.
  wa_report-amount     = 150000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Completed'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  wa_report-order_id   = 'SO-1003'.
  wa_report-order_type = 'Sales'.
  wa_report-customer   = 'Patel Home Appliances'.
  wa_report-material   = 'Washing Machine 8kg'.
  wa_report-quantity   = 5.
  wa_report-amount     = 110000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Completed'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  wa_report-order_id   = 'SO-1004'.
  wa_report-order_type = 'Sales'.
  wa_report-customer   = 'Gupta Mart'.
  wa_report-material   = 'Air Conditioner 1.5T'.
  wa_report-quantity   = 4.
  wa_report-amount     = 180000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Pending'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  " ---------- Purchase Orders (PO) ----------
  wa_report-order_id   = 'PO-2001'.
  wa_report-order_type = 'Purchase'.
  wa_report-customer   = 'ABC Furniture Ltd'.
  wa_report-material   = 'Office Chairs'.
  wa_report-quantity   = 10.
  wa_report-amount     = 25000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Paid'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  wa_report-order_id   = 'PO-2002'.
  wa_report-order_type = 'Purchase'.
  wa_report-customer   = 'TechWorld Pvt Ltd'.
  wa_report-material   = 'Laptops'.
  wa_report-quantity   = 5.
  wa_report-amount     = 225000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Paid'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

  wa_report-order_id   = 'PO-2003'.
  wa_report-order_type = 'Purchase'.
  wa_report-customer   = 'PrintZone Ltd'.
  wa_report-material   = 'Laser Printers'.
  wa_report-quantity   = 3.
  wa_report-amount     = 45000.00.
  wa_report-order_date = sy-datum.
  wa_report-status     = 'Pending'.
  APPEND wa_report TO it_report.
  CLEAR wa_report.

ENDFORM.


*&---------------------------------------------------------------------*
*& FORM : BUILD_FIELDCAT
*& Purpose: Define each column for the ALV grid
*&          (column name, label, width, data type)
*&---------------------------------------------------------------------*
FORM build_fieldcat.

  " --- Column 1: Order ID ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'ORDER_ID'.       " Field in structure
  wa_fieldcat-seltext_m   = 'Order ID'.       " Column header label
  wa_fieldcat-col_pos     = 1.                " Column position
  wa_fieldcat-outputlen   = 10.               " Column width
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 2: Order Type ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'ORDER_TYPE'.
  wa_fieldcat-seltext_m   = 'Order Type'.
  wa_fieldcat-col_pos     = 2.
  wa_fieldcat-outputlen   = 10.
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 3: Customer / Vendor Name ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'CUSTOMER'.
  wa_fieldcat-seltext_m   = 'Customer/Vendor'.
  wa_fieldcat-col_pos     = 3.
  wa_fieldcat-outputlen   = 25.
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 4: Material ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'MATERIAL'.
  wa_fieldcat-seltext_m   = 'Material/Product'.
  wa_fieldcat-col_pos     = 4.
  wa_fieldcat-outputlen   = 22.
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 5: Quantity ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'QUANTITY'.
  wa_fieldcat-seltext_m   = 'Qty'.
  wa_fieldcat-col_pos     = 5.
  wa_fieldcat-outputlen   = 5.
  wa_fieldcat-just        = 'R'.             " Right-align numbers
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 6: Amount (with totals) ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'AMOUNT'.
  wa_fieldcat-seltext_m   = 'Amount (INR)'.
  wa_fieldcat-col_pos     = 6.
  wa_fieldcat-outputlen   = 15.
  wa_fieldcat-do_sum      = 'X'.             " Enable column total
  wa_fieldcat-just        = 'R'.             " Right-align
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 7: Order Date ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'ORDER_DATE'.
  wa_fieldcat-seltext_m   = 'Order Date'.
  wa_fieldcat-col_pos     = 7.
  wa_fieldcat-outputlen   = 10.
  APPEND wa_fieldcat TO it_fieldcat.

  " --- Column 8: Status ---
  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname   = 'STATUS'.
  wa_fieldcat-seltext_m   = 'Status'.
  wa_fieldcat-col_pos     = 8.
  wa_fieldcat-outputlen   = 12.
  APPEND wa_fieldcat TO it_fieldcat.

ENDFORM.


*&---------------------------------------------------------------------*
*& FORM : SET_LAYOUT
*& Purpose: Configure the visual appearance of the ALV grid
*&---------------------------------------------------------------------*
FORM set_layout.

  " Zebra striping (alternate row colors)
  ls_layout-zebra           = 'X'.

  " Show column separator lines
  ls_layout-colsep          = '|'.

  " Enable cell highlighting based on color
  ls_layout-info_fieldname  = ''.

  " Box around the entire grid
  ls_layout-box_fieldname   = ''.

ENDFORM.


*&---------------------------------------------------------------------*
*& FORM : DISPLAY_ALV
*& Purpose: Call the standard SAP function to display ALV
*&---------------------------------------------------------------------*
FORM display_alv.

  " Set the title of the report
  lv_title = 'SAP ERP Order Summary Report - Student Project'.

  " Call standard SAP ALV function module
  " REUSE_ALV_GRID_DISPLAY is the most common ALV function
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid      " Current program name
      i_grid_title       = lv_title      " Title shown on top of grid
      it_fieldcat        = it_fieldcat   " Column definitions
      i_save             = 'A'           " Allow saving layout
      is_layout          = ls_layout     " Layout settings
    TABLES
      t_outtab           = it_report     " Actual data to display
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  " Check if ALV displayed successfully
  IF sy-subrc <> 0.
    WRITE: / 'Error displaying ALV report. Please check configuration.'.
  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* END OF PROGRAM
*---------------------------------------------------------------------*
