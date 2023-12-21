connect uart rx @115200 baudrate
should return "57 52 FF FF FF"
this means "W" done & "R" done, and checked correct num 16777215
if less than FF FF FF, than error
