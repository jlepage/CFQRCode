
<cfset code = new info.jlepage.Barcode() />
<cfset path =  expandPath('img')/>

<cfset code.setData('Hello World!') />
<cfset code.setQuality('Q') />
<cfset code.setType('CODE_128') />

<cfset fileName = 'codabar_code128.png' />
<cfset code.writeToFile(fileName, path) />

<h3>Codabar Sample - Code128</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<cfset code = new info.jlepage.Barcode() />
<cfset path =  expandPath('img')/>

<cfset code.setData('5901234123457') />
<cfset code.setQuality('Q') />
<cfset code.setType('EAN_13') />

<cfset fileName = 'codabar_ean13.png' />
<cfset code.writeToFile(fileName, path) />

<h3>Codabar Sample - EAN13</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>

<cfset code = new info.jlepage.Barcode() />
<cfset path =  expandPath('img')/>

<cfset code.setData('A5901234123457N') />
<cfset code.setQuality('Q') />
<cfset code.setType('CODABAR') />

<cfset fileName = 'codabar_codabar.png' />
<cfset code.writeToFile(fileName, path) />

<h3>Codabar Sample - Codabar</h3>
<cfoutput>
<img src="img/#fileName#" alt="Scan Me!" border="0" />
</cfoutput>
