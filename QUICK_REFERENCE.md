# PowerApps Quick Reference Card

## Data Type Conversion Issue Fix

### ❌ PROBLEMATIC
```powerfx
"Quality Order #: " & Text(ListViewQO.Selected.Title)
// When used in numeric context causes: 
// "The value 'Quality Order #: 000016' cannot be converted to a number"
```

### ✅ SOLUTION
```powerfx
// For Display (Label.Text):
"Quality Order #: " & Text(ListViewQO.Selected.Title)

// For Numeric Operations:
Value(ListViewQO.Selected.Title)
```

## Essential Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `Text()` | Convert to text | `Text(123)` → `"123"` |
| `Value()` | Convert to number | `Value("123")` → `123` |
| `IsNumeric()` | Check if convertible | `IsNumeric("123")` → `true` |
| `IsBlank()` | Check for empty | `IsBlank("")` → `true` |
| `Coalesce()` | First non-blank | `Coalesce("", "default")` → `"default"` |

## Safe Patterns

### Pattern 1: Display Text
```powerfx
"Quality Order #: " & Text(Coalesce(Source.Title, "N/A"))
```

### Pattern 2: Get Number
```powerfx
If(IsNumeric(Source.Title), Value(Source.Title), 0)
```

### Pattern 3: Validate & Display
```powerfx
If(IsBlank(Source.Title), 
   "No selection", 
   "Quality Order #: " & Text(Source.Title))
```

## Testing Checklist

- [ ] Test with valid numbers: `"000016"`, `"12345"`
- [ ] Test with blank/empty: `""`, `null`
- [ ] Test with text: `"ABC123"`, `"invalid"`
- [ ] Test with zero: `"0"`, `"000000"`

## Common Mistakes

1. **Using display strings in calculations**
2. **Not validating before conversion**
3. **Mixing data types in operations**
4. **Forgetting to handle blank values**

## Quick Fixes

| Error | Quick Fix |
|-------|-----------|
| Cannot convert to number | Separate display from data logic |
| Invalid argument type | Add `Text()` or `Value()` conversion |
| Name isn't valid | Check control names and spelling |

---
*For detailed examples, see `PowerApps_Formula_Examples.md`*