<cfcomponent output="false">
	/**
	Copyright (c) 2013, Jerome Lepage

	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License
	http://creativecommons.org/licenses/by-sa/3.0/

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
	*/

	<cffunction name="init">

		<cfset variables.data = '' />
		<cfset variables.width = 400 />
		<cfset variables.height = 400 />

		<cfset variables.type = 'QR_CODE' />
		<cfset variables.format = 'PNG' />
		<cfset variables.quality = 'H' />
		<cfset variables.foreground = _getArgbcolor('000000', 'FF') />
		<cfset variables.background = _getArgbcolor('ffffff', 'FF') />

		<cfset variables.byteMatrix = '' />

		<cfreturn this />
	</cffunction>

	<cffunction name="setData">
		<cfargument name="data" required="true" hint="like ##fff"/>
		<cfset variables.data = arguments.data />
	</cffunction>

	<cffunction name="setSize">
		<cfargument name="width" required="true" hint="in Pixel"/>
		<cfargument name="height" required="true" hint="in Pixel"/>
		<cfset variables.width = arguments.width />
		<cfset variables.height = arguments.height />
	</cffunction>

	<cffunction name="setFormat">
		<cfargument name="format" required="true" hint="like PNG/JPEG"/>
		<cfset variables.format = arguments.format />
	</cffunction>

	<cffunction name="setType">
		<cfargument name="type" required="true" hint="like PNG/JPEG"/>
		<cfset variables.type = arguments.type />
	</cffunction>

	<cffunction name="setQuality">
		<cfargument name="quality" required="true" hint="L/M/Q/H"/>
		<cfset variables.quality = arguments.quality />
	</cffunction>

	<cffunction name="setColor">
		<cfargument name="hexColor" required="true" hint="like ##fff"/>
		<cfargument name="transparency" required="false" default="255" hint="0-255"/>
		<cfset variables.foreground = _getArgbcolor(arguments.hexColor, arguments.transparency) />
	</cffunction>

	<cffunction name="setBackground">
		<cfargument name="hexColor" required="true" hint="like ##fff"/>
		<cfargument name="transparency" required="false" default="255" hint="0-255"/>
		<cfset variables.background = _getArgbcolor(arguments.hexColor, arguments.transparency) />
	</cffunction>

	<cffunction name="_getConfig" access="private">
		<cfreturn createObject('java','com.google.zxing.client.j2se.MatrixToImageConfig').init(variables.foreground, variables.background) />
	</cffunction>

	<cffunction name="_getARGBColor" access="private">
		<cfargument name="hexColor" required="true" hint="like <sharp>fff or <sharp>c20000"/>
		<cfargument name="alpha" required="false" default="ff" hint="00-FF"/>

		<cfset arguments.hexColor = replace(arguments.hexColor, chr(35), '', 'ALL') />
		<cfif len(arguments.hexColor) eq 3>
			<cfset r = mid(arguments.hexColor, 1, 1) />
			<cfset g = mid(arguments.hexColor, 2, 1) />
			<cfset b = mid(arguments.hexColor, 3, 1) />
			<cfset r &= r />
			<cfset g &= g />
			<cfset b &= b />
			<cfset arguments.hexColor = r & g & b />

		</cfif>

		<cfset a = arguments.alpha />
		<cfset ipNumber = createObject('java', 'java.lang.Long').init(0) />
		<cfset value = ipNumber.decode('0x' & a & arguments.hexColor) />

		<cfreturn value />

	</cffunction>

	<cffunction name="writeToFile">
		<cfargument name="fileName" required="true" />
		<cfargument name="path" required="false" default="#expandPath('.')#" />

		<cfset oMatrixToImageConfig = _getConfig() />
		<cfset oFile = createObject('java','java.io.File').init(arguments.path, arguments.fileName) />
		<cfset oMatrixToImageWriter = createObject('java','com.google.zxing.client.j2se.MatrixToImageWriter') />

		<cfset _generateByteMatrix() />
		<cfset oMatrixToImageWriter.writeToFile(variables.byteMatrix, variables.format, oFile, oMatrixToImageConfig) />

	</cffunction>

	<cffunction name="_getErrorCorrectionLevel" access="private">
		<cfset ErrorCorrectionLevel = createObject('java', 'com.google.zxing.qrcode.decoder.ErrorCorrectionLevel') />
		<cfreturn ErrorCorrectionLevel.valueOf(variables.quality) />
	</cffunction>

	<cffunction name="_getBarcodeFormat" access="private">
		<cfset BarcodeFormat = createObject('java', 'com.google.zxing.BarcodeFormat') />
		<cfreturn BarcodeFormat.valueOf(variables.type) />
	</cffunction>

	<cffunction name="_generateByteMatrix" access="private">

		<cfset EncodeHintType = createObject('java', 'com.google.zxing.EncodeHintType') />
		<cfset QRCodeWriter = createObject('java', 'com.google.zxing.qrcode.QRCodeWriter') />

		<cfset hints = structNew() />
		<cfset hints[EncodeHintType.ERROR_CORRECTION]= _getErrorCorrectionLevel() />
		<cfset variables.byteMatrix = QRCodeWriter.encode(variables.data, _getBarcodeFormat(), variables.width, variables.height, hints) />

	</cffunction>


</cfcomponent>