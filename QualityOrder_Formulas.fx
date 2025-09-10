// PowerFx Formula Examples for Quality Order Display Issue
// This file contains example formulas to resolve the data type conversion error

// ============================================================================
// PROBLEM: "Quality Order #: " & Text(ListViewQO.Selected.Title)
// ERROR: The value 'Quality Order #: 000016' cannot be converted to a number
// ============================================================================

// SOLUTION 1: Separate Display and Data Formulas
// ----------------------------------------------

// For Label Controls (Display Only):
DisplayFormula = "Quality Order #: " & Text(ListViewQO.Selected.Title);

// For Numeric Operations (Data Only):
NumericValue = Value(ListViewQO.Selected.Title);

// SOLUTION 2: Safe Display with Error Handling
// --------------------------------------------

SafeDisplayFormula = If(
    IsBlank(ListViewQO.Selected.Title),
    "No Quality Order Selected",
    "Quality Order #: " & Text(ListViewQO.Selected.Title)
);

// SOLUTION 3: Validated Numeric Conversion
// ----------------------------------------

SafeNumericValue = If(
    IsNumeric(ListViewQO.Selected.Title),
    Value(ListViewQO.Selected.Title),
    0
);

// SOLUTION 4: Complete Error-Resistant Pattern
// --------------------------------------------

CompleteDisplayFormula = If(
    IsBlank(ListViewQO.Selected),
    "No selection made",
    If(
        IsBlank(ListViewQO.Selected.Title),
        "Quality Order: No Title",
        If(
            IsNumeric(ListViewQO.Selected.Title),
            "Quality Order #: " & Text(Value(ListViewQO.Selected.Title)),
            "Quality Order #: " & Text(ListViewQO.Selected.Title)
        )
    )
);

// SOLUTION 5: Using Variables for Better Performance
// --------------------------------------------------

// In App.OnStart or Screen.OnVisible:
Set(SelectedQO, ListViewQO.Selected);
Set(QOTitle, Coalesce(SelectedQO.Title, ""));
Set(QODisplay, If(IsBlank(QOTitle), "No Quality Order", "Quality Order #: " & Text(QOTitle)));
Set(QONumber, If(IsNumeric(QOTitle), Value(QOTitle), 0));

// Then use:
// - QODisplay for labels and text displays
// - QONumber for calculations and numeric operations

// ADVANCED PATTERNS
// =================

// Pattern 1: Extract numeric part from mixed text
ExtractNumericFromText = Value(
    Regex(
        ListViewQO.Selected.Title,
        "\d+",
        "g"
    ).FullMatch
);

// Pattern 2: Format number with leading zeros
FormatWithLeadingZeros = Text(
    Value(ListViewQO.Selected.Title),
    "000000"
);

// Pattern 3: Validate and format in one formula
ValidateAndFormat = If(
    IsNumeric(ListViewQO.Selected.Title),
    "Quality Order #: " & Text(Value(ListViewQO.Selected.Title), "000000"),
    "Invalid Quality Order: " & Text(ListViewQO.Selected.Title)
);

// TESTING EXAMPLES
// ================

// Test with these sample values:
// - "000016" → Should display "Quality Order #: 000016" and convert to 16
// - "" → Should display "No Quality Order Selected" and convert to 0  
// - "ABC123" → Should display "Quality Order #: ABC123" and convert to 0
// - null → Should display "No selection made" and convert to 0

// CONTROL PROPERTY ASSIGNMENTS
// ============================

// Label1.Text (Display):
Label1Text = "Quality Order #: " & Text(Coalesce(ListViewQO.Selected.Title, "N/A"));

// Button1.OnSelect (Action with numeric value):
Button1OnSelect = If(
    IsNumeric(ListViewQO.Selected.Title),
    Navigate(DetailsScreen, ScreenTransition.Fade, {QONumber: Value(ListViewQO.Selected.Title)}),
    Notify("Please select a valid Quality Order", NotificationType.Warning)
);

// Gallery1.Items (Filter based on numeric comparison):
Gallery1Items = Filter(
    QualityOrders,
    Value(ID) > Value(Coalesce(ListViewQO.Selected.Title, "0"))
);