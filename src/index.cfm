<cfscript>
// Generate a QRCode Object
qrCode = new info.jlepage.QRCode();
path =  expandPath("img");

qrCode.setData("Hello World !");
qrCode.setColor("000000");
qrCode.setQuality("Q");

fileName = "myQRCode_note.png";
qrCode.writeToFile(fileName, path);
</cfscript>
<h3>QRCode Sample - Note</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
qrCode.setData("http://www.jlepage.info");
qrCode.setColor("C20000");
qrCode.setQuality("H");
qrCode.setSize(300, 300);

fileName = "myQRCode_link.png";
qrCode.writeToFile(fileName, path);
</cfscript>
<h3>QRCode Sample - Link</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
qrCode.setData("mailto:j.lepage@ekalys.net?subject=Nice Work&body=I'm your biggest fan !");
qrCode.setColor("0000C2");
qrCode.setQuality("M");
qrCode.setSize(200, 200);

fileName = "myQRCode_mail.png";
qrCode.writeToFile(fileName, path);
</cfscript>
<h3>QRCode Sample - Mail</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
// don't try to call is a fake number
qrCode.setData("tel:+33102030405");
qrCode.setColor("00C200");
qrCode.setQuality("L");
qrCode.setSize(100, 100);

fileName = "myQRCode_phone.png";
qrCode.writeToFile(fileName, path);
</cfscript>
<h3>QRCode Sample - Phone call</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<cfscript>
// don't try to call is a fake number
meCard = "N:Lepage,Jerome;";
meCard &= "TEL:+33102030405;";
meCard &= "ADR:Paris,France;";
meCard &= "EMAIL:j.lepage@ekalys.net;";
meCard &= "URL:http://www.jlepage.info;";

qrCode.setData("MECARD:" & meCard & ";");
qrCode.setColor("C2002C");
qrCode.setQuality("H");
qrCode.setSize(400, 400);

fileName = "myQRCode_card.png";
qrCode.writeToFile(fileName, path);
</cfscript>
<h3>QRCode Sample - MeCard</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
<hr>
<a href="http://www.jlepage.info" target="_blank">&copy; JLepage.info 2013</a>
