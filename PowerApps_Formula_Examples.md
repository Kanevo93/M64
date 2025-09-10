# PowerApps Formula Examples and Solutions

## Quality Order Number Conversion Issue

### Problematic Formula
```powerfx
"Quality Order #: " & Text(ListViewQO.Selected.Title)
```

**Problem:** This creates a string like "Quality Order #: 000016" which cannot be converted to a number.

### Solutions

#### Solution 1: Separate Display and Data Formulas

**For Display (Label.Text property):**
```powerfx
"Quality Order #: " & Text(ListViewQO.Selected.Title)
```

**For Data Operations (where numeric value is needed):**
```powerfx
Value(ListViewQO.Selected.Title)
```

#### Solution 2: Extract Numeric Value Only

**If you need the numeric part of the Quality Order:**
```powerfx
Value(ListViewQO.Selected.Title)
```

**If the Title contains non-numeric characters, use:**
```powerfx
Value(
    Regex(
        ListViewQO.Selected.Title,
        "\d+",
        "g"
    ).FullMatch
)
```

#### Solution 3: Conditional Display with Validation

**Safe display formula with error handling:**
```powerfx
If(
    IsNumeric(ListViewQO.Selected.Title),
    "Quality Order #: " & Text(Value(ListViewQO.Selected.Title)),
    "Quality Order #: " & Text(ListViewQO.Selected.Title)
)
```

#### Solution 4: Using Variables for Better Control

**In an OnSelect or OnChange event:**
```powerfx
Set(QualityOrderDisplay, "Quality Order #: " & Text(ListViewQO.Selected.Title));
Set(QualityOrderNumber, Value(ListViewQO.Selected.Title))
```

**Then use:**
- `QualityOrderDisplay` for labels and display
- `QualityOrderNumber` for calculations and numeric operations

### Data Type Best Practices

1. **Always use Text() for display concatenation**
2. **Always use Value() for numeric operations**
3. **Validate data types before operations using IsNumeric()**
4. **Separate display logic from business logic**

### Common Patterns

#### Pattern 1: Safe String Concatenation
```powerfx
// For displaying formatted text
"Quality Order #: " & Text(Coalesce(ListViewQO.Selected.Title, "N/A"))
```

#### Pattern 2: Safe Numeric Conversion
```powerfx
// For numeric operations
If(
    IsNumeric(ListViewQO.Selected.Title),
    Value(ListViewQO.Selected.Title),
    0
)
```

#### Pattern 3: Error-Resistant Display
```powerfx
// Combines both approaches with error handling
If(
    IsBlank(ListViewQO.Selected.Title),
    "No Quality Order Selected",
    If(
        IsNumeric(ListViewQO.Selected.Title),
        "Quality Order #: " & Text(Value(ListViewQO.Selected.Title)),
        "Quality Order #: " & Text(ListViewQO.Selected.Title)
    )
)
```

### Testing Your Formulas

To test if your formula works correctly:

1. **Test with valid numeric titles**: "000016", "12345"
2. **Test with invalid/blank titles**: "", "ABC123", null
3. **Test edge cases**: "0", "000000", very large numbers

### Related Functions

- `Text()` - Converts any value to text
- `Value()` - Converts text to number
- `IsNumeric()` - Checks if text can be converted to number
- `IsBlank()` - Checks for blank/empty values
- `Coalesce()` - Returns first non-blank value
- `Regex()` - Pattern matching for complex text extraction