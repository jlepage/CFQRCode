abstract component output="false" {
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

	private this.data;
	private this.type;
	private this.width;
	private this.height;
	private this.format;
	private this.quality;
	private this.BitMatrix;

	private ZXing function init(
		required string type,
		required numeric width,
		required numeric height
	) {
		this.data = "";
		this.type = type;
		this.width = width;
		this.height = height;

		this.format = "PNG";
		this.quality = "H";

		this.BitMatrix = NullValue();

		return this;
	}

	abstract public any function getConfig();

	/**
	* @data content of Barcode or QRCode
	*/
	public void function setData(required string data) {
		this.data = arguments.data;
	}

	/**
	* @width in Pixel
	* @height in Pixel
	*/
	public void function setSize(
		required numeric width,
		required numeric height
	) {
		this.width = arguments.width;
		this.height = arguments.height;
	}

	/**
	* @format like PNG/JPEG
	*/
	public void function setFormat(required string format) {
		this.format = arguments.format;
	}

	/**
	* @type like CODE_128
	*/
	public void function setType(required string type) {
		this.type = arguments.type;
	}

	/**
	* @quality L/M/Q/H
	*/
	public void function setQuality(required string quality) {
		this.quality = arguments.quality;
	}

	public void function writeToFile(
		required string fileName,
		string path = ExpandPath(".")
	) {
		_generateBitMatrix();
		var oMatrixToImageConfig = getConfig();
		var oFile = CreateObject("java", "java.io.File").init(arguments.path, arguments.fileName);
		var MatrixToImageWriter = CreateObject("java","com.google.zxing.client.j2se.MatrixToImageWriter");
		MatrixToImageWriter.writeToFile(this.BitMatrix, this.format, oFile, oMatrixToImageConfig);
	}

	private any function _getErrorCorrectionLevel() {
		var ErrorCorrectionLevel = CreateObject("java", "com.google.zxing.qrcode.decoder.ErrorCorrectionLevel");
		return ErrorCorrectionLevel.valueOf(this.quality);
	}

	private any function _getBarcodeFormat() {
		return CreateObject("java", "com.google.zxing.BarcodeFormat").valueOf(this.type);
	}

	private void function _generateBitMatrix() {
		var thisWriter = this._getWriter();
		var EncodeHintType = CreateObject("java", "com.google.zxing.EncodeHintType");

		var hints = structNew();
		hints[EncodeHintType.ERROR_CORRECTION] = _getErrorCorrectionLevel();

		this.BitMatrix = thisWriter.encode(this.data, _getBarcodeFormat(), this.width, this.height, hints);
	}

	private any function _getWriter() {
		switch (this.type) {
		case "QR_CODE":
			return CreateObject("java", "com.google.zxing.qrcode.QRCodeWriter").init();
		case "CODE_39":
			return CreateObject("java", "com.google.zxing.oned.Code39Writer").init();
		case "EAN_13":
			return CreateObject("java", "com.google.zxing.oned.EAN13Writer").init();
		case "EAN_8":
			return CreateObject("java", "com.google.zxing.oned.EAN8Writer").init();
		case "CODABAR":
			return CreateObject("java", "com.google.zxing.oned.CodaBarWriter").init();
		case "UPC_A":
			return CreateObject("java", "com.google.zxing.oned.UPCAWriter").init();
		case "PDF_417":
			return CreateObject("java", "com.google.zxing.pdf417.encoder.PDF417Writer").init();
		case "AZTEC":
			return CreateObject("java", "com.google.zxing.aztec.AztecWriter").init();
		case "CODE_128":
		default:
			return CreateObject("java", "com.google.zxing.oned.Code128Writer").init();
		}
	}

}
