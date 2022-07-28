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

	public QRCode function init() {
		variables.data = "";
		variables.width = 400;
		variables.height = 400;

		variables.type = "QR_CODE";
		variables.format = "PNG";
		variables.quality = "H";
		variables.foreground = _getArgbcolor("000000", "FF");
		variables.background = _getArgbcolor("ffffff", "FF");

		variables.byteMatrix = "";

		return this;
	}

	/**
	* @data like #fff
	*/
	public void function setData(required string data) {
		variables.data = arguments.data;
	}

	/**
	* @width in Pixel
	* @height in Pixel
	*/
	public void function setSize(
		required numeric width,
		required numeric height
	) {
		variables.width = arguments.width;
		variables.height = arguments.height;
	}

	/**
	* @format like PNG/JPEG
	*/
	public void function setFormat(required string format) {
		variables.format = arguments.format;
	}

	/**
	* @type like PNG/JPEG
	*/
	public void function setType(required string type) {
		variables.type = arguments.type;
	}

	/**
	* @quality L/M/Q/H
	*/
	public void function setQuality(required string quality) {
		variables.quality = arguments.quality;
	}

	/**
	* @hexColor like #fff
	* @transparency 0-255
	*/
	public void function setColor(
		required string hexColor,
		numeric transparency = 255
	) {
		var alpha = FormatBaseN(arguments.transparency, 16);
		variables.foreground = _getArgbcolor(arguments.hexColor, alpha);
	}

	/**
	* @hexColor like #fff
	* @transparency 0-255
	*/
	public void function setBackground(
		required string hexColor,
		numeric transparency = 255
	) {
		var alpha = FormatBaseN(arguments.transparency, 16);
		variables.background = _getArgbcolor(arguments.hexColor, alpha);
	}

	public void function writeToFile(
		required string fileName,
		string path = ExpandPath(".")
	) {
		oMatrixToImageConfig = _getConfig();
		oFile = createObject("java","java.io.File").init(arguments.path, arguments.fileName);
		oMatrixToImageWriter = createObject("java","com.google.zxing.client.j2se.MatrixToImageWriter");

		_generateByteMatrix();
		oMatrixToImageWriter.writeToFile(variables.byteMatrix, variables.format, oFile, oMatrixToImageConfig);
	}

	private any function _getConfig() {
		return createObject("java","com.google.zxing.client.j2se.MatrixToImageConfig").init(variables.foreground, variables.background);
	}

	/**
	* @hexColor like #fff or #c20000
	* @alpha 00-FF
	*/
	private any function _getARGBColor(
		required string hexColor,
		string alpha = "FF"
	) {
		arguments.hexColor = replace(arguments.hexColor, chr(35), "", "ALL");
		if (len(arguments.hexColor) == 3) {
			r = mid(arguments.hexColor, 1, 1);
			g = mid(arguments.hexColor, 2, 1);
			b = mid(arguments.hexColor, 3, 1);
			r &= r;
			g &= g;
			b &= b;
			arguments.hexColor = r & g & b;
		}

		a = arguments.alpha;
		ipNumber = createObject("java", "java.lang.Long").init(0);
		value = ipNumber.decode("0x" & a & arguments.hexColor);

		return value;
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
		EncodeHintType = createObject("java", "com.google.zxing.EncodeHintType");
		QRCodeWriter = createObject("java", "com.google.zxing.qrcode.QRCodeWriter");

		hints = structNew();
		hints[EncodeHintType.ERROR_CORRECTION] = _getErrorCorrectionLevel();

		variables.byteMatrix = QRCodeWriter.encode(variables.data, _getBarcodeFormat(), variables.width, variables.height, hints);
	}

}
