<cfcomponent output="false">
	/*
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
		<cfset variables.width = 200 />
		<cfset variables.height = 50 />

		<cfset variables.type = 'CODE_128' />
		<cfset variables.format = 'PNG' />
		<cfset variables.quality = 'H' />

		<cfset variables.byteMatrix = '' />

		<cfreturn this />
	</cffunction>

	<cffunction name="setData">
		<cfargument name="data" required="true" hint="content of the QRCode"/>
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
		<cfargument name="type" required="true" hint="like CODE_128"/>
		<cfset variables.type = arguments.type />
	</cffunction>

	<cffunction name="setQuality">
		<cfargument name="quality" required="true" hint="L/M/Q/H"/>
		<cfset variables.quality = arguments.quality />
	</cffunction>

	<cffunction name="_getConfig" access="private">
		<cfreturn createObject('java','com.google.zxing.client.j2se.MatrixToImageConfig').init()/>
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
		<cfset Writer = _getWriter() />
		<cfset EncodeHintType = createObject('java', 'com.google.zxing.EncodeHintType') />

		<cfset hints = structNew() />
		<cfset hints[EncodeHintType.ERROR_CORRECTION]= _getErrorCorrectionLevel() />

		<cfset variables.byteMatrix = Writer.encode(variables.data, _getBarcodeFormat(), variables.width, variables.height, hints) />
	</cffunction>

	<cffunction name="_getWriter" access="private">
		<cfif variables.type eq 'CODE_128'>
			<cfreturn createObject('java', 'com.google.zxing.oned.Code128Writer').init() />

		<cfelseif variables.type eq 'CODE_39'>
			<cfreturn createObject('java', 'com.google.zxing.oned.Code39Writer').init() />

		<cfelseif variables.type eq 'EAN_13'>
			<cfreturn createObject('java', 'com.google.zxing.oned.EAN13Writer').init() />

		<cfelseif variables.type eq 'EAN_8'>
			<cfreturn createObject('java', 'com.google.zxing.oned.EAN8Writer').init() />

		<cfelseif variables.type eq 'CODABAR'>
			<cfreturn createObject('java', 'com.google.zxing.oned.CodaBarWriter').init() />

		<cfelseif variables.type eq 'UPC_A'>
			<cfreturn createObject('java', 'com.google.zxing.oned.UPCAWriter').init() />

		<cfelseif variables.type eq 'PDF_417'>
			<cfreturn createObject('java', 'com.google.zxing.pdf417.encoder.PDF417Writer').init() />

		<cfelseif variables.type eq 'AZTEC'>
			<cfreturn createObject('java', 'com.google.zxing.aztec.AztecWriter').init() />

		<cfelse>
			<cfreturn createObject('java', 'com.google.zxing.oned.Code128Writer').init() />
		</cfif>
	</cffunction>

</cfcomponent>