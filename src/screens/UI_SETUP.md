# Custom UI Setup

Add text input and button to your Mach4 screen:

## Screen Editor Steps

1. **Operator** → **Edit Screen**
2. **Add Text Field**: Name `txtMoveSize`, default value `2.0`
3. **Add Button**: Name `btnExecuteMove`, text "Execute Square Move"
4. **Button Script**: Copy `button_execute_script.lua` to button's Left Up Script
5. **Screen Script** (optional): Copy `screen_load_script.lua` to Screen Load Script
6. **Save**

## Layout
```
Square Size (inches): [2.0      ]
       [ Execute Square Move ]
```

Result: UI with input validation, safety checks, and error handling.