# M64 PowerApps Application Assets

This repository contains image assets and documentation for the M64 PowerApps application.

## Known Issues and Solutions

### Quality Order Number Conversion Error

**Error Message:** 
```
"Quality Order #: " & Text(ListViewQO.Selected.Title)
The value 'Quality Order #: 000016' cannot be converted to a number.
```

**Problem:** 
The concatenated string "Quality Order #: 000016" is being treated as a number somewhere in the application, causing a type conversion error.

**Root Cause:**
This error occurs when a formula that creates a display string (like "Quality Order #: 000016") is being used in a context where PowerApps expects a numeric value.

**Solution:**
1. **Separate Display Logic from Data Logic**: Use different formulas for display purposes vs. data operations
2. **Use Proper Data Types**: Ensure numeric operations use only the numeric part of the data
3. **Implement Proper Type Checking**: Add validation to prevent string-to-number conversion errors

See `PowerApps_Formula_Examples.md` for detailed examples and solutions.

## Repository Contents

- `Banner.jpg` - Application banner image
- `Body.gif` - Main body animation
- `Logo.jpg` - Application logo
- `footer.png` - Footer image
- `logo-banner.png` - Logo banner combination
- `PowerApps_Formula_Examples.md` - Formula examples and solutions
- `Troubleshooting_Guide.md` - Common issues and solutions

## Usage

These assets are designed to be imported into a PowerApps application for branding and visual elements.