component output="false" {
	/*
	Copyright (c) 2013, Jerome Lepage
	Copyright (c) 2022, Conrad T. Pino

	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License
	http://creativecommons.org/licenses/by-sa/3.0/

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
	*/

	public Barcode function init() {
		variables.data = "";
		variables.width = 200;
		variables.height = 50;

		variables.type = "CODE_128";
		variables.format = "PNG";
		variables.quality = "H";

		variables.byteMatrix = "";

		return this;
	}

	/**
	* @data content of the QRCode
	*/
	public void function setData(required any data) {
		variables.data = arguments.data;
	}

	/**
	* @width in Pixel
	* @height in Pixel
	*/
	public void function setSize(
		required any width,
		required any height
	) {
		variables.width = arguments.width;
		variables.height = arguments.height;
	}

	/**
	* @format like PNG/JPEG
	*/
	public void function setFormat(required any format) {
		variables.format = arguments.format;
	}

	/**
	* @type like CODE_128
	*/
	public void function setType(required any type) {
		variables.type = arguments.type;
	}

	/**
	* @quality L/M/Q/H
	*/
	public void function setQuality(required any quality) {
		variables.quality = arguments.quality;
	}

	public void function writeToFile(
		required any fileName,
		any path = ExpandPath(".")
	) {
		oMatrixToImageConfig = _getConfig();
		oFile = createObject("java","java.io.File").init(arguments.path, arguments.fileName);
		oMatrixToImageWriter = createObject("java","com.google.zxing.client.j2se.MatrixToImageWriter");

		_generateByteMatrix();
		oMatrixToImageWriter.writeToFile(variables.byteMatrix, variables.format, oFile, oMatrixToImageConfig);
	}

	private any function _getConfig() {
		return createObject("java","com.google.zxing.client.j2se.MatrixToImageConfig").init();
	}

	private any function _getErrorCorrectionLevel() {
		ErrorCorrectionLevel = createObject("java", "com.google.zxing.qrcode.decoder.ErrorCorrectionLevel");
		return ErrorCorrectionLevel.valueOf(variables.quality);
	}

	private any function _getBarcodeFormat() {
		BarcodeFormat = createObject("java", "com.google.zxing.BarcodeFormat");
		return BarcodeFormat.valueOf(variables.type);
	}

	private void function _generateByteMatrix() {
		Writer = _getWriter();
		EncodeHintType = createObject("java", "com.google.zxing.EncodeHintType");

		hints = structNew();
		hints[EncodeHintType.ERROR_CORRECTION] = _getErrorCorrectionLevel();

		variables.byteMatrix = Writer.encode(variables.data, _getBarcodeFormat(), variables.width, variables.height, hints);
	}

	private any function _getWriter() {
		switch (variables.type) {
		case "CODE_39":
			return createObject("java", "com.google.zxing.oned.Code39Writer").init();
		case "EAN_13":
			return createObject("java", "com.google.zxing.oned.EAN13Writer").init();
		case "EAN_8":
			return createObject("java", "com.google.zxing.oned.EAN8Writer").init();
		case "CODABAR":
			return createObject("java", "com.google.zxing.oned.CodaBarWriter").init();
		case "UPC_A":
			return createObject("java", "com.google.zxing.oned.UPCAWriter").init();
		case "PDF_417":
			return createObject("java", "com.google.zxing.pdf417.encoder.PDF417Writer").init();
		case "AZTEC":
			return createObject("java", "com.google.zxing.aztec.AztecWriter").init();
		case "CODE_128":
		default:
			return createObject("java", "com.google.zxing.oned.Code128Writer").init();
		}
	}

}
