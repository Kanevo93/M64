# PowerApps Troubleshooting Guide

## Common Data Type Conversion Errors

### Error: "The value 'Quality Order #: 000016' cannot be converted to a number"

**Symptoms:**
- Error occurs when using concatenated strings in numeric contexts
- App crashes or shows error when selecting items from ListView
- Formulas work in some contexts but fail in others

**Diagnosis Steps:**
1. Identify where the concatenated string is being used
2. Check if the formula result is being passed to a numeric function
3. Verify data types in your data source
4. Check for implicit type conversions

**Quick Fixes:**
1. **Use separate formulas for display vs. data operations**
2. **Add type validation before operations**
3. **Use explicit conversion functions (Text/Value)**

### Error: "Invalid argument type"

**Common Causes:**
- Passing text to numeric functions
- Using numbers where text is expected
- Mixing data types in calculations

**Solutions:**
- Use `Text()` to convert numbers to text
- Use `Value()` to convert text to numbers
- Use `IsNumeric()` to validate before conversion

### Error: "Name isn't valid"

**Common Causes:**
- Referencing controls that don't exist
- Typos in control names
- Scope issues with variables

**Solutions:**
- Double-check control names
- Use IntelliSense suggestions
- Verify control is in the correct scope

## Best Practices

### 1. Data Type Consistency
- Always be explicit about data types
- Use conversion functions when needed
- Validate data before operations

### 2. Error Handling
- Use `IfError()` for graceful error handling
- Provide fallback values for invalid data
- Test with various data scenarios

### 3. Performance
- Avoid unnecessary type conversions
- Cache converted values in variables
- Use efficient lookup patterns

### 4. Debugging
- Use labels to display intermediate values
- Break complex formulas into steps
- Test formulas in isolation

## Debugging Techniques

### 1. Formula Breakdown
Instead of:
```powerfx
SomeComplexFunction("Quality Order #: " & Text(ListViewQO.Selected.Title))
```

Use:
```powerfx
Set(DebugDisplay, "Quality Order #: " & Text(ListViewQO.Selected.Title));
Set(DebugValue, Value(ListViewQO.Selected.Title));
// Then use DebugDisplay for display and DebugValue for calculations
```

### 2. Type Checking
Add debug labels to show data types:
```powerfx
"Type: " & TypeOf(ListViewQO.Selected.Title) & " Value: " & Text(ListViewQO.Selected.Title)
```

### 3. Step-by-Step Validation
```powerfx
If(IsBlank(ListViewQO.Selected),
    "No selection",
    If(IsBlank(ListViewQO.Selected.Title),
        "No title",
        If(IsNumeric(ListViewQO.Selected.Title),
            "Numeric: " & Text(Value(ListViewQO.Selected.Title)),
            "Text: " & Text(ListViewQO.Selected.Title)
        )
    )
)
```

## Prevention Strategies

### 1. Schema Design
- Use appropriate data types in data sources
- Include validation rules
- Document expected formats

### 2. Formula Standards
- Establish naming conventions
- Create reusable formulas as components
- Document complex formulas

### 3. Testing
- Test with edge cases
- Validate all user input scenarios
- Include error scenarios in testing

## Quick Reference

### Safe Type Conversions
```powerfx
// Text to Number (safe)
If(IsNumeric(TextValue), Value(TextValue), 0)

// Number to Text (always safe)
Text(NumberValue)

// Safe concatenation
Text(Value1) & " - " & Text(Value2)
```

### Error Prevention
```powerfx
// Check for blank/null
Coalesce(PossiblyBlankValue, DefaultValue)

// Validate before use
If(IsNumeric(UserInput), DoSomething(Value(UserInput)), ShowError())

// Safe selection
If(IsBlank(ListView.Selected), DefaultAction(), ProcessSelection())
```