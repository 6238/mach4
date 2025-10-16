# 6 Troubleshooting

---
**Navigation:** ← [Previous: 5 Examples](examples.md) | [📋 Table of Contents](table_of_contents.md)
---

# Troubleshooting
Memory Mapped File Error:
![Image 7378](images/image_7378.png)
If you’re getting this error, check the file that seems to be causing this for mc.mcToolPathGenerate(). This used to have to be called every time a file was loaded to regenerate the tool path but this call is now automatically called every time a file is loaded. The error is called by both of them trying to edit the tool path file at the same time. If it’s present after a GCODE load call then try commenting it out.

---
**Navigation:** ← [Previous: 5 Examples](examples.md) | [📋 Table of Contents](table_of_contents.md)
---