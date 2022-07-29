<!DOCTYPE html>
<html lang="en">
<head>
<title>barcode.cfm</title>
</head>
<body>
<cfscript>
code = new info.jlepage.Barcode();
path =  expandPath("img");

code.setData("Hello World!");
code.setQuality("Q");
code.setType("CODE_128");

fileName = "codabar_code128.png";
code.writeToFile(fileName, path);
</cfscript>
<h3>Codabar Sample - Code128</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
code = new info.jlepage.Barcode();
path =  expandPath("img");

code.setData("5901234123457");
code.setQuality("Q");
code.setType("EAN_13");

fileName = "codabar_ean13.png";
code.writeToFile(fileName, path);
</cfscript>
<h3>Codabar Sample - EAN13</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
code = new info.jlepage.Barcode();
path =  expandPath("img");

code.setData("A5901234123457N");
code.setQuality("Q");
code.setType("CODABAR");

fileName = "codabar_codabar.png";
code.writeToFile(fileName, path);
</cfscript>
<h3>Codabar Sample - Codabar</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
</body>
</html>
