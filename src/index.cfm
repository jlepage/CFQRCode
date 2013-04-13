<!--- Generate a QRCode Object --->
<cfset qrCode = new info.jlepage.QRCode() />
<cfset path =  expandPath('img')/>

<cfset qrCode.setData('Hello World !') />
<cfset qrCode.setColor('000000') />
<cfset qrCode.setQuality('Q') />

<cfset fileName = 'myQRCode_note.png' />
<cfset qrCode.writeToFile(fileName, path) />

<h3>QRCode Sample - Note</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<cfset qrCode.setData('http://www.jlepage.info') />
<cfset qrCode.setColor('C20000') />
<cfset qrCode.setQuality('H') />
<cfset qrCode.setSize(300, 300) />

<cfset fileName = 'myQRCode_link.png' />
<cfset qrCode.writeToFile(fileName, path) />

<h3>QRCode Sample - Link</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<cfset qrCode.setData('mailto:j.lepage@ekalys.net?subject=Nice Work&body=I''m your biggest fan !') />
<cfset qrCode.setColor('0000C2') />
<cfset qrCode.setQuality('M') />
<cfset qrCode.setSize(200, 200) />

<cfset fileName = 'myQRCode_mail.png' />
<cfset qrCode.writeToFile(fileName, path) />

<h3>QRCode Sample - Mail</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<!--- don't try to call is a fake number --->
<cfset qrCode.setData('tel:+33102030405') />
<cfset qrCode.setColor('00C200') />
<cfset qrCode.setQuality('L') />
<cfset qrCode.setSize(100, 100) />

<cfset fileName = 'myQRCode_phone.png' />
<cfset qrCode.writeToFile(fileName, path) />

<h3>QRCode Sample - Phone call</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<!--- don't try to call is a fake number --->
<cfset meCard = 'N:Lepage,Jerome;' />
<cfset meCard &= 'TEL:+33102030405;' />
<cfset meCard &= 'ADR:Paris,France;' />
<cfset meCard &= 'EMAIL:j.lepage@ekalys.net;' />
<cfset meCard &= 'URL:http://www.jlepage.info;' />

<cfset qrCode.setData('MECARD:' & meCard & ';') />
<cfset qrCode.setColor('C2002C') />
<cfset qrCode.setQuality('H') />
<cfset qrCode.setSize(400, 400) />

<cfset fileName = 'myQRCode_card.png' />
<cfset qrCode.writeToFile(fileName, path) />

<h3>QRCode Sample - MeCard</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<hr>
<a href="http://www.jlepage.info" target="_blank">&copy; JLepage.info 2013</a>